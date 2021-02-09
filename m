Return-Path: <SRS0=hK36=HL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE69C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 11:56:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA8364E7C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 11:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA8364E7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZhFT68BvzDq9s
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 22:56:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZfFG1mz5zDrgD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2021 21:26:25 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DZfF95Qgsz9tx3p;
 Tue,  9 Feb 2021 11:26:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kppz17VdpS9f; Tue,  9 Feb 2021 11:26:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DZfF94TDfz9tx3l;
 Tue,  9 Feb 2021 11:26:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 819E08B7D8;
 Tue,  9 Feb 2021 11:26:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BUaKzDMSuPmu; Tue,  9 Feb 2021 11:26:22 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BEDC8B7D6;
 Tue,  9 Feb 2021 11:26:22 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 258116733E; Tue,  9 Feb 2021 10:26:22 +0000 (UTC)
Message-Id: <decefb47c8a2070bf55d20b096b813908c7b3110.1612866360.git.christophe.leroy@csgroup.eu>
In-Reply-To: <99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu>
References: <99bf008e2970de7f8ed3225cda69a6d06ae1a644.1612866360.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/3] powerpc/time: Avoid using get_tbl()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 broonie@kernel.org
Date: Tue,  9 Feb 2021 10:26:22 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

get_tbl() is confusing as it returns the content TBL register
on PPC32 but the concatenation of TBL and TBU on PPC64.

Use mftb() instead.

This will allow the removal of get_tbl() in a following patch.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 05e19470d523..b91ebebd9ff2 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -229,7 +229,7 @@ static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
 	int dma, write, poll_dma;
 
 	spin_lock_irqsave(&lpbfifo.lock, flags);
-	ts = get_tbl();
+	ts = mftb();
 
 	req = lpbfifo.req;
 	if (!req) {
@@ -307,7 +307,7 @@ static irqreturn_t mpc52xx_lpbfifo_irq(int irq, void *dev_id)
 	if (irq != 0) /* don't increment on polled case */
 		req->irq_count++;
 
-	req->irq_ticks += get_tbl() - ts;
+	req->irq_ticks += mftb() - ts;
 	spin_unlock_irqrestore(&lpbfifo.lock, flags);
 
 	/* Spinlock is released; it is now safe to call the callback */
@@ -330,7 +330,7 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, void *dev_id)
 	u32 ts;
 
 	spin_lock_irqsave(&lpbfifo.lock, flags);
-	ts = get_tbl();
+	ts = mftb();
 
 	req = lpbfifo.req;
 	if (!req || (req->flags & MPC52XX_LPBFIFO_FLAG_NO_DMA)) {
@@ -361,7 +361,7 @@ static irqreturn_t mpc52xx_lpbfifo_bcom_irq(int irq, void *dev_id)
 	lpbfifo.req = NULL;
 
 	/* Release the lock before calling out to the callback. */
-	req->irq_ticks += get_tbl() - ts;
+	req->irq_ticks += mftb() - ts;
 	spin_unlock_irqrestore(&lpbfifo.lock, flags);
 
 	if (req->callback)
-- 
2.25.0

