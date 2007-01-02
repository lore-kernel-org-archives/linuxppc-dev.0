Return-Path: <linux-ppc@castalie.org>
Received: from tloen.castalie.org (tloen.castalie.org [213.41.240.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B6AFDDE2C
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 03:46:09 +1100 (EST)
Received: from mlejnas.priv.castalie.org ([192.168.12.8])
	by tloen.castalie.org with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.61)
	(envelope-from <linux-ppc@castalie.org>) id 1H1mSZ-0004jA-K5
	for linuxppc-dev@ozlabs.org; Tue, 02 Jan 2007 17:25:55 +0100
Date: Tue, 2 Jan 2007 17:25:54 +0100
From: Simon Vallet <linux-ppc@castalie.org>
To: linuxppc-dev@ozlabs.org
Subject: R_PPC_ADDR16_HI relocs in PPC modules ?
Message-ID: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm currently trying to port a binary-only driver to Linux/PPC using a
MacOS X driver as a starting point. "Translating" this driver to ELF32
gives an object that links into a .ko without too much problems.

However, trying to insmod the resulting object gives the following
error message:

unknown ADD relocation: 5

which refers to R_PPC_ADDR16_HI relocations. The error message comes
from apply_relocate_add() in arch/powerpc/kernel/module_32.c, which
deals with R_PPC_ADDR16_LO and R_PPC_ADDR16_HA relocs, but not
R_PPC_ADDR16_HI ones.

Is there a reason for this ? Those relocs directly come from the
mapping of PPC_RELOC_HI16 in the original driver, and i'd rather not
transpose them into R_PPC_ADDR16_HA.

If there are no reasons, then how about the following patch ?
(this is against 2.6.18.1, but the problem is still present in 2.6.19 kernels)

--- arch/powerpc/kernel/module_32.c.orig	2007-01-02 17:07:21.000000000 +0100
+++ arch/powerpc/kernel/module_32.c	2007-01-02 17:11:55.000000000 +0100
@@ -222,6 +222,11 @@ int apply_relocate_add(Elf32_Shdr *sechd
 			*(uint16_t *)location = value;
 			break;
 		
+		case R_PPC_ADDR16_HI:
+			/* Higher half of the symbol */
+			*(uint16_t *)location = (value >> 16);
+			break;
+
 		case R_PPC_ADDR16_HA:
 			/* Sign-adjusted lower 16 bits: PPC ELF ABI says:
 			   (((x >> 16) + ((x & 0x8000) ? 1 : 0))) & 0xFFFF.


Note that I'm quite new to the kernel in general, so feel free to point me to 
another list if you think my questions are inappropriate here.

Simon
