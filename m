Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171A1C63798
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED0B20674
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 15:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED0B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgSpG0yTHzDqPy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 02:37:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgSWP4gngzDqZl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 02:25:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CgSWH4YJWz9v0d5;
 Tue, 24 Nov 2020 16:24:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id nPEsL3BkWtmw; Tue, 24 Nov 2020 16:24:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CgSWH2jy7z9v0dP;
 Tue, 24 Nov 2020 16:24:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 567BB8B7B5;
 Tue, 24 Nov 2020 16:25:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rLBehuRkZu7T; Tue, 24 Nov 2020 16:25:00 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9487A8B7B3;
 Tue, 24 Nov 2020 16:24:59 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 6FC72668E2; Tue, 24 Nov 2020 15:24:59 +0000 (UTC)
Message-Id: <e281e3a611eead8817c49cf06a60072a021af823.1606231483.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 6/6] powerpc/ppc-opcode: Add PPC_RAW_MFSPR()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 24 Nov 2020 15:24:59 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add PPC_RAW_MFSPR() to replace open coding done in 8xx-pmu.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ppc-opcode.h | 3 ++-
 arch/powerpc/perf/8xx-pmu.c           | 5 +----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index a6e3700c4566..da6f300e9788 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -230,7 +230,6 @@
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
 #define PPC_INST_RFEBB			0x4c000124
 #define PPC_INST_RFID			0x4c000024
-#define PPC_INST_MFSPR			0x7c0002a6
 #define PPC_INST_MFSPR_DSCR		0x7c1102a6
 #define PPC_INST_MFSPR_DSCR_MASK	0xfc1ffffe
 #define PPC_INST_MTSPR_DSCR		0x7c1103a6
@@ -507,6 +506,8 @@
 
 #define PPC_RAW_NEG(d, a)		(0x7c0000d0 | ___PPC_RT(d) | ___PPC_RA(a))
 
+#define PPC_RAW_MFSPR(d, spr)		(0x7c0002a6 | ___PPC_RT(d) | __PPC_SPR(spr))
+
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_BCCTR_FLUSH		stringify_in_c(.long PPC_INST_BCCTR_FLUSH)
 #define	PPC_CP_ABORT		stringify_in_c(.long PPC_RAW_CP_ABORT)
diff --git a/arch/powerpc/perf/8xx-pmu.c b/arch/powerpc/perf/8xx-pmu.c
index 93004ee586a1..f970d1510d3d 100644
--- a/arch/powerpc/perf/8xx-pmu.c
+++ b/arch/powerpc/perf/8xx-pmu.c
@@ -153,10 +153,7 @@ static void mpc8xx_pmu_read(struct perf_event *event)
 
 static void mpc8xx_pmu_del(struct perf_event *event, int flags)
 {
-	struct ppc_inst insn;
-
-	/* mfspr r10, SPRN_SPRG_SCRATCH2 */
-	insn = ppc_inst(PPC_INST_MFSPR | __PPC_RS(R10) | __PPC_SPR(SPRN_SPRG_SCRATCH2));
+	struct ppc_inst insn = ppc_inst(PPC_RAW_MFSPR(10, SPRN_SPRG_SCRATCH2));
 
 	mpc8xx_pmu_read(event);
 
-- 
2.25.0

