Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A00CCB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 15:00:17 +1000 (EST)
Subject: Re: [PATCH] viotape: Fix memory and semaphore leak
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200907181506.33499.mb@bu3sch.de>
References: <200907181506.33499.mb@bu3sch.de>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 15:00:03 +1000
Message-Id: <1250139603.3587.106.camel@pasglop>
Mime-Version: 1.0
Cc: Dave Boutcher <boutcher@us.ibm.com>, Ryan Arnold <ryanarn@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Colin Devilbiss <devilbis@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-07-18 at 15:06 +0200, Michael Buesch wrote:
> This patch fixes a memory and semaphore leak in the viotape driver's
> char device write op. It leaks the DMA memory and the semaphore lock
> in case the device was opened with O_NONBLOCK.
> 
> This patch is only compile tested, because I do not have the hardware.
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

(going trough my backlog ...)

Thanks Michael, but I don't think that's right...

IE. We aren't waiting for the write to complete, which means that it can
be happening asynchronously, thus we must not free the DMA memory until
it has actually complete.

Now, if you look at vioHandleTapeEvent(), it does appear that when the
completion happens, the DMA memory will eventually be released and the
mutex up'ed. 

Or am I missing something ?

Cheers,
Ben.

> ---
>  drivers/char/viotape.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> --- linux-2.6.orig/drivers/char/viotape.c
> +++ linux-2.6/drivers/char/viotape.c
> @@ -401,30 +401,31 @@ static ssize_t viotap_write(struct file 
>  			viopath_targetinst(viopath_hostLp),
>  			(u64)(unsigned long)op, VIOVERSION << 16,
>  			((u64)devi.devno << 48) | op->dmaaddr, count, 0, 0);
>  	if (hvrc != HvLpEvent_Rc_Good) {
>  		printk(VIOTAPE_KERN_WARN "hv error on op %d\n",
>  				(int)hvrc);
>  		ret = -EIO;
>  		goto free_dma;
>  	}
>  
> -	if (noblock)
> -		return count;
> -
> -	wait_for_completion(&op->com);
> +	if (noblock) {
> +		ret = count;
> +	} else {
> +		wait_for_completion(&op->com);
>  
> -	if (op->rc)
> -		ret = tape_rc_to_errno(op->rc, "write", devi.devno);
> -	else {
> -		chg_state(devi.devno, VIOT_WRITING, file);
> -		ret = op->count;
> +		if (op->rc)
> +			ret = tape_rc_to_errno(op->rc, "write", devi.devno);
> +		else {
> +			chg_state(devi.devno, VIOT_WRITING, file);
> +			ret = op->count;
> +		}
>  	}
>  
>  free_dma:
>  	dma_free_coherent(op->dev, count, op->buffer, op->dmaaddr);
>  up_sem:
>  	up(&reqSem);
>  free_op:
>  	free_op_struct(op);
>  	return ret;
>  }
> 
