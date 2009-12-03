Return-Path: <jgpobox@gmail.com>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 9B730B7C0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 18:35:56 +1100 (EST)
Received: by ywh17 with SMTP id 17so1127966ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 02 Dec 2009 23:35:54 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4B176A57.5040605@garzik.org>
Date: Thu, 03 Dec 2009 02:35:51 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of
	ata_bmdma_stop()
References: <20091202003629.4342710080C@ozlabs.org>
In-Reply-To: <20091202003629.4342710080C@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2009 07:36 PM, Benjamin Herrenschmidt wrote:
> In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
> instead of ap->ops->bmdma_stop(). This can be a problem for controllers
> that use their own bmdma_stop for which the generic sff one isn't suitable
>
> Signed-off-by: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> ---
>
>   drivers/ata/libata-sff.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-work.orig/drivers/ata/libata-sff.c	2009-12-01 17:48:27.000000000 +1100
> +++ linux-work/drivers/ata/libata-sff.c	2009-12-01 17:48:48.000000000 +1100
> @@ -2384,7 +2384,7 @@ void ata_sff_post_internal_cmd(struct at
>   	ap->hsm_task_state = HSM_ST_IDLE;
>
>   	if (ap->ioaddr.bmdma_addr)
> -		ata_bmdma_stop(qc);
> +		ap->ops->bmdma_stop(qc);
>
>   	spin_unlock_irqrestore(ap->lock, flags);

applied

As we discussed, feel free to carry this in your tree as well.  git 
should be able to sort it out.

Acked-by: Jeff Garzik <jgarzik@redhat.com>
