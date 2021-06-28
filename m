Return-Path: <SRS0=PW3U=LW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7230FC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 06:57:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B6661A0F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 06:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B6661A0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GCz1X36Qrz3bhY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 16:57:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GCz0q1ZQRz30JZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jun 2021 16:56:26 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GCz0c3JJxzBD3H;
 Mon, 28 Jun 2021 08:56:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mGG8CusSe2ok; Mon, 28 Jun 2021 08:56:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GCz0Y0YjCzBD2H;
 Mon, 28 Jun 2021 08:56:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BDE798B781;
 Mon, 28 Jun 2021 08:56:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PK5cYC-pTAkN; Mon, 28 Jun 2021 08:56:12 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F0E78B77F;
 Mon, 28 Jun 2021 08:56:12 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 8A36E64BE3; Mon, 28 Jun 2021 06:56:12 +0000 (UTC)
Message-Id: <b9c2a9add0f11754539e24c6f421bd2009327c36.1624863323.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/4xx: Fix setup_kuep() on SMP
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 28 Jun 2021 06:56:12 +0000 (UTC)
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

On SMP, setup_kuep() is also called from start_secondary() since
commit 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").

start_secondary() is not an __init function.

Remove the __init marker from setup_kuep() and bail out when
not caller on the first CPU as the work is already done.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 10248dcba120 ("powerpc/44x: Implement Kernel Userspace Exec Protection (KUEP)")
Fixes: 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/44x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/44x.c b/arch/powerpc/mm/nohash/44x.c
index 7da6d1e9fc9b..20c18bd5b9a0 100644
--- a/arch/powerpc/mm/nohash/44x.c
+++ b/arch/powerpc/mm/nohash/44x.c
@@ -241,8 +241,11 @@ void __init mmu_init_secondary(int cpu)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_PPC_KUEP
-void __init setup_kuep(bool disabled)
+void setup_kuep(bool disabled)
 {
+	if (smp_processor_id() != boot_cpuid)
+		return;
+
 	if (disabled)
 		patch_instruction_site(&patch__tlb_44x_kuep, ppc_inst(PPC_RAW_NOP()));
 	else
-- 
2.25.0

