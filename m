Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-233-wednesday.dmz.nerim.net
	[195.5.254.233]) by ozlabs.org (Postfix) with ESMTP id 7E5BEDDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 03:17:39 +1000 (EST)
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net
	[62.4.17.103])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 629A122BB4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 19:17:28 +0200 (CEST)
Date: Wed, 8 Aug 2007 19:19:13 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] i2c-mpc: don't disable I2C module on stop condition.
Message-ID: <20070808191913.3e6bb0e6@hyperion.delvare>
In-Reply-To: <20070724051431.GF4529@moe.telargo.com>
References: <20070709071955.GD4186@moe.telargo.com>
	<Pine.LNX.4.60.0707210154330.3946@poirot.grange>
	<20070724051431.GF4529@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	i2c@lm-sensors.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Domen,

On Tue, 24 Jul 2007 07:14:31 +0200, Domen Puncer wrote:
> Disabling module on stop doesn't work on some CPUs (ie. mpc8241,
> as reported by Guennadi Liakhovetski), so remove that.
> 
> Disable I2C module on errors/interrupts to prevent it from
> locking up on mpc5200b.
> 
> 
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
> ---
> Hi!
> 
> So I fixed i2c on one board, and broke it on another :-(
> This patch works on both Guennadi's and mine (hey, it might break
> a third one!).
> Jean, can you please push this, if there are no objections
> and "doesn't work for me" reports.

Queued for 2.6.23-rc3, thanks. Guennadi, can you please confirm that
this patch fixes your problem?

> 
> 
> 	Domen
> 
> 
>  drivers/i2c/busses/i2c-mpc.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> ===================================================================
> --- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
> +++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> @@ -105,6 +105,7 @@ static int i2c_wait(struct mpc_i2c *i2c,
>  			schedule();
>  			if (time_after(jiffies, orig_jiffies + timeout)) {
>  				pr_debug("I2C: timeout\n");
> +				writeccr(i2c, 0);
>  				result = -EIO;
>  				break;
>  			}
> @@ -116,10 +117,12 @@ static int i2c_wait(struct mpc_i2c *i2c,
>  		result = wait_event_interruptible_timeout(i2c->queue,
>  			(i2c->interrupt & CSR_MIF), timeout * HZ);
>  
> -		if (unlikely(result < 0))
> +		if (unlikely(result < 0)) {
>  			pr_debug("I2C: wait interrupted\n");
> -		else if (unlikely(!(i2c->interrupt & CSR_MIF))) {
> +			writeccr(i2c, 0);
> +		} else if (unlikely(!(i2c->interrupt & CSR_MIF))) {
>  			pr_debug("I2C: wait timeout\n");
> +			writeccr(i2c, 0);
>  			result = -ETIMEDOUT;
>  		}
>  
> @@ -172,7 +175,6 @@ static void mpc_i2c_start(struct mpc_i2c
>  static void mpc_i2c_stop(struct mpc_i2c *i2c)
>  {
>  	writeccr(i2c, CCR_MEN);
> -	writeccr(i2c, 0);
>  }
>  
>  static int mpc_write(struct mpc_i2c *i2c, int target,
> @@ -261,6 +263,7 @@ static int mpc_xfer(struct i2c_adapter *
>  	while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
>  		if (signal_pending(current)) {
>  			pr_debug("I2C: Interrupted\n");
> +			writeccr(i2c, 0);
>  			return -EINTR;
>  		}
>  		if (time_after(jiffies, orig_jiffies + HZ)) {


-- 
Jean Delvare
