Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6C606A31B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYkwTALH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7qd23zQ1z3bTj;
	Tue, 20 Oct 2026 09:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792448166;
	cv=pass; b=jWk69E77/uPhcRI11SJ87YKAzzoVxKlYXNH8MgQNBPqxzIT7vKihs2bIRK3jsR1a54C9RSfsRyCDqcDYMRrmg9pDOCcL4oLR5sEHPkqvgXHDZuNdBbsTiB6g3ZEBZfAAwY+f8JF1c2FCAKEaymRRqcc0eMnHkHhSMGuCPOEj3sHge7IzhWJJvk/l59Q6ElzOcn7Z8QdOMaiYPH+4CunI6xBl/PH3bdCLVN/P4/lamSacZM2NNU7MasyUlDX9kOS+LAtEPxB/US9SlUCitGC3EPPLJZtu0+ue3EPeg/6yRUmCiXTdOCsxAajhV0UV6bAANGHR4oWRg1kEU1w4j9rkoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792448166; c=relaxed/relaxed;
	bh=1SsAn/4D2KY8LrxXXAic0O4wc9gDlFfVuJBtWgZjhik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJvFhK8ihbUGQGcPkT+nwxe6P+uZgHZIJJiI2ErtHLuDIk+qSZFu/VKXQR4WlwPkkn7xhpP5VQCmZg/EMpVfbZlVGrn/rgw+je832ZBnRTkaEX8LqW86boqSFkpEGR+WV1DLbg7fyXCLladxhwp2+f1ttJmXAoNTjWUE26oSWUfM87sWl8DbYUcoNL2CWEpeYnt5wN3PMZ488UaGen71nd3iV8KyJYYtqCKs7yfD1R+ZogqEVtyoFeJnlIXL6xHJTEaTvaas5yXriMZ26iJ/vxpJGBjJO2eOp1VRbd4n+blk6OcX9gFciOEBGqJHj9YwX5fAXFyOePSKyG6iAbVIlg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYkwTALH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYkwTALH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7qcw4WQsz30V4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 09:16:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 41ECB44517;
	Mon, 19 Oct 2026 22:15:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792448154;
	b=kSB1Iz0gufp1l26JULcV1o86K80KuuBoeSFWps/Rg8IJrll++7hDbkcf2Ojk1chWSKk4
	 daQdzDyx9nfmDcM70GvBXrpD7K4Eur4zBXK5bw4O8CaghvxfqvFQ+FZY18HcOyfIRZzDT
	 cB0mw+rqAiJsycD8Q5VaqXNXDBLI19wMzv3hoVnDzEHfNOh99EOh9RUgZQRMo2P6TXCt2
	 w7gtBX5XG1HMGJULEQQjPu9F66hrV0dL800NNJ6Is78DflISLlyGw3fSyD0MRnpEF7Pvy
	 myfKZbJ1f3Z5uDt0XE5yL0ufW2etHV4egwDeFGhRIbEXbUlMs5Tuspz0bJqED+a3TTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792448154;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1SsAn/4D2KY8LrxXXAic0O4wc9gDlFfVuJBtWgZjhik=;
	b=y7uL0HgnfNsouMiEgXioNeiRnsPSCpI1rWgQVugP/g1fZ2UvQ29XK2cfxsKuiecVE3zF
	 tRvO0ZIbBGnEhTKaF2gN1/o/cG/lfjKgwsrpwTdvkWrSwGaM+qY27SVYN0iDSJKxGbXjV
	 8HSnPhprH/6vAR/b4YOiHCWS96Fsqj1cH11ydasBXkRuGUCsY5AMTzRldszYhJX1u2iCG
	 0gFHHsimyvxUnYsUw5v5LFPKhPqtOTDX3iPm127oADQtm0CWJLkxIWGQd7jZ6936TmVnN
	 h8UAmN+RvBOwo0r37hsGW6b11DGT7CloIrawv0uDCqUJiUSI+Mj1oWIhutjjbeDAR0g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7C1E11F000CB;
	Mon, 19 Oct 2026 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448154;
	bh=1SsAn/4D2KY8LrxXXAic0O4wc9gDlFfVuJBtWgZjhik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bYkwTALHV+njm1Y1HifTYYB2GWPiSX1vSy8JJBEs6W+Ua7wXfGbCRij+GtCjPm+Wm
	 6UlKpT12C71skZ6OknL60+posaULWMf3OljWIsrF1JXvVCPzB11WcIjbYx7iMKhD5M
	 YK6T1pcQeWZ5YEsdMp322OOYRfIvKBJtwpb/G+PZUBhU+XQJtE6JI6q7TJj1pSYqHA
	 eLTzn7jLXMnWv5biiqyVupYGtHKLs5Rqiz8ILnhkxqzsdeBMDwZXG4C/a+sNmEB+se
	 EloZcCZWQwdTxfETPlKaHb8aqhM/tdmSms0rXs7SCfarCsEUMKM7882/CTfgLNdeRU
	 GMNr2kcGa+pYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4774D40677;
	Mon, 19 Oct 2026 22:15:49 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 19 Oct 2026 17:15:53 -0500
Subject: [PATCH v15 08/11] scsi: ibmvfc: add interrupt routine for
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261019-ibmvfc-fpin-support-v15-8-a858726e178a@linux.ibm.com>
References: <20261019-ibmvfc-fpin-support-v15-0-a858726e178a@linux.ibm.com>
In-Reply-To: <20261019-ibmvfc-fpin-support-v15-0-a858726e178a@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792448148; l=3347;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=Eh62A6Y+lUfh8f/4MfnlRnZuPDVmZGcaIx37w0Ng5Nk=;
 b=lmal3ZJbbuXVU+J5raFMWwUbcZohCA5sCclg4BawB9XPE5od/3xkcuFdf7j/W0qC/N+CMq9Ex
 Xkc59LGpcayBikZLgOvCZ/+cex83yGJQ+p34p8/+PMQyFo1Nx60lSpS
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index eeba6e6b3cae..c1ee8eb57491 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4385,6 +4385,72 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
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
2.56.0



