Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CA13ADDED3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 10:03:09 +1000 (EST)
Date: Sat, 21 Jul 2007 02:03:06 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [i2c] [PATCH] i2c-mpc: work around missing-9th-clock-pulse bug
In-Reply-To: <20070709071955.GD4186@moe.telargo.com>
Message-ID: <Pine.LNX.4.60.0707210154330.3946@poirot.grange>
References: <20070709071955.GD4186@moe.telargo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: khali@linux-fr.org, i2c@lm-sensors.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 9 Jul 2007, Domen Puncer wrote:

> Work around a problem reported on:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> Without this patch I2C on mpc5200 becomes unusable after a while.
> Tested on mpc5200 based boards by Matthias and me.

Domen, unfortunately, your suspicion, expressed on IRC, was right. It is 
this patch that breaks i2c on mpc8241 (linkstation). Reverting it fixes 
the problem. For reference, here's a rtc-debug log with this patch 
(linux-2.6 tree of 19.07):

rtc-rs5c372 0-0032: rs5c372_probe
rtc-rs5c372 0-0032: 52 28 21 (04) 19 07 07 (15), 04 00 6a, 08 00 3e; 00 20
rtc-rs5c372 0-0032: 28 21 04 (19) 07 07 15 (04), 00 6a 08, 00 3e 00; 20 52
rtc-rs5c372 0-0032: rs5c372_get_datetime: tm is secs=28, mins=21, hours=4, mday=7, mon=6, year=115, wday=1
rtc-rs5c372 0-0032: rs5c372b found, 24hr, driver version 0.5
rtc-rs5c372: dev (254:0)
rtc-rs5c372 0-0032: rtc core: registered rtc-rs5c372 as rtc0
rtc-rs5c372 0-0032: 21 04 19 (07) 07 15 04 (00), 6a 08 00, 3e 00 20; 52 28
rtc-rs5c372 0-0032: rs5c372_get_datetime: tm is secs=21, mins=4, hours=19, mday=7, mon=14, year=104, wday=7
rtc-rs5c372 0-0032: hctosys: unable to read the hardware clock

Let me know when you'll have any patches to test.

Thanks
Guennadi

> 
> 
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
> 
> ---
>  drivers/i2c/busses/i2c-mpc.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> ===================================================================
> --- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
> +++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> @@ -74,6 +74,20 @@ static irqreturn_t mpc_i2c_isr(int irq, 
>  	return IRQ_HANDLED;
>  }
>  
> +static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> +{
> +	writeccr(i2c, 0);
> +	udelay(30);
> +	writeccr(i2c, CCR_MEN);
> +	udelay(30);
> +	writeccr(i2c, CCR_MSTA | CCR_MTX);
> +	udelay(30);
> +	writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> +	udelay(30);
> +	writeccr(i2c, CCR_MEN);
> +	udelay(30);
> +}
> +
>  static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
>  {
>  	unsigned long orig_jiffies = jiffies;
> @@ -153,6 +167,9 @@ static void mpc_i2c_start(struct mpc_i2c
>  static void mpc_i2c_stop(struct mpc_i2c *i2c)
>  {
>  	writeccr(i2c, CCR_MEN);
> +	mb();
> +	writeccr(i2c, 0);
> +	mb();
>  }
>  
>  static int mpc_write(struct mpc_i2c *i2c, int target,
> @@ -245,6 +262,8 @@ static int mpc_xfer(struct i2c_adapter *
>  		}
>  		if (time_after(jiffies, orig_jiffies + HZ)) {
>  			pr_debug("I2C: timeout\n");
> +			if (readb(i2c->base + MPC_I2C_SR) == (CSR_MCF | CSR_MBB | CSR_RXAK))
> +				mpc_i2c_fixup(i2c);
>  			return -EIO;
>  		}
>  		schedule();
> 
> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c
> 

---
Guennadi Liakhovetski
