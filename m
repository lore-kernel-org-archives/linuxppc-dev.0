Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BE741A094B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:09:46 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1FC36140D4E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:09:44 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:39:43 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 54EEB125805D
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:41:55 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF9cwB1769792
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:39:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8Vwk028549
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 16/28] selftests, powerpc: Add more SPR numbers,
 TM & VMX instructions to 'reg.h'
Date: Tue, 19 May 2015 20:38:12 +0530
Message-Id: <1432048104-4695-17-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds SPR number for TAR, PPR, DSCR special
purpose registers. It also adds TM, VSX, VMX related
instructions which will then be used by patches later
in the series.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/reg.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/powerpc/reg.h b/tools/testing/selftests/powerpc/reg.h
index 5921b0d..76f170d 100644
--- a/tools/testing/selftests/powerpc/reg.h
+++ b/tools/testing/selftests/powerpc/reg.h
@@ -18,6 +18,19 @@
 
 #define mb()		asm volatile("sync" : : : "memory");
 
+/* Vector Instructions */
+#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
+				 ((rb) << 11) | (((xs) >> 5)))
+#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs), (ra), (rb)))
+#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs), (ra), (rb)))
+
+/* TM instructions */
+#define TBEGIN		".long 0x7C00051D;"
+#define TABORT		".long 0x7C00071D;"
+#define TEND		".long 0x7C00055D;"
+#define TSUSPEND	".long 0x7C0005DD;"
+#define TRESUME		".long 0x7C2005DD;"
+
 #define SPRN_MMCR2     769
 #define SPRN_MMCRA     770
 #define SPRN_MMCR0     779
@@ -46,4 +59,12 @@
 #define SPRN_SDAR      781
 #define SPRN_SIER      768
 
+#define SPRN_DSCR      3	/* Data Stream Control Register */
+#define SPRN_TAR       815	/* Target Address Register */
+#define SPRN_PPR       896	/* Program Priority Register */
+
+#define SPRN_TFHAR	0x80	/* TM Failure Handle Register */
+#define SPRN_TFIAR	0x81	/* TM Failure Instruction Address Register */
+#define SPRN_TEXASR	0x82	/* TM Exception and Status Register */
+
 #endif /* _SELFTESTS_POWERPC_REG_H */
-- 
2.1.0
