Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1B842C0125
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:57:02 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 18:22:49 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 88FB91258053
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:28:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3GCuoLC5374436
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:26:51 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3GCurU3001538
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:56:54 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] powerpc, perf: Add new BHRB related instructions on POWER8
Date: Tue, 16 Apr 2013 18:26:36 +0530
Message-Id: <1366117000-10979-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1366117000-10979-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1366117000-10979-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds new instructions support for reading various
BHRB entries and also clearing the BHRB buffer.

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
