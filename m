Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 5FF832C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2012 07:02:32 +1000 (EST)
Date: Fri, 24 Aug 2012 14:02:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] rapidio/tsi721: modify mport name assignment
Message-Id: <20120824140229.20e6a46c.akpm@linux-foundation.org>
In-Reply-To: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
References: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Aug 2012 10:23:54 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Modify mport device name assignment to provide clear reference to devices
> in systems with multiple Tsi721 bridges.
> 
> This patch is applicable to kernel versions starting from v3.2.

This seems to imply that you think the patch should be backported into
earlier kernels.  But no reason for doing this was provided.

> --- a/drivers/rapidio/devices/tsi721.c
> +++ b/drivers/rapidio/devices/tsi721.c
> @@ -2165,7 +2165,8 @@ static int __devinit tsi721_setup_mport(struct tsi721_device *priv)
>  	rio_init_dbell_res(&mport->riores[RIO_DOORBELL_RESOURCE], 0, 0xffff);
>  	rio_init_mbox_res(&mport->riores[RIO_INB_MBOX_RESOURCE], 0, 3);
>  	rio_init_mbox_res(&mport->riores[RIO_OUTB_MBOX_RESOURCE], 0, 3);
> -	strcpy(mport->name, "Tsi721 mport");
> +	snprintf(mport->name, RIO_MAX_MPORT_NAME, "%s(%s)",
> +		 dev_driver_string(&pdev->dev), dev_name(&pdev->dev));

And it's a non-back-compatible change to a userspace-visible interface!
As such we'd need extraordinary justification to merge it into
*future* kernels, let alone backport it.

Please, do provide much better changelogging than this.
