Return-Path: <SRS0=iSul=EJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8228FC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 18:17:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD07D20757
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 18:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD07D20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQdLC5DHlzDqmJ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 05:17:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQd6H2VNmzDqgV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2020 05:07:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CQd6B1lWkz9v1Yb;
 Tue,  3 Nov 2020 19:07:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NF4LVou6ygdx; Tue,  3 Nov 2020 19:07:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CQd6B0xm0z9v1YS;
 Tue,  3 Nov 2020 19:07:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E19C58B7DC;
 Tue,  3 Nov 2020 19:07:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1AyYWoDOcbhm; Tue,  3 Nov 2020 19:07:15 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 59EAB8B7DD;
 Tue,  3 Nov 2020 19:07:15 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 3E52266860; Tue,  3 Nov 2020 18:07:15 +0000 (UTC)
Message-Id: <2d03f4b466156c0a0bfe5494c8874dcac952445c.1604426550.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1604426550.git.christophe.leroy@csgroup.eu>
References: <cover.1604426550.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v13 4/8] powerpc/time: Move timebase functions into new
 asm/timebase.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 nathanl@linux.ibm.com, anton@ozlabs.org
Date: Tue,  3 Nov 2020 18:07:15 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In order to easily use get_tb() from C VDSO, move timebase
functions into a new header named asm/timebase.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v13: new
---
 arch/powerpc/include/asm/time.h     | 30 +--------------------
 arch/powerpc/include/asm/timebase.h | 42 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 29 deletions(-)
 create mode 100644 arch/powerpc/include/asm/timebase.h

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 2f566c1a754c..46d0d65cda0e 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -15,6 +15,7 @@
 
 #include <asm/processor.h>
 #include <asm/cpu_has_feature.h>
+#include <asm/timebase.h>
 
 /* time.c */
 extern unsigned long tb_ticks_per_jiffy;
@@ -38,12 +39,6 @@ struct div_result {
 	u64 result_low;
 };
 
-/* For compatibility, get_tbl() is defined as get_tb() on ppc64 */
-static inline unsigned long get_tbl(void)
-{
-	return mftb();
-}
-
 static inline u64 get_vtb(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -53,29 +48,6 @@ static inline u64 get_vtb(void)
 	return 0;
 }
 
-static inline u64 get_tb(void)
-{
-	unsigned int tbhi, tblo, tbhi2;
-
-	if (IS_ENABLED(CONFIG_PPC64))
-		return mftb();
-
-	do {
-		tbhi = mftbu();
-		tblo = mftb();
-		tbhi2 = mftbu();
-	} while (tbhi != tbhi2);
-
-	return ((u64)tbhi << 32) | tblo;
-}
-
-static inline void set_tb(unsigned int upper, unsigned int lower)
-{
-	mtspr(SPRN_TBWL, 0);
-	mtspr(SPRN_TBWU, upper);
-	mtspr(SPRN_TBWL, lower);
-}
-
 /* Accessor functions for the decrementer register.
  * The 4xx doesn't even have a decrementer.  I tried to use the
  * generic timer interrupt code, which seems OK, with the 4xx PIT
diff --git a/arch/powerpc/include/asm/timebase.h b/arch/powerpc/include/asm/timebase.h
new file mode 100644
index 000000000000..a8eae3adaa91
--- /dev/null
+++ b/arch/powerpc/include/asm/timebase.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Common timebase prototypes and such for all ppc machines.
+ *
+ * Written by Cort Dougan (cort@cs.nmt.edu) to merge
+ * Paul Mackerras' version and mine for PReP and Pmac.
+ */
+
+#ifndef __POWERPC_TIMEBASE_H
+#define __POWERPC_TIMEBASE_H
+
+#include <asm/reg.h>
+
+/* For compatibility, get_tbl() is defined as get_tb() on ppc64 */
+static inline unsigned long get_tbl(void)
+{
+	return mftb();
+}
+
+static inline u64 get_tb(void)
+{
+	unsigned int tbhi, tblo, tbhi2;
+
+	if (IS_ENABLED(CONFIG_PPC64))
+		return mftb();
+
+	do {
+		tbhi = mftbu();
+		tblo = mftb();
+		tbhi2 = mftbu();
+	} while (tbhi != tbhi2);
+
+	return ((u64)tbhi << 32) | tblo;
+}
+
+static inline void set_tb(unsigned int upper, unsigned int lower)
+{
+	mtspr(SPRN_TBWL, 0);
+	mtspr(SPRN_TBWU, upper);
+	mtspr(SPRN_TBWL, lower);
+}
+#endif /* __POWERPC_TIMEBASE_H */
-- 
2.25.0

