Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 7C9FEB7D5C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 06:49:25 +1100 (EST)
Date: Tue, 16 Feb 2010 11:49:22 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH/RFC 1/2] 5200: improve i2c bus error recovery
Message-ID: <20100216194922.GA27811@ovro.caltech.edu>
References: <1264191475.2224.1@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1264191475.2224.1@antares>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 22, 2010 at 09:17:55PM +0100, Albrecht Dreﬂ wrote:
> Improve the recovery of the MPC5200B's I2C bus from errors like bus
> hangs.
> 
> Signed-off-by: Albrecht Dreﬂ <albrecht.dress@arcor.de>
> 
> ---
> 
> This patch introduces several improvements to the MPC5200B's I2C driver
> as to improve the recovery from error conditions I encountered when
> testing a custom board with several I2C devices attached (eeprom, io
> expander, rtc, sensors).  The error conditions included cases where the
> bus if logic of one slave apparently went south, blocking the bus
> completely.
> 
> My fixes include:
> 1. make the bus timeout configurable in fsl_i2c_probe(); the default of
>    one second is *way* too long for my use case;
> 2. if a timeout condition occurs in mpc_xfer(), mpc_i2c_fixup() the bus
>    if *any* of the CF, BB and RXAK flags in the MSR is 1.  I actually
>    saw different combinations with hangs, not only all three set;

Hello Albrecht,

I see this exact hang on a MPC8349EA board. I poll my i2c sensors every
500ms, and it takes around 12 hours to produce a hang. The usual hang
has (CF | BB) set, however I have seen a hang with just BB (only once so
far in about 2 weeks).

I think the fixup should be run on 8349 as well, if not all processors.
I'm happy to test patches. I have a way to reliably trigger a lockup,
using another master on the i2c bus.

> 3. improve the fixup procedure by calculating the timing needed from the
>    real (configured) bus clock, calculated in mpc_i2c_setclock_52xx().
>    Furthermore, I issue 9 instead of one cycle, as I experienced cases
>    where the single one is not enough (found this tip in a forum).  As a
>    side effect, the new scheme needs only 81us @375kHz bus clock instead
>    of 150us.  I recorded waveforms for 18.4kHz, 85.9kHz and 375kHz, all
>    looking fine, which I can provide if anyone is interested.
> 
> Open questions:
> - is the approach correct at all, in particular the interpretation of
>   the flags (#2)?
> - could this code also be used on non-5200 processors?
> 
> --- linux-2.6.32-orig/drivers/i2c/busses/i2c-mpc.c	2009-12-03 04:51:21.000000000 +0100
> +++ linux-2.6.32/drivers/i2c/busses/i2c-mpc.c	2010-01-22 16:05:13.000000000 +0100
> @@ -59,6 +59,7 @@ struct mpc_i2c {
>  	wait_queue_head_t queue;
>  	struct i2c_adapter adap;
>  	int irq;
> +	u32 real_clk;
>  };
>  
>  struct mpc_i2c_divider {
> @@ -97,16 +98,32 @@ static irqreturn_t mpc_i2c_isr(int irq, 
>   */
>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>  {
> -	writeccr(i2c, 0);
> -	udelay(30);
> -	writeccr(i2c, CCR_MEN);
> -	udelay(30);
> -	writeccr(i2c, CCR_MSTA | CCR_MTX);
> -	udelay(30);
> -	writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> -	udelay(30);
> -	writeccr(i2c, CCR_MEN);
> -	udelay(30);
> +	if (i2c->real_clk == 0) {
> +		writeccr(i2c, 0);
> +		udelay(30);
> +		writeccr(i2c, CCR_MEN);
> +		udelay(30);
> +		writeccr(i2c, CCR_MSTA | CCR_MTX);
> +		udelay(30);
> +		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> +		udelay(30);
> +		writeccr(i2c, CCR_MEN);
> +		udelay(30);
> +	} else {
> +		int k;
> +		u32 delay_val = 1000000 / i2c->real_clk + 1;
> +
> +		if (delay_val < 2)
> +			delay_val = 2;
> +
> +		for (k = 9; k; k--) {
> +			writeccr(i2c, 0);
> +			writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> +			udelay(delay_val);
> +			writeccr(i2c, CCR_MEN);
> +			udelay(delay_val << 1);
> +		}
> +	}
>  }
>  

The old sequence has always un-hung the bus for me. Yours might be
better. I'll try it next time the bus wedges up on me.

>  static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
> @@ -186,15 +203,18 @@ static const struct mpc_i2c_divider mpc_
>  	{10240, 0x9d}, {12288, 0x9e}, {15360, 0x9f}
>  };
>  
> -int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescaler)
> +int mpc_i2c_get_fdr_52xx(struct device_node *node, u32 clock, int prescaler,
> +			 u32 *real_clk)
>  {
>  	const struct mpc_i2c_divider *div = NULL;
>  	unsigned int pvr = mfspr(SPRN_PVR);
>  	u32 divider;
>  	int i;
>  
> -	if (!clock)
> +	if (!clock) {
> +		*real_clk = 0;
>  		return -EINVAL;
> +	}
>  
>  	/* Determine divider value */
>  	divider = mpc5xxx_get_bus_frequency(node) / clock;
> @@ -212,7 +232,8 @@ int mpc_i2c_get_fdr_52xx(struct device_n
>  			break;
>  	}
>  
> -	return div ? (int)div->fdr : -EINVAL;
> +	*real_clk = mpc5xxx_get_bus_frequency(node) / div->divider;
> +	return (int)div->fdr;
>  }
>  
>  static void mpc_i2c_setclock_52xx(struct device_node *node,
> @@ -221,13 +242,14 @@ static void mpc_i2c_setclock_52xx(struct
>  {
>  	int ret, fdr;
>  
> -	ret = mpc_i2c_get_fdr_52xx(node, clock, prescaler);
> +	ret = mpc_i2c_get_fdr_52xx(node, clock, prescaler, &i2c->real_clk);
>  	fdr = (ret >= 0) ? ret : 0x3f; /* backward compatibility */
>  
>  	writeb(fdr & 0xff, i2c->base + MPC_I2C_FDR);
>  
>  	if (ret >= 0)
> -		dev_info(i2c->dev, "clock %d Hz (fdr=%d)\n", clock, fdr);
> +		dev_info(i2c->dev, "clock %u Hz (fdr=%d)\n", i2c->real_clk,
> +			 fdr);
>  }
>  #else /* !CONFIG_PPC_MPC52xx */
>  static void mpc_i2c_setclock_52xx(struct device_node *node,
> @@ -446,10 +468,14 @@ static int mpc_xfer(struct i2c_adapter *
>  			return -EINTR;
>  		}
>  		if (time_after(jiffies, orig_jiffies + HZ)) {
> +			u8 status = readb(i2c->base + MPC_I2C_SR);
> +
>  			dev_dbg(i2c->dev, "timeout\n");
> -			if (readb(i2c->base + MPC_I2C_SR) ==
> -			    (CSR_MCF | CSR_MBB | CSR_RXAK))
> +			if ((status & (CSR_MCF | CSR_MBB | CSR_RXAK)) != 0) {
> +				writeb(status & ~CSR_MAL,
> +				       i2c->base + MPC_I2C_SR);
>  				mpc_i2c_fixup(i2c);
> +			}
>  			return -EIO;
>  		}
>  		schedule();

This hunk looks good to me. It is basically what I did, except I didn't
clear the MAL bit. Judging by the manual, it should be cleared.

> @@ -540,6 +566,14 @@ static int __devinit fsl_i2c_probe(struc
>  		}
>  	}
>  
> +	prop = of_get_property(op->node, "timeout", &plen);
> +	if (prop && plen == sizeof(u32)) {
> +		mpc_ops.timeout = *prop * HZ / 1000000;
> +		if (mpc_ops.timeout < 5)
> +			mpc_ops.timeout = 5;
> +	}
> +	dev_info(i2c->dev, "timeout %u us\n", mpc_ops.timeout * 1000000 / HZ);
> +
>  	dev_set_drvdata(&op->dev, i2c);
>  
>  	i2c->adap = mpc_ops;
> 

Ira
