Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B86C@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Changes in the MPC8xx I2C driver
Date: Fri, 9 Jun 2000 12:19:32 +0200 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01BFD1FC.33DE7E30"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01BFD1FC.33DE7E30
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
I have made some changes in the MPC8xx I2C driver, mainly adding write
support and making the driver re-entrant. This might have some ones interest
so I'll post the driver here.

I don't use the minor number for the device address, instead I added an
ioctl function to allow set up of the device address, internal address
length and bus frequency. The setup data is saved in a struct, which is
accessed by the private pointer in the file pointer.
This allows several processes to talk to several i2c devices with different
bus frequency at the (almost) same time. I had a need for this, that's why I
made is that way.

I have removed all of the microcode relocation code in the driver, as I
couldn't make the driver work with this code and I had no need for applying
the patch.

I added these defines in commproc.h:
#define BD_SC_NAK       ((ushort)0x0004)        /* No Acknowledge */
#define BD_SC_UN        ((ushort)0x0002)        /* Underrun */
#define BD_SC_CL        ((ushort)0x0001)        /* Collision */

I made some clumsy code for converting offset to internal address, maybe
some one can tell me how to make this in a simpler way?

Any suggestions and comments are welcome.

--
Kim Jorgensen



------_=_NextPart_000_01BFD1FC.33DE7E30
Content-Type: application/octet-stream;
	name="iic.c"
Content-Disposition: attachment;
	filename="iic.c"
Content-Transfer-Encoding: quoted-printable

=0A=
/* MPC8xx CPM I2C interface. Copyright (c) 1999 Dan Malek =
(dmalek@jlc.net).=0A=
 * This driver only support I2C master mode.=0A=
 */=0A=
#include <linux/config.h>=0A=
#include <linux/module.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/signal.h>=0A=
#include <linux/sched.h>=0A=
#include <linux/timer.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/major.h>=0A=
#include <linux/string.h>=0A=
#include <linux/fcntl.h>=0A=
#include <linux/ptrace.h>=0A=
#include <linux/mm.h>=0A=
#include <linux/malloc.h>=0A=
#include <linux/poll.h>=0A=
#include <linux/init.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/wait.h>=0A=
#include <asm/uaccess.h>=0A=
#include <asm/pgtable.h>=0A=
#include <asm/mpc8xx.h>=0A=
=0A=
#include "commproc.h"=0A=
=0A=
/* Print debug messages=0A=
 */=0A=
#define DEBUG=0A=
=0A=
/* This is the I2C device number.=0A=
 */=0A=
#define CPM_I2C_CDEV_MAJOR 89=0A=
=0A=
/* Defines to make I2C clock run at 100kHz (101kHz) @ 50MHz CPU clock =
*/=0A=
#define I2BRG_100KHZ	0x1A=0A=
#define I2MOD_100KHZ 	0x0C=0A=
=0A=
/* Defines to make I2C clock run at 400kHz (391kHz) @ 50MHz CPU clock =
*/=0A=
#define I2BRG_400KHZ	0x0B=0A=
#define I2MOD_400KHZ 	0x0E=0A=
=0A=
void	cpm_iic_init(void);=0A=
static int cpm_iic_open(struct inode *, struct file *);=0A=
static int cpm_iic_close(struct inode *, struct file *);=0A=
static ssize_t cpm_iic_read(struct file *, char *, size_t, loff_t =
*);=0A=
static ssize_t cpm_iic_write(struct file *, const char *, size_t, =
loff_t *);=0A=
static int cpm_iic_ioctl(struct inode *, struct file *, uint, =
ulong);=0A=
static void cpm_iic_interrupt(void *);=0A=
=0A=
static struct file_operations cpm_iic_fops =3D {=0A=
	NULL,			/* lseek */=0A=
	cpm_iic_read,		/* read */=0A=
	cpm_iic_write,		/* write */=0A=
	NULL,			/* readdir */=0A=
	NULL,			/* select */=0A=
	cpm_iic_ioctl,		/* ioctl */=0A=
	NULL,			/* mmap */=0A=
	cpm_iic_open,		/* open */=0A=
	cpm_iic_close,		/* close */=0A=
	NULL			/* fsync */=0A=
};=0A=
=0A=
/* File pointer specific setup=0A=
 */=0A=
typedef struct i2c_setup_struct_def=0A=
{=0A=
    u_char device_address;		/* The device we want to talk to */=0A=
    u_char internal_address_len;	/* The length of internal address =
*/=0A=
    uint  clock_freq;			/* The i2c clock frequency */=0A=
} i2c_setup_struct;=0A=
=0A=
/* Mutex used to make sure only one uses the i2c bus at time.=0A=
 */=0A=
struct semaphore bus_busy_mutex =3D MUTEX;=0A=
=0A=
/* Wait queue used while waiting for interrupt=0A=
 */=0A=
static struct wait_queue *i2c_interrupt_wait;=0A=
=0A=
volatile i2c8xx_t	*i2c;=0A=
volatile cbd_t		*tbdf, *rbdf;=0A=
=0A=
void=0A=
cpm_iic_init()=0A=
{=0A=
	uint	mem_addr, dp_addr;=0A=
	volatile cpm8xx_t	*cp;=0A=
	volatile iic_t		*iip;=0A=
	volatile immap_t	*immap;=0A=
=0A=
	/* print version string=0A=
	 */=0A=
	printk("CPM I2C driver version 0.01\n");=0A=
=0A=
	/* Get pointer to Communication Processor=0A=
	 * and to internal registers=0A=
	 */=0A=
	cp =3D cpmp;=0A=
	immap =3D (immap_t *)IMAP_ADDR;=0A=
=0A=
	iip =3D (iic_t *)&cp->cp_dparam[PROFF_IIC];=0A=
	i2c =3D (i2c8xx_t *)&(immap->im_i2c);=0A=
=0A=
	/* Initialize Port B I2C pins.=0A=
	 */=0A=
	cp->cp_pbpar |=3D 0x00000030;=0A=
	cp->cp_pbdir |=3D 0x00000030;=0A=
	cp->cp_pbodr |=3D 0x00000030;=0A=
=0A=
	/* Disable interrupts.=0A=
	 */=0A=
	i2c->i2c_i2cmr =3D 0;=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
=0A=
	/* Set I2C controller in master mode=0A=
	 */=0A=
	i2c->i2c_i2com =3D 0x01;=0A=
=0A=
	/* Allocate space for two transmit and one receive buffer=0A=
	 * descriptor in the DP ram.=0A=
	 */=0A=
	dp_addr =3D m8xx_cpm_dpalloc(sizeof(cbd_t) * 3);=0A=
=0A=
	/* Allocate space for two transmit and one receive buffer in the host =
memory.=0A=
	 * The most you can read or write at once from I2C is 128 bytes.=0A=
	 */=0A=
	mem_addr =3D m8xx_cpm_hostalloc(128 * 3);=0A=
=0A=
	/* Set up the I2C parameters in the parameter ram.=0A=
	 */=0A=
	iip->iic_rbase =3D  dp_addr;=0A=
	iip->iic_tbase =3D  dp_addr + sizeof(cbd_t);=0A=
=0A=
	/* Set the buffer address.=0A=
	 */=0A=
	rbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];=0A=
	tbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];=0A=
=0A=
	rbdf[0].cbd_bufaddr =3D __pa(mem_addr);=0A=
	tbdf[0].cbd_bufaddr =3D __pa(mem_addr+128);=0A=
	tbdf[1].cbd_bufaddr =3D __pa(mem_addr+256);=0A=
=0A=
	/* Set big endian byte order=0A=
	 */=0A=
	iip->iic_tfcr =3D SMC_EB;=0A=
	iip->iic_rfcr =3D SMC_EB;=0A=
=0A=
	/* Set maximum receive size.=0A=
	 */=0A=
	iip->iic_mrblr =3D 128;=0A=
=0A=
	/* Initialize Tx/Rx parameters.=0A=
	 */=0A=
	cp->cp_cpcr =3D mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | =
CPM_CR_FLG;=0A=
	while (cp->cp_cpcr & CPM_CR_FLG);=0A=
=0A=
	/* Install interrupt handler.=0A=
	 */=0A=
	cpm_install_handler(CPMVEC_I2C, cpm_iic_interrupt, (void *)iip);=0A=
=0A=
	/* Register the I2C driver=0A=
	 */=0A=
	if (register_chrdev(CPM_I2C_CDEV_MAJOR,"i2c",&cpm_iic_fops))=0A=
		printk("unable to get major %d for I2C devs\n",	=
CPM_I2C_CDEV_MAJOR);=0A=
=0A=
}=0A=
=0A=
static int=0A=
cpm_iic_open(struct inode *ip, struct file *fp)=0A=
{=0A=
    i2c_setup_struct *i2c_setup;=0A=
=0A=
    /* Check minor number.=0A=
     */=0A=
    if( MINOR(ip->i_rdev) > 0)=0A=
	 return -ENODEV;=0A=
=0A=
    /* Alloc some memory for I2C setup struct=0A=
     */=0A=
    fp->private_data =3D kmalloc(sizeof(i2c_setup_struct), =
GFP_KERNEL);=0A=
    i2c_setup =3D (i2c_setup_struct *)(fp->private_data);=0A=
    if(!i2c_setup)=0A=
	return -ENOMEM;=0A=
=0A=
    /* Set device address and internal address length to 0=0A=
     * and i2c clock freq. to 100kHz=0A=
     */=0A=
    i2c_setup->device_address =3D 0;=0A=
    i2c_setup->internal_address_len =3D 0;=0A=
    i2c_setup->clock_freq =3D 100000;=0A=
    =0A=
    /* Set pointer to file operations struct=0A=
     */=0A=
    fp->f_op =3D &cpm_iic_fops;=0A=
=0A=
    return 0;=0A=
}=0A=
=0A=
static int=0A=
cpm_iic_close(struct inode *ip, struct file *fp)=0A=
{=0A=
        /* Free space used by i2c setup struct=0A=
	 */=0A=
	kfree(fp->private_data);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
/* Read from I2C.=0A=
 * This is a two step process if internal addresses is used.  First, we =
send =0A=
 * the "dummy" write to set the internal address for the read.  Second, =
we =0A=
 * perform the read operation.=0A=
 */=0A=
static ssize_t=0A=
cpm_iic_read(struct file *fp, char *buf, size_t count, loff_t *ppos)=0A=
{=0A=
        i2c_setup_struct	*i2c_setup;=0A=
	loff_t	offset;=0A=
	u_char	*tb, *tb2, *rb, len, tmp_off[4];=0A=
=0A=
	/* Get pointer to i2c setup data=0A=
	 */=0A=
	i2c_setup =3D (i2c_setup_struct *)(fp->private_data);=0A=
=0A=
	/* Get pointer to transmit and receive buffer=0A=
	 */=0A=
	tb =3D  __va(tbdf[0].cbd_bufaddr);=0A=
	tb2 =3D __va(tbdf[1].cbd_bufaddr);=0A=
	rb =3D  __va(rbdf[0].cbd_bufaddr);=0A=
=0A=
	/* Get file offset (internal address)=0A=
	 */=0A=
	offset =3D *ppos;=0A=
=0A=
	tmp_off[0] =3D (char)(offset >> 24);=0A=
	tmp_off[1] =3D (char)((offset >> 16) % 0x100);=0A=
	tmp_off[2] =3D (char)((offset >> 8) % 0x100);=0A=
	tmp_off[3] =3D (char)(offset % 0x100);=0A=
=0A=
	/* Enter critical section=0A=
	 */=0A=
	down(&bus_busy_mutex);=0A=
        if (signal_pending(current))=0A=
	{=0A=
	    up(&bus_busy_mutex);=0A=
	    return -ERESTARTSYS;=0A=
	}=0A=
=0A=
	if(i2c_setup->internal_address_len)		/* Use internal address	*/=0A=
	{=0A=
	    *tb =3D i2c_setup->device_address & 0xfe;	/* Device address, write =
request */=0A=
	    tbdf[0].cbd_datlen =3D i2c_setup->internal_address_len + 1 ;	/* =
Length */=0A=
=0A=
	    /* copy offset into transmit buffer=0A=
	     */=0A=
	     for(len=3D0; len < i2c_setup->internal_address_len; len++)=0A=
	         tb[1+len] =3D tmp_off[(4 - i2c_setup->internal_address_len) + =
len];=0A=
	    =0A=
	    *tb2 =3D i2c_setup->device_address | 0x01;	/* Device address, read =
request */=0A=
	    tbdf[1].cbd_datlen =3D count + 1;		/* Length */=0A=
=0A=
	    tbdf[0].cbd_sc =3D BD_SC_READY | BD_IIC_START;=0A=
	    tbdf[1].cbd_sc =3D BD_SC_READY | BD_SC_LAST | BD_SC_WRAP | =
BD_IIC_START;=0A=
	}=0A=
	else						/* No internal address */=0A=
	{=0A=
	    *tb =3D i2c_setup->device_address | 0x01;	/* Device address, read =
request */=0A=
    	    tbdf[0].cbd_datlen =3D count + 1;		/* Length */=0A=
=0A=
	    tbdf[0].cbd_sc =3D BD_SC_READY | BD_SC_LAST | BD_SC_WRAP | =
BD_IIC_START;=0A=
	}=0A=
	=0A=
	rbdf[0].cbd_sc =3D BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_WRAP;=0A=
	=0A=
	i2c->i2c_i2cmr =3D 0x15;			/* Enable receive interrupt */=0A=
	i2c->i2c_i2cer =3D 0xff;			/* Clear event register */=0A=
=0A=
	if(i2c_setup->clock_freq =3D=3D 400000)	/* Make clock run at 400kHz =
*/=0A=
	{=0A=
	    i2c->i2c_i2brg =3D I2BRG_400KHZ;=0A=
	    i2c->i2c_i2mod =3D I2MOD_400KHZ;=0A=
	}=0A=
	else					/* Make clock run at 100kHz */=0A=
	{=0A=
	    i2c->i2c_i2brg =3D I2BRG_100KHZ;=0A=
	    i2c->i2c_i2mod =3D I2MOD_100KHZ;=0A=
	}=0A=
=0A=
	i2c->i2c_i2mod |=3D 0x01;			/* Chip errata, set enable here */=0A=
	i2c->i2c_i2com |=3D 0x80;			/* Start transmit */=0A=
=0A=
	/* Wait for I2C receive interrupt or time out (1 second).=0A=
	*/=0A=
	if(interruptible_sleep_on_timeout(&i2c_interrupt_wait, 1*HZ)<=3D0)=0A=
	{=0A=
#ifdef DEBUG=0A=
	    printk("I2C read: Time out!\n");=0A=
#endif=0A=
	}=0A=
=0A=
	i2c->i2c_i2mod &=3D ~0x01;		/* Chip errata, clear enable */=0A=
=0A=
	if(signal_pending(current))=0A=
	{=0A=
	    up(&bus_busy_mutex);=0A=
	    return -ERESTARTSYS;=0A=
	}=0A=
=0A=
	/* check for errors in first tx buffer=0A=
	 */=0A=
	if(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | =
BD_SC_CL))=0A=
	{=0A=
#ifdef DEBUG=0A=
	    switch(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | =
BD_SC_CL))=0A=
	    {=0A=
		case BD_SC_READY:=0A=
		    printk("I2C read complete but tx_buf ready!\n");=0A=
		    break;=0A=
		case BD_SC_NAK:=0A=
		    printk("I2C read: no acknowledge!\n");=0A=
		    break;=0A=
		case BD_SC_UN:=0A=
	    	    printk("I2C read: underrun!\n");=0A=
		    break;=0A=
		case BD_SC_CL:=0A=
		    printk("I2C read: collision!\n");=0A=
		    break;=0A=
	    }=0A=
#endif=0A=
	    up(&bus_busy_mutex);=0A=
	    return -EFAULT;=0A=
	}=0A=
=0A=
	if(i2c_setup->internal_address_len)=0A=
	{=0A=
	    /* check for errors in second tx buffer=0A=
	     */=0A=
	    if(tbdf[1].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | =
BD_SC_CL))=0A=
	    {=0A=
#ifdef DEBUG=0A=
		switch(tbdf[1].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | =
BD_SC_CL))=0A=
		{=0A=
		    case BD_SC_READY:=0A=
			printk("I2C read complete but tx_buf ready!\n");=0A=
			break;=0A=
		    case BD_SC_NAK:=0A=
			printk("I2C read: no acknowledge!\n");=0A=
			break;=0A=
    		    case BD_SC_UN:=0A=
	    		printk("I2C read: underrun!\n");=0A=
			break;=0A=
		    case BD_SC_CL:=0A=
			printk("I2C read: collision!\n");=0A=
			break;=0A=
		}=0A=
#endif=0A=
		up(&bus_busy_mutex);=0A=
		return -EFAULT;=0A=
	    }=0A=
	}=0A=
=0A=
	/* check for errors in rx buffer=0A=
	 */=0A=
	if (rbdf[0].cbd_sc & BD_SC_EMPTY)=0A=
	{=0A=
	    up(&bus_busy_mutex);=0A=
#ifdef DEBUG=0A=
	    printk("I2C read complete but rx_buf empty!");=0A=
#endif=0A=
    	    return -EFAULT;=0A=
	}=0A=
	=0A=
	if (copy_to_user(buf, rb, count))=0A=
	{=0A=
	    up(&bus_busy_mutex);=0A=
	    return -EFAULT;=0A=
	}=0A=
=0A=
	/* Leave critical section=0A=
	 */=0A=
        up(&bus_busy_mutex);=0A=
	=0A=
	*ppos +=3D count;=0A=
	return count;=0A=
}=0A=
=0A=
/* I2C write funktion.=0A=
*/=0A=
static ssize_t=0A=
cpm_iic_write(struct file *fp, const char *buf, size_t count, loff_t =
*ppos)=0A=
{=0A=
	i2c_setup_struct 	*i2c_setup;=0A=
	loff_t	offset;=0A=
	u_char	*tb, len, tmp_off[4];=0A=
=0A=
	/* Get pointer to i2c setup data=0A=
	 */=0A=
	i2c_setup =3D (i2c_setup_struct *)(fp->private_data);=0A=
	=0A=
	/* Get file offset (internal address)=0A=
	 */=0A=
	offset =3D *ppos;=0A=
=0A=
	tmp_off[0] =3D (char)(offset >> 24);=0A=
	tmp_off[1] =3D (char)((offset >> 16) % 0x100);=0A=
	tmp_off[2] =3D (char)((offset >> 8) % 0x100);=0A=
	tmp_off[3] =3D (char)(offset % 0x100);=0A=
=0A=
=0A=
	/* Enter critical section=0A=
	 */=0A=
	down(&bus_busy_mutex);=0A=
        if(signal_pending(current))=0A=
	{=0A=
	    up(&bus_busy_mutex);=0A=
	    return -ERESTARTSYS;=0A=
	}=0A=
=0A=
	/* Get pointer to transmit buffer=0A=
	 */=0A=
	tb =3D __va(tbdf[0].cbd_bufaddr);=0A=
=0A=
	*tb =3D i2c_setup->device_address & 0xfe;	/* Set device address, write =
request */=0A=
=0A=
=0A=
	if(i2c_setup->internal_address_len)	/* Use internal address	*/=0A=
	{=0A=
            /* copy offset into transmit buffer=0A=
	     */=0A=
	    for(len=3D0; len < i2c_setup->internal_address_len; len++)=0A=
		tb[1+len] =3D tmp_off[(4 - i2c_setup->internal_address_len) + =
len];=0A=
	}=0A=
=0A=
	/* copy data into transmit buffer=0A=
	 */=0A=
	if(copy_from_user(tb+i2c_setup->internal_address_len+1, buf, =
count))=0A=
	{=0A=
	    up(&bus_busy_mutex);=0A=
	    return -EFAULT;=0A=
	}=0A=
=0A=
	tbdf[0].cbd_datlen =3D count + i2c_setup->internal_address_len + 1;	/* =
Data length */=0A=
	tbdf[0].cbd_sc =3D  BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | =
BD_SC_WRAP | BD_IIC_START;=0A=
=0A=
	i2c->i2c_i2cmr =3D 0x16;			/* Enable transmit interrupt */=0A=
	i2c->i2c_i2cer =3D 0xff;			/* Clear event register */=0A=
=0A=
=0A=
	if(i2c_setup->clock_freq =3D=3D 400000)	/* Make clock run at 400kHz =
*/=0A=
	{=0A=
	    i2c->i2c_i2brg =3D I2BRG_400KHZ;=0A=
	    i2c->i2c_i2mod =3D I2MOD_400KHZ;=0A=
	}=0A=
	else					/* Make clock run at 100kHz */=0A=
	{=0A=
	    i2c->i2c_i2brg =3D I2BRG_100KHZ;=0A=
	    i2c->i2c_i2mod =3D I2MOD_100KHZ;=0A=
	}=0A=
=0A=
	i2c->i2c_i2mod |=3D 0x01;			/* Chip errata, set enable here */=0A=
	i2c->i2c_i2com |=3D 0x80;			/* Start transmit */=0A=
=0A=
	/* Wait for I2C transmit interrupt or time out (1 second).=0A=
	*/=0A=
	if(interruptible_sleep_on_timeout(&i2c_interrupt_wait, 1*HZ)<=3D0)=0A=
	{=0A=
#ifdef DEBUG=0A=
	    printk("I2C write: Time out!\n");=0A=
#endif=0A=
	}=0A=
=0A=
	i2c->i2c_i2mod &=3D ~0x01;		/* Chip errata, clear enable */=0A=
=0A=
	if (signal_pending(current))=0A=
	{=0A=
	    up(&bus_busy_mutex);=0A=
	    return -ERESTARTSYS;=0A=
	}=0A=
=0A=
	/* check for errors in tx buffer=0A=
	 */=0A=
	if(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | =
BD_SC_CL))=0A=
	{=0A=
#ifdef DEBUG=0A=
	    switch(tbdf[0].cbd_sc & (BD_SC_READY | BD_SC_NAK | BD_SC_UN | =
BD_SC_CL))=0A=
	    {=0A=
		case BD_SC_READY:=0A=
		    printk("I2C write complete but tx_buf ready!\n");=0A=
		    break;=0A=
		case BD_SC_NAK:=0A=
		    printk("I2C write: no acknowledge!\n");=0A=
		    break;=0A=
		case BD_SC_UN:=0A=
	    	    printk("I2C write: underrun!\n");=0A=
		    break;=0A=
		case BD_SC_CL:=0A=
		    printk("I2C write: collision!\n");=0A=
		    break;=0A=
	    }=0A=
#endif=0A=
	    up(&bus_busy_mutex);=0A=
	    return -EFAULT;=0A=
	}=0A=
=0A=
	/* Leave critical section=0A=
	 */=0A=
	up(&bus_busy_mutex);=0A=
=0A=
        *ppos +=3D count;=0A=
	return count;=0A=
}=0A=
=0A=
static int=0A=
cpm_iic_ioctl(struct inode *ip, struct file *fp, u_int cmd, ulong =
arg)=0A=
{=0A=
	int	retval =3D 0;=0A=
	i2c_setup_struct *i2c_setup;=0A=
=0A=
	i2c_setup =3D (i2c_setup_struct *)(fp->private_data);=0A=
=0A=
	switch(cmd)=0A=
	{=0A=
	    /* Set device address.=0A=
	     */=0A=
	    case 1:=0A=
		i2c_setup->device_address =3D (u_char)arg & 0xfe; 	/* Set device =
address, ignore LSB */=0A=
		break;=0A=
=0A=
	    /* Set internal address length.=0A=
	     */=0A=
	    case 2:=0A=
	    	if((u_char)arg > 4)=0A=
		    retval =3D -EINVAL;=0A=
		else =0A=
		    i2c_setup->internal_address_len =3D (u_char)arg;=0A=
		break;=0A=
=0A=
	    /* Set the bus clock frequency.=0A=
	     */=0A=
	    case 3:=0A=
		if(((uint)arg !=3D 100000) && ((uint)arg !=3D 400000))=0A=
		    retval =3D -EINVAL;=0A=
		else=0A=
		    i2c_setup->clock_freq =3D (uint)arg;=0A=
		break;=0A=
		=0A=
	    default: retval =3D -ENOIOCTLCMD;=0A=
	}=0A=
=0A=
	return retval;=0A=
}=0A=
=0A=
static void=0A=
cpm_iic_interrupt(void *dev_id)=0A=
{=0A=
	/* Clear interrupt.=0A=
	*/=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
=0A=
	/* Wake up process in wait queue=0A=
	*/=0A=
	wake_up_interruptible(&i2c_interrupt_wait);=0A=
}=0A=

------_=_NextPart_000_01BFD1FC.33DE7E30--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
