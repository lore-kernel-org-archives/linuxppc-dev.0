Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 584881A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 03:31:38 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] sdhci-of-esdhc: Support 8BIT bus width.
Date: Mon, 04 May 2015 19:31:30 +0200
Message-ID: <2384804.XbcbTBBFP9@wuerfel>
In-Reply-To: <1430757092-15847-1-git-send-email-joakim.tjernlund@transmode.se>
References: <1430757092-15847-1-git-send-email-joakim.tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 04 May 2015 18:31:31 Joakim Tjernlund wrote:
> @@ -252,6 +260,8 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
>  
>         if (vvn > VENDOR_V_22)
>                 host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
> +
> +       host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>  }
> 

Shouldn't this check the "bus-width" property before setting the width?

There might be an eMMC or SDIO with 4-bit interface connected.

	Arnd
