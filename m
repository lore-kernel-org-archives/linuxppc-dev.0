Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r2wqz17LnzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 05:41:35 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id z3so9669308qkb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 May 2016 12:41:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 8 May 2016 15:41:12 -0400
From: Tejun Heo <tj@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH v2 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
Message-ID: <20160508194112.GL4775@htj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461661404-1952-4-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461661404-1952-4-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 26, 2016 at 12:03:04PM +0300, Andy Shevchenko wrote:
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 7f95389..aee8873 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1151,7 +1151,13 @@ static struct scsi_host_template sata_dwc_sht = {
>  	 */
>  	.sg_tablesize		= LIBATA_MAX_PRD,
>  	/* .can_queue		= ATA_MAX_QUEUE, */
> -	.dma_boundary		= ATA_DMA_BOUNDARY,
> +	/*
> +	 * Make sure a LLI block is not created that will span 8K max FIS
> +	 * boundary. If the block spans such a FIS boundary, there is a chance
> +	 * that a DMA burst will cross that boundary -- this results in an
> +	 * error in the host controller.
> +	 */
> +	.dma_boundary		= 0x1fff /* ATA_DMA_BOUNDARY */,

The host controller can't cross 8k boundary?  Is this for real?

-- 
tejun
