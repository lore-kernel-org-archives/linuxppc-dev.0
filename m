Return-Path: <kumar.gala@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id C713D2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Dec 2004 02:16:16 +1100 (EST)
In-Reply-To: <1103122166.3406.174.camel@tglx.tec.linutronix.de>
References: <1103122166.3406.174.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <366A345A-4EAC-11D9-9441-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 15 Dec 2004 09:15:53 -0600
To: <tglx@linutronix.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Compile 6xx specific code only for 6xx machines
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One reason for this is that we dont have boot/common code for e500.  Up=20=

to this point we've been using uImage's which causes code in=20
boot/common not to get built.

Maybe someone will be motivated to right e500/85xx boot/common code :)

- kumar

On Dec 15, 2004, at 8:49 AM, Thomas Gleixner wrote:

> On Wed, 2004-12-15 at 07:35 -0700, Tom Rini wrote:
>  > On Wed, Dec 15, 2004 at 03:21:43PM +0100, tglx@linutronix.de wrote:
>  >
> > > The 6xx specific mmu functions in arch/boot/common/util.S break=20
> the compile for
>  > > other platforms. Compile them for 6xx only.
>  >
> > They, er, do?=A0 Can you please post a log?=A0 And what toolchain =
are you
>  > using?=A0 I'd make a quick guess that the binutils folks are being=20=

> overly
>  > 'helpful' again, but perhaps I'm just jaded. :)
>
> I'm compiling for 8540 (e500)
>
> =A0 AS=A0=A0=A0=A0=A0 arch/ppc/boot/common/util.o
> /home/tglx/work/repos/linux-ebrain/2.6.10-
>  rc3/arch/ppc/boot/common/util.S: Assembler messages:
>  /home/tglx/work/repos/linux-ebrain/2.6.10-
>  rc3/arch/ppc/boot/common/util.S:76: Error: Unrecognized opcode:=20
> `mtsrin'
>  make[3]: *** [arch/ppc/boot/common/util.o] Error 1
>  make[2]: *** [arch/ppc/boot/common] Error 2
>  make[1]: *** [zImage] Error 2
>  make: *** [_all] Error 2
>
> Toolchain is built with crosstool
>
> binutils-2.15
>  gcc-3.4.2
>  glibc-2.3.3
>
> tglx
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
