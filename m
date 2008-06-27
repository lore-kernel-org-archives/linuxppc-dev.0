Return-Path: <john.williams@petalogix.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.227])
	by ozlabs.org (Postfix) with ESMTP id 8DE86DDE1E
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 10:03:49 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so656206qbc.39
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 17:03:47 -0700 (PDT)
Message-ID: <1d3f23370806261703w277719cfn8b9f193e08a9d85a@mail.gmail.com>
Date: Fri, 27 Jun 2008 10:03:46 +1000
From: "John Williams" <john.williams@petalogix.com>
To: "Adrian Bunk" <bunk@kernel.org>
Subject: Re: [PATCH 02/60] microblaze_v4: Makefiles for Microblaze cpu
In-Reply-To: <20080626194002.GC22827@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<20080626143623.GC30954@cs181140183.pp.htv.fi>
	<4863E414.4090303@seznam.cz>
	<20080626194002.GC22827@cs181140183.pp.htv.fi>
Cc: linux-arch@vger.kernel.org, vapier.adi@gmail.com, arnd@arndb.de,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	Michal Simek <monstr@seznam.cz>, John.Linn@xilinx.com,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/27/08, Adrian Bunk <bunk@kernel.org> wrote:
> On Thu, Jun 26, 2008 at 08:46:44PM +0200, Michal Simek wrote:
>  > Adrian Bunk napsal(a):
>  > > On Thu, Jun 26, 2008 at 02:29:31PM +0200, monstr@seznam.cz wrote:
>  > >> ...
>  > >> --- /dev/null
>  > >> +++ b/arch/microblaze/Makefile
>  > >> ...
>  > >> +# Work out HW multipler support.  This is icky.
>  > >> +# 1. Spartan2 has no HW multiplers.
>  > >> +# 2. MicroBlaze v3.x always uses them, except in Spartan 2
>  > >> +# 3. All other FPGa/CPU ver combos, we can trust the CONFIG_ settings
>  > >> +ifeq (,$(findstring spartan2,$(CONFIG_XILINX_MICROBLAZE0_FAMILY)))
>  > >> +  ifeq ($(CPU_MAJOR),3)
>  > >> +    CPUFLAGS-1 += -mno-xl-soft-mul
>  > >> +  else
>  > >> +    # USE_HW_MUL can be 0, 1, or 2, defining a heirarchy of HW Mul support.
>  > >> +    CPUFLAGS-$(subst 1,,$(CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL)) += -mxl-multiply-high
>  > >> +    CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL) += -mno-xl-soft-mul
>  > >> +  endif
>  > >> +endif
>  > >> +CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
>  > >> +CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
>  > >> +CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP) += -mxl-pattern-compare
>  > >> +
>  > >> +CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
>  > >> +
>  > >> +# The various CONFIG_XILINX cpu features options are integers 0/1/2...
>  > >> +# rather than bools y/n
>  > >> +CFLAGS += $(CPUFLAGS-1)
>  > >> +CFLAGS += $(CPUFLAGS-2)
>  > >> ...
>  > >
>  > > Why are the options not bools?
>  > because CONFIG_XILINX_... are 0, 1 or 2 not only y, n.

> I understood that.
>
>  But _why_ are these options not bools?

The CPU has 3 levels of multiplier support -

0=none
1= 32-bit (mul produces 32 LSB of a 32x32 bit multiply)
2= 32-bit high (mulhi produces 32 MSB of a 32x32 bit multiply).

The CPU-specific options are pulled directly out of the MicroBlaze
system design tools as an auto-generated config file that we drop into
the kernel build.  Doing so ensures consistency between the hardware
and the kernel running on it.

These options come out of the tools as intergers, 0,1,2.  We found in
the early days of microblaze that lots of users built unbootable
kernels because they manually transcribed these options incorrectly.
So, we integrate as closely as we reasonable can to prevent these sort
of CPU configuration errors.

These options are now limited to about 6 CPU-specific options - things
we must know about the CPU at compile time to set the correct cpuflags
to GCC.

All else is set through open firmware or querying a Processor Version
Register at boot.

Regards,

John
-- 
John Williams, PhD, B.Eng, B.IT
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663
