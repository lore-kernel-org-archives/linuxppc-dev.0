Return-Path: <Qi.W@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D669367BB2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 11:10:52 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9J1ApiF015621 for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 18:10:51 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9J1AlqR009170
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Oct 2006 20:10:49 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linuxppc-embedded Digest, Vol 26, Issue 36
Date: Thu, 19 Oct 2006 09:10:44 +0800
Message-ID: <54A124D27BDE0F449E2032F42ED617583197CD@zch01exm21.fsl.freescale.net>
In-Reply-To: <mailman.354.1161187327.32299.linuxppc-embedded@ozlabs.org>
From: "Wang Matthew-R59995" <Qi.W@freescale.com>
To: <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Actually I do many trials about it. Vxwerks Bootrom is smaller than
U-Boot. The key difference between Bootrom and U-boot is that some
source code of Bootrom is invisible to the users.

Actually the rfi instruction which I point out is the first rfi
instruction of Linux PowerPC bringup.

Before that, it's TLB entry invalidation and temp TLB entry mapping.

I check MMU setting carefully before coming Linux Kernel.

I just want to know if other guys met similar scenario like me. I don't
need the precise answer, just overall suggestion about it because I
understand that not everyone has the same bootloader of mine, that
bootloader is actually a customized bootloader.

Anyway thank you.

R9 point to LR register, mask the high 20 bit of r9 and send to r7, and
then add 24, which means stride 6 instructions for rfi instruction
execution.

Of course, rfi can switch the TLB entry, both the previous TLB entry and
the temp TLB entry point to the same physical address.

I've checked it.

B.R
Wang Qi.


Date: Wed, 18 Oct 2006 08:39:23 -0500
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: About the RFI instruction on Linux Powerpc
To: Wang Matthew-R59995 <Qi.W@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Message-ID: <0EE06CE5-98CB-49BB-A398-DF0E3277125D@kernel.crashing.org>
Content-Type: text/plain; charset=3DUS-ASCII; delsp=3Dyes; =
format=3Dflowed


On Oct 18, 2006, at 7:49 AM, Wang Matthew-R59995 wrote:

> Hi folks,
>
> Currently I meet an issue about rfi instruction. Please see the =20
> following source code. This source code is contained at the =20
> head_fsl_booke.h of ./arch/powerpc/kernel directory.
>
>  xori r6,r4,1
>  slwi r6,r6,5  /* setup new context with other address space */
>  bl 1f  /* Find our address */
> 1: mflr r9
>  rlwimi r7,r9,0,20,31
>  addi r7,r7,24
>  mtspr SPRN_SRR0,r7
>  mtspr SPRN_SRR1,r6
>  rfi
> I found that rfi instruction can't jump to the address of SRR0. I =20
> take the MPC8555CDS board to do those test. And I don't take U-Boot =20
> as bootloader, while the Vxwerks Bootrom.
>
> I just want to try if Bootrom can bring up the Linux Powerpc kernel.
>
> Any suggestion for that?

What does happen after the rfi instruction?  Do you have a JTAG =20
debugger or something you can use to single step through this code?  =20
Do you know the value of r9?

There are some expectations as to what's setup by the bootloader when =20
you jump into the kernel.  They are pretty minimal but I dont know if =20
the VxWorks Bootrom does the same thing as u-boot.

- kumar
