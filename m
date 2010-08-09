Return-Path: <mirqus@gmail.com>
Received: from mail-qy0-f170.google.com (mail-qy0-f170.google.com
	[209.85.216.170]) by ozlabs.org (Postfix) with ESMTP id 9CC0EB6F14
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 04:24:51 +1000 (EST)
Received: by qyk36 with SMTP id 36so2674104qyk.15
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Aug 2010 11:24:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Date: Mon, 9 Aug 2010 18:24:49 +0000
Message-ID: <AANLkTikUypKobPAHsE+tz-Py-XvvJhbcj7Syj3rX_ej0@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/8/3 Roy Zang <tie-fei.zang@freescale.com>:
[...]
> @@ -240,6 +240,8 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1<<25)
> =A0/* Controller cannot support End Attribute in NOP ADMA descriptor */
> =A0#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC =A0 =A0 =A0 =A0 =A0 =A0 =A0(=
1<<26)
> +/* Controller uses Auto CMD12 command to stop the transfer */
> +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 =A0 =A0 =A0 =A0 =A0 =A0 (1<<2=
7)
>
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =A0 =
=A0 =A0 =A0 =A0/* Device IRQ */
> =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0 =A0 =
/* Mapped address */

Just a cosmetic hint: I suggest SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD12
or something for the quirk name, because ACMD12 part might be confused
with MMC/SD App CMD 12 (CMD55+CMD12 combo) if/whenever that gets used.

Best Regards,
Micha=B3 Miros=B3aw
