Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE3242C01D9
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 22:26:47 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 18 Apr 2013 17:51:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 30419125804F
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 17:58:04 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3ICQQie24510528
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 17:56:26 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3ICQVxM008564
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 22:26:31 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] powerpc,
 perf: Add new BHRB related instructions for POWER8
Date: Thu, 18 Apr 2013 17:56:12 +0530
Message-Id: <1366287976-3900-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1366287976-3900-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1366287976-3900-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds new POWER8 instruction encoding for reading
the BHRB buffer entries and also clearing it. Encoding for
"clrbhrb" instruction is straight forward. But "mfbhrbe"
encoding involves reading a certain index of BHRB buffer
into a particular GPR register.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-opcode.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 8752bc8..93ae5a1 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -82,6 +82,7 @@
 #define	__REGA0_R31	31
 
 /* sorted alphabetically */
+#define PPC_INST_BHRBE			0x7c00025c
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
@@ -297,6 +298,12 @@
 #define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
 #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
 
+/* BHRB instructions */
+#define PPC_CLRBHRB		stringify_in_c(.long 0x7c00035c)
+#define PPC_MFBHRBE(r, n)	stringify_in_c(.long PPC_INST_BHRBE | \
+						__PPC_RS(r) | \
+							(((n) & 0x1f) << 11))
+
 /* Transactional memory instructions */
 #define TRECHKPT		stringify_in_c(.long PPC_INST_TRECHKPT)
 #define TRECLAIM(r)		stringify_in_c(.long PPC_INST_TRECLAIM \
-- 
1.7.11.7
