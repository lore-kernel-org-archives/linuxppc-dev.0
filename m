Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6B982DE934
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 06:16:36 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] [0/5] tuning options for PPC64
Date: Wed, 23 Jul 2008 22:16:31 +0200
References: <200807210902.48150.marvin24@gmx.de>
In-Reply-To: <200807210902.48150.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807232216.31610.marvin24@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

and thanks for the feedback. To make it short, the conclusions I draw from 
that are:

	- let the cpu type be choosen optionaly
	- both target cpu and tuning cpu should be selectable
	- if one cpu gets choosen, it should select some feature flag, mcpu and mtune 
option automatically in Kconfig.cputypes
	- if none gets choosen, all features will be selected (is this save?)

I found these ppc64 cpu specific candidates for CONFIG_FEATURE-X:

Altivec (G4, G5, POWER6+7, PA6T)
BAT64 aka POWER3 (Power3)
FPU (all)
Std_MMU (all)
Virt_CPU_Accounting (all, except PA6T?)
VSX (power7)

There are probably some more features present, which are currently enabled by 
some ifdefs for PPC64 and POWER4 (e.g. powermac/feature.c). I will not touch 
them due to my little knowledge and just keep these symbols.

I guess this will become another long weekend ;-)

Marvin


On Monday 21 July 2008 09:02:47 Marvin wrote:
> Hi,
>
> the following five patches should lay a foundation to more fine-grained
> tuning on PPC64 cpus. They must be applied in order. The motivation are the
> discussions of serveral cpu specific optimizations in the past on this
> list, cleanup of the wired Makefile/CONFIG_POWERx constructs and at least
> the ownership of a PS3.
>
> The patches intoduce CONFIG_TUNE_some_cpu and CONFIG_OPT_EXCLUSIVE, with
> the aim to cover two common cases:
>
> 	- distributions want a common kernel, bootable on all ppc64 machines and
> tune for a certain cpu
>
> 	- high end users don't care about older cpus and want to compile a kernel
> with their favorite mcpu option
>
> I know there is also the possibility of mcpu=x and mtune=y, y>x but this
> can be tackled in the next step (hopefully).
>
> I know this will bring up some conserns, but my initial findings grepping
> the defconfigs show:
>
> 	- CONFIG_POWER3 enables BATS only
> 		it is also used the enable some configs
> 		it is used always in combination with CONFIG_POWER4
>
> 	- CONFIG_POWER4 is always combined with CONFIG_PPC64 and vice versa
> 		all POWER3 || POWER4 || PPC64 can be replaced by PPC64
>
> 	- There seems to be no support for 32-bit kernels on ppc64 machines
>
> I hope for some feedback, so this new scheme (or some other) can be
> included to mainstream kernel.
>
> Greetings
>
> Marvin
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
