Message-ID: <20001016182300.6641.qmail@web514.mail.yahoo.com>
Date: Mon, 16 Oct 2000 11:23:00 -0700 (PDT)
From: Dan Winkler <dantwinkler@yahoo.com>
Subject: IIC driver which supports microcode patch
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-260152959-971720580=:2712"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0-260152959-971720580=:2712
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've attached an iic driver which is a modified
version of the one by Dan Malek and Kim Jorgensen.
Thanks for the initial effort.  After many hours of
trying different scenarios I've finally found the
trick to the microcode patch.  What you have to
understand with the microcode path is that the
parameter ram is relocated and you must initialize the
Rx/Tx parameters manually (i.e. the init Tx/Rx command
is not available due to the relocation).  Info on the
microcode patch can be found at
http://www.mot.com/SPS/ADC/pps/subpgs/etoolbox/8XX/i2c_spi.html.
 Attached is the updated iic driver and a spi driver
in development.  The spi driver is from Matthew Locke
over at Montevista.  I've been working on this spi
driver for quite a while and am having trouble with it
in interrupt driven mode.  I was wondering if anyone
could look it over and see if I am doing something
generally wrong.  It is in slave mode and the device
attached just takes data in (i.e. the Clock is always
on, only the SMIMISO pin is connected and the Enable
pin is always active).  Any possible reasons why the
"write" always times out would be appreciated.  Thanks

-Dan Winkler

Yahoo! Messenger - Talk while you surf!  It's FREE.
http://im.yahoo.com/
--0-260152959-971720580=:2712
Content-Type: text/plain; name="iic.c"
Content-Description: iic.c
Content-Disposition: inline; filename="iic.c"


/* MPC8xx CPM I2C interface. Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
 * This driver only support I2C master mode.
 */
#include <linux/config.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/major.h>
#include <linux/string.h>
#include <linux/fcntl.h>
#include <linux/ptrace.h>
#include <linux/mm.h>
#include <linux/malloc.h>
#include <linux/poll.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/wait.h>
#include <asm/uaccess.h>
#include <asm/pgtable.h>
#include <asm/mpc8xx.h>

#include "commproc.h"

/* Print debug messages
 */
#define DEBUG

/* This is the I2C device number.
 */
#define CPM_I2C_CDEV_MAJOR 89

/* Defines to make I2C clock run at 100kHz (101kHz) @ 50MHz CPU clock */
#define I2BRG_100KHZ	0x1A
#define I2MOD_100KHZ 	0x0C

/* Defines to make I2C clock run at 400kHz (391kHz) @ 50MHz CPU clock */
#define I2BRG_400KHZ	0x0B
#define I2MOD_400KHZ 	0x0E

/* Maximum number of bytes we can xmit/receive at once (hardware). */
#define MAX_I2C_DATALEN		128

void	cpm_iic_init(void);
static int cpm_iic_open(struct inode *, struct file *);
static int cpm_iic_close(struct inode *, struct file *);
static ssize_t cpm_iic_read(struct file *, char *, size_t, loff_t *);
static ssize_t cpm_iic_write(struct file *, const char *, size_t, loff_t *);
static int cpm_iic_ioctl(struct inode *, struct file *, uint, ulong);
static void cpm_iic_interrupt(void *);

static struct file_operations cpm_iic_fops = {
	NULL,			/* lseek */
	cpm_iic_read,		/* read */
	cpm_iic_write,		/* write */
	NULL,			/* readdir */
	NULL,			/* select */
	cpm_iic_ioctl,		/* ioctl */
	NULL,			/* mmap */
	cpm_iic_open,		/* open */
	cpm_iic_close,		/* close */
	NULL			/* fsync */
};

/* File pointer specific setup
 */
typedef struct i2c_setup_struct_def
{
    u_char device_address;		/* The device we want to talk to */
    u_char internal_address_len;	/* The length of internal address */
    uint  clock_freq;			/* The i2c clock frequency */
} i2c_setup_struct;

/* Mutex used to make sure only one uses the i2c bus at time.
 */
struct semaphore bus_busy_mutex = MUTEX;

/* Wait queue used while waiting for interrupt
 */
static struct wait_queue *i2c_interrupt_wait;

volatile i2c8xx_t	*i2c;
volatile cbd_t		*tbdf, *rbdf;

/***************************************************************************
 *  Setup the interface for r/w.
 *
 *	@param	reloc	Returns relocation offset for microcode.  0 = original.
 *					If pass in NULL, nothing returned.
 *	@param	cp		Pointer to the communications processor address space.
 *	@param	init	TRUE to force init of the registers for startup.  If
 *					FALSE, may init but depends on patching of ucode.
 *	@return	Pointer to memory space for control registers.
 ***************************************************************************/
volatile iic_t	*setupChip(int* reloc,volatile cpm8xx_t *cp, int init)
{
	volatile iic_t		*iip;	// Parameter ram section for i2c
	int					 r;		// Relocation.

/* Load up base pointers.  Note that cpmp is set in kernal initialization. */
	iip   = (iic_t *)&cp->cp_dparam[PROFF_IIC];

	/* Check for and use a microcode relocation patch.	If so, we also move the
		location of the parameters. */
	if (reloc = iip->iic_rpbase)
	{
		printk("Microcode relocation patch used\n");
		ipp = (iic_t *)&cp->cp_dpmem[reloc]
	}

	return iip;
}

void cpm_iic_init()
{
	uint	mem_addr, dp_addr;
	volatile cpm8xx_t	*cp;
	volatile iic_t		*iip;
	volatile immap_t	*immap;
	int*				reloc;

	/* print version string */
	printk("CPM I2C driver version 1.0 %s\n", __DATE__);

	/* Get pointer to Communication Processor
	 * and to internal registers
	 */
	cp = cpmp;
	immap = (immap_t *)IMAP_ADDR;

	iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];
	i2c = (i2c8xx_t *)&(immap->im_i2c);

	/* Initialize Port B I2C pins. */
	cp->cp_pbpar |= 0x00000030;
	cp->cp_pbdir |= 0x00000030;
	cp->cp_pbodr |= 0x00000030;

	/* Disable interrupts. */
	i2c->i2c_i2cmr = 0;
	i2c->i2c_i2cer = 0xff;

	/* Set I2C controller in master mode */
	i2c->i2c_i2com = 0x01;

	/* Allocate space for two transmit and one receive buffer
	 * descriptor in the DP ram.
	 */
	dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * 3);

	/* Allocate space for two transmit and one receive buffer in the host memory.
	 * The most you can read or write at once from I2C is 128 bytes.
	 */
	mem_addr = m8xx_cpm_hostalloc(128 * 3);

	/* Load up base pointers. */
	iip   = (iic_t *)&cp->cp_dparam[PROFF_IIC];

	/* Check for and use a microcode relocation patch.	If so, we also move the
		location of the parameters. */
	if (reloc = iip->iic_rpbase)
	{
		printk("Microcode relocation patch used\n");
		ipp = (iic_t *)&cp->cp_dpmem[reloc]
	}

	/* Set up the I2C parameters in the parameter ram. */
	iip->iic_rbase =  dp_addr;
	iip->iic_tbase =  dp_addr + sizeof(cbd_t);

	/* Set the buffer address. */
	rbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];
	tbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];

	rbdf[0].cbd_bufaddr = __pa(mem_addr);
	tbdf[0].cbd_bufaddr = __pa(mem_addr+128);
	tbdf[1].cbd_bufaddr = __pa(mem_addr+256);

	if(!relocated)
	{
		/* Initialize Tx/Rx parameters.
	 	*/
		cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
		while (cp->cp_cpcr & CPM_CR_FLG);
	}
	else
	{
		/*
		*  Initialize required parameters if using microcode patch
		*
		*  NOTE:  These are the parameters required as stated in the
		*		  Relocation spec which can be found at
		*		  http://www.mot.com/SPS/ADC/pps/subpgs/etoolbox/8XX/i2c_spi.html
	 	*/

		iip->iic_rbptr = iip->iic_rbase;
		iip->iic_tbptr = iip->iic_tbase;

		iip->iic_rstate	= 0;
		iip->iic_tstate	= 0;
	}

	/* Set byte order to big endian.  Also, setup address type to 5.*/
	iip->iic_tfcr	= SMC_EB;
	iip->iic_rfcr	= SMC_EB;

	/* Set maximum receive size. */
	iip->iic_mrblr	 = MAX_I2C_DATALEN;

	/* Install interrupt handler.
	 */
	cpm_install_handler(CPMVEC_I2C, cpm_iic_interrupt, (void *)iip);

	/* Register the I2C driver
	 */
	if(register_chrdev(CPM_I2C_CDEV_MAJOR,"i2c",&cpm_iic_fops))
	{
		printk("unable to get major %d for I2C devs\n",	CPM_I2C_CDEV_MAJOR);
	}

	printk("IIC Drivers Loaded (Major %d)!\n", CPM_I2C_CDEV_MAJOR);
}

static int

cpm_iic_open(struct inode *ip, struct file *fp)
{

    i2c_setup_struct *i2c_setup;

    printk("Opening iic device\n");

   /* Check minor number.
     */
    if( MINOR(ip->i_rdev) > 0)
	 return -ENODEV;

    /* Alloc some memory for I2C setup struct
     */
    fp->private_data = kmalloc(sizeof(i2c_setup_struct), GFP_KERNEL);
    i2c_setup = (i2c_setup_struct *)(fp->private_data);
    if(!i2c_setup)
	return -ENOMEM;

    /* Set device address and internal address length to 0
     * and i2c clock freq. to 100kHz
     */
    i2c_setup->device_address = 0;
    i2c_setup->internal_address_len = 0;
    i2c_setup->clock_freq = 100000;

    /* Set pointer to file operations struct
     */
    fp->f_op = &cpm_iic_fops;

    return 0;
}

static int
cpm_iic_close(struct inode *ip, struct file *fp)
{
        /* Free space used by i2c setup struct
	 */
	kfree(fp->private_data);

	return 0;
}

/* Read from I2C.
 * This is a two step process if internal addresses is used.  First, we send
 * the "dummy" write to set the internal address for the read.  Second, we
 * perform the read operation.
 */
static ssize_t
cpm_iic_read(struct file *fp, char *buf, size_t count, loff_t *ppos)
{
        i2c_setup_struct	*i2c_setup;
	loff_t	offset;
	u_char	*tb, *tb2, *rb, len, tmp_off[4];

	/* Get pointer to i2c setup data
	 */
	i2c_setup = (i2c_setup_struct *)(fp->private_data);

	/* Get pointer to transmit and receive buffer
	 */
	tb =  __va(tbdf[0].cbd_bufaddr);
	tb2 = __va(tbdf[1].cbd_bufaddr);
	rb =  __va(rbdf[0].cbd_bufaddr);

	/* Get file offset (internal address)
	 */
	offset = *ppos;

	tmp_off[0] = (char)(offset >> 24);
	tmp_off[1] = (char)((offset >> 16) % 0x100);
	tmp_off[2] = (char)((offset >> 8) % 0x100);
	tmp_off[3] = (char)(offset % 0x100);

	/* Enter critical section
	 */
	down(&bus_busy_mutex);
        if (signal_pending(current))
	{
	    up(&bus_busy_mutex);
	    return -ERESTARTSYS;
	}

	if(i2c_setup->internal_address_len)		/* Use internal address	*/
	{
	    *tb = i2c_setup->device_address & 0xfe;	/* Device address, write request */
	    tbdf[0].cbd_datlen = i2c_setup->internal_address_len + 1 ;	/* Length */

	    /* copy offset into transmit buffer
	     */
	     for(len=0; len < i2c_setup->internal_address_len; len++)
	         tb[1+len] = tmp_off[(4 - i2c_setup->internal_address_len) + len];

	    *tb2 = i2c_setup->device_address | 0x01;	/* Device address, read request */
	    tbdf[1].cbd_datlen = count + 1;		/* Length */

	    tbdf[0].cbd_sc = BD_SC_READY | BD_IIC_START;
	    tbdf[1].cbd_sc = BD_SC_READY | BD_SC_LAST | BD_SC_WRAP | BD_IIC_START;
	}
	else						/* No internal address */
	{
	    *tb = i2c_setup->device_address | 0x01;	/* Device address, read request */
    	    tbdf[0].cbd_datlen = count + 1;		/* Length */

	    tbdf[0].cbd_sc = BD_SC_READY | BD_SC_LAST | BD_SC_WRAP | BD_IIC_START;
	}

	rbdf[0].cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_WRAP;

	i2c->i2c_i2cmr = 0x15;			/* Enable receive interrupt */
	i2c->i2c_i2cer = 0xff;			/* Clear event register */

	if(i2c_setup->clock_freq == 400000)	/* Make clock run at 400kHz */
	{
	    i2c->i2c_i2brg = I2BRG_400KHZ;
	    i2c->i2c_i2mod = I2MOD_400KHZ;
	}
	else					/* Make clock run at 100kHz */
	{
	    i2c->i2c_i2brg = I2BRG_100KHZ;
	    i2c->i2c_i2mod = I2MOD_100KHZ;
	}

	i2c->i2c_i2mod |= 0x01;			/* Chip errata, set enable here */
	i2c->i2c_i2com |= 0x80;			/* Start transmit */

	/* Wait for I2C receive interrupt or time out (1 second).
	*/
	if(interruptible_sleep_on_timeout(&i2c_interrupt_wait, 1*HZ)<=0)
	{
#ifdef DEBUG
	    printk("I2C read: Time out!\n");
#endif
	}

	i2c->i2c_i2mod &= ~0x01;		/* Chip errata, clear enable */

	if(signal_pending(current))
	{
	    up(&bus_busy_mutex);
	    return -ERESTARTSYS;
	}

	/* check for errors in first tx buffer
	 */
	if(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
	{
#ifdef DEBUG
	    switch(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
	    {
		case BD_SC_READY:
		    printk("I2C read complete but tx_buf ready!\n");
		    break;
		case BD_SC_NAK:
		    printk("I2C read: no acknowledge!\n");
		    break;
		case BD_SC_UN:
	    	    printk("I2C read: underrun!\n");
		    break;
		case BD_SC_CL:
		    printk("I2C read: collision!\n");
		    break;
	    }
#endif
	    up(&bus_busy_mutex);
	    return -EFAULT;
	}

	if(i2c_setup->internal_address_len)
	{
	    /* check for errors in second tx buffer
	     */
	    if(tbdf[1].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
	    {
#ifdef DEBUG
		switch(tbdf[1].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
		{
		    case BD_SC_READY:
			printk("I2C read complete but tx_buf ready!\n");
			break;
		    case BD_SC_NAK:
			printk("I2C read: no acknowledge!\n");
			break;
    		    case BD_SC_UN:
	    		printk("I2C read: underrun!\n");
			break;
		    case BD_SC_CL:
			printk("I2C read: collision!\n");
			break;
		}
#endif
		up(&bus_busy_mutex);
		return -EFAULT;
	    }
	}

	/* check for errors in rx buffer
	 */
	if (rbdf[0].cbd_sc & BD_SC_EMPTY)
	{
	    up(&bus_busy_mutex);
#ifdef DEBUG
	    printk("I2C read complete but rx_buf empty!");
#endif
    	    return -EFAULT;
	}

	if (copy_to_user(buf, rb, count))
	{
	    up(&bus_busy_mutex);
	    return -EFAULT;
	}

	/* Leave critical section
	 */
        up(&bus_busy_mutex);

	*ppos += count;
	return count;
}

/* I2C write funktion.
*/
static ssize_t
cpm_iic_write(struct file *fp, const char *buf, size_t count, loff_t *ppos)
{
	i2c_setup_struct 	*i2c_setup;
	loff_t	offset;
	u_char	*tb, len, tmp_off[4];

	/* Get pointer to i2c setup data
	 */
	i2c_setup = (i2c_setup_struct *)(fp->private_data);

	/* Get file offset (internal address)
	 */
	offset = *ppos;

	tmp_off[0] = (char)(offset >> 24);
	tmp_off[1] = (char)((offset >> 16) % 0x100);
	tmp_off[2] = (char)((offset >> 8) % 0x100);
	tmp_off[3] = (char)(offset % 0x100);


	/* Enter critical section
	 */
	down(&bus_busy_mutex);
        if(signal_pending(current))
	{
	    up(&bus_busy_mutex);
	    return -ERESTARTSYS;
	}

	/* Get pointer to transmit buffer
	 */
	tb = __va(tbdf[0].cbd_bufaddr);

	*tb = i2c_setup->device_address & 0xfe;	/* Set device address, write request */


	if(i2c_setup->internal_address_len)	/* Use internal address	*/
	{
            /* copy offset into transmit buffer
	     */
	    for(len=0; len < i2c_setup->internal_address_len; len++)
		tb[1+len] = tmp_off[(4 - i2c_setup->internal_address_len) + len];
	}

	/* copy data into transmit buffer
	 */
	if(copy_from_user(tb+i2c_setup->internal_address_len+1, buf, count))
	{
	    up(&bus_busy_mutex);
	    return -EFAULT;
	}

	tbdf[0].cbd_datlen = count + i2c_setup->internal_address_len + 1;	/* Data length */
	tbdf[0].cbd_sc =  BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP | BD_IIC_START;

	i2c->i2c_i2cmr = 0x16;			/* Enable transmit interrupt */
	i2c->i2c_i2cer = 0xff;			/* Clear event register */


	if(i2c_setup->clock_freq == 400000)	/* Make clock run at 400kHz */
	{
	    i2c->i2c_i2brg = I2BRG_400KHZ;
	    i2c->i2c_i2mod = I2MOD_400KHZ;
	}
	else					/* Make clock run at 100kHz */
	{
	    i2c->i2c_i2brg = I2BRG_100KHZ;
	    i2c->i2c_i2mod = I2MOD_100KHZ;
	}

	i2c->i2c_i2mod |= 0x01;			/* Chip errata, set enable here */
	i2c->i2c_i2com |= 0x80;			/* Start transmit */

	/* Wait for I2C transmit interrupt or time out (1 second).
	*/
	if(interruptible_sleep_on_timeout(&i2c_interrupt_wait, 1*HZ)<=0)
	{
#ifdef DEBUG
	    printk("I2C write: Time out!\n");
#endif
	}

	i2c->i2c_i2mod &= ~0x01;		/* Chip errata, clear enable */

	if (signal_pending(current))
	{
	    up(&bus_busy_mutex);
	    return -ERESTARTSYS;
	}

	/* check for errors in tx buffer
	 */
	if(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
	{
#ifdef DEBUG
	    switch(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
	    {
		case BD_SC_READY:
		    printk("I2C write complete but tx_buf ready!\n");
		    break;
		case BD_SC_NAK:
		    printk("I2C write: no acknowledge!\n");
		    break;
		case BD_SC_UN:
	    	    printk("I2C write: underrun!\n");
		    break;
		case BD_SC_CL:
		    printk("I2C write: collision!\n");
		    break;
	    }
#endif
	    up(&bus_busy_mutex);
	    return -EFAULT;
	}

	/* Leave critical section
	 */
	up(&bus_busy_mutex);

        *ppos += count;
	return count;
}

static int
cpm_iic_ioctl(struct inode *ip, struct file *fp, u_int cmd, ulong arg)
{
	int	retval = 0;
	i2c_setup_struct *i2c_setup;

	i2c_setup = (i2c_setup_struct *)(fp->private_data);

	switch(cmd)
	{
	    /* Set device address.
	     */
	    case 1:
		i2c_setup->device_address = (u_char)arg & 0xfe; 	/* Set device address, ignore LSB */
		break;

	    /* Set internal address length.
	     */
	    case 2:
	    	if((u_char)arg > 4)
		    retval = -EINVAL;
		else
		    i2c_setup->internal_address_len = (u_char)arg;
		break;

	    /* Set the bus clock frequency.
	     */
	    case 3:
		if(((uint)arg != 100000) && ((uint)arg != 400000))
		    retval = -EINVAL;
		else
		    i2c_setup->clock_freq = (uint)arg;
		break;

	    default: retval = -ENOIOCTLCMD;
	}

	return retval;
}

static void
cpm_iic_interrupt(void *dev_id)
{
	/* Clear interrupt.
	*/
	i2c->i2c_i2cer = 0xff;

	/* Wake up process in wait queue
	*/
	wake_up_interruptible(&i2c_interrupt_wait);
}

--0-260152959-971720580=:2712
Content-Type: text/plain; name="spi.c"
Content-Description: spi.c
Content-Disposition: inline; filename="spi.c"


/*****************************************************************************
 *
 * MPC8xx CPM SPI interface.
 * in progress, can't get microcode patch to work
 * Copyright (c) 2000 Embedded Planet <mlocke@jps.net>.
 *
 * 8/00 - microcode patch works so SPI can work with Ethernet
 *        just the basics are here for other drivers
 *        to use spi - tpanel, etc
 * Copyright (c) 2000 Montavista Software Inc. <source@mvista.com>
 *
 *  This file is subject to the terms and conditions of the GNU General
 *  Public License.  See the file "COPYING" in the main directory of
 *  this archive for more details
 *****************************************************************************/

#include <linux/errno.h>
#include <linux/string.h>
#include <linux/fcntl.h>
#include <linux/mm.h>
#include <linux/malloc.h>
#include <linux/delay.h>
#include <linux/wait.h>
#include <asm/mpc8xx.h>

#include "commproc.h"

#define CPM_SPI_CDEV_MAJOR 96

#define MAX_RECEIVE_SIZE	4
#define MAX_TRANSMIT_SIZE	1024

void	cpm_spi_init(void);
static int cpm_spi_open(struct inode *, struct file *);
static int cpm_spi_close(struct inode *, struct file *);
extern ssize_t cpm_spi_read(struct file *, char *, size_t, loff_t *);
extern ssize_t cpm_spi_write(struct file *, char *, size_t, loff_t *);
static int cpm_spi_ioctl(struct inode *, struct file *, uint, ulong);
static void cpm_spi_interrupt(void *);

/* Wait queue used while waiting for interrupt */
static struct wait_queue *spi_interrupt_wait;
volatile spi_t	*spp;
volatile cpm8xx_t	*cp;

static struct file_operations cpm_spi_fops = {
	NULL,						/* lseek */
	cpm_spi_read,		/* read */
	cpm_spi_write,	/* write */
	NULL,						/* readdir */
	NULL,						/* select */
	cpm_spi_ioctl,	/* ioctl */
	NULL,						/* mmap */
	cpm_spi_open,		/* open */
	cpm_spi_close,	/* close */
	NULL						/* fsync */
};

void
cpm_spi_init()
{
	uint	mem_addr, dp_addr, reloc;
	volatile cbd_t		*bdp;
	volatile immap_t	*immap;

	cp = cpmp;	/* Get pointer to Communication Processor */
	immap = (immap_t *)IMAP_ADDR;	/* and to internal registers */

	spp = (spi_t *)&cp->cp_dparam[PROFF_SPI];

	/* Check for and use a microcode relocation patch.
	*/
	if ((reloc = spp->spi_rpbase))
	{
		printk("Microcode relocation patch used\n");
		spp = (spi_t *)&cp->cp_dpmem[spp->spi_rpbase];
	}

	/* Initialize Port B SPI pins.
	*/
 	cp->cp_pbpar |=  0x0000000F;
	cp->cp_pbdir |=  0x0000000A;
	cp->cp_pbodr &= ~0x0000000F;

	/* Allocate space for one transmit and one receive buffer
	 * descriptor in the DP ram.
	 */
	dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * 2);

	/* Set up the SPI parameters in the parameter ram. */
	spp->spi_rbase = dp_addr + sizeof(cbd_t);
	spp->spi_tbase = dp_addr;

	/* Normal Operation (Big Endian) */
	spp->spi_rfcr = 0x18;//
	spp->spi_tfcr = 0x18;//SMC_EB;

	/* Initialize required parameters if using microcode patch */
	if(reloc)
	{
		spp->spi_rbptr = spp->spi_rbase;
		spp->spi_tbptr = spp->spi_tbase;

    spp->spi_rstate	= 0;
		spp->spi_tstate	= 0;
	}
	else
	{
		/* Initialize Tx/Rx parameters.  We can only do this if we are not using
		 * the microcode patch
		 */
		cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_INIT_TRX) | CPM_CR_FLG;

		while (cp->cp_cpcr & CPM_CR_FLG);
	}

	immap->im_siu_conf.sc_sdcr = 0x00000001;

	/* Set maximum receive size. */
	spp->spi_mrblr = MAX_RECEIVE_SIZE;

	/* Set the buffer address. */
	mem_addr = m8xx_cpm_hostalloc(MAX_RECEIVE_SIZE);
	bdp = (cbd_t *)&cp->cp_dpmem[spp->spi_rbase];
	bdp->cbd_bufaddr = __pa(mem_addr);
	bdp->cbd_sc = BD_SC_WRAP;

	mem_addr = m8xx_cpm_hostalloc(MAX_TRANSMIT_SIZE);
	bdp = (cbd_t *)&cp->cp_dpmem[spp->spi_tbase];
	bdp->cbd_bufaddr = __pa(mem_addr);
	bdp->cbd_sc = BD_SC_WRAP|BD_SC_LAST;

	/* Clear the event register */
	cp->cp_spie = 0xff;

	/* Set interupts for all events  */
	cp->cp_spim = 0x37;

	/* Install interrupt handler.
	 */
	cpm_install_handler(CPMVEC_SPI, cpm_spi_interrupt, (void *)spp);

	/* Allow the serial peripheral interface to generate
		 a system interrupt */
	immap->im_cpic.cpic_cicr |= CICR_IEN;

  /*
   * Initialize SPMODE
   *
   * Settings:
   *     Reverse Data      -- Normal Operation (TX/RX MSB first)
   *     Master/Slave Mode -- Slave Mode
   *     Character Length  -- 8 Bits
   */

	// MSB First
  cp->cp_spmode = SPMODE_REV;

  // Character length (8-bits [0x0111])
	cp->cp_spmode |= (0x7 << 4);

	// Enable the SPI port
  cp->cp_spmode |= SPMODE_EN;

	printk("SPMODE = 0x%x\n", cp->cp_spmode);


	// Setupt memory map for status and control registers
	//printk("BR6 = %x\n", immap->im_memctl.memc_br6);
	//printk("OR6 = %x\n", immap->im_memctl.memc_or6);

	// Register the SPI driver
	if (register_chrdev(CPM_SPI_CDEV_MAJOR,"spi",&cpm_spi_fops))
	{
		printk("Unable to get major %d for SPI devs\n",	CPM_SPI_CDEV_MAJOR);
	}

	printk("SPI Drivers Loaded!\n");
}

static int
cpm_spi_open(struct inode *ip, struct file *fp)
{
    printk("Opening spi device\n");

		/* Check the minor number to make sure it is 0 */
    if( MINOR(ip->i_rdev) > 0)
		{
			printk("Wrong minor number... try again\n");
			return -ENODEV;
		}

    /* Set pointer to file operations struct */
    fp->f_op = &cpm_spi_fops;

    return 0;
}

static int
cpm_spi_close(struct inode *ip, struct file *fp)
{
	return 0;
}

ssize_t
cpm_spi_read(struct file *file, char *buf, size_t count, loff_t *ppos)
{
	volatile cbd_t	*tbdf, *rbdf;
	unsigned long flags;

	tbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_tbase];
	rbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_rbase];

	memset(__va(tbdf->cbd_bufaddr),0,count);

	tbdf->cbd_datlen = count;
	tbdf->cbd_sc |= BD_SC_READY;

	rbdf->cbd_sc |= BD_SC_EMPTY;

	save_flags(flags);

	cli();

	cp->cp_spcom = 0x80;	/* Start Transmit */

	/* Wait for SPI transfer.
	*/
	while(rbdf->cbd_sc & BD_SC_EMPTY);

	restore_flags(flags);
	if (signal_pending(current))
		return -ERESTARTSYS;

	if (rbdf->cbd_sc & BD_SC_EMPTY)
		printk("SPI read complete but rbuf empty\n");

	memcpy(buf,__va(rbdf->cbd_bufaddr), 2);

	return count;
}

ssize_t
cpm_spi_write(struct file *file, char *buf, size_t count, loff_t *ppos)
{
	volatile cbd_t	*tbdf, *rbdf;
	unsigned long flags;

	printk("Starting the SPI write!!!\n");

	if(count > MAX_TRANSMIT_SIZE)
	{
		return -ERESTARTSYS;
	}
	tbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_tbase];
	rbdf = (cbd_t *)&cp->cp_dpmem[spp->spi_rbase];

	memcpy(__va(tbdf->cbd_bufaddr), buf, count);

	tbdf->cbd_datlen	= MAX_TRANSMIT_SIZE;

	tbdf->cbd_sc = BD_SC_READY|BD_SC_WRAP|BD_SC_LAST|BD_SC_INTRPT;

	printk("The event register before transmission 0x%x\n", cp->cp_spie);

	/* Start the transfer */
	cp->cp_spcom = 0x80;

	// Turn on clock

	printk("Waiting for SPI transfer\n");

	/* Wait for SPI transmit interrupt or time out (20 seconds).*/
	if(interruptible_sleep_on_timeout(&spi_interrupt_wait, 20*HZ)<=0)
	{
	    printk("SPI write: Time out!\n");
	}

	// Turn off clock

	printk("The event register after transmission 0x%x\n", cp->cp_spie);

	printk("Finshed SPI transfer\n");

	if (signal_pending(current))
	{
		return -ERESTARTSYS;
	}

	/* check for errors in tx buffer */
	if(tbdf->cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
	{
	    switch(tbdf->cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | BD_SC_CL))
	    {
				case BD_SC_READY:
		    	printk("SPI write complete but tx_buf ready!\n");
		    	break;
				case BD_SC_NAK:
		    	printk("SPI write: no acknowledge!\n");
		    	break;
				case BD_SC_UN:
	    		printk("SPI write: underrun!\n");
		    	break;
				case BD_SC_CL:
		    	printk("SPI write: collision!\n");
		    	break;
	    }
	}

  printk("Finished the SPI write\n");

  return count;
}

static int
cpm_spi_ioctl(struct inode *ip, struct file *fp, u_int cmd, ulong arg)
{
	int	retval = 0;

	switch(cmd)
	{
	    /* Dummy IOCTL Command. */
	    case 1:
			break;

			default:
				retval = -ENOIOCTLCMD;
	}

	return retval;
}

static void
cpm_spi_interrupt(void *dev_id)
{
	printk("Interrupt Received %x\n", cp->cp_spie);

	/* Clear Interrupt */
	cp->cp_spie = ~0;

	/* Wake up process in wait queue */
	wake_up_interruptible(&spi_interrupt_wait);
}

--0-260152959-971720580=:2712--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
