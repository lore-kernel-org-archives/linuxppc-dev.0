Return-Path: <brking@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 699981A0014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 11:23:31 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Thu, 24 Sep 2015 19:23:29 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 58D1E1FF0049
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 19:14:36 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8P1MHCi66715850
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 18:22:17 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8P1NPEp004010
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 19:23:27 -0600
Subject: Re: [PATCH v3 08/32] cxlflash: Fix to avoid CXL services during EEH
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
References: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443123485-16808-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Brian King <brking@linux.vnet.ibm.com>
Message-ID: <5604A20C.4090000@linux.vnet.ibm.com>
Date: Thu, 24 Sep 2015 20:23:24 -0500
MIME-Version: 1.0
In-Reply-To: <1443123485-16808-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2015 02:38 PM, Matthew R. Ochs wrote:
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index 3e3ccf1..6e85c77 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -2383,16 +2397,14 @@ static pci_ers_result_t cxlflash_pci_error_detected(struct pci_dev *pdev,
>  	switch (state) {
>  	case pci_channel_io_frozen:
>  		cfg->state = STATE_LIMBO;
> -
> -		/* Turn off legacy I/O */
>  		scsi_block_requests(cfg->host);
> +		drain_ioctls(cfg);

I don't see this addressing the deadlock with an outstanding read_cap16 during EEH I identified
in the previous review. Am I missing something here?

>  		rc = cxlflash_mark_contexts_error(cfg);
>  		if (unlikely(rc))
>  			dev_err(dev, "%s: Failed to mark user contexts!(%d)\n",
>  				__func__, rc);
>  		term_mc(cfg, UNDO_START);
>  		stop_afu(cfg);
> -
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	case pci_channel_io_perm_failure:
>  		cfg->state = STATE_FAILTERM;
> diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
> index 28aa9d9..544ef09 100644
> --- a/drivers/scsi/cxlflash/superpipe.c
> +++ b/drivers/scsi/cxlflash/superpipe.c
> @@ -1214,6 +1214,48 @@ static const struct file_operations null_fops = {
>  };
> 
>  /**
> + * check_state() - checks and responds to the current adapter state
> + * @cfg:	Internal structure associated with the host.
> + * @ioctl:	Indicates if on an ioctl thread.
> + *
> + * This routine can block and should only be used on process context.
> + * When blocking on an ioctl thread, the ioctl read semaphore should be
> + * let up to allow for draining actively running ioctls. Also note that
> + * when waking up from waiting in reset, the state is unknown and must
> + * be checked again before proceeding.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +static int check_state(struct cxlflash_cfg *cfg, bool ioctl)

Looks like you missed this cleanup. The second parameter is not needed, since all
the callers set it to true.

> +{
> +	struct device *dev = &cfg->dev->dev;
> +	int rc = 0;
> +
> +retry:
> +	switch (cfg->state) {
> +	case STATE_LIMBO:
> +		dev_dbg(dev, "%s: Limbo state, going to wait...\n", __func__);
> +		if (ioctl)
> +			up_read(&cfg->ioctl_rwsem);
> +		rc = wait_event_interruptible(cfg->limbo_waitq,
> +					      cfg->state != STATE_LIMBO);
> +		if (ioctl)
> +			down_read(&cfg->ioctl_rwsem);
> +		if (unlikely(rc))
> +			break;
> +		goto retry;
> +	case STATE_FAILTERM:
> +		dev_dbg(dev, "%s: Failed/Terminating!\n", __func__);
> +		rc = -ENODEV;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
>   * cxlflash_disk_attach() - attach a LUN to a context
>   * @sdev:	SCSI device associated with LUN.
>   * @attach:	Attach ioctl data structure.



-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
