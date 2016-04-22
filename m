Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com
 [IPv6:2a00:1450:4010:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrwz95MqZzDqbs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 23:13:07 +1000 (AEST)
Received: by mail-lf0-x232.google.com with SMTP id g184so79052805lfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 06:13:07 -0700 (PDT)
Subject: Re: [PATCH v1 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461262544-115408-4-git-send-email-andriy.shevchenko@linux.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <571A235C.5070007@cogentembedded.com>
Date: Fri, 22 Apr 2016 16:13:00 +0300
MIME-Version: 1.0
In-Reply-To: <1461262544-115408-4-git-send-email-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 04/21/2016 09:15 PM, Andy Shevchenko wrote:

> The original code states:
>
> 	Make sure a LLI block is not created that will span 8K max FIS
> 	boundary. If the block spans such a FIS boundary, there is a chance
> 	that a DMA burst will cross that boundary -- this results in an error
> 	in the host controller.
>
> Since we have switched to generic DMAengine API we satisfy above by setting
> dma_boundary value to 0x1fff.
>
> Suggested-by: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ata/sata_dwc_460ex.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 7f95389..aee8873 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1151,7 +1151,13 @@ static struct scsi_host_template sata_dwc_sht = {
>   	 */
>   	.sg_tablesize		= LIBATA_MAX_PRD,
>   	/* .can_queue		= ATA_MAX_QUEUE, */
> -	.dma_boundary		= ATA_DMA_BOUNDARY,
> +	/*
> +	 * Make sure a LLI block is not created that will span 8K max FIS
> +	 * boundary. If the block spans such a FIS boundary, there is a chance
> +	 * that a DMA burst will cross that boundary -- this results in an
> +	 * error in the host controller.
> +	 */
> +	.dma_boundary		= 0x1fff /* ATA_DMA_BOUNDARY */,

    Not ~0x1fff?

[...]

MBR, Sergei
