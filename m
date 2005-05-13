Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 49B32679F5
	for <linuxppc-dev@ozlabs.org>; Sat, 14 May 2005 02:03:49 +1000 (EST)
In-Reply-To: <200505131749.20752.pluto@agmk.net>
References: <200505131749.20752.pluto@agmk.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <54f0f21514487ab2492daa91cc630a58@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 13 May 2005 11:03:35 -0500
To: "Pawel Sikora" <pluto@agmk.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8] OOPS and SIGSEGV on altivec instruction on PowerPC 7540.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is odd. the 2.6.8 kernel should have the code that causes a SIGILL=20=

if !CONFIG_ALTIVEC.  Can you enable CONFIG_KALLSYMS.

- kumar

On May 13, 2005, at 10:49 AM, Pawel Sikora wrote:

> Hi,
>
> simple runtime altivec detection from userspace causes an oops
>  on the `vand` instruction. kernel was built *without* CONFIG_ALTIVEC.
> i think kernel should return a SIGILL instead of an oops ;-)
>
> Oops: kernel access of bad area, sig: 11 [#65]
>  NIP: C0008B84 LR: C0007F2C SP: CF373F20 REGS: cf373e70 TRAP: 0300 Not=20=

> tainted
>  MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>  DAR: 00000088, DSISR: 40000000
>  TASK =3D c81e04f0[12983] 'altivec' THREAD: cf372000Last syscall: 174
>  GPR00: C0007F2C CF373F20 C81E04F0 00000004 00000004 00030001 00000000=20=

> 0FEE08D0
>  GPR08: 0000F932 C0007F2C 00009032 C0350000 081E0788 00000000 00000000=20=

> 100A37D8
>  GPR16: 100A0000 00000000 100A0000 00000000 10070000 100A37C8 100AEF08=20=

> 00000000
>  GPR24: 100A1108 00000000 100A59A8 3002AEF8 3002BB80 3002AE60 0FFEA6FC=20=

> 00000004
>  Call trace: [c0007f2c]
>
>
>
> processor =A0 =A0 =A0 : 0
>  cpu =A0 =A0 =A0 =A0 =A0 =A0 : 7450
>  clock =A0 =A0 =A0 =A0 =A0 : 700MHz
>  revision =A0 =A0 =A0 =A0: 2.1 (pvr 8000 0201)
>  bogomips =A0 =A0 =A0 =A0: 696.32
>  machine =A0 =A0 =A0 =A0 : PowerMac4,4
>  motherboard =A0 =A0 : PowerMac4,4 MacRISC2 MacRISC Power Macintosh
>  detected as =A0 =A0 : 80 (eMac)
>  pmac flags =A0 =A0 =A0: 00000001
>  L2 cache =A0 =A0 =A0 =A0: 256K unified
> memory =A0 =A0 =A0 =A0 =A0: 384MB
>  pmac-generation : NewWorld
>
> --=20
> The only thing necessary for the triumph of evil
>  =A0 is for good men to do nothing.
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - Edmund Burke
> <altivec.c>=
