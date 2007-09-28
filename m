Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F5EADDF31
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:30:19 +1000 (EST)
Date: Sat, 29 Sep 2007 00:30:05 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
Message-ID: <20070929003005.59afc2a0@kernel.crashing.org>
In-Reply-To: <20070928190616.GB20213@loki.buserror.net>
References: <20070928190616.GB20213@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

Realizing this may suffer a bit from cleanest-dts flame war, but anyway I pretty much see a lot of
sense in getting this in during next merge window. Is this possible?

On Fri, 28 Sep 2007 14:06:16 -0500
Scott Wood wrote:

> The way the current CPM binding describes available multi-user (a.k.a.
> dual-ported) RAM doesn't work well when there are multiple free regions,
> and it doesn't work at all if the region doesn't begin at the start of
> the muram area (as the hardware needs to be programmed with offsets into
> this area).  The latter situation can happen with SMC UARTs on CPM2, as its
> parameter RAM is relocatable, u-boot puts it at zero, and the kernel doesn't
> support moving it.
> 
> It is now described with a muram node, similar to QE.  The current CPM
> binding is sufficiently recent (i.e. never appeared in an official release)
> that compatibility with existing device trees is not an issue.
> 
> The code supporting the new binding is shared between cpm1 and cpm2, rather
> than remain separated.  QE should be able to use this code as well, once
> minor fixes are made to its device trees.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
Acked-by: Vitaly Bordug <vitb@kernel.crashing.org>

> ---
>  Documentation/powerpc/booting-without-of.txt |   40 ++++++-
>  arch/powerpc/Kconfig.debug                   |    6 +-
>  arch/powerpc/boot/cpm-serial.c               |   44 +++++--
>  arch/powerpc/boot/dts/ep88xc.dts             |   13 ++-
>  arch/powerpc/boot/dts/mpc8272ads.dts         |   11 ++
>  arch/powerpc/boot/dts/mpc885ads.dts          |   13 ++-
>  arch/powerpc/boot/dts/pq2fads.dts            |   13 ++-
>  arch/powerpc/sysdev/commproc.c               |   11 ++-
>  arch/powerpc/sysdev/cpm2_common.c            |   36 ++----
>  arch/powerpc/sysdev/cpm_common.c             |  159 ++++++++++++++++++++++++++
>  drivers/serial/cpm_uart/cpm_uart_cpm2.c      |    4 +-
>  include/asm-powerpc/commproc.h               |   12 ++
>  include/asm-powerpc/cpm.h                    |   14 +++
>  include/asm-powerpc/cpm2.h                   |   10 ++
>  14 files changed, 338 insertions(+), 48 deletions(-)

-- 
Sincerely, Vitaly
