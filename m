Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81EA1DDF0F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:30:34 +1000 (EST)
Date: Wed, 11 Apr 2007 03:30:00 -0500 (CDT)
Subject: [PATCH kexec-tools] ppc64: correct @ha relocation
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: <fastboot@lists.osdl.org>, Sachin Sant <sachinp@in.ibm.com>
Message-Id: <boot-4-kexec-02.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Vivek Goyal <vgoyal@in.ibm.com>,
	Simon Horman <horms@verge.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The @ha relocation is supposed to account for the @l relocation being
a signed quantity by adding 1 if the msb of @l is set.

The trick of adding 0x8000 stolen from the linux kernel file
arch/powerpc/kernel/module_64.c which credits binutils.

Signed-off-by: Milton Miller <miltonm@bga.com>

--- 
This relocation is used in v2wrap.S to hold and release the slave cpus.
Without this fix the memory location may be 64k off the initialized variable
which is checked against 0.


--- kexec-tools-testing/kexec/arch/ppc64/kexec-elf-rel-ppc64.c.orig	2007-04-10 22:29:59.000000000 -0500
+++ kexec-tools-testing/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2007-04-10 22:29:59.000000000 -0500
@@ -97,7 +97,7 @@ void machine_apply_elf_rel(struct mem_eh
 		break;
 
 	case R_PPC64_ADDR16_HA:
-		*(uint16_t *)location = ((value>>16)  & 0xffff);
+		*(uint16_t *)location = (((value+0x8000)>>16)  & 0xffff);
 		break;
 
 	case R_PPC64_ADDR16_HIGHEST:
