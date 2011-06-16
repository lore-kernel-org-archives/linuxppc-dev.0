Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0219B6FA0
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:14:35 +1000 (EST)
Received: by fxm1 with SMTP id 1so1329303fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:14:31 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] Relocatable kernel for ppc44x
Date: Thu, 16 Jun 2011 16:14:21 +0200
Message-Id: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
Cc: arnd@arndb.de, tmarri@apm.com, suzuki@in.ibm.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

John mentioned in his email that we have some patches.
I am also sending them [patch 1/7-6/7]. It is support for non zero
boot address for ppc44x.

Patch 7/7 is relocatable support for ppc44x.

All patches are against 2.6.31.13 but it shouldn't be big problem
to port them to the latest and greatest. 

We are using 256MB alignment which is fine for our purposes. But I think
it could be simple to change it to any different style.

I have tested it on QEMU system emulator with u-boot.
I have used its with vmlinux.bin.gz and DTB. Not sure about your configuration
but the best is not to relocate DTB. Address of DTB should be in 256MB boundary
to be able to access it in the first pinned 256MB tlb. I haven't tested any other
configuration but I have tried not to break anyone. Not sure if I can use r25, r26 and r21
(I need two regs for storing temp values). I look forward on your recommendation.

The idea of this patch is to find out where the kernel runs. Pinned 256MB
in asm - setup memstart_addr and kernstart_addr in ASM and not to break generic 
PPC code. And also setup TLB for larger memories in mmu_mapin_ram. Have tested system till
768MB.

Thanks for your comments,
Michal

P.S.: Sorry for faults in PPC asm - I am not PPC expert.
