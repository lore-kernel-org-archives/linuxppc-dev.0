Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <bart@ardistech.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Fri, 11 Oct 2002 11:12:02 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLMEAKFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002E_01C27117.0650F2B0"
In-Reply-To: <3DA682D8.AE9E968A@ardistech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_002E_01C27117.0650F2B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

OK, here it is.

Perhaps someone can add it to the ppctree?

 Jocke

>
>
> Hi Joakim,
>
> > Anyway I have fixed the bugs in i2c-algo-8xx.c driver and it's working great for me
> > so I think I will stick with it for the time being.
> >
> Could you please post the fixes on the list? I also might want to use them.
>
> Thanks,
> 	Bart
>
------=_NextPart_000_002E_01C27117.0650F2B0
Content-Type: application/octet-stream;
	name="i2c-algo-8xx.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="i2c-algo-8xx.c"

/*=0A=
 * i2c-algo-8xx.c i2x driver algorithms for MPC8XX CPM=0A=
 * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).=0A=
 *=0A=
 * moved into proper i2c interface; separated out platform specific =0A=
 * parts into ic-rpx.c=0A=
 * Brad Parker (brad@heeltoe.com)=0A=
 */=0A=
=0A=
/* $Id: i2c-algo-8xx.c,v 1.3 2001/11/21 17:20:22 jocke Exp $ */=0A=
=0A=
#include <linux/kernel.h>=0A=
#include <linux/module.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/version.h>=0A=
#include <linux/init.h>=0A=
#include <asm/uaccess.h>=0A=
#include <linux/ioport.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/sched.h>=0A=
=0A=
#include <asm/mpc8xx.h>=0A=
#include <asm/commproc.h>=0A=
=0A=
#include <linux/i2c.h>=0A=
#include <linux/i2c-algo-8xx.h>=0A=
=0A=
#define CPM_MAX_READ	513=0A=
/* #define I2C_CHIP_ERRATA */ /* Try uncomment this if you have an older =
CPU(earlier than rev D4) */=0A=
static wait_queue_head_t iic_wait;=0A=
static ushort r_tbase, r_rbase;=0A=
static u8 irq_flags;=0A=
=0A=
int cpm_scan =3D 0;=0A=
int cpm_debug =3D 0;=0A=
=0A=
static void=0A=
cpm_iic_interrupt(void *dev_id, struct pt_regs *regs)=0A=
{=0A=
	volatile i2c8xx_t *i2c =3D (i2c8xx_t *)dev_id;=0A=
	if (cpm_debug > 1)=0A=
		printk("cpm_iic_interrupt(dev_id=3D%p)\n", dev_id);=0A=
#if 0=0A=
	/* Chip errata, clear enable. This is not needed on rev D4 CPUs */=0A=
        /* This should probably be removed and replaced by =
I2C_CHIP_ERRATA stuff */=0A=
        /* Someone with a buggy CPU needs to confirm that */=0A=
	i2c->i2c_i2mod &=3D ~1;=0A=
#endif=0A=
	/* Clear interrupt.=0A=
	*/=0A=
	irq_flags =3D i2c->i2c_i2cer;=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
=0A=
	/* Get 'me going again.=0A=
	*/=0A=
	wake_up_interruptible(&iic_wait);=0A=
}=0A=
=0A=
static void=0A=
cpm_iic_init(struct i2c_algo_8xx_data *cpm_adap)=0A=
{=0A=
	volatile iic_t		*iip =3D cpm_adap->iip;=0A=
	volatile i2c8xx_t	*i2c =3D cpm_adap->i2c;=0A=
	unsigned char brg;=0A=
	bd_t *bd =3D (bd_t *)__res;=0A=
=0A=
	if (cpm_debug) printk("cpm_iic_init()\n");=0A=
=0A=
	/* Initialize the parameter ram.=0A=
	 * We need to make sure many things are initialized to zero,=0A=
	 * especially in the case of a microcode patch.=0A=
	 */=0A=
	iip->iic_rstate =3D 0;=0A=
	iip->iic_rdp =3D 0;=0A=
	iip->iic_rbptr =3D 0;=0A=
	iip->iic_rbc =3D 0;=0A=
	iip->iic_rxtmp =3D 0;=0A=
	iip->iic_tstate =3D 0;=0A=
	iip->iic_tdp =3D 0;=0A=
	iip->iic_tbptr =3D 0;=0A=
	iip->iic_tbc =3D 0;=0A=
	iip->iic_txtmp =3D 0;=0A=
=0A=
	/* Set up the IIC parameters in the parameter ram.=0A=
	*/=0A=
	iip->iic_tbase =3D r_tbase =3D cpm_adap->dp_addr;=0A=
	iip->iic_rbase =3D r_rbase =3D cpm_adap->dp_addr + sizeof(cbd_t)*2;=0A=
=0A=
	iip->iic_tfcr =3D SMC_EB;=0A=
	iip->iic_rfcr =3D SMC_EB;=0A=
=0A=
	/* Set maximum receive size.=0A=
	*/=0A=
	iip->iic_mrblr =3D CPM_MAX_READ;=0A=
=0A=
	/* Initialize Tx/Rx parameters.=0A=
	*/=0A=
	if (cpm_adap->reloc =3D=3D 0) {=0A=
		volatile cpm8xx_t *cp =3D cpm_adap->cp;=0A=
=0A=
		cp->cp_cpcr =3D=0A=
			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;=0A=
		while (cp->cp_cpcr & CPM_CR_FLG);=0A=
	} else {=0A=
		iip->iic_rbptr =3D iip->iic_rbase;=0A=
		iip->iic_tbptr =3D iip->iic_tbase;=0A=
		iip->iic_rstate	=3D 0;=0A=
		iip->iic_tstate	=3D 0;=0A=
	}=0A=
=0A=
	/* Select an arbitrary address.  Just make sure it is unique.=0A=
	*/=0A=
	i2c->i2c_i2add =3D 0xfe;=0A=
=0A=
	/* Make clock run at 60 KHz.=0A=
	*/=0A=
	brg =3D (unsigned char) (bd->bi_intfreq/(32*2*60000) -3);=0A=
	i2c->i2c_i2brg =3D brg;=0A=
=0A=
	i2c->i2c_i2mod =3D 0x80; /* Filter clock */=0A=
	i2c->i2c_i2com =3D 0x01; /* Master mode */=0A=
=0A=
	/* Disable interrupts.=0A=
	*/=0A=
	i2c->i2c_i2cmr =3D 0;=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
=0A=
	init_waitqueue_head(&iic_wait);=0A=
=0A=
	/* Install interrupt handler.=0A=
	*/=0A=
	(*cpm_adap->setisr)(CPMVEC_I2C, cpm_iic_interrupt, (void *)i2c);=0A=
}=0A=
=0A=
=0A=
static int=0A=
cpm_iic_shutdown(struct i2c_algo_8xx_data *cpm_adap)=0A=
{=0A=
	volatile i2c8xx_t *i2c =3D cpm_adap->i2c;=0A=
=0A=
	/* Shut down IIC.=0A=
	*/=0A=
	i2c->i2c_i2mod &=3D ~1;=0A=
	i2c->i2c_i2cmr =3D 0;=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
=0A=
	return(0);=0A=
}=0A=
=0A=
static void =0A=
cpm_reset_iic_params(volatile iic_t *iip)=0A=
{=0A=
	iip->iic_tbase =3D r_tbase;=0A=
	iip->iic_rbase =3D r_rbase;=0A=
=0A=
	iip->iic_tfcr =3D SMC_EB;=0A=
	iip->iic_rfcr =3D SMC_EB;=0A=
=0A=
	iip->iic_mrblr =3D CPM_MAX_READ;=0A=
=0A=
	iip->iic_rstate =3D 0;=0A=
	iip->iic_rdp =3D 0;=0A=
	iip->iic_rbptr =3D iip->iic_rbase;=0A=
	iip->iic_rbc =3D 0;=0A=
	iip->iic_rxtmp =3D 0;=0A=
	iip->iic_tstate =3D 0;=0A=
	iip->iic_tdp =3D 0;=0A=
	iip->iic_tbptr =3D iip->iic_tbase;=0A=
	iip->iic_tbc =3D 0;=0A=
	iip->iic_txtmp =3D 0;=0A=
}=0A=
=0A=
#define BD_SC_NAK		((ushort)0x0004) /* NAK - did not respond */=0A=
#define BD_SC_OV		((ushort)0x0002) /* OV - receive overrun */=0A=
#define CPM_CR_CLOSE_RXBD	((ushort)0x0007)=0A=
=0A=
static void force_close(struct i2c_algo_8xx_data *cpm)=0A=
{=0A=
	volatile i2c8xx_t *i2c =3D cpm->i2c;=0A=
	if (cpm->reloc =3D=3D 0) { /* micro code disabled */=0A=
		volatile cpm8xx_t *cp =3D cpm->cp;=0A=
=0A=
		if (cpm_debug) printk("force_close()\n");=0A=
		cp->cp_cpcr =3D=0A=
			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |=0A=
			CPM_CR_FLG;=0A=
=0A=
		while (cp->cp_cpcr & CPM_CR_FLG);=0A=
	}=0A=
	i2c->i2c_i2cmr =3D 0x00;	/* Disable all interrupts */=0A=
	i2c->i2c_i2cer =3D 0xff; =0A=
}=0A=
=0A=
=0A=
/* Read from IIC...=0A=
 * abyte =3D address byte, with r/w flag already set=0A=
 */=0A=
static int=0A=
cpm_iic_read(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf, int =
count)=0A=
{=0A=
	volatile iic_t *iip =3D cpm->iip;=0A=
	volatile i2c8xx_t *i2c =3D cpm->i2c;=0A=
	volatile cpm8xx_t *cp =3D cpm->cp;=0A=
	volatile cbd_t	*tbdf, *rbdf;=0A=
	u_char *tb;=0A=
	unsigned long flags, tmo;=0A=
=0A=
	if (count >=3D CPM_MAX_READ)=0A=
		return -EINVAL;=0A=
=0A=
	/* check for and use a microcode relocation patch */=0A=
	if (cpm->reloc) {=0A=
		cpm_reset_iic_params(iip);=0A=
	}=0A=
=0A=
	tbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];=0A=
	rbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];=0A=
=0A=
	/* To read, we need an empty buffer of the proper length.=0A=
	 * All that is used is the first byte for address, the remainder=0A=
	 * is just used for timing (and doesn't really have to exist).=0A=
	 */=0A=
	tb =3D cpm->temp;=0A=
	tb =3D (u_char *)(((uint)tb + 15) & ~15);=0A=
	tb[0] =3D abyte;		/* Device address byte w/rw flag */=0A=
=0A=
	flush_dcache_range((unsigned long)tb, (unsigned long)(tb+1));=0A=
	if (cpm_debug) printk("cpm_iic_read(abyte=3D0x%x)\n", abyte);=0A=
=0A=
	tbdf->cbd_bufaddr =3D __pa(tb);=0A=
	tbdf->cbd_datlen =3D count + 1;=0A=
	tbdf->cbd_sc =3D=0A=
		BD_SC_READY | BD_SC_LAST |=0A=
		BD_SC_WRAP | BD_IIC_START;=0A=
=0A=
	iip->iic_mrblr =3D count +1; /* prevent excessive read, +1=0A=
				      is needed otherwise will the=0A=
				      RXB interrupt come too early */=0A=
=0A=
	/* flush will invalidate too. */=0A=
	flush_dcache_range((unsigned long)buf, (unsigned long)(buf+count));=0A=
	rbdf->cbd_datlen =3D 0;=0A=
	rbdf->cbd_bufaddr =3D __pa(buf);=0A=
	rbdf->cbd_sc =3D BD_SC_EMPTY | BD_SC_WRAP| BD_SC_INTRPT;=0A=
	/* Chip bug, set enable here */=0A=
	local_irq_save(flags);=0A=
	i2c->i2c_i2cmr =3D 0x13;	/* Enable some interupts */=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
	i2c->i2c_i2mod |=3D 1;	/* Enable */=0A=
	i2c->i2c_i2com |=3D 0x80;	/* Begin transmission */=0A=
=0A=
	/* Wait for IIC transfer */=0A=
	tmo =3D interruptible_sleep_on_timeout(&iic_wait,3*HZ);=0A=
	local_irq_restore(flags);=0A=
	if(irq_flags & 0x14)=0A=
		printk("IIC read irq err:%x\n",(unsigned int) irq_flags); =0A=
=0A=
=0A=
	if (signal_pending(current) || !tmo){=0A=
		force_close(cpm);=0A=
		if(cpm_debug) =0A=
			printk("IIC read: timeout!\n");=0A=
		return -EIO;=0A=
	}=0A=
#ifdef I2C_CHIP_ERRATA=0A=
	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.=0A=
	 Disabling I2C too early may cause too short stop condition */=0A=
	udelay(4);=0A=
	i2c->i2c_i2mod &=3D ~1;=0A=
#endif=0A=
	if (cpm_debug) {=0A=
		printk("tx sc %04x, rx sc %04x\n",=0A=
		       tbdf->cbd_sc, rbdf->cbd_sc);=0A=
	}=0A=
=0A=
	if (tbdf->cbd_sc & BD_SC_READY) {=0A=
		printk("IIC read; complete but tbuf ready\n");=0A=
		force_close(cpm);=0A=
		printk("tx sc %04x, rx sc %04x\n",=0A=
		       tbdf->cbd_sc, rbdf->cbd_sc);=0A=
	}=0A=
=0A=
	if (tbdf->cbd_sc & BD_SC_NAK) {=0A=
		if (cpm_debug)=0A=
			printk("IIC read; no ack\n");=0A=
		return -EREMOTEIO;=0A=
	}=0A=
=0A=
	if (rbdf->cbd_sc & BD_SC_EMPTY) {=0A=
		/* force_close(cpm); */=0A=
		if (cpm_debug){=0A=
			printk("IIC read; complete but rbuf empty\n");=0A=
			printk("tx sc %04x, rx sc %04x\n",=0A=
			       tbdf->cbd_sc, rbdf->cbd_sc);=0A=
		}=0A=
		return -EREMOTEIO;=0A=
	}=0A=
=0A=
	if (rbdf->cbd_sc & BD_SC_OV) {=0A=
		if (cpm_debug)=0A=
			printk("IIC read; Overrun\n");=0A=
		return -EREMOTEIO;;=0A=
	}=0A=
=0A=
	if (cpm_debug) printk("read %d bytes\n", rbdf->cbd_datlen);=0A=
=0A=
	if (rbdf->cbd_datlen < count) {=0A=
		if (cpm_debug)=0A=
			printk("IIC read; short, wanted %d got %d\n",=0A=
			       count, rbdf->cbd_datlen);=0A=
		return 0;=0A=
	}=0A=
=0A=
	return count;=0A=
}=0A=
=0A=
/* Write to IIC...=0A=
 * addr =3D address byte, with r/w flag already set=0A=
 */=0A=
static int=0A=
cpm_iic_write(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf,int =
count)=0A=
{=0A=
	volatile iic_t *iip =3D cpm->iip;=0A=
	volatile i2c8xx_t *i2c =3D cpm->i2c;=0A=
	volatile cpm8xx_t *cp =3D cpm->cp;=0A=
	volatile cbd_t	*tbdf;=0A=
	u_char *tb;=0A=
	unsigned long flags, tmo;=0A=
=0A=
	/* check for and use a microcode relocation patch */=0A=
	if (cpm->reloc) {=0A=
		cpm_reset_iic_params(iip);=0A=
	}=0A=
	tb =3D cpm->temp;=0A=
	tb =3D (u_char *)(((uint)tb + 15) & ~15);=0A=
	*tb =3D abyte;		/* Device address byte w/rw flag */=0A=
=0A=
	flush_dcache_range((unsigned long)tb, (unsigned long)(tb+1));=0A=
	flush_dcache_range((unsigned long)buf, (unsigned long)(buf+count));=0A=
=0A=
	if (cpm_debug) printk("cpm_iic_write(abyte=3D0x%x)\n", abyte);=0A=
=0A=
	/* set up 2 descriptors */=0A=
	tbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];=0A=
=0A=
	tbdf[0].cbd_bufaddr =3D __pa(tb);=0A=
	tbdf[0].cbd_datlen =3D 1;=0A=
	tbdf[0].cbd_sc =3D BD_SC_READY | BD_IIC_START;=0A=
=0A=
	tbdf[1].cbd_bufaddr =3D __pa(buf);=0A=
	tbdf[1].cbd_datlen =3D count;=0A=
	tbdf[1].cbd_sc =3D BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;=0A=
=0A=
	/* Chip bug, set enable here */=0A=
	local_irq_save(flags);=0A=
	i2c->i2c_i2cmr =3D 0x13;	/* Enable some interupts */=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
	i2c->i2c_i2mod |=3D 1;	/* Enable */=0A=
	i2c->i2c_i2com |=3D 0x80;	/* Begin transmission */=0A=
=0A=
	/* Wait for IIC transfer */=0A=
	tmo =3D interruptible_sleep_on_timeout(&iic_wait,3*HZ);=0A=
	local_irq_restore(flags);=0A=
	if(irq_flags & 0x14)=0A=
		printk("IIC write irq  err:%x\n",(unsigned int) irq_flags); =0A=
=0A=
	if (signal_pending(current) || !tmo){=0A=
		force_close(cpm);=0A=
		if(cpm_debug && !tmo) =0A=
			printk("IIC write: timeout!\n");=0A=
		return -EIO;=0A=
	}=0A=
	=0A=
#if I2C_CHIP_ERRATA=0A=
	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.=0A=
	 Disabling I2C too early may cause too short stop condition */=0A=
	udelay(4);=0A=
	i2c->i2c_i2mod &=3D ~1;=0A=
#endif=0A=
	if (cpm_debug) {=0A=
		printk("tx0 sc %04x, tx1 sc %04x\n",=0A=
		       tbdf[0].cbd_sc, tbdf[1].cbd_sc);=0A=
	}=0A=
=0A=
	if (tbdf->cbd_sc & BD_SC_NAK) {=0A=
		if (cpm_debug) =0A=
			printk("IIC write; no ack\n");=0A=
		return 0;=0A=
	}=0A=
	  =0A=
	if (tbdf->cbd_sc & BD_SC_READY) {=0A=
		if (cpm_debug)=0A=
			printk("IIC write; complete but tbuf ready\n");=0A=
		return 0;=0A=
	}=0A=
=0A=
	return count;=0A=
}=0A=
=0A=
/* See if an IIC address exists..=0A=
 * addr =3D 7 bit address, unshifted=0A=
 */=0A=
static int=0A=
cpm_iic_tryaddress(struct i2c_algo_8xx_data *cpm, int addr)=0A=
{=0A=
	volatile iic_t *iip =3D cpm->iip;=0A=
	volatile i2c8xx_t *i2c =3D cpm->i2c;=0A=
	volatile cpm8xx_t *cp =3D cpm->cp;=0A=
	volatile cbd_t *tbdf, *rbdf;=0A=
	u_char *tb;=0A=
	unsigned long flags, len, tmo;=0A=
=0A=
	if (cpm_debug > 1)=0A=
		printk("cpm_iic_tryaddress(cpm=3D%p,addr=3D%d)\n", cpm, addr);=0A=
=0A=
	/* check for and use a microcode relocation patch */=0A=
	if (cpm->reloc) {=0A=
		cpm_reset_iic_params(iip);=0A=
	}=0A=
=0A=
	if (cpm_debug && addr =3D=3D 0) {=0A=
		printk("iip %p, dp_addr 0x%x\n", cpm->iip, cpm->dp_addr);=0A=
		printk("iic_tbase %d, r_tbase %d\n", iip->iic_tbase, r_tbase);=0A=
	}=0A=
=0A=
	tbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];=0A=
	rbdf =3D (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];=0A=
=0A=
	tb =3D cpm->temp;=0A=
	tb =3D (u_char *)(((uint)tb + 15) & ~15);=0A=
=0A=
	/* do a simple read */=0A=
	tb[0] =3D (addr << 1) | 1;	/* device address (+ read) */=0A=
	len =3D 2;=0A=
=0A=
	flush_dcache_range((unsigned long)tb, (unsigned long)(tb+2));=0A=
=0A=
	tbdf->cbd_bufaddr =3D __pa(tb);=0A=
	tbdf->cbd_datlen =3D len;=0A=
	tbdf->cbd_sc =3D=0A=
		BD_SC_READY | BD_SC_LAST |=0A=
		BD_SC_WRAP | BD_IIC_START;=0A=
=0A=
	rbdf->cbd_datlen =3D 0;=0A=
	rbdf->cbd_bufaddr =3D __pa(tb+2);=0A=
	rbdf->cbd_sc =3D BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;=0A=
=0A=
	local_irq_save(flags);=0A=
	i2c->i2c_i2cmr =3D 0x13;	/* Enable some interupts */=0A=
	i2c->i2c_i2cer =3D 0xff;=0A=
	i2c->i2c_i2mod |=3D 1;	/* Enable */=0A=
	i2c->i2c_i2com |=3D 0x80;	/* Begin transmission */=0A=
=0A=
	if (cpm_debug > 1) printk("about to sleep\n");=0A=
=0A=
	/* wait for IIC transfer */=0A=
	tmo =3D interruptible_sleep_on_timeout(&iic_wait,3*HZ);=0A=
	local_irq_restore(flags);=0A=
=0A=
#ifdef I2C_CHIP_ERRATA=0A=
	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.=0A=
	 Disabling I2C too early may cause too short stop condition */=0A=
	udelay(4);=0A=
	i2c->i2c_i2mod &=3D ~1;=0A=
#endif=0A=
=0A=
	if (signal_pending(current) || !tmo){=0A=
		force_close(cpm);=0A=
		if(cpm_debug && !tmo) =0A=
			printk("IIC tryaddress: timeout!\n");=0A=
		return -EIO;=0A=
	}=0A=
=0A=
	if (cpm_debug > 1) printk("back from sleep\n");=0A=
=0A=
	if (tbdf->cbd_sc & BD_SC_NAK) {=0A=
		if (cpm_debug > 1) printk("IIC try; no ack\n");=0A=
		return 0;=0A=
	}=0A=
	  =0A=
	if (tbdf->cbd_sc & BD_SC_READY) {=0A=
		printk("IIC try; complete but tbuf ready\n");=0A=
	}=0A=
	=0A=
	return 1;=0A=
}=0A=
=0A=
static int cpm_xfer(struct i2c_adapter *i2c_adap,=0A=
		    struct i2c_msg msgs[], =0A=
		    int num)=0A=
{=0A=
	struct i2c_algo_8xx_data *adap =3D i2c_adap->algo_data;=0A=
	struct i2c_msg *pmsg;=0A=
	int i, ret;=0A=
	u_char addr;=0A=
    =0A=
	for (i =3D 0; i < num; i++) {=0A=
		pmsg =3D &msgs[i];=0A=
=0A=
		if (cpm_debug)=0A=
			printk("i2c-algo-8xx.o: "=0A=
			       "#%d addr=3D0x%x flags=3D0x%x len=3D%d\n buf=3D%lx\n",=0A=
			       i, pmsg->addr, pmsg->flags, pmsg->len, (unsigned =
long)pmsg->buf);=0A=
=0A=
		addr =3D pmsg->addr << 1;=0A=
		if (pmsg->flags & I2C_M_RD )=0A=
			addr |=3D 1;=0A=
		if (pmsg->flags & I2C_M_REV_DIR_ADDR )=0A=
			addr ^=3D 1;=0A=
    =0A=
		if (!(pmsg->flags & I2C_M_NOSTART)) {=0A=
		}=0A=
		if (pmsg->flags & I2C_M_RD ) {=0A=
			/* read bytes into buffer*/=0A=
			ret =3D cpm_iic_read(adap, addr, pmsg->buf, pmsg->len);=0A=
			if (cpm_debug)=0A=
				printk("i2c-algo-8xx.o: read %d bytes\n", ret);=0A=
			if (ret < pmsg->len ) {=0A=
				return (ret<0)? ret : -EREMOTEIO;=0A=
			}=0A=
		} else {=0A=
			/* write bytes from buffer */=0A=
			ret =3D cpm_iic_write(adap, addr, pmsg->buf, pmsg->len);=0A=
			if (cpm_debug)=0A=
				printk("i2c-algo-8xx.o: wrote %d\n", ret);=0A=
			if (ret < pmsg->len ) {=0A=
				return (ret<0) ? ret : -EREMOTEIO;=0A=
			}=0A=
		}=0A=
	}=0A=
	return (num);=0A=
}=0A=
=0A=
#define I2C_BITRATE 0x070f=0A=
static int algo_control(struct i2c_adapter *adapter, =0A=
	unsigned int cmd, unsigned long arg)=0A=
{=0A=
	struct i2c_algo_8xx_data *adap =3D adapter->algo_data;=0A=
	volatile i2c8xx_t *i2c =3D adap->i2c;=0A=
	unsigned char brg;=0A=
	bd_t *bd =3D (bd_t *)__res;=0A=
=0A=
	switch(cmd){=0A=
	case I2C_BITRATE:=0A=
		brg =3D (unsigned char) (bd->bi_intfreq/(32*2*arg) -3);=0A=
		printk("IntFreq: %lu    I2C brg: %lu\n", bd->bi_intfreq, (unsigned =
long)brg);=0A=
		i2c->i2c_i2brg =3D brg;=0A=
		return 0;=0A=
		break;=0A=
	default:=0A=
		return -EINVAL;=0A=
	}=0A=
}=0A=
=0A=
static u32 cpm_func(struct i2c_adapter *adap)=0A=
{=0A=
	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | =0A=
	       I2C_FUNC_PROTOCOL_MANGLING; =0A=
}=0A=
=0A=
/* -----exported algorithm data: -------------------------------------	*/=0A=
=0A=
static struct i2c_algorithm cpm_algo =3D {=0A=
	"MPX8XX CPM algorithm",=0A=
	I2C_ALGO_MPC8XX,=0A=
	cpm_xfer,=0A=
	NULL,=0A=
	NULL,				/* slave_xmit		*/=0A=
	NULL,				/* slave_recv		*/=0A=
	algo_control,			/* ioctl		*/=0A=
	cpm_func,			/* functionality	*/=0A=
};=0A=
=0A=
/* =0A=
 * registering functions to load algorithms at runtime =0A=
 */=0A=
int i2c_8xx_add_bus(struct i2c_adapter *adap)=0A=
{=0A=
	int i;=0A=
	struct i2c_algo_8xx_data *cpm_adap =3D adap->algo_data;=0A=
=0A=
	if (cpm_debug)=0A=
		printk("i2c-algo-8xx.o: hw routines for %s registered.\n",=0A=
		       adap->name);=0A=
=0A=
	/* register new adapter to i2c module... */=0A=
=0A=
	adap->id |=3D cpm_algo.id;=0A=
	adap->algo =3D &cpm_algo;=0A=
=0A=
#ifdef MODULE=0A=
	MOD_INC_USE_COUNT;=0A=
#endif=0A=
=0A=
	i2c_add_adapter(adap);=0A=
	cpm_iic_init(cpm_adap);=0A=
=0A=
	/* scan bus */=0A=
	if (cpm_scan) {=0A=
		printk(KERN_INFO " i2c-algo-8xx.o: scanning bus %s...\n",=0A=
		       adap->name);=0A=
		for (i =3D 0; i < 128; i++) {=0A=
			if (cpm_iic_tryaddress(cpm_adap, i)) {=0A=
				printk("(%02x)",i<<1); =0A=
			}=0A=
		}=0A=
		printk("\n");=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
=0A=
int i2c_8xx_del_bus(struct i2c_adapter *adap)=0A=
{=0A=
	int res;=0A=
	struct i2c_algo_8xx_data *cpm_adap =3D adap->algo_data;=0A=
=0A=
	cpm_iic_shutdown(cpm_adap);=0A=
=0A=
	if ((res =3D i2c_del_adapter(adap)) < 0)=0A=
		return res;=0A=
=0A=
	printk("i2c-algo-8xx.o: adapter unregistered: %s\n",adap->name);=0A=
=0A=
#ifdef MODULE=0A=
	MOD_DEC_USE_COUNT;=0A=
#endif=0A=
	return 0;=0A=
}=0A=
=0A=
EXPORT_SYMBOL(i2c_8xx_add_bus);=0A=
EXPORT_SYMBOL(i2c_8xx_del_bus);=0A=
=0A=
int __init i2c_algo_8xx_init (void)=0A=
{=0A=
	printk("i2c-algo-8xx.o: i2c mpc8xx algorithm module\n");=0A=
	return 0;=0A=
}=0A=
=0A=
=0A=
#ifdef MODULE=0A=
MODULE_AUTHOR("Brad Parker <brad@heeltoe.com>");=0A=
MODULE_DESCRIPTION("I2C-Bus MPC8XX algorithm");=0A=
=0A=
int init_module(void) =0A=
{=0A=
	return i2c_algo_8xx_init();=0A=
}=0A=
=0A=
void cleanup_module(void) =0A=
{=0A=
}=0A=
#endif=0A=

------=_NextPart_000_002E_01C27117.0650F2B0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
