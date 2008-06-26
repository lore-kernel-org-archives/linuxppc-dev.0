Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id EEC56DECDA
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 00:38:33 +1000 (EST)
Date: Thu, 26 Jun 2008 17:36:23 +0300
From: Adrian Bunk <bunk@kernel.org>
To: monstr@seznam.cz
Subject: Re: [PATCH 02/60] microblaze_v4: Makefiles for Microblaze cpu
Message-ID: <20080626143623.GC30954@cs181140183.pp.htv.fi>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1214483429-32360-3-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 02:29:31PM +0200, monstr@seznam.cz wrote:
>...
> --- /dev/null
> +++ b/arch/microblaze/Makefile
>...
> +# Work out HW multipler support.  This is icky.
> +# 1. Spartan2 has no HW multiplers.
> +# 2. MicroBlaze v3.x always uses them, except in Spartan 2
> +# 3. All other FPGa/CPU ver combos, we can trust the CONFIG_ settings
> +ifeq (,$(findstring spartan2,$(CONFIG_XILINX_MICROBLAZE0_FAMILY)))
> +  ifeq ($(CPU_MAJOR),3)
> +    CPUFLAGS-1 += -mno-xl-soft-mul
> +  else
> +    # USE_HW_MUL can be 0, 1, or 2, defining a heirarchy of HW Mul support.
> +    CPUFLAGS-$(subst 1,,$(CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL)) += -mxl-multiply-high
> +    CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL) += -mno-xl-soft-mul
> +  endif
> +endif
> +CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
> +CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
> +CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP) += -mxl-pattern-compare
> +
> +CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
> +
> +# The various CONFIG_XILINX cpu features options are integers 0/1/2...
> +# rather than bools y/n
> +CFLAGS += $(CPUFLAGS-1)
> +CFLAGS += $(CPUFLAGS-2)
>...

Why are the options not bools?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
