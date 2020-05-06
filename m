Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB310C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 18:07:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCF920747
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 18:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCF920747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49HPhD37xwzDrBg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2020 04:07:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49HMx9064GzDqlD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2020 02:48:45 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49HMx36PHtz9v4kL;
 Wed,  6 May 2020 18:48:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Fc1Kf6BEehOV; Wed,  6 May 2020 18:48:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49HMx35B4Jz9v4kD;
 Wed,  6 May 2020 18:48:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 94DF38B7C5;
 Wed,  6 May 2020 18:48:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 77V0bCkrPIQt; Wed,  6 May 2020 18:48:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 56AA38B7C3;
 Wed,  6 May 2020 18:48:41 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 2223865911; Wed,  6 May 2020 16:48:41 +0000 (UTC)
Message-Id: <1b1406f8c839805dd6d259e2fd40a135e0a9a830.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 35/45] powerpc/8xx: Move DTLB perf handling closer.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed,  6 May 2020 16:48:41 +0000 (UTC)
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

Now that space have been freed next to the DTLB miss handler,
it's associated DTLB perf handling can be brought back in
the same place.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index fb5d17187772..9f3f7f3d03a7 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -344,6 +344,17 @@ DataStoreTLBMiss:
 	rfi
 	patch_site	0b, patch__dtlbmiss_exit_1
 
+#ifdef CONFIG_PERF_EVENTS
+	patch_site	0f, patch__dtlbmiss_perf
+0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	addi	r10, r10, 1
+	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
+	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_DAR, r11	/* Tag DAR */
+	mfspr	r11, SPRN_M_TW
+	rfi
+#endif
+
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -390,18 +401,6 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
 	EXC_XFER_LITE(0x300, handle_page_fault)
 
-/* Called from DataStoreTLBMiss when perf TLB misses events are activated */
-#ifdef CONFIG_PERF_EVENTS
-	patch_site	0f, patch__dtlbmiss_perf
-0:	lwz	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	addi	r10, r10, 1
-	stw	r10, (dtlb_miss_counter - PAGE_OFFSET)@l(0)
-	mfspr	r10, SPRN_DAR
-	mtspr	SPRN_DAR, r11	/* Tag DAR */
-	mfspr	r11, SPRN_M_TW
-	rfi
-#endif
-
 stack_overflow:
 	vmap_stack_overflow_exception
 
-- 
2.25.0

