Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39D66B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 19:19:20 +1000 (EST)
Subject: Re: [PATCH 01/18] powerpc: Add ability to build little endian kernels
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
Date: Fri, 1 Oct 2010 04:18:20 -0500
Message-Id: <F7E7DAE6-A132-458D-ABC3-4CC92A4C7263@kernel.crashing.org>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>, Albert Herranz <albert_herranz@yahoo.es>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	paulus@samba.org, Andreas Schwab <schwab@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 1, 2010, at 2:05 AM, Ian Munsie wrote:

>=20
> diff --git a/arch/powerpc/platforms/Kconfig.cputype =
b/arch/powerpc/platforms/Kconfig.cputype
> index d361f81..074ff12 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -329,3 +329,19 @@ config CHECK_CACHE_COHERENCY
> 	bool
>=20
> endmenu
> +
> +config ARCH_SUPPORTS_LITTLE_ENDIAN
> +	bool
> +
> +config CPU_LITTLE_ENDIAN
> +	bool "Build little endian kernel"
> +	depends on ARCH_SUPPORTS_LITTLE_ENDIAN && EXPERIMENTAL
> +	default n
> +	help
> +	  This option selects whether a big endian or little endian =
kernel will
> +	  be built.
> +
> +	  Note that if building a little endian kernel, CROSS_COMPILE =
must
> +	  point to a toolchain capable of targetting little endian =
powerpc,
> +	  while the toolchain specified by CROSS32_COMPILE must be =
capable of
> +	  targetting *BIG* endian PowerPC.
> --=20
> 1.7.1

Shouldn't we have something that limits to the sub-arch'es that actually =
support it?  I doubt I'm ever going to make FSL-Book-e support LE.

- k=
