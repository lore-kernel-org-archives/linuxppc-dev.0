Return-Path: <linuxppc-dev+bounces-29009-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AF9CA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 19:26:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0NQG3Kznz3bxL;
	Thu, 08 Oct 2026 06:25:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791401158;
	cv=none; b=LuRP4ZMwLqrFJNseE4eFCDlbBB111u8Ie9bdXItLAu/BkSXAeyVx28WmQ7do1qJ5t/0dX/1/xyc4b8bPHJS8vB25ZnuVuaGEyz+yqDA7dfGQKPlSju17bf+RsIAM/8O/IcW2CLijRNGVITs3e3HaPMWpEr8xC6frUSaDmxdAKmKNP3qplgE19Caps8JUgyEdCEHoYMY10hpiuRiwD19Znf6wUFDf25Jc06GNnzASAj5bryyX0KasdaES8lFGzg4yqu62JFbrw+VBsCzJ0v84U68yBHuCExx7b4ZZG2gNKRCB7DBtxDUr+Y+m4CYDGOpDIxfxG9RgZvBZ4BooPN15mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791401158; c=relaxed/relaxed;
	bh=oi+300uQCKN6go0Uzy01rEfOuz7twvEiy0ZSJsooAbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhPiSIIXintaD+Qq0nSFDebUSRHfEI3lVCIi3YP6OLnMul1aQnaSwvv1RbhcL8k5X7n8yR8r3e8tFk0Tc0RG8YgZ320MSMzJin8+7gVxgclOV6zm9bvgqUriXmOYfGgWjOi9Ypxth94jVgD/7m2MZQU/ekJscHN0wjCFosvkfMcTU1AXOQpvjo2Wn/mUBkq/PdCWfyoyG26odJezD/FqxeotmSehMdk4lnUb4vmX4BbsZNFQF3Mn7WqqxpIdPyWWDtaOKaEWWk9UtCUaSRR9uFJcr90IgX6vFX2geFcp1JdLXPl4pRR1Yfy/FaklO4BzhwmZgfhr6X2gZtd2ApKSOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SavFRQCw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SavFRQCw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0NQ863ljz30gC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 06:25:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E8004447E6;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCD54C2BCFA;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791401147;
	bh=V09RjvzolNHWRszOqYf7WLNZkg/MCRYg5KvXw/oqMPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SavFRQCwQ/fXVAbZ1+nyCjpeXpD7DtBK+2v9RpsJo1JJYeYHmjtxgvf/TCtEtXMUe
	 mtAnHhvWJ4RaH+DW0qYCbYY1mXAQLmeWitlFAkk0fU3qHk+ftyzgckoGHbMIyblg39
	 Qm8MoMueYB3v/vU+spcaZr418N6H9+Rsh4Ib6ipgEur0SDg949/Kd4mFnedjnSTznK
	 unqLwTD4LBaACoFVY2piLD1d1kLtA3hnx9HwIfecycMMCl26R4KhD8efUjwrnBUSmE
	 OR6UeQFN1utHz2fZ6pr/d31itoiVmVGSsyKcWC89QwEORgHiTP44F89gQlRVkA5M9p
	 XmIPNlAJRLBbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB77DCA6002;
	Wed,  7 Oct 2026 19:25:47 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 07 Oct 2026 14:25:52 -0500
Subject: [PATCH v13 08/11] scsi: ibmvfc: add interrupt routine for
 asynchronous sub CRQ
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-ibmvfc-fpin-support-v13-8-b816abfa4fcc@linux.ibm.com>
References: <20261007-ibmvfc-fpin-support-v13-0-b816abfa4fcc@linux.ibm.com>
In-Reply-To: <20261007-ibmvfc-fpin-support-v13-0-b816abfa4fcc@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791401146; l=3347;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=PHOqpk1WAAZzLwxgoVZ8eInjwKojHQ8iHX81s4h6paQ=;
 b=OdQ/o+gg/b+/vKdfX5waKve4FiUgZDzJK8JiQbrbxRSnjrTK3z76iXxbA+C54LxlQHY+6jUAK
 PjuGWJBuQUyC7OdHddHKt1PYAb9LLQRYWFLUkgXlx8+PkbYbJlgDe6V
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

From: Dave Marquardt <davemarq@linux.ibm.com>

Add ibmvfc_interrupt_async_subq(), an IRQ handler dedicated to
asynchronous sub-CRQ events from the adapter. The handler disables
the sub-CRQ IRQ and then calls ibmvfc_drain_async_subq() to consume
all pending entries before re-enabling interrupts.

Add ibmvfc_next_async_scrq() to traverse the async sub-CRQ ring
directly via msgs.async_scrq[], returning a typed
struct ibmvfc_async_sub_crq * without the cast that would be needed
when going through ibmvfc_next_scrq().

ibmvfc_drain_async_subq() holds the host lock and per-queue q_lock
while processing. It loops over available entries via
ibmvfc_next_async_scrq(), wrapping each in a struct
ibmvfc_async_crq_event and dispatching to ibmvfc_handle_async(),
then clears the valid bit and issues a write barrier. After draining,
it re-enables the sub-CRQ IRQ and performs one final check for a
newly arrived entry to close the IRQ-enable race; if one is found it
is processed before exiting the loop.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 6db9df91e9e6..32bc00a4be7e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4374,6 +4374,72 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
 	return crq;
 }
 
+static struct ibmvfc_async_sub_crq *ibmvfc_next_async_scrq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_async_sub_crq *crq;
+
+	crq = &scrq->msgs.async_scrq[scrq->cur];
+	if (crq->valid & 0x80) {
+		if (++scrq->cur == scrq->size)
+			scrq->cur = 0;
+		rmb();
+	} else
+		crq = NULL;
+
+	return crq;
+}
+
+static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_host *vhost = scrq->vhost;
+	struct ibmvfc_async_crq_event ae = {
+		.type = IBMVFC_ASYNC_CRQ_SUB,
+	};
+	struct ibmvfc_async_sub_crq *crq;
+	unsigned long flags;
+	int done = 0;
+
+	spin_lock_irqsave(&vhost->host->host_lock, flags);
+	spin_lock(scrq->q_lock);
+	while (!done) {
+		while ((crq = ibmvfc_next_async_scrq(scrq)) != NULL) {
+			ae.subq = *crq;
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		}
+
+		ibmvfc_toggle_scrq_irq(scrq, 1);
+		crq = ibmvfc_next_async_scrq(scrq);
+		if (crq != NULL) {
+			ae.subq = *crq;
+			ibmvfc_toggle_scrq_irq(scrq, 0);
+			ibmvfc_handle_async(&ae, scrq->vhost);
+			crq->valid = 0;
+			wmb();	/* complete write */
+		} else
+			done = 1;
+	}
+	spin_unlock(scrq->q_lock);
+	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+}
+
+/**
+ * ibmvfc_interrupt_async_subq - Handle an async event from the adapter
+ * @irq:           interrupt request
+ * @scrq_instance: async subq
+ *
+ **/
+static irqreturn_t __maybe_unused ibmvfc_interrupt_async_subq(int irq, void *scrq_instance)
+{
+	struct ibmvfc_queue *scrq = (struct ibmvfc_queue *)scrq_instance;
+
+	ibmvfc_toggle_scrq_irq(scrq, 0);
+	ibmvfc_drain_async_subq(scrq);
+
+	return IRQ_HANDLED;
+}
+
 static void ibmvfc_drain_sub_crq(struct ibmvfc_queue *scrq)
 {
 	struct ibmvfc_crq *crq;

-- 
2.55.0



