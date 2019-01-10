Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D4BC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 11:56:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8791C214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 11:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8791C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b4GG0DrlzDqfB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 22:56:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b4CH2WfJzDqdR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 22:53:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43b4CG35v9z9sLt; Thu, 10 Jan 2019 22:53:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43b4CG27XXz9sMQ; Thu, 10 Jan 2019 22:53:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Allow smt-enabled=off on Power9
Date: Thu, 10 Jan 2019 22:53:35 +1100
Message-Id: <20190110115335.29463-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: mikey@neuling.org, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit d70a54e2d085 ("powerpc/powernv: Ignore smt-enabled on Power8
and later") we disabled smt-enabled=off on Power8 and later CPUs
because the subcore logic required all CPUs to be booted.

However Power9 doesn't support subcore, so we can support
smt-enabled=off on Power9. Fix the code to do that.

Fixes: c3ab300ea555 ("powerpc: Add POWER9 cputable entry")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/smp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 0d354e19ef92..3ab5755eb09f 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -254,12 +254,12 @@ static void pnv_smp_cpu_kill_self(void)
 static int pnv_cpu_bootable(unsigned int nr)
 {
 	/*
-	 * Starting with POWER8, the subcore logic relies on all threads of a
-	 * core being booted so that they can participate in split mode
-	 * switches. So on those machines we ignore the smt_enabled_at_boot
-	 * setting (smt-enabled on the kernel command line).
+	 * On POWER8 the subcore logic relies on all threads of a core being
+	 * booted so that they can participate in split mode switches. So on
+	 * those machines we ignore the smt_enabled_at_boot setting (smt-enabled
+	 * on the kernel command line).
 	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+	if (cpu_has_feature(CPU_FTR_ARCH_207S) && !cpu_has_feature(CPU_FTR_ARCH_300))
 		return 1;
 
 	return smp_generic_cpu_bootable(nr);
-- 
2.20.1

