Return-Path: <alexander.sverdlin@nokia.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0109.outbound.protection.outlook.com [104.47.1.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g0HX2ztBzF18k
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 01:10:25 +1000 (AEST)
Subject: Re: [RESEND PATCH 1/6] rapidio: define top Kconfig menu in driver
 subtree
To: Alexei Colin <acolin@isi.edu>, Alexandre Bounine <alex.bou9@gmail.com>,
 Matt Porter <mporter@kernel.crashing.org>
CC: Andrew Morton <akpm@linux-foundation.org>, John Paul Walters
 <jwalters@isi.edu>, Catalin Marinas <catalin.marinas@arm.com>, Russell King
 <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Will Deacon
 <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton
 <paul.burton@mips.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Anvin <hpa@zytor.com>, <x86@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-2-acolin@isi.edu>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <053432eb-1f24-a763-0bfe-e67373e7ea82@nokia.com>
Date: Tue, 31 Jul 2018 17:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180731142954.30345-2-acolin@isi.edu>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On 31/07/18 16:29, Alexei Colin wrote:
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfigs. This
> commit re-defines it in the driver subtree, and subsequent
> commits, one per architecture, will remove the duplicated
> definitions from respective per-architecture Kconfigs.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/rapidio/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> index d6d2f20c4597..98e301847584 100644
> --- a/drivers/rapidio/Kconfig
> +++ b/drivers/rapidio/Kconfig
> @@ -1,6 +1,21 @@
>  #
>  # RapidIO configuration
>  #
> +
> +config HAS_RAPIDIO
> +	bool
> +	default n
> +
> +config RAPIDIO
> +	tristate "RapidIO support"
> +	depends on HAS_RAPIDIO || PCI
> +	help
> +	  This feature enables support for RapidIO high-performance
> +	  packet-switched interconnect.
> +
> +	  If you say Y here, the kernel will include drivers and
> +	  infrastructure code to support RapidIO interconnect devices.
> +
>  source "drivers/rapidio/devices/Kconfig"
>  
>  config RAPIDIO_DISC_TIMEOUT

-- 
Best regards,
Alexander Sverdlin.
