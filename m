Message-ID: <001901c06aa8$c72f4df0$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: SPI driver problems
Date: Wed, 20 Dec 2000 17:17:49 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,

I am trying to implement an SPI driver for my custom board with 823.  I have
3 uarts connected to my SPI controller. PBDAT is used as chip selects for
these devices. I followed the IIC driver example for the 823 by Dan Malek. I
setup the receive and transmit buffer rings and data buffers. When I start
the transfer by setting SPCOM |= 0x80, the board just hangs. I dont see
anything. I do have an interrupt handler which does not seem to be working.
I am attaching the code. Can anyone suggest anything?

Thank you,
Sincerely,
Navin Boppuri

/* MPC8xx CPM SPI interface.
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
#include <asm/imd.h>
#include "commproc.h"

char quickhex(int i)
{
  if(i >= 10 ) return i - 10 + 'A';
  return i + '0';
}

int quickisprint(int c)
{
  if( c >= 'A' && c <= 'Z' ) return 1;
  if( c >= 'a' && c <= 'z' ) return 1;
  if( c >= '0' && c <= '9' ) return 1;
  return 0;
}

void memdump(void *pv, int num)
{
  int i;
  unsigned char* pc = (unsigned char*)pv;
  for(i = 0; i < num; i++ )
    printk("%c%c ", quickhex(pc[i] >> 4), quickhex(pc[i] & 0x0f));
  printk("\t");
  for(i = 0; i < num; i++ )
    printk("%c", quickisprint(pc[i]) ? pc[i] : '.');
  printk("\n");
}

/* This is the SPI device number, but I use the minors to indicate
 * the SPI device address.
 */
#define CPM_SPI_CDEV_MAJOR 89

void cpm_spi_init(void);
static int cpm_spi_open(struct inode *, struct file *);
static int cpm_spi_close(struct inode *, struct file *);
static ssize_t cpm_spi_write(struct file *, char *, size_t, loff_t *);
static void cpm_spi_interrupt(void *);

static struct file_operations cpm_spi_fops = {
 NULL,  /* lseek */
 NULL, /* read */
 cpm_spi_write,  /* write */
 NULL,  /* readdir */
 NULL,  /* poll */
 NULL,  /* ioctl */
 NULL,  /* mmap */
 cpm_spi_open,   /* open */
 NULL,  /* flush */
 cpm_spi_close,  /* close */
};

/* Only one user at a time.
*/
static int cpm_spi_flags;
#define CPM_SPI_OPEN 0x01

static dev_t spi_device;

static struct wait_queue *spi_wait;

static
ushort r_tbase, r_rbase;

void
cpm_spi_init()
{
 uint mem_addr, dp_addr, reloc;
 volatile cpm8xx_t *cp;
 volatile spi_t  *spi;
 volatile immap_t *immap;
 volatile cpic8xx_t  *cpi;
 volatile sysconf8xx_t   *sys;

 immap = (immap_t *)IMAP_ADDR; /* and to internal registers */

 cpi = (cpic8xx_t*)&(((immap_t*)IMAP_ADDR)->im_cpic); file://cpm interrupt
controller
 sys = (sysconf8xx_t*)&(((immap_t*)IMAP_ADDR)->im_siu_conf); file://cpm
interrupt controller

 cp = cpmp; /* Get pointer to Communication Processor */

 spi = (spi_t *)&cp->cp_dparam[PROFF_SPI];

 printk("Initializing spi\n");

 /* Check for and use a microcode relocation patch.
 */
 if ((reloc = spi->spi_rpbase))
 {
  spi = (spi_t *)&cp->cp_dpmem[spi->spi_rpbase];
  printk(" MICROCODE RELOCATION PATCH ");
 }


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
 dp_addr = m8xx_cpm_dpalloc(sizeof(cbd_t) * 2);

 /* Set up the IIC parameters in the parameter ram.
 */
 spi->spi_rbase = r_rbase = dp_addr;
 spi->spi_tbase = r_tbase = dp_addr + sizeof(cbd_t);

 /* Set the buffer address.*/
 spi->spi_tfcr = SMC_EB;
 spi->spi_rfcr = SMC_EB;

 /* Set maximum receive size.*/
 spi->spi_mrblr = 64;

 /* Setting CPCR */
// if (reloc == 0) {
//  cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_INIT_TRX) | CPM_CR_FLG;
//  while (cp->cp_cpcr & CPM_CR_FLG);
// }
 cp->cp_cpcr |= 0x51;
 immap->im_siu_conf.sc_sdcr = 0x0001;

 cp->cp_spie = 0xff; file://clear all spi events
 cp->cp_spim = 0x00; file://mask all SPI events

 /* Setting some interrupts */
 file://cpi->cpic_cimr |= 0x00000020;
 sys->sc_simask |= 0x20400000;
 sys->sc_siel   |= 0x20000000;

 /* SPI Mode setting */
 cp->cp_spmode = 0x0fff;

 asm("mtspr 80,0");

 /* Install interrupt handler.
 */
 cpm_install_handler(CPMVEC_SPI, cpm_spi_interrupt, (void *)spi);

 if (register_chrdev(CPM_SPI_CDEV_MAJOR,"spi",&cpm_spi_fops))
  printk("unable to get major %d for SPI devs\n",
    CPM_SPI_CDEV_MAJOR);


 printk("Succesfully registered spi 89 \n");


return;
}

/* Open does not have to do much, just make sure only one user.
*/
static int
cpm_spi_open(struct inode *ip, struct file *fp)
{
 printk("Opening spi \n");
 /* We allow only one user of the device.
 */
 if (cpm_spi_flags & CPM_SPI_OPEN) /* device is busy */
  return(EBUSY);

 fp->f_op = &cpm_spi_fops;

 spi_device = MINOR(ip->i_rdev);

 cpm_spi_flags |= CPM_SPI_OPEN;

 printk("Successfully opened spi\n");

 return(0);
}

static int
cpm_spi_close(struct inode *ip, struct file *fp)
{
 volatile cpm8xx_t *cp;
 cp = cpmp;

 printk("Closing spi \n");

 /* Shut down SPI.
 */
 cp->cp_spmode = 0;
 cp->cp_spie = 0xff;
 cp->cp_spim = 0;

 cpm_spi_flags &= ~CPM_SPI_OPEN;

 printk("Closed spi \n");

return(0);
}


/* Read
 */
static ushort txbuffer[64]; // transmit buffer
static  ushort  rxbuffer[64]; file://receive buffer

static ssize_t
cpm_spi_write(struct file *file, char *buf, size_t count, loff_t *ppos)
{
 volatile buf_t* spi_buf = 0;
 volatile uint virt_addr = 0;
 volatile cpic8xx_t *cpi;
 volatile cbd_t *tbdf, *rbdf;
 volatile cpm8xx_t *cp;
 char tspitemp[count];
 int i;
 unsigned long flags;


 cpi = (cpic8xx_t*)&(((immap_t*)IMAP_ADDR)->im_cpic); file://cpm interrupt
controller

 cp = cpmp; /* Get pointer to Communication Processor */

 tbdf = (cbd_t *)&cp->cp_dpmem[r_tbase];
 rbdf = (cbd_t *)&cp->cp_dpmem[r_rbase];

 /* Preparing transmit buffer */
 for(i = 0;i < count+1;i++)
 {
  if(i == 0)
   txbuffer[i] = 0x0bc4; /* uart initialization */
  else
   txbuffer[i] = ((ushort)buf[i-1] << 8) | 0x0080; /* data in BIG-Endian */
 }
 memdump((void*)txbuffer,32); /* view txbuffer */

 tbdf->cbd_bufaddr = __pa(txbuffer);
 tbdf->cbd_datlen  = (count*2) + 2;
 tbdf->cbd_sc =  BD_SC_READY | BD_SC_LAST;

 memdump((void*)rxbuffer,32); /* view rxbuffer */
 rbdf->cbd_bufaddr = __pa(rxbuffer);
 rbdf->cbd_datlen = 0;
 rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_INTRPT | BD_SC_LAST;


 /* Setting up Port B */

 cp->cp_pbodr &= ~(0x000e);
 cp->cp_pbdir |= 0x000f;
 cp->cp_pbpar |= 0x000e;

 cp->cp_pbodr &= ~(0x1230);
 cp->cp_pbdir |= 0x1230;
 cp->cp_pbpar &= ~(0x1231);

 cp->cp_pbdat |= 0x0001;
 cp->cp_pbdat |= 0x1230;
 cp->cp_pbdat &= ~(0x0010);



 save_flags(flags);cli();

 cp->cp_spie = 0xff; file://clear all spi events
 cp->cp_spim = 0x37; file://mask all SPI events

 /* Starting transfer */
 cp->cp_spcom   |= 0x80;
 cpi->cpic_cicr |= 0x0080;

 interruptible_sleep_on(&spi_wait);
 restore_flags(flags);
 if (signal_pending(current))
  return -ERESTARTSYS;

 printk("Done writing, now return\n");
 return count;
}



static void
cpm_spi_interrupt(void *dev_id)
{
 volatile spi_t *spi;
 volatile cpm8xx_t *cp;

 cp = cpmp; /* Get pointer to Communication Processor */

 printk("In interuppt code\n");
 spi = (spi_t *)dev_id;

 /* Chip errata, clear enable.
 */
 cp->cp_spmode = 0;

 /* Clear interrupt.
 */
 cp->cp_spie = 0xff;

 /* Get 'me going again.
 */
 wake_up_interruptible(&spi_wait);

 printk("Leaving interrupt code\n");
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
