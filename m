Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D028A2BF16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jan 2005 02:53:05 +1100 (EST)
In-Reply-To: <7f834d4e050109212155be7b19@mail.gmail.com>
References: <7f834d4e050109212155be7b19@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-2022-JP; format=flowed
Message-Id: <AD51476A-631F-11D9-807E-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 10 Jan 2005 09:52:48 -0600
To: Aubrey Lee <aubrey1127@gmail.com>,
	"<tglx@linutronix.de> <tglx@linutronix.de>" <tglx@linutronix.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Build cross tools for PowerQUICCIII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've attached some patches Freescale has developed and sent Dan K. to 
include into crosstool.  Feel free to use these until Dan K. 
incorporates them into crosstool:

http://gate.crashing.org/~galak/crosstool-0.28-rc37-e500.patch.bz2
http://gate.crashing.org/~galak/crosstool-0.28-extra-patches.patch.bz2

Two patches are needed for crosstool-0.28-rc37, and are attached:

1/ e500 toolchain patch.

This patch contains the following:

   - spe patches for glibc-2.3.2 and glibc-2.3.2,
     - gcc-3.4.3-e500-glibc-2.3.3-spe.dat
     - powerpc-e500.dat
     - powerpc-e500.config (e500 kernel config for 2.6.9)
     - demo-e500.sh

demo-e500.sh will build an e500 toolchain comprising gcc-3.4.3
glibc-2.3.3, and binutils-2.15

2/ getandpatch EXTRA_PATCHES patch.

This is a patch for getandpatch to permit additional patches (in
addition to the standard crosstool patches) that are needed to be
applied for a toolchain build.  To do this the environment variable
EXTRA_PATCHES is set to the name of the patches needed.  For example
when building the e500 toolchain EXTRA_PATCHES needs to be set to "spe"
to apply the spe patches to glibc.  The glibc spe patches are located
in: crosstool-0.28-rc37/patches/glibc-2.3.2-spe
  The advantage that this gives is that all the standard crosstool 
patches
for glibc-2.3.2 can remain in their original directory, and the spe
patches are applied in addition to the normal glibc patches.

- kumar


On Jan 9, 2005, at 11:21 PM, Aubrey Lee wrote:

>      Hi, I want to build cross tools for PowerQUICCIII（mpc8540, e500 
> core）,
>      Had anyone built cross tools successfully by cross-tools-0.28?
>       What type of target should I set? Could you tell me the versions
>  you have used?
>       Thank you!
>      Best regards
>
>     Aubrey
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
