Return-Path: <htejun@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id ADCDADDFBA
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 17:30:17 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2582875wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 00:29:52 -0700 (PDT)
Message-ID: <483520E9.2090201@gmail.com>
Date: Thu, 22 May 2008 16:29:45 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add port multiplier (PMP) support in sata_fsl driver
References: <Pine.LNX.4.64.0805200015010.5318@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0805200015010.5318@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, ashish.kalra@freescale.com,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> From: Ashish Kalra <ashish.kalra@freescale.com>
> 
> PMP support for sata_fsl driver.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
> ---
> Jeff,
> 
> The following commit (4c9bf4e799ce06a7378f1196587084802a414c03):
> libata: replace tf_read with qc_fill_rtf for non-SFF drivers

Heh.. I tried not to break anything and theoretically it shouldn't have. 
  Oh well, there's theory and there's reality.  Sorry about the trouble.

> Broke the sata_fsl.c driver in 2.6.26.  I know the following patch fixes
> the issue, it clearly also adds port multipler support.  I'm not sure if
> you are willing to take that as part of 2.6.26 or not, but the current
> 2.6.26 driver is broken.

Would it be possible to break the patch into two pieces?  One to fix the 
problem and the other to add PMP support?

> @@ -771,7 +803,8 @@ try_offline_again:
>  		ata_port_printk(ap, KERN_WARNING,
>  				"No Device OR PHYRDY change,Hstatus = 0x%x\n",
>  				ioread32(hcr_base + HSTATUS));
> -		goto err;
> +		*class = ATA_DEV_NONE;
> +		goto out;
>  	}
> 
>  	/*
> @@ -783,7 +816,8 @@ try_offline_again:
> 
>  	if ((temp & 0xFF) != 0x18) {
>  		ata_port_printk(ap, KERN_WARNING, "No Signature Update\n");
> -		goto err;
> +		*class = ATA_DEV_NONE;
> +		goto out;

Is setting class to ATA_DEV_NONE necessary?  What happens if you drop 
the above two chunks?

Also, it looks to me that currently sata_fsl_softreset() does both hard 
and soft resets.  Is it possible to split it into sata_fsl_hardreset() 
and softreset()?

> @@ -926,42 +975,28 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>  	sata_fsl_scr_read(ap, SCR_ERROR, &SError);
>  	if (unlikely(SError & 0xFFFF0000)) {
>  		sata_fsl_scr_write(ap, SCR_ERROR, SError);
> -		err_mask |= AC_ERR_ATA_BUS;
>  	}
> 
>  	DPRINTK("error_intr,hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
>  		hstatus, cereg, ioread32(hcr_base + DE), SError);
> 
> -	/* handle single device errors */
> -	if (cereg) {
> -		/*
> -		 * clear the command error, also clears queue to the device
> -		 * in error, and we can (re)issue commands to this device.
> -		 * When a device is in error all commands queued into the
> -		 * host controller and at the device are considered aborted
> -		 * and the queue for that device is stopped. Now, after
> -		 * clearing the device error, we can issue commands to the
> -		 * device to interrogate it to find the source of the error.
> -		 */
> -		dereg = ioread32(hcr_base + DE);
> -		iowrite32(dereg, hcr_base + DE);
> -		iowrite32(cereg, hcr_base + CE);
> +	/* handle fatal errors */
> +	if (hstatus & FATAL_ERROR_DECODE) {
> +		ehi->err_mask |= AC_ERR_ATA_BUS;
> +		ehi->action |= ATA_EH_SOFTRESET;
> 
> -		DPRINTK("single device error, CE=0x%x, DE=0x%x\n",
> -			ioread32(hcr_base + CE), ioread32(hcr_base + DE));
>  		/*
> -		 * We should consider this as non fatal error, and TF must
> -		 * be updated as done below.
> +		 * Ignore serror in case of fatal errors as we always want
> +		 * to do a soft-reset of the FSL SATA controller. Analyzing
> +		 * serror may cause libata to schedule a hard-reset action,
> +		 * and hard-reset currently does not do controller
> +		 * offline/online, causing command timeouts and leads to an
> +		 * un-recoverable state, hence make libATA ignore
> +		 * autopsy in case of fatal errors.
>  		 */
> 
> -		err_mask |= AC_ERR_DEV;
> -	}
> +		ehi->flags |= ATA_EHI_NO_AUTOPSY;

This is really fishy.  NO_AUTOPSY isn't for stuff like this and libata 
EH as of the current #usptream and #upstream-fixes default to hardreset, 
so it will hardreset no matter what you do.

What do you mean by hardreset does'nt do controller offline/online?  Is 
this PHY sequence in sata_fsl_softreset()?  I think what should be done 
is...

* Separate out PHY diddling from sata_fsl_softreset() into 
sata_fsl_hardreset().

* If sata_fsl_hardreset() alone doesn't leave the controller in usable 
state.  Return -EAGAIN from it to request follow-up SRST on success.

Thanks.

-- 
tejun
