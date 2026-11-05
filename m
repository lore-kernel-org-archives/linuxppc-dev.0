Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445C606A335
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb0GhLiO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL8KC4Gqsz30Sv;
	Fri, 06 Nov 2026 04:23:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.105.4.254 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793899391;
	cv=pass; b=B62IdJHZYWY69tGhAfxSO+WuStcqtrB4Hdp3QRYWWtPun0w8ucMKeJKkuWhiKh+uBui4E926OvxCMiGEFHWKcr3oQvDQf2vxp4UN71ZuAB0gQMLJVsy+roXPOnrAPGQCzB4f4Fzv5AxSokcaMrwWJ9y8G/u0Gbdc76VLcV88+wvmNDGm7Y6QWXGZYkzfmqr6/rT2/44MdKWtevNpbSA+7j8aUtzXzMsZjyePj5TSY34J9HnfP3AkXkvAQ5SK/TT85d5e3Xc+Ls2l5OaAeHkie2ei+LeO/O8pIsDXnshAyTF7OuRIARLnpayiIeGES5fEMZwo4c1YIHCSskg0yvC2GQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793899391; c=relaxed/relaxed;
	bh=sJMcAYcoUTWQFWujTsU8rKB0PJ6Mwry7U0/HNEkGZjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFYPxm3eYWDiTH15+AOoUjjDurDm5OKpiZ6RDtx60C41ro03nW1bcEFP89UtKoyD8XRCDOAmQXgOeoVulsowRlD6dj/WfFYdy2gflnvquaArzCgGtlISu1Bb2zi7O9p0hAOkvgKA7yAZhqsvSygb0qvT2ngD524qNtmE9W07sU/vpj31yRzmkIcktE5wQv0jj1PvKtmqAfCR/a38bNonX6RNvodtS4VT70QpgVgfAwWpfuwo6qfb3PHVNh/DPmk8Tg/Tu85HcIcX0jMdz+yh4KG/53A+rlsaFBlGFYf0zGFkovW2gwpQPitgCbWT70pQnV2G6zj3CeXXFADg1t0VeA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb0GhLiO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb0GhLiO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL8K53QNzz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:23:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 51C53601C8;
	Thu,  5 Nov 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793899383;
	b=CqfVyzn0nz3PLQNpR6bWXJikSCYilUV+AMLs9cUBqCBkEUNT/aOfDLvR/exx8orRglex
	 RVS6dvJaANSmCCnJdF6q07LqdbZdSEl8hwcZEr9LuLoRHiK3G57qq+EXSvA2CqBU75ECv
	 3sqeElFbc0EV/QlcVM7tyPXo3ooW8vRo6Gg+W69elmYq6x0DsH2mGM/2nc6LrRM3XsVr1
	 q5iEpOnecdtLsjD7cNrgIR/8g6vHMHNLjrqQAjBmDBuGeGeH5G3dFuTdGUWaVfril6l3t
	 Vb2lwisTAqSDnHP64feDPhGG4a/E92Bz07TBJ6hUFXCeNrj/ur4ZnBpE/+3RvLiO/yA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899383;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sJMcAYcoUTWQFWujTsU8rKB0PJ6Mwry7U0/HNEkGZjg=;
	b=FiidtQiBOH2sqQ19agKBRK3rEZjMlVE8OA9Zk6cfQsrhL3knHqARFKn8qXBMj574urFi
	 dQBsc/RNf2/IPHxiYkviUoZkV/cDG0t5tYiN/ZcHIkQAHwN4gK3pV9e+Yt/V9ZKJkS/rp
	 K9bIppxB+nTyewdMyg6jRRNhtHd3UfvQFS9iOtfED8LnqAQGjY2JHW7UIAec8ktlcVtu4
	 8oibwt29XHg1/y5J70yyIozrdOfOTq7u/Z7MSENAm5tocCjg6fYIwLFKIy9Aii1c+BEw5
	 /YY2WuEeaV6+qSqoIAiiP/lCQ7EO+bZY9zdVemTFFiJRGutfng604Vflzur4lZEvOpQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D77D21F00A1F;
	Thu,  5 Nov 2026 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899383;
	bh=sJMcAYcoUTWQFWujTsU8rKB0PJ6Mwry7U0/HNEkGZjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Zb0GhLiOrjyQoT5SBGbWNXRkS18B8mDdcVZbJrzK9CXcL/lU3DehKQ7qB+qnq+Lxp
	 +OGcbOXOSsNfUhmBiUXRqcG+fKUsZubveoAhG3uowCmz0C1kWtG8wRih2ZZXNqWl5n
	 Fsdn6ULbJA5h3Yeg+F5dI21QKJMIyBL2iTdy6pdCnsHc0F8rk1P7Qy6v00zH5hbB66
	 ES5dBDrdo0HBmSIuRdUN3YLYfHy7IA9eFw6QVyPxb/pyYT65TbLZ302v30PJNUZenh
	 5x0Q4SRtnyzDoKD6hSdXj6yHaJqahGxqH+mPDM27TAvWBPtB9uyWWgimvKdfHNzKvW
	 rFTTUPpdet2kg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C50EE47392;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 05 Nov 2026 11:23:03 -0600
Subject: [PATCH v18 10/13] scsi: ibmvfc: add interrupt routine for
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
Message-Id: <20261105-ibmvfc-fpin-support-v18-10-d683b74736a3@linux.ibm.com>
References: <20261105-ibmvfc-fpin-support-v18-0-d683b74736a3@linux.ibm.com>
In-Reply-To: <20261105-ibmvfc-fpin-support-v18-0-d683b74736a3@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793899377; l=5369;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=rzRLzI/0DVNhhsjrydAeA8hyA2ajK90jlhszpnL3xos=;
 b=hOW7hsP8mN/rP31S6HU+jig9QGUur24Tv3AdEsQRFNQ7eNFECoc41qpc0LPB2RQ+bdAroc0yv
 4lPB8AO8UZ9DPWVSz3KwKaXEUvPoAX87gEINWxQJ52fhO2Mw2DLI2w1
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

ibmvfc_drain_async_subq() separates ring drain from event dispatch.
With host_lock and q_lock both held, it loops over available entries
via ibmvfc_next_async_scrq() and passes each one to
ibmvfc_queue_async_subq_entry(). That helper allocates a
struct ibmvfc_async_drain_entry node with kzalloc_obj(..., GFP_ATOMIC),
copies the event into it, and appends it to a local doneq list.
The node is zero-allocated because struct ibmvfc_async_crq_event is a
union and the copied sub-CRQ is smaller than the main CRQ member; the
remaining bytes are later copied wholesale into the FPIN work item. The
valid bit is cleared and a write barrier issued regardless of whether
the allocation succeeded. If the GFP_ATOMIC allocation fails, a
ratelimited error is logged and that event is dropped; it is not
retried. After draining the inner loop, both locks
are still held while the sub-CRQ IRQ is re-enabled and one final
ring check is performed to close the race between the last drain and
IRQ re-enable; any newly arrived entry is collected the same way. Only
after both locks are released does ibmvfc_drain_async_subq() walk doneq,
re-taking host_lock around each ibmvfc_handle_async() call before
freeing the node.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 100 ++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 7406e7182777..5dba084086d5 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4456,6 +4456,106 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
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
+struct ibmvfc_async_drain_entry {
+	struct ibmvfc_async_crq_event event;
+	struct list_head list;
+};
+
+/**
+ * ibmvfc_queue_async_subq_entry - Copy an async sub-CRQ entry to a deferred list
+ * @vhost:	ibmvfc host struct
+ * @crq:	async sub-CRQ entry to consume
+ * @doneq:	list on which to queue the copied event for later dispatch
+ *
+ * Copies @crq into a newly allocated ibmvfc_async_drain_entry and appends it
+ * to @doneq. If the allocation fails, a ratelimited error is logged and the
+ * event is dropped. In either case the entry is returned to the adapter by
+ * clearing its valid bit.
+ **/
+static void ibmvfc_queue_async_subq_entry(struct ibmvfc_host *vhost,
+					  struct ibmvfc_async_sub_crq *crq,
+					  struct list_head *doneq)
+{
+	struct ibmvfc_async_drain_entry *entry;
+
+	entry = kzalloc_obj(*entry, GFP_ATOMIC);
+	if (entry) {
+		entry->event.type = IBMVFC_ASYNC_CRQ_SUB;
+		entry->event.subq = *crq;
+		list_add_tail(&entry->list, doneq);
+	} else
+		dev_err_ratelimited(vhost->dev,
+				    "Couldn't allocate async drain entry\n");
+	crq->valid = 0;
+	wmb();	/* complete write */
+}
+
+static void ibmvfc_drain_async_subq(struct ibmvfc_queue *scrq)
+{
+	struct ibmvfc_host *vhost = scrq->vhost;
+	struct ibmvfc_async_drain_entry *entry, *temp;
+	struct ibmvfc_async_sub_crq *crq;
+	LIST_HEAD(doneq);
+	unsigned long flags;
+	int done = 0;
+
+	spin_lock_irqsave(&vhost->host->host_lock, flags);
+	spin_lock(scrq->q_lock);
+	while (!done) {
+		while ((crq = ibmvfc_next_async_scrq(scrq)) != NULL)
+			ibmvfc_queue_async_subq_entry(vhost, crq, &doneq);
+
+		ibmvfc_toggle_scrq_irq(scrq, 1);
+		crq = ibmvfc_next_async_scrq(scrq);
+		if (crq != NULL) {
+			ibmvfc_toggle_scrq_irq(scrq, 0);
+			ibmvfc_queue_async_subq_entry(vhost, crq, &doneq);
+		} else
+			done = 1;
+	}
+	spin_unlock(scrq->q_lock);
+	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+
+	list_for_each_entry_safe(entry, temp, &doneq, list) {
+		list_del(&entry->list);
+		spin_lock_irqsave(&vhost->host->host_lock, flags);
+		ibmvfc_handle_async(&entry->event, vhost);
+		spin_unlock_irqrestore(&vhost->host->host_lock, flags);
+		kfree(entry);
+	}
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



