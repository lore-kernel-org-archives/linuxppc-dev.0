Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A828A2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 11:10:10 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: don't flush/invalidate the d/icache for an unknown
 relocation type
Date: Thu, 27 Jun 2013 09:09:43 +0800
Message-ID: <1372295383-19740-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>,
 Suzuki Poulose <suzuki@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For an unknown relocation type since the value of r4 is just the 8bit
relocation type, the sum of r4 and r7 may yield an invalid memory
address. For example:
    In normal case:
             r4 = c00xxxxx
             r7 = 40000000
             r4 + r7 = 000xxxxx

    For an unknown relocation type:
             r4 = 000000xx
             r7 = 40000000
             r4 + r7 = 400000xx
   400000xx is an invalid memory address for a board which has just
   512M memory.

And for operations such as dcbst or icbi may cause bus error for an
invalid memory address on some platforms and then cause the board
reset. So we should skip the flush/invalidate the d/icache for
an unknown relocation type.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/reloc_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/reloc_32.S b/arch/powerpc/kernel/reloc_32.S
index ef46ba6..f366fed 100644
--- a/arch/powerpc/kernel/reloc_32.S
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -166,7 +166,7 @@ ha16:
 	/* R_PPC_ADDR16_LO */
 lo16:
 	cmpwi	r4, R_PPC_ADDR16_LO
-	bne	nxtrela
+	bne	unknown_type
 	lwz	r4, 0(r9)	/* r_offset */
 	lwz	r0, 8(r9)	/* r_addend */
 	add	r0, r0, r3
@@ -191,6 +191,7 @@ nxtrela:
 	dcbst	r4,r7
 	sync			/* Ensure the data is flushed before icbi */
 	icbi	r4,r7
+unknown_type:
 	cmpwi	r8, 0		/* relasz = 0 ? */
 	ble	done
 	add	r9, r9, r6	/* move to next entry in the .rela table */
-- 
1.8.1.4
