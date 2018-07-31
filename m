Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g0kQ4gtMzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 01:30:19 +1000 (AEST)
Date: Tue, 31 Jul 2018 16:29:44 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Alexei Colin <acolin@isi.edu>
Cc: Alexandre Bounine <alex.bou9@gmail.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Paul Walters <jwalters@isi.edu>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Alexander Sverdlin <alexander.sverdlin@nokia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/6] rapidio: define top Kconfig menu in driver
 subtree
Message-ID: <20180731152944.GL17271@n2100.armlinux.org.uk>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-2-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731142954.30345-2-acolin@isi.edu>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 31, 2018 at 10:29:49AM -0400, Alexei Colin wrote:
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

There's no need to specify this default - the default default defaults to
'n' anyway, so "default n" just respecifies what's already the default.
(next time I'll try to add more "default"s into that! ;) )

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
