Return-Path: <cajus.hahn@de.abb.com>
Received: from nse3.abb.com (nse3.abb.com [129.35.204.69])
	by ozlabs.org (Postfix) with ESMTP id 4D62667ED6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 18:20:00 +1000 (EST)
Received: from abb-despk-smtp.de.abb.com (deehn-s-cc1gw54.de.abb.com
	[10.51.20.40])
	by nse3.abb.com (8.11.6/8.11.6) with ESMTP id j7A7S1v25815
	for <linuxppc-embedded@ozlabs.org>; Wed, 10 Aug 2005 09:28:02 +0200
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF065A7C05.DE2F464C-ONC1257059.00217532-C1257059.00290301@de.abb.com>
From: cajus.hahn@de.abb.com
Date: Wed, 10 Aug 2005 09:27:57 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Subject: 8xx: i2c-algo-8xx - fixed timeout detection and transmission errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>





Hi all,

I had some problems on my MPC855M based board when I tried to access th=
e
i2c bus.
The cause were some disturbances on the i2c bus. If a slave device or
another master device hold the SDA or SCL line low, the CPM will get in=
to a
state, where no more transmissions are made. The  only way I found, to =
get
the CPM back to work, was a complete re-initialisation. -> force_reinit=
()
In this case the busy-wait for transmissions with count < 16 will lock =
the
complete system (CPU load 99.9%)
I added the define I2C_BUSY_WAIT to switch between faster access or saf=
er
system.
I found out that the i2c-algo-8xx.c has a bug in cpm_iic_read() and
cpm_iic_write(): the timeout detection will not work in the case of cou=
nt <
16.
I also added the define I2C_INTERRUPTIBLE_SLEEP: the old driver reporte=
d
IO-error (-EIO) if a timeout occured (which was not working, see above)=
 or
if a signal was pending. This caused some problems if the process recei=
ves
user-signals. The driver will report IO-error, which is not correct. Wi=
th
the busy-wait this effect might not be seen, because there will be no
process scheduling -> no signals might be send.
My modified file is appended. The defines for  I2C_BUSY_WAIT and
I2C_INTERRUPTIBLE_SLEEP are active, which let the driver act like the o=
ld
one.
Maybe this is helpful for others too and some of the modifications find=

it=B4s way into the official kernel tree.

Cajus Hahn

/*
 * i2c-algo-8xx.c i2x driver algorithms for MPC8XX CPM
 * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
 *
    This program is free software; you can redistribute it and/or modif=
y
    it under the terms of the GNU General Public License as published b=
y
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * moved into proper i2c interface; separated out platform specific
 * parts into i2c-rpx.c
 * Brad Parker (brad@heeltoe.com)
 *
 * added define for BUSY_WAIT and INTERRUPTIBLE_SLEEP, added
I2C_ALGO_8XX_DATE + ..VERSION
 * fixed bug in cpm_iic_read and cpm_iic_write (timeout never detected =
if
count < 16)
 * added force_reinit(): in certain cases (disturbances on the I2C bus)=
 a
timeout will
 * occur. After this a complete re-initialisation will be necessary,
otherwise all
 * following transmissions will have a timeout.
 * Cajus Hahn, 09.08.2005
 */

// XXX todo
// timeout sleep?

/* $Id: i2c-algo-8xx.c,v 1.1.1.1 2004/12/10 08:44:35 cajus Exp $ */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/delay.h>
#include <linux/slab.h>
#include <linux/version.h>
#include <linux/init.h>
#include <asm/uaccess.h>
#include <linux/ioport.h>
#include <linux/errno.h>
#include <linux/sched.h>

#include <asm/mpc8xx.h>
#include <asm/commproc.h>

#include <linux/i2c.h>
#include <linux/i2c-algo-8xx.h>

#define I2C_ALGO_8XX_DATE "20050809"
#define I2C_ALGO_8XX_VERSION "2.6.2"

#define CPM_MAX_READ    513
/* #define I2C_CHIP_ERRATA */ /* Try uncomment this if you have an olde=
r
CPU(earlier than rev D4) */
#define I2C_BUSY_WAIT  /* Uncomment this if you want to do a busy wait =
in
cpm_iic_read and cpm_iic_write */
#define I2C_INTERRUPTIBLE_SLEEP /* Uncomment this if you want the waiti=
ng
in cpm_iic_read and
                                         cpm_iic_write beeing interrupt=
able
by signals */

static wait_queue_head_t iic_wait;
static ushort r_tbase, r_rbase;

int cpm_scan =3D 0;
int cpm_debug =3D 0;

static  void
cpm_iic_interrupt(void *dev_id, struct pt_regs *regs)
 {
      volatile i2c8xx_t *i2c =3D (i2c8xx_t *)dev_id;

      if (cpm_debug > 1)
            printk(KERN_DEBUG "cpm_iic_interrupt(dev_id=3D%p)\n", dev_i=
d);

#ifdef I2C_CHIP_ERRATA
      /* Chip errata, clear enable.
       * This seems to not be needed on rev D4 or newer CPUs.
       * Someone with an older CPU needs to verify this.
       */
      i2c->i2c_i2mod &=3D ~1;
#endif

      /* Clear interrupt.
      */
      i2c->i2c_i2cer =3D 0xff;

      /* Get 'me going again.
      */
#ifdef I2C_INTERRUPTIBLE_SLEEP
      wake_up_interruptible(&iic_wait);
#else
      wake_up(&iic_wait);
#endif
}

static void
cpm_iic_init(struct i2c_algo_8xx_data *cpm_adap)
{
      volatile iic_t          *iip =3D cpm_adap->iip;
      volatile i2c8xx_t *i2c =3D cpm_adap->i2c;
      unsigned char brg;
      bd_t *bd =3D (bd_t *)__res;

      if (cpm_debug) printk(KERN_DEBUG "cpm_iic_init() - iip=3D%p\n",ii=
p);

      /* Initialize the parameter ram.
       * We need to make sure many things are initialized to zero,
       * especially in the case of a microcode patch.
       */
      iip->iic_rstate =3D 0;
      iip->iic_rdp =3D 0;
      iip->iic_rbptr =3D 0;
      iip->iic_rbc =3D 0;
      iip->iic_rxtmp =3D 0;
      iip->iic_tstate =3D 0;
      iip->iic_tdp =3D 0;
      iip->iic_tbptr =3D 0;
      iip->iic_tbc =3D 0;
      iip->iic_txtmp =3D 0;

      /* Set up the IIC parameters in the parameter ram.
      */
      iip->iic_tbase =3D r_tbase =3D cpm_adap->dp_addr;
      iip->iic_rbase =3D r_rbase =3D cpm_adap->dp_addr + sizeof(cbd_t)*=
2;

      iip->iic_tfcr =3D SMC_EB;
      iip->iic_rfcr =3D SMC_EB;

      /* Set maximum receive size.
      */
      iip->iic_mrblr =3D CPM_MAX_READ;

      /* Initialize Tx/Rx parameters.
      */
      if (cpm_adap->reloc =3D=3D 0) {
            volatile cpm8xx_t *cp =3D cpm_adap->cp;

            cp->cp_cpcr =3D
                  mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FL=
G;
            while (cp->cp_cpcr & CPM_CR_FLG);
      } else {
            iip->iic_rbptr =3D iip->iic_rbase;
            iip->iic_tbptr =3D iip->iic_tbase;
            iip->iic_rstate   =3D 0;
            iip->iic_tstate   =3D 0;
      }

      /* Select an arbitrary address.  Just make sure it is unique.
      */
      i2c->i2c_i2add =3D 0xfe;

      /* Make clock run at 60 KHz.
      */
      brg =3D (unsigned char) (bd->bi_intfreq/(32*2*60000) -3);
      i2c->i2c_i2brg =3D brg;

      i2c->i2c_i2mod =3D 0x00;
      i2c->i2c_i2com =3D 0x01; /* Master mode */

      /* Disable interrupts.
      */
      i2c->i2c_i2cmr =3D 0;
      i2c->i2c_i2cer =3D 0xff;

      init_waitqueue_head(&iic_wait);

      /* Install interrupt handler.
      */
      if (cpm_debug) {
            printk (KERN_DEBUG "%s[%d] Install ISR for IRQ %d\n",
                  __func__,__LINE__, CPMVEC_I2C);
      }
      cpm_install_handler(CPMVEC_I2C, cpm_iic_interrupt, (void *)i2c);
}


static int
cpm_iic_shutdown(struct i2c_algo_8xx_data *cpm_adap)
{
      volatile i2c8xx_t *i2c =3D cpm_adap->i2c;

      /* Shut down IIC.
      */
      i2c->i2c_i2mod &=3D ~1;
      i2c->i2c_i2cmr =3D 0;
      i2c->i2c_i2cer =3D 0xff;

      return(0);
}

static void
cpm_reset_iic_params(volatile iic_t *iip)
{
      iip->iic_tbase =3D r_tbase;
      iip->iic_rbase =3D r_rbase;

      iip->iic_tfcr =3D SMC_EB;
      iip->iic_rfcr =3D SMC_EB;

      iip->iic_mrblr =3D CPM_MAX_READ;

      iip->iic_rstate =3D 0;
      iip->iic_rdp =3D 0;
      iip->iic_rbptr =3D iip->iic_rbase;
      iip->iic_rbc =3D 0;
      iip->iic_rxtmp =3D 0;
      iip->iic_tstate =3D 0;
      iip->iic_tdp =3D 0;
      iip->iic_tbptr =3D iip->iic_tbase;
      iip->iic_tbc =3D 0;
      iip->iic_txtmp =3D 0;
}

#define BD_SC_NAK       ((ushort)0x0004) /* NAK - did not respond */
#define BD_SC_OV        ((ushort)0x0002) /* OV - receive overrun */
#define CPM_CR_CLOSE_RXBD     ((ushort)0x0007)

static void force_close(struct i2c_algo_8xx_data *cpm)
{
      volatile i2c8xx_t *i2c =3D cpm->i2c;

        if (cpm_debug)
            printk(KERN_DEBUG "force_close()");

      if (cpm->reloc =3D=3D 0) { /* micro code disabled */
            volatile cpm8xx_t *cp =3D cpm->cp;
            cp->cp_cpcr =3D
                  mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
                  CPM_CR_FLG;

            while (cp->cp_cpcr & CPM_CR_FLG);
      }

      i2c->i2c_i2cmr =3D 0x00;  /* Disable all interrupts */
      i2c->i2c_i2cer =3D 0xff;
}

static void force_reinit(struct i2c_algo_8xx_data *cpm)
{
      volatile iic_t *iip =3D cpm->iip;
      volatile i2c8xx_t *i2c =3D cpm->i2c;
      volatile cpm8xx_t *cp =3D cpm->cp;
      unsigned char brg;
      bd_t *bd =3D (bd_t *)__res;

      // Disable interrupts.
      i2c->i2c_i2cmr =3D 0;
      i2c->i2c_i2cer =3D 0xff;
        // Clear enable
      i2c->i2c_i2mod &=3D ~1;

      // Initialize the parameter ram.
      iip->iic_rstate =3D 0;
      iip->iic_rdp =3D 0;
      iip->iic_rbptr =3D 0;
      iip->iic_rbc =3D 0;
      iip->iic_rxtmp =3D 0;
      iip->iic_tstate =3D 0;
      iip->iic_tdp =3D 0;
      iip->iic_tbptr =3D 0;
      iip->iic_tbc =3D 0;
      iip->iic_txtmp =3D 0;
        iip->iic_tbase =3D r_tbase;
      iip->iic_rbase =3D r_rbase;
      iip->iic_tfcr =3D SMC_EB;
      iip->iic_rfcr =3D SMC_EB;
      iip->iic_mrblr =3D CPM_MAX_READ;

      if (cpm->reloc =3D=3D 0)
        {
            cp->cp_cpcr =3D mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) |=

CPM_CR_FLG;
            while (cp->cp_cpcr & CPM_CR_FLG);
      }
        else
        {
            iip->iic_rbptr =3D iip->iic_rbase;
            iip->iic_tbptr =3D iip->iic_tbase;
            iip->iic_rstate   =3D 0;
            iip->iic_tstate   =3D 0;
      }

      // Select an arbitrary address.  Just make sure it is unique.
      i2c->i2c_i2add =3D 0xfe;

      // Make clock run at 60 KHz.
      brg =3D (unsigned char) (bd->bi_intfreq/(32*2*60000) -3);
      i2c->i2c_i2brg =3D brg;

      i2c->i2c_i2mod =3D 0x00;
      i2c->i2c_i2com =3D 0x01; /* Master mode */
}

/* Read from IIC...
 * abyte =3D address byte, with r/w flag already set
 */
static int
cpm_iic_read(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf, in=
t
count)
{
      volatile iic_t *iip =3D cpm->iip;
      volatile i2c8xx_t *i2c =3D cpm->i2c;
      volatile cpm8xx_t *cp =3D cpm->cp;
      volatile cbd_t    *tbdf, *rbdf;
      u_char *tb;
      unsigned long flags, tmo, timedout;

      if (count >=3D CPM_MAX_READ)
            return -EINVAL;

      /* check for and use a microcode relocation patch */
      if (cpm->reloc) {
            cpm_reset_iic_params(iip);
      }

      tbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
      rbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];

      /* To read, we need an empty buffer of the proper length.
       * All that is used is the first byte for address, the remainder
       * is just used for timing (and doesn't really have to exist).
       */
      tb =3D cpm->temp;
      tb =3D (u_char *)(((uint)tb + 15) & ~15);
      tb[0] =3D abyte;          /* Device address byte w/rw flag */

      flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));

      if (cpm_debug) printk(KERN_DEBUG "cpm_iic_read(abyte=3D0x%x)\n",
abyte);

      tbdf->cbd_bufaddr =3D __pa(tb);
      tbdf->cbd_datlen =3D count + 1;
      tbdf->cbd_sc =3D
            BD_SC_READY | BD_SC_LAST |
            BD_SC_WRAP | BD_IIC_START;

      iip->iic_mrblr =3D count + 1; /* prevent excessive read, +1
                              is needed otherwise will the
                              RXB interrupt come too early */

      /* flush will invalidate too. */
      flush_dcache_range((unsigned long) buf, (unsigned long) (buf+coun=
t));

      rbdf->cbd_datlen =3D 0;
      rbdf->cbd_bufaddr =3D __pa(buf);

      rbdf->cbd_sc =3D BD_SC_EMPTY | BD_SC_WRAP| BD_SC_INTRPT;
        timedout =3D 0;
#ifdef I2C_BUSY_WAIT
      if(count > 16){
#endif
            /* Chip bug, set enable here */
            local_irq_save(flags);
            i2c->i2c_i2cmr =3D 0x13;  /* Enable some interupts */
            i2c->i2c_i2cer =3D 0xff;
            i2c->i2c_i2mod |=3D 1;    /* Enable */
            i2c->i2c_i2com |=3D 0x80; /* Begin transmission */

            /* Wait for IIC transfer */
#ifdef I2C_INTERRUPTIBLE_SLEEP
            tmo =3D interruptible_sleep_on_timeout(&iic_wait,1*HZ);
#else
            tmo =3D sleep_on_timeout(&iic_wait,1*HZ);
#endif
                if(tmo =3D=3D 0) timedout=3D1;
            local_irq_restore(flags);
#ifdef I2C_BUSY_WAIT
      } else { /* busy wait for small transfers, its faster */
            i2c->i2c_i2cmr =3D 0x00;  /* Disable I2C interupts */
            i2c->i2c_i2cer =3D 0xff;
            i2c->i2c_i2mod |=3D 1;    /* Enable */
            i2c->i2c_i2com |=3D 0x80; /* Begin transmission */
            tmo =3D jiffies + 1*HZ;
            while(!(i2c->i2c_i2cer & 0x11 || (timedout =3D
time_after(jiffies, tmo)))); /* Busy wait, with a timeout */
      }
#endif
        if(timedout)
        {
            printk(KERN_DEBUG "cpm_iic_read: timeout!\n");
            force_reinit(cpm);
            return -EIO;
        }

#ifdef I2C_INTERRUPTIBLE_SLEEP
      if (signal_pending(current))
        {
            force_close(cpm);
          if (cpm_debug)
                printk(KERN_DEBUG "cpm_iic_read: signal_pending! \n");
          return -EINTR;
        }
#endif

#ifdef I2C_CHIP_ERRATA
      /* Chip errata, clear enable. This is not needed on rev D4 CPUs.
       Disabling I2C too early may cause too short stop condition */
      udelay(4);
      i2c->i2c_i2mod &=3D ~1;
#endif

      if (cpm_debug) {
            printk(KERN_DEBUG "tx sc %04x, rx sc %04x\n",
                   tbdf->cbd_sc, rbdf->cbd_sc);
      }

      if (tbdf->cbd_sc & BD_SC_READY) {
            printk(KERN_INFO "IIC read; complete but tbuf ready\n");
            force_close(cpm);
            printk(KERN_INFO "tx sc %04x, rx sc %04x\n",
                   tbdf->cbd_sc, rbdf->cbd_sc);
      }

      if (tbdf->cbd_sc & BD_SC_NAK) {
            if (cpm_debug)
                  printk(KERN_DEBUG "IIC read; no ack\n");
            return -EREMOTEIO;
      }

      if (rbdf->cbd_sc & BD_SC_EMPTY) {
            /* force_close(cpm); */
            if (cpm_debug){
                  printk(KERN_DEBUG "IIC read; complete but rbuf empty\=
n");
                  printk(KERN_DEBUG "tx sc %04x, rx sc %04x\n",
                         tbdf->cbd_sc, rbdf->cbd_sc);
            }
            return -EREMOTEIO;
      }

      if (rbdf->cbd_sc & BD_SC_OV) {
            if (cpm_debug)
                  printk(KERN_DEBUG "IIC read; Overrun\n");
            return -EREMOTEIO;;
      }

      if (cpm_debug) printk(KERN_DEBUG "read %d bytes\n",
rbdf->cbd_datlen);

      if (rbdf->cbd_datlen < count) {
            if (cpm_debug)
                  printk(KERN_DEBUG "IIC read; short, wanted %d got %d\=
n",
                         count, rbdf->cbd_datlen);
            return 0;
      }

      return count;
}

/* Write to IIC...
 * addr =3D address byte, with r/w flag already set
 */
static int
cpm_iic_write(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf,in=
t
count)
{
      volatile iic_t *iip =3D cpm->iip;
      volatile i2c8xx_t *i2c =3D cpm->i2c;
      volatile cpm8xx_t *cp =3D cpm->cp;
      volatile cbd_t    *tbdf;
      u_char *tb;
      unsigned long flags, tmo, timedout;

      /* check for and use a microcode relocation patch */
      if (cpm->reloc) {
            cpm_reset_iic_params(iip);
      }
      tb =3D cpm->temp;
      tb =3D (u_char *)(((uint)tb + 15) & ~15);
      *tb =3D abyte;            /* Device address byte w/rw flag */

      flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));
      flush_dcache_range((unsigned long) buf, (unsigned long) (buf+coun=
t));

      if (cpm_debug) printk(KERN_DEBUG "cpm_iic_write(abyte=3D0x%x)\n",=

abyte);

      /* set up 2 descriptors */
      tbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];

      tbdf[0].cbd_bufaddr =3D __pa(tb);
      tbdf[0].cbd_datlen =3D 1;
      tbdf[0].cbd_sc =3D BD_SC_READY | BD_IIC_START;

      tbdf[1].cbd_bufaddr =3D __pa(buf);
      tbdf[1].cbd_datlen =3D count;
      tbdf[1].cbd_sc =3D BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
BD_SC_WRAP;

        timedout =3D 0;
#ifdef I2C_BUSY_WAIT
      if(count > 16){
#endif
            /* Chip bug, set enable here */
            local_irq_save(flags);
            i2c->i2c_i2cmr =3D 0x13;  /* Enable some interupts */
            i2c->i2c_i2cer =3D 0xff;
            i2c->i2c_i2mod |=3D 1;    /* Enable */
            i2c->i2c_i2com |=3D 0x80; /* Begin transmission */

            /* Wait for IIC transfer */
#ifdef I2C_INTERRUPTIBLE_SLEEP
            tmo =3D interruptible_sleep_on_timeout(&iic_wait,1*HZ);
#else
            tmo =3D sleep_on_timeout(&iic_wait,1*HZ);
#endif
                if(tmo =3D=3D 0) timedout=3D1;
            local_irq_restore(flags);
#ifdef I2C_BUSY_WAIT
      } else {  /* busy wait for small transfers, its faster */
            i2c->i2c_i2cmr =3D 0x00;  /* Disable I2C interupts */
            i2c->i2c_i2cer =3D 0xff;
            i2c->i2c_i2mod |=3D 1;    /* Enable */
            i2c->i2c_i2com |=3D 0x80; /* Begin transmission */
            tmo =3D jiffies + 1*HZ;
            while(!(i2c->i2c_i2cer & 0x12 || (timedout =3D
time_after(jiffies, tmo)))); /* Busy wait, with a timeout */
      }
#endif
        if(timedout)
        {
            printk(KERN_DEBUG "cpm_iic_write: timeout!\n");
            force_reinit(cpm);
            return -EIO;
        }

#ifdef I2C_INTERRUPTIBLE_SLEEP
      if (signal_pending(current))
        {
            force_close(cpm);
          if (cpm_debug)
                printk(KERN_DEBUG "cpm_iic_write: signal_pending! \n");=

          return -EINTR;
        }
#endif

#if I2C_CHIP_ERRATA
      /* Chip errata, clear enable. This is not needed on rev D4 CPUs.
       Disabling I2C too early may cause too short stop condition */
      udelay(4);
      i2c->i2c_i2mod &=3D ~1;
#endif
      if (cpm_debug) {
            printk(KERN_DEBUG "tx0 sc %04x, tx1 sc %04x\n",
                   tbdf[0].cbd_sc, tbdf[1].cbd_sc);
      }

      if ((tbdf[0].cbd_sc | tbdf[1].cbd_sc) & BD_SC_NAK) {
            if (cpm_debug)
                  printk(KERN_DEBUG "IIC write; no ack\n");
            return 0;
      }

      if ((tbdf[0].cbd_sc | tbdf[1].cbd_sc) & BD_SC_READY) {
            if (cpm_debug)
                  printk(KERN_DEBUG "IIC write; complete but tbuf
ready\n");
            return 0;
      }

      return count;
}

/* See if an IIC address exists..
 * addr =3D 7 bit address, unshifted
 */
static int
cpm_iic_tryaddress(struct i2c_algo_8xx_data *cpm, int addr)
{
      volatile iic_t *iip =3D cpm->iip;
      volatile i2c8xx_t *i2c =3D cpm->i2c;
      volatile cpm8xx_t *cp =3D cpm->cp;
      volatile cbd_t *tbdf, *rbdf;
      u_char *tb;
      unsigned long flags, len, tmo;

      if (cpm_debug > 1)
            printk(KERN_DEBUG "cpm_iic_tryaddress(cpm=3D%p,addr=3D%d)\n=
", cpm,
addr);

      /* check for and use a microcode relocation patch */
      if (cpm->reloc) {
            cpm_reset_iic_params(iip);
      }

      if (cpm_debug && addr =3D=3D 0) {
            printk(KERN_DEBUG "iip %p, dp_addr 0x%x\n", cpm->iip,
cpm->dp_addr);
            printk(KERN_DEBUG "iic_tbase %d, r_tbase %d\n", iip->iic_tb=
ase,
r_tbase);
      }

      tbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
      rbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];

      tb =3D cpm->temp;
      tb =3D (u_char *)(((uint)tb + 15) & ~15);

      /* do a simple read */
      tb[0] =3D (addr << 1) | 1;      /* device address (+ read) */
      len =3D 2;

      flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));

      tbdf->cbd_bufaddr =3D __pa(tb);
      tbdf->cbd_datlen =3D len;
      tbdf->cbd_sc =3D
            BD_SC_READY | BD_SC_LAST |
            BD_SC_WRAP | BD_IIC_START;

      rbdf->cbd_datlen =3D 0;
      rbdf->cbd_bufaddr =3D __pa(tb+2);
      rbdf->cbd_sc =3D BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;

      local_irq_save(flags);
      i2c->i2c_i2cmr =3D 0x13;  /* Enable some interupts */
      i2c->i2c_i2cer =3D 0xff;
      i2c->i2c_i2mod |=3D 1;    /* Enable */
      i2c->i2c_i2com |=3D 0x80; /* Begin transmission */

      if (cpm_debug > 1) printk(KERN_DEBUG "about to sleep\n");

      /* wait for IIC transfer */
#ifdef I2C_INTERRUPTIBLE_SLEEP
      tmo =3D interruptible_sleep_on_timeout(&iic_wait,1*HZ);
#else
      tmo =3D sleep_on_timeout(&iic_wait,1*HZ);
#endif
      local_irq_restore(flags);

#ifdef I2C_CHIP_ERRATA
      /* Chip errata, clear enable. This is not needed on rev D4 CPUs.
       Disabling I2C too early may cause too short stop condition */
      udelay(4);
      i2c->i2c_i2mod &=3D ~1;
#endif

      if (signal_pending(current) || !tmo){
            force_close(cpm);
            if(cpm_debug && !tmo)
                  printk(KERN_DEBUG "IIC tryaddress: timeout!\n");
            return -EIO;
      }

      if (cpm_debug > 1) printk(KERN_DEBUG "back from sleep\n");

      if (tbdf->cbd_sc & BD_SC_NAK) {
            if (cpm_debug > 1) printk(KERN_DEBUG "IIC try; no ack\n");
            return 0;
      }

      if (tbdf->cbd_sc & BD_SC_READY) {
            printk(KERN_INFO "IIC try; complete but tbuf ready\n");
      }

      return 1;
}

static int cpm_xfer(struct i2c_adapter *i2c_adap,
                struct i2c_msg msgs[],
                int num)
{
      struct i2c_algo_8xx_data *adap =3D i2c_adap->algo_data;
      struct i2c_msg *pmsg;
      int i, ret;
      u_char addr;

      for (i =3D 0; i < num; i++) {
            pmsg =3D &msgs[i];

            if (cpm_debug)
                  printk(KERN_DEBUG "i2c-algo-8xx.o: "
                         "#%d addr=3D0x%x flags=3D0x%x len=3D%d\n buf=3D=
%lx\n",
                         i, pmsg->addr, pmsg->flags, pmsg->len, (unsign=
ed
long)pmsg->buf);

            addr =3D pmsg->addr << 1;
            if (pmsg->flags & I2C_M_RD )
                  addr |=3D 1;
            if (pmsg->flags & I2C_M_REV_DIR_ADDR )
                  addr ^=3D 1;

            if (!(pmsg->flags & I2C_M_NOSTART)) {
            }
            if (pmsg->flags & I2C_M_RD ) {
                  /* read bytes into buffer*/
                  ret =3D cpm_iic_read(adap, addr, pmsg->buf, pmsg->len=
);
                  if (cpm_debug)
                        printk(KERN_DEBUG "i2c-algo-8xx.o: read %d
bytes\n", ret);
                  if (ret < pmsg->len ) {
                        return (ret<0)? ret : -EREMOTEIO;
                  }
            } else {
                  /* write bytes from buffer */
                  ret =3D cpm_iic_write(adap, addr, pmsg->buf, pmsg->le=
n);
                  if (cpm_debug)
                        printk(KERN_DEBUG "i2c-algo-8xx.o: wrote %d\n",=

ret);
                  if (ret < pmsg->len ) {
                        return (ret<0) ? ret : -EREMOTEIO;
                  }
            }
      }
      return (num);
}

static int algo_control(struct i2c_adapter *adapter,
      unsigned int cmd, unsigned long arg)
{
      return 0;
}

static u32 cpm_func(struct i2c_adapter *adap)
{
      return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
             I2C_FUNC_PROTOCOL_MANGLING;
}

/* -----exported algorithm data: ------------------------------------- =
 */

static struct i2c_algorithm cpm_algo =3D {
      "MPC8xx CPM algorithm",
      I2C_ALGO_MPC8XX,
      cpm_xfer,
      NULL,
      NULL,                   /* slave_xmit           */
      NULL,                   /* slave_recv           */
      algo_control,                 /* ioctl          */
      cpm_func,               /* functionality  */
};

/*
 * registering functions to load algorithms at runtime
 */
int i2c_8xx_add_bus(struct i2c_adapter *adap)
{
      int i;
      struct i2c_algo_8xx_data *cpm_adap =3D adap->algo_data;

      if (cpm_debug)
            printk(KERN_DEBUG "i2c-algo-8xx.o: hw routines for %s
registered.\n",
                   adap->name);

      /* register new adapter to i2c module... */

      adap->id |=3D cpm_algo.id;
      adap->algo =3D &cpm_algo;

#ifdef MODULE
      MOD_INC_USE_COUNT;
#endif

      i2c_add_adapter(adap);
      cpm_iic_init(cpm_adap);

      /* scan bus */
      if (cpm_scan) {
            printk(KERN_INFO " i2c-algo-8xx.o: scanning bus %s...\n",
                   adap->name);
            for (i =3D 0; i < 128; i++) {
                  if (cpm_iic_tryaddress(cpm_adap, i)) {
                        printk("(%02x)",i<<1);
                  }
            }
            printk("\n");
      }
      return 0;
}

int i2c_8xx_del_bus(struct i2c_adapter *adap)
{
      int res;
      struct i2c_algo_8xx_data *cpm_adap =3D adap->algo_data;

      cpm_iic_shutdown(cpm_adap);

      if ((res =3D i2c_del_adapter(adap)) < 0)
            return res;

      printk(KERN_INFO "i2c-algo-8xx.o: adapter unregistered:
%s\n",adap->name);

#ifdef MODULE
      MOD_DEC_USE_COUNT;
#endif
      return 0;
}

EXPORT_SYMBOL(i2c_8xx_add_bus);
EXPORT_SYMBOL(i2c_8xx_del_bus);

int __init i2c_algo_8xx_init (void)
{
      printk(KERN_INFO "i2c-algo-8xx.o: i2c mpc8xx algorithm module ver=
sion
%s (%s)\n", I2C_ALGO_8XX_VERSION, I2C_ALGO_8XX_DATE);
      return 0;
}


#ifdef MODULE
MODULE_AUTHOR("Brad Parker <brad@heeltoe.com>");
MODULE_DESCRIPTION("I2C-Bus MPC8XX algorithm");
#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

int init_module(void)
{
      return i2c_algo_8xx_init();
}

void cleanup_module(void)
{
}
#endif=
