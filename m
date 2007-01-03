Return-Path: <linux-ppc@castalie.org>
Received: from tloen.castalie.org (tloen.castalie.org [213.41.240.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1932DDE16
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 17:50:02 +1100 (EST)
Received: from mlejnas.priv.castalie.org ([192.168.12.8])
	by tloen.castalie.org with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.61)
	(envelope-from <linux-ppc@castalie.org>) id 1H1zwj-00056A-AD
	for linuxppc-dev@ozlabs.org; Wed, 03 Jan 2007 07:49:57 +0100
Date: Wed, 3 Jan 2007 07:49:56 +0100
From: Simon Vallet <linux-ppc@castalie.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add support for R_PPC_ADDR16_HI relocations
Message-ID: <20070103074956.4c396f71@mlejnas.priv.castalie.org>
In-Reply-To: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
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


apply_relocate_add() does not support R_PPC_ADDR16_HI relocations, which
prevents some non gcc-built modules to be loaded.

Signed-off-by: Simon Vallet <svallet@gmail.com>
---

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 8339fd6..07a89a3 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -224,7 +224,12 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			/* Low half of the symbol */
 			*(uint16_t *)location = value;
 			break;
-		
+
+		case R_PPC_ADDR16_HI:
+			/* Higher half of the symbol */
+			*(uint16_t *)location = (value >> 16);
+			break;
+
 		case R_PPC_ADDR16_HA:
 			/* Sign-adjusted lower 16 bits: PPC ELF ABI says:
 			   (((x >> 16) + ((x & 0x8000) ? 1 : 0))) & 0xFFFF.
