Message-ID: <3C1F1156.6EBFF01A@cambridgebroadband.com>
Date: Tue, 18 Dec 2001 09:50:14 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SPI driver?
References: <3C1E9268.13D0EE46@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> A link to an 8xx driver would be almost as good. The only one I've found
> so far has been SPI over a PC's parallel port. heh

Kevin,

Here's one (below) for the 860.  You'll probably need to change the GPIO pin used to select the SPI
slave.  You may also want get rid of the semaphore ioctl call.  I put this in as a way to allow
processes to do a sequence of reads/writes atomically.  However, it also allows one process to
permanently lock out all others :-(

Alex

/*
   MPC8xx CPM SPI interface.
   Copyright (c) 2001 Navin Boppuri/Prashant Patel
   (nboppuri@trinetcommunication.com/pmpatel@trinetcommunication.com)
   This interface requires the microcode patches.
   Helper functions for memdump put in by Ralph Nichols (ralphn@trinetcommunication.com)

   Alex Zeffertt 06Sep01
   Notes:

   0.

   This code drives the MPC860 SPI as a master device.

   1.

   The Chip selects are controlled by the ioctl interface.
   This is necessary because some SPI devices lose state
   information when the CS is unasserted.
   For example, with an SPI EEPROM (e.g. AT25010) you may
   have to assert the CS, send a READ command, receive
   some data, and then unassert the CS.  The corresponding
   user commands are:

   ioctl(s, SPI_IOCTL_RESET, 1);       // 3rd argument selects port A pin 1
   write(s, readcmdstring, sizeof(readcmdstring));
   read(s, buffer, sizeof(buffer);
   ioctl(s, SPI_IOCTL_SET, 1);         // 3rd argument selects port A pin 1

   For such a device we cannot assert the CS at the start of
   write/read and unassert it at the end of write/read, because
   it would forget what command it was processing.

   Since all devices will differ in this respect we have left
   the decision of when to assert the CS to the user.

   2.

   Several processes may have this device open at a time.  However,
   this may result in one process interferring with the other
   process.  To prevent this we have introduced a semaphore:

   // To gain semaphore
   ioctl(s, SPI_IOCTL_SEMAPHORE_DOWN, 0); // 3rd argument is unused

   ... do reads and writes and non-semaphore ioctls

   // To release semaphore
   ioctl(s, SPI_IOCTL_SEMAPHORE_UP, 0);   // 3rd argument is unused

   If every process uses these two ioctls before and after any device
   operations, then every device operation will be atomic.

   3.

   This driver protects against simultaneous calls to read/write
   by the use of wait queues.

   4.

   This driver uses interrupts to indicate when the TX buffer is sent
   or the RX buffer is full.

*/

/*########################### Includes ###############################*/

#include <linux/config.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/major.h>
#include <linux/string.h>
#include <linux/fs.h>
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
#include <asm/irq.h>
#include <asm/8xx_immap.h>
#include "commproc.h"

/*########################### Defines/typedefs ########################*/
//#define DEBUG
#ifdef DEBUG
#define DPRINTK(format,args...) printk(format,##args)
#else
#define DPRINTK(format,args...)
#endif


/* This is the SPI device number, but I use the minors to indicate
 * the SPI device address.
 */
#define CPM_SPI_CDEV_MAJOR 89
#define SPI_BUFFER_SIZE 64

typedef int SPI_IOCTL_FN(uint cmd, ulong arg);

typedef struct _spi_ioctl_cmds
{
    char *name;
    SPI_IOCTL_FN *fn;
} SPI_IOCTL_CMDS;


typedef enum _spi_ioctls
{
    SPI_IOCTL_INIT,
    SPI_IOCTL_RESET,
    SPI_IOCTL_SET,
    SPI_IOCTL_SEMAPHORE_UP,
    SPI_IOCTL_SEMAPHORE_DOWN,
    NUM_SPI_IOCTL_CMDS
} SPI_IOCTLS;

// number of bits in a character
#define CHAR_BITS         8

#define SPI_CLK_SPEED     500000  // Max = 2.1MHz (see data sheet) Minium = BRGCLK/1024

/*########################## Forward declarations #####################*/

static int cpm_spi_open(struct inode *, struct file *);
static int cpm_spi_close(struct inode *, struct file *);
static ssize_t cpm_spi_write(struct file *, const char *, size_t, loff_t *);
static ssize_t cpm_spi_read(struct file *, char *, size_t, loff_t *);
static void cpm_spi_interrupt(void *);
static int cpm_spi_ioctl(struct inode *, struct file *, uint, ulong);
static int t1_semaphore_down(uint cmd, ulong arg);
static int t1_semaphore_up(uint cmd, ulong arg);
static int t1_cs_set(uint cmd, ulong arg);
static int t1_cs_reset(uint cmd, ulong arg);
static int t1_cs_init(uint cmd, ulong arg);
int spi_ioctl_set_clk(uint cmd, ulong arg);

/*########################## File scope variables #####################*/

static SPI_IOCTL_CMDS spi_ioctl_cmds[NUM_SPI_IOCTL_CMDS] = {
    {"Initialise CS",       &t1_cs_init },
    {"Reset CS",            &t1_cs_reset},
    {"Set CS",              &t1_cs_set},
    {"Semaphore UP",        &t1_semaphore_up},
    {"Semaphore DOWN",      &t1_semaphore_down},
};

/* Number of users of the driver at any one time */
static int	cpm_spi_users = 0;

DECLARE_WAIT_QUEUE_HEAD(waitq);      // For waiting for SPI hardware to complete operation
DECLARE_WAIT_QUEUE_HEAD(lockq);      // To prevent more than one user at a time in read() or write()
static int reading_writing = 0;      // Set this when in read() or write()
static struct semaphore spi_sem;     // set this in t1_semaphore_up, clear in t1_semaphore_down

static ushort t_tbase, r_rbase;
static volatile cbd_t  *tbd, *rbd;

/* RX and TX buffers */
static ulong hostpage;              /* points to page of host memory */
static pte_t pte_old;               /* saves hostpage's Page Table Entry */
static unsigned char *rxbuffer;     /* rx and tx buffers in hostpage */
static unsigned char *txbuffer;

static struct file_operations cpm_spi_fops = {
	read: cpm_spi_read,
	write: cpm_spi_write,
	ioctl: cpm_spi_ioctl,
	open: cpm_spi_open,
	release: cpm_spi_close,
};

// Stuff initialised by cpm_spi_init()
static int two_char_times_us;  // we need to wait 2 character times after tx interrupt to be sure
buf sent
static ushort spmode;          // This is the value to write to spmode register on an open

static char *cpm_spi_drivername = "spi";
static uint  cpm_spi_dp_addr;

/*########################## Function definitions #####################*/

static int t1_semaphore_down(uint cmd, ulong arg)
{
    down_interruptible(&spi_sem);
    return 0;
}

static int t1_semaphore_up(uint cmd, ulong arg)
{
    up(&spi_sem);
    return 0;
}

static int t1_cs_set(uint cmd, ulong arg)
{
 	volatile immap_t* immap = (immap_t*)IMAP_ADDR;

    // write one to PAarg
	immap->im_ioport.iop_padat |= (0x8000 >> arg);

    return 0;
}

static int t1_cs_reset(uint cmd, ulong arg)
{
 	volatile immap_t* immap = (immap_t*)IMAP_ADDR;

    // write zero to PAarg
	immap->im_ioport.iop_padat &= ~(0x8000 >> arg);

    return 0;
}

static int t1_cs_init(uint cmd, ulong arg)
{
 	volatile immap_t* immap = (immap_t*)IMAP_ADDR;

   // Port A pin PAarg
    // configured as actively driven
    // General purpose output
//	cpmp->cp_pbodr &= ~(0x0010);  // pre mod rev A ICU
    immap->im_ioport.iop_padir |=  (0x8000 >> arg);
	immap->im_ioport.iop_papar &= ~(0x8000 >> arg);

    // Set line!
    return t1_cs_set(cmd, arg);
}

static int cpm_spi_ioctl(struct inode *ip, struct file *fp, uint cmd, ulong arg)
{

    // Is this a valid IOCTL cmd
    if (cmd < NUM_SPI_IOCTL_CMDS) {

        DPRINTK("Handling ioctl->%s\n", spi_ioctl_cmds[cmd].name);

        // Yes so handle it
        return (*(spi_ioctl_cmds[cmd].fn)) (cmd, arg);
    }

    // Invalid IOCTL command
    return -ENOIOCTLCMD;
}

int __init cpm_spi_init(void)
{
    volatile spi_t        *spi;
    volatile immap_t      *immap;
    volatile cpic8xx_t    *cpi;
    volatile sysconf8xx_t *sys;
    volatile cpm8xx_t     *cp;

	bd_t* bd = (bd_t*)__res;
	unsigned int system_clock = bd->bi_busfreq * 1000000;
    unsigned int divisor = system_clock/SPI_CLK_SPEED;
    int sys_clocks_per_spi_clock = 1;

    pte_t *pte;

	DPRINTK(__FUNCTION__ "\n");


    // Work out what to write to SPMODE:
    spmode =
      //SPMODE_REV   | // msb of character sent and recvd first // E1 device has lsb first
        SPMODE_MASTER| // SPI is a master
        SPMODE_EN    | // enable device
        ((CHAR_BITS-1) << SPMODE_LEN_SHIFT); // Sets the number of bits in a character

    // Work out how to set speed
    if (divisor >= 16) {
        spmode |= SPMODE_DIV16;               // pre divide BRGCLK by 16
        divisor = (divisor + 15)/16;          // rounds down clockspeed
        sys_clocks_per_spi_clock *= 16;
    }
    if (divisor > 64) {
        printk("Error: (" __FUNCTION__ ") SPI_CLK_SPEED out of range\n");
        return -EFAULT;
    } else {
        divisor = (divisor + 3)/4;            // rounds down clockspeed
        spmode |= (divisor-1) << SPMODE_PM_SHIFT;
        sys_clocks_per_spi_clock *= (4*divisor);
    }

    // Calculate how many us 2 character times is (and round up for safety)
    two_char_times_us = ((2*CHAR_BITS*sys_clocks_per_spi_clock) +
(bd->bi_busfreq-1))/bd->bi_busfreq; // round up

	// Get internal registers
    immap = (immap_t *)IMAP_ADDR;

	//cpm interrupt controller
	cpi = (cpic8xx_t*)&(immap->im_cpic);

	//cpm interrupt controller
    sys = (sysconf8xx_t*)&(immap->im_siu_conf);

	// Get pointer to Communication Processor
    cp = cpmp;
    spi = (volatile spi_t *)&cp->cp_dparam[PROFF_SPI];

#if USE_IIC_PATCH // I2C patch also relocates SPI
	// Check for SPI relocation patch
    if ((reloc = spi->spi_rpbase)) {
        spi = (spi_t *)&cp->cp_dpmem[spi->spi_rpbase];
        printk(" MICROCODE RELOCATION PATCH \n");
    }
#endif
    /* Initialize the parameter ram.
     * We need to make sure many things are initialized to zero,
     * especially in the case of a microcode patch.
     */
    spi->spi_rstate = 0;
    spi->spi_rdp = 0;
    spi->spi_rbptr = 0;
    spi->spi_rbc = 0;
    spi->spi_rxtmp = 0;
    spi->spi_tstate = 0;
    spi->spi_tdp = 0;
    spi->spi_tbptr = 0;
    spi->spi_tbc = 0;
    spi->spi_txtmp = 0;

    /* Allocate space for one transmit and one receive buffer
     * descriptor in the DP ram.
     */
    cpm_spi_dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * 2);

    // Set up the SPI parameters in the parameter ram.
    spi->spi_rbase = r_rbase = cpm_spi_dp_addr;
    spi->spi_tbase = t_tbase = cpm_spi_dp_addr + sizeof(cbd_t);

	/***********IMPORTANT******************/
	/* Setting transmit and receive buffer descriptor
	   pointers intially to rbase and rbase. Only the
	   microcode patches documentation talks about initializing
	   this pointer. This is missing from the sample I2C driver.
	   If you dont initialize these pointers, the kernel hangs. */
    spi->spi_rbptr = r_rbase;
    spi->spi_tbptr = t_tbase;

    // Set to big endian
    spi->spi_tfcr = SMC_EB;
    spi->spi_rfcr = SMC_EB;

    // Set maximum receive size
    spi->spi_mrblr = SPI_BUFFER_SIZE;

    // Setting CPCR (initialise rx and tx params)
	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SPI,CPM_CR_INIT_TRX) | CPM_CR_FLG;

    // Wait for acknowledgement
    while (cp->cp_cpcr & CPM_CR_FLG)
       ;
    // sets SDMA configuration register
	immap->im_siu_conf.sc_sdcr = 0x0001;

	// clear all spi events
    cp->cp_spie = 0xff;

	// Clear SPI interrupt Mask (We only want interrupts when device is open)
    cp->cp_spim = 0;

	/* My PortB setting */
	/* These setting may be different for you.
	   Refer example 16-443 MPC823 Manual*/

    // Port B pin 31 configured as
    // actively driven General purpose
    // output
    // Port B pins 28, 29, 30
    // configured as SPIMISO, SPIMOSI,
    // and SPICLK, respectively
	cp->cp_pbodr &= ~0x000e;
    cp->cp_pbodr |=  0x0001;
	cp->cp_pbdir |=  0x000f;
    cp->cp_pbpar &= ~0x0001;
	cp->cp_pbpar |=  0x000e;

    // Initialise PA1 and PA3 for output - these go to CLKXSRC on McBSB1
    // and CS on E1 line driver, respectively
    t1_cs_init(2, 1);
    t1_cs_init(2, 3);

	// tx and rx buffer descriptors
	tbd = (volatile cbd_t *)&cp->cp_dpmem[t_tbase];
	rbd = (volatile cbd_t *)&cp->cp_dpmem[r_rbase];

	// Initialize tx and rx bd's (in particular
    // clear the BD_SC_READY and BD_SC_EMPTY bits
    memset((void*)tbd, 0, sizeof(cbd_t));
    memset((void*)rbd, 0, sizeof(cbd_t));

	// Allocate 1 page of host memory for the data
	hostpage = __get_dma_pages(GFP_KERNEL,0 /*order*/);
    pte = va_to_pte(hostpage);

    // Save the current pte setting for the page
    pte_val(pte_old) = pte_val(*pte);

    // Disable cacheing for the page
    pte_val(*pte) |= _PAGE_NO_CACHE;

    // Make it clean
    flush_tlb_page(current->mm->mmap, hostpage);

    rxbuffer = (unsigned char *) hostpage;
    txbuffer = rxbuffer + SPI_BUFFER_SIZE;

	/* Set the bd's rx and tx buffer address pointers */
    tbd->cbd_bufaddr = __pa(txbuffer);
    rbd->cbd_bufaddr = __pa(rxbuffer);

    /* install interrupt handler if using interrupts */
    cpm_install_handler(CPMVEC_SPI, cpm_spi_interrupt, (void *)spi);

    /* register spi device */
    if (register_chrdev(CPM_SPI_CDEV_MAJOR,cpm_spi_drivername,&cpm_spi_fops))
        printk("unable to get major %d for SPI devs\n",
               CPM_SPI_CDEV_MAJOR);

    printk("Successfully registered spi major=%d\n", CPM_SPI_CDEV_MAJOR);

    /* initialise the semaphore for mutual exclusion */
    sema_init(&spi_sem, 1);

    return 0;
}

/* Open does not have to do much */
static int cpm_spi_open(struct inode *ip, struct file *fp)
{
	DPRINTK(__FUNCTION__ "\n");

    fp->f_op = &cpm_spi_fops;

	/* Increment the number of users. */
    if (cpm_spi_users++ == 0)
    {
        /* If this is the first user we need to initialise device */
        /* Write to SPMODE */
        cpmp->cp_spmode = spmode;
        DPRINTK("cpmp->cp_spmode=%04x\n",cpmp->cp_spmode);

        /* Set mask to allow all interrupts */
        cpmp->cp_spim =
            SPIE_MME|
            SPIE_TXE|
            SPIE_BSY|
            SPIE_TXB|
            SPIE_RXB;
    }

    return(0);
}

static int cpm_spi_close(struct inode *ip, struct file *fp)
{
	DPRINTK(__FUNCTION__ "\n");

    if (--cpm_spi_users == 0)
    {
        /* If no more users left shut down SPI. */
        cpmp->cp_spmode = 0;
        cpmp->cp_spie = 0xff;
        cpmp->cp_spim = 0;
    }

    return(0);
}


/* write is exactly like read.
   spi does read and write simultaneously */

static ssize_t cpm_spi_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
{
    volatile immap_t	*immap;
    volatile cpic8xx_t 	*cpi;
    volatile cpm8xx_t	*cp;

    // Cannot have 2 users sending or receiving at once
    wait_event_interruptible(lockq,reading_writing == 0);
    reading_writing = 1;

	DPRINTK(__FUNCTION__ "\n");

    // Make sure buffer is not greater than buffer size !
    if (count > SPI_BUFFER_SIZE)
        return -EINVAL;

    // Get internal memory map
    immap = (immap_t *)IMAP_ADDR;

    // Get cpm interrupt controller
    cpi = (cpic8xx_t*) &(immap->im_cpic);

    // Get pointer to Communication Processor
    cp = cpmp;

    // Make sure BD is not in use !
    if ((tbd->cbd_sc & BD_SC_READY) || (rbd->cbd_sc & BD_SC_EMPTY))
    {
        printk("Error: BD in use\n");
        return -EFAULT;
    }

    // Set the tx bd status and data length
    tbd->cbd_sc =  BD_SC_READY | BD_SC_LAST | BD_SC_WRAP | BD_SC_INTRPT;
    tbd->cbd_datlen  = count;

    // Set rx bd status and data length (=0 because we're not reading here)
    rbd->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;
    rbd->cbd_datlen = 0;

    // Copy transmit data from user space to tx buffer */
    if (copy_from_user((void*)txbuffer,(void*)buf, count))
    {
        printk("Error: copying from user\n");
        return -EFAULT;
    }

    // Start spi transfer
    cp->cp_spcom  |= 0x80;

    // Wait for transfer to complete
    wait_event_interruptible(waitq, (tbd->cbd_sc & BD_SC_READY) == 0 && (rbd->cbd_sc & BD_SC_EMPTY)
== 0);
    DPRINTK("txsc=%04x/rxsc=%04x\n", tbd->cbd_sc, rbd->cbd_sc);

    // Wait two char times like the book says
    udelay(two_char_times_us);

    // Allow another user to send or receive
    reading_writing = 0;
    wake_up_interruptible(&lockq);

    return count;
}


/* read is exactly like write.
   spi does read and write simultaneously.
   It's not exactly simultaneous. I've noticed that transmit is done
   first and then receive.*/

static ssize_t cpm_spi_read(struct file *file, char *buf,
                            size_t count, loff_t *ppos)
{
    volatile immap_t	*immap;
    volatile cpic8xx_t 	*cpi;
    volatile cpm8xx_t	*cp;

    // Cannot have 2 users sending or receiving at once
    wait_event_interruptible(lockq,reading_writing == 0);
    reading_writing = 1;

	DPRINTK(__FUNCTION__ "\n");

    // Make sure buffer is not greater than buffer size !
    if (count > SPI_BUFFER_SIZE)
    {
        return -EINVAL;
    }

    //printk("Count is %d\n", count);

    immap = (immap_t *)IMAP_ADDR;   /* and to internal registers */

    cpi = (cpic8xx_t*)&(immap->im_cpic); //cpm interrupt controller
    cp = cpmp;	/* Get pointer to Communication Processor */

    // check BDs are not in use!
    if ((tbd->cbd_sc & BD_SC_READY) || (rbd->cbd_sc & BD_SC_EMPTY))
    {
        printk("Error: BD in use\n");
        return -EFAULT;
    }

    /* Initialize buffer memory to empty */
    memset((void*)txbuffer, 0, count);

    // Setting tx bd status and data length
    tbd->cbd_sc =  BD_SC_READY | BD_SC_LAST | BD_SC_WRAP | BD_SC_INTRPT;
    tbd->cbd_datlen  = count; /* We write count 0 s and hope device ignores it */

    // Setting rx bd status and data length
    rbd->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;
    rbd->cbd_datlen = count;

    // Start spi transfer
    cp->cp_spcom |= 0x80;

    // Wait for transfer to complete
    wait_event_interruptible(waitq, (tbd->cbd_sc & BD_SC_READY) == 0 && (rbd->cbd_sc & BD_SC_EMPTY)
== 0);
    DPRINTK("txsc=%04x/rxsc=%04x\n", tbd->cbd_sc, rbd->cbd_sc);

    // Wait two char times like the book says
    udelay(two_char_times_us);

    // Transfer is done.

    //printk("Reception: ");
    //memdump((void*)rxbuffer, count);/* dump of rxbuffer after transmit */

    /* copy received bytes to user space */
    /***********
     *  Please note that the data in rxbuffer is in big endian format.
     *  you will have to flip it.
     *************/
    copy_to_user((void*)buf, (void*)rxbuffer, count);

    // Allow another user to send or receive
    reading_writing = 0;
    wake_up_interruptible(&lockq);

    return count;
}

/* Interrupt handler in case you use spi interrupts. I have tried using the interrupts
   and they work just fine. You can use his handler to detect */
static void cpm_spi_interrupt(void *dev_id)
{
    unsigned char events = cpmp->cp_spie;

	DPRINTK("Spi event reg. 0x%x\n", events);

	/* reset spi event register and mode */
	cpmp->cp_spie = events;

    if (SPIE_MME & events)
        printk ("Error: ~SPISEL asserted externally while SPI in master mode\n");

    if (SPIE_TXE & events)
        printk("Error: Tx error\n");

    if (SPIE_BSY & events)
        printk("Error: No Rx buffer available\n");

    if (SPIE_TXB & events)
        wake_up_interruptible(&waitq);

    if (SPIE_RXB & events)
        wake_up_interruptible(&waitq);
}
/********************************************************
 * module_init() is called by insmod, if built as module,
 * or by do_initcalls(), if built as a resident driver.
 ********************************************************/
module_init(cpm_spi_init);

#ifdef MODULE
static void __exit cpm_spi_exit(void)
{
    volatile cpm8xx_t	*cp = cpmp;
    pte_t *pte;

    // Only allow this is no user has device open
    // This should be automatically true.
    // (This means we're not going to get any interrupts while doing rmmod.)
    if (cpm_spi_users != 0)
        printk(__FILE__ " " __FUNCTION__ " line %d: This should not happen\n", __LINE__);

    // unregister the driver majore number
    if (unregister_chrdev(CPM_SPI_CDEV_MAJOR, cpm_spi_drivername) < 0)
        printk(__FILE__ " " __FUNCTION__ " line %d: This should not happen\n", __LINE__);

    // uninstall cpm interrupt handler
    cpm_free_handler(CPMVEC_SPI);

    // Hand back page containing rxbuffer and txbuffer
    pte = va_to_pte(hostpage);
    pte_val(*pte) = pte_val(pte_old);

    // Make it clean
    flush_tlb_page(current->mm->mmap, hostpage);

    // Free the page
    free_pages(hostpage, 0 /*order*/);

    // Reinitialise cs's back to old state
    t1_cs_init(2, 3);
    t1_cs_init(2, 1);

    // Reinitialise Port B
    cp->cp_pbpar &=  ~0x000f;
	cp->cp_pbdir |=  0x000f;
    cp->cp_pbdat |=  0x000f;


    // Free the memory allocated to cpm_spi_dp_addr
    m8xx_cpm_dpfree(cpm_spi_dp_addr);
}
module_exit(cpm_spi_exit);
#endif // MODULE

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
