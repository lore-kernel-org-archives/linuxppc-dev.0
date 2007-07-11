Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 5048FDDE2D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 01:33:52 +1000 (EST)
Date: Wed, 11 Jul 2007 08:35:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: arnd@arndb.de
Subject: Re: [patch 1/9] move 82xx/83xx/86xx Kconfig options to platform
	selection
Message-ID: <20070711153542.GB11516@mag.az.mvista.com>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.183462070@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070616000618.183462070@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 16, 2007 at 02:05:12AM +0200, arnd@arndb.de wrote:
> The cores used in the MPC82xx/83xx/86xx embedded controllers are very similar
> to those in the 32 bit general-purpose processors, so it makes sense to
> treat them as the same CPU family.
> 
> Choosing between the embedded platforms and the multiplatform code is
> now done in the platform menu, but functionally everything stays the
> same.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Index: linux-2.6/arch/powerpc/platforms/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/Kconfig

> @@ -16,8 +16,31 @@ config EMBEDDED6xx
>  	bool "Embedded 6xx/7xx/7xxx-based board"
>  	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)

<snip>

> +config CLASSIC32
> +	def_bool y
> +	depends on 6xx && PPC_MULTIPLATFORM
		       ^^^^^^^^^^^^^^^^^^^^
Arnd, is this really what you wanted?  With it, none of the embedded
classics have CLASSIC32 defined which means they don't get TAU or
ALTIVEC defined which isn't good.

Mark
