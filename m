Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D76C432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 08:30:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C961260FE8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 08:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C961260FE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GzL3K6Z2Dz2yw5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Aug 2021 18:30:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GzL2t1Vq9z2xXR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Aug 2021 18:29:39 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GzL2l5Ydhz9sTF;
 Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffasIuKm1dMh; Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GzL2l4brwz9sT9;
 Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A5E38B7DD;
 Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id I_QUyGcvPMKr; Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AC718B7DE;
 Tue, 31 Aug 2021 10:29:35 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 223E66BCA2; Tue, 31 Aug 2021 08:29:35 +0000 (UTC)
Message-Id: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 31 Aug 2021 08:29:35 +0000 (UTC)
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

Commit d75d68cfef49 ("powerpc: Clean up obsolete code relating to
decrementer and timebase") made generic_suspend_enable_irqs() and
generic_suspend_disable_irqs() static.

Fold them into their only caller.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/time.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 934d8ae66cc6..cae8f03a44fe 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -631,8 +631,12 @@ void timer_broadcast_interrupt(void)
 #endif
 
 #ifdef CONFIG_SUSPEND
-static void generic_suspend_disable_irqs(void)
+/* Overrides the weak version in kernel/power/main.c */
+void arch_suspend_disable_irqs(void)
 {
+	if (ppc_md.suspend_disable_irqs)
+		ppc_md.suspend_disable_irqs();
+
 	/* Disable the decrementer, so that it doesn't interfere
 	 * with suspending.
 	 */
@@ -642,23 +646,11 @@ static void generic_suspend_disable_irqs(void)
 	set_dec(decrementer_max);
 }
 
-static void generic_suspend_enable_irqs(void)
-{
-	local_irq_enable();
-}
-
-/* Overrides the weak version in kernel/power/main.c */
-void arch_suspend_disable_irqs(void)
-{
-	if (ppc_md.suspend_disable_irqs)
-		ppc_md.suspend_disable_irqs();
-	generic_suspend_disable_irqs();
-}
-
 /* Overrides the weak version in kernel/power/main.c */
 void arch_suspend_enable_irqs(void)
 {
-	generic_suspend_enable_irqs();
+	local_irq_enable();
+
 	if (ppc_md.suspend_enable_irqs)
 		ppc_md.suspend_enable_irqs();
 }
-- 
2.25.0

