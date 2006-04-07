Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE1CD67B4A
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Apr 2006 00:17:10 +1000 (EST)
In-Reply-To: <20060407063131.GB22416@in.ibm.com>
References: <20060407063131.GB22416@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <981C3B4E-7336-403D-AF58-3B36AA071866@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] tickless idle cpu: Skip ticks when CPU is idle
Date: Fri, 7 Apr 2006 09:16:58 -0500
To: vatsa@in.ibm.com
Cc: sri_vatsa_v@yahoo.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2006, at 1:31 AM, Srivatsa Vaddagiri wrote:

> This is the core patch which skips ticks when a CPU is idle.
> Should work on pSeries, pmac and maple machines.
>
> The patch is against 2.6.17-rc1-mm1 and has been tested on a 16-way  
> (with SMT)
> Power5 box (p570).
>
> Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>
>
> ---
>
>  linux-2.6.17-rc1-root/arch/powerpc/Kconfig                   |    6
>  linux-2.6.17-rc1-root/arch/powerpc/kernel/idle_power4.S      |    3
>  linux-2.6.17-rc1-root/arch/powerpc/kernel/irq.c              |    3
>  linux-2.6.17-rc1-root/arch/powerpc/kernel/time.c             |   
> 150 ++++++++---
>  linux-2.6.17-rc1-root/arch/powerpc/kernel/traps.c            |    1
>  linux-2.6.17-rc1-root/arch/powerpc/platforms/pseries/setup.c |    6
>  linux-2.6.17-rc1-root/include/asm-powerpc/time.h             |    8
>  7 files changed, 147 insertions(+), 30 deletions(-)
>

[snip]

> diff -puN arch/powerpc/Kconfig~no_idle_hz arch/powerpc/Kconfig
> --- linux-2.6.17-rc1/arch/powerpc/Kconfig~no_idle_hz	2006-04-07  
> 04:14:39.000000000 +0530
> +++ linux-2.6.17-rc1-root/arch/powerpc/Kconfig	2006-04-07  
> 04:14:58.000000000 +0530
> @@ -593,6 +593,12 @@ config HOTPLUG_CPU
>
>  	  Say N if you are unsure.
>
> +config NO_IDLE_HZ
> +	depends on EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC || PPC_MAPLE)
> +	bool "Switch off timer ticks on idle CPUs"
> +	help
> +	  Switches the HZ timer interrupts off when a CPU is idle.
> +

any reason not to provide this for all 6xx class processors?

>  config KEXEC
>  	bool "kexec system call (EXPERIMENTAL)"
>  	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
