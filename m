Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id DCD431007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:26:42 +1000 (EST)
Received: by eyh6 with SMTP id 6so2155629eyh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 00:26:41 -0700 (PDT)
Date: Fri, 30 Jul 2010 11:26:37 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 1/3] mmc: Auto CMD12 support for eSDHC driver
Message-ID: <20100730072637.GC20351@oksana.dev.rtsoft.ru>
References: <1280295753-12331-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1280295753-12331-1-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-mmc-approval@vger.kernel.org,
	Chang-Ming.Huang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 28, 2010 at 01:42:33PM +0800, Roy Zang wrote:
[...]
> +	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
> +		if (mrq->stop) {
> +			mrq->data->stop = NULL;
> +			mrq->stop = NULL;
> +		}

Please put additional curly braces for the first 'if' statement.

>  	host->mrq = mrq;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..aa112aa 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -2,6 +2,7 @@
>   *  linux/drivers/mmc/host/sdhci.h - Secure Digital Host Controller Interface driver
>   *
>   *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
> + * Copyright 2010 Freescale Semiconductor, Inc.

Wrong count of spaces after '*'.

Also, according to git shortlog it's Freescale's first
patch to sdhci core, and the patch is quite trivial.

IANAL, but please refrain from adding authorship or copyright
notices unless you have done some major contribution(s).

>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -240,6 +241,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
>  /* Controller cannot support End Attribute in NOP ADMA descriptor */
>  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller uses Auto CMD12 command to stop the transfer */
> +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
