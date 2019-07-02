Return-Path: <SRS0=fll7=U7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D1C06510
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 08:29:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA35208C4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 08:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA35208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45dHV55cvfzDqXZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 18:29:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45dHSD04T3zDqX7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2019 18:28:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45dHSC4mfHz9s00; Tue,  2 Jul 2019 18:28:11 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45dHSC4R4Zz9sLt; Tue,  2 Jul 2019 18:28:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s/exception: Remove unused SOFTEN_VALUE_0x980
Date: Tue,  2 Jul 2019 18:28:01 +1000
Message-Id: <20190702082801.29975-1-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove SOFTEN_VALUE_0x980, it's been unused since commit
dabe859ec636 ("powerpc: Give hypervisor decrementer interrupts their
own handler") (Sep 2012).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index b590765f6e45..b4f8b745ba01 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -583,7 +583,6 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 /* This associate vector numbers with bits in paca->irq_happened */
 #define SOFTEN_VALUE_0x500	PACA_IRQ_EE
 #define SOFTEN_VALUE_0x900	PACA_IRQ_DEC
-#define SOFTEN_VALUE_0x980	PACA_IRQ_DEC
 #define SOFTEN_VALUE_0xa00	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
-- 
2.20.1

