Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC2606A334
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2VAOli0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYnyH72VLz3bmQ;
	Wed, 25 Nov 2026 03:17:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795537031;
	cv=pass; b=LF/3U9ae4qkoUhoRTBeOvNg+alAi/tl24OsZYTzJscPZJcp/yHsWuY9oq2cwOvop8V4fJMoK81neM6kzTXYV2Du/BfrNtdro74g6/4h7ugaHe72ysTtI68XH1dDRWYjLMyRQaa84fjw4ySizZHTZmbsBWYLFP318UKgRJTI6w7k8uJRh2WSkWBsSZtGcDX+kJVAX1kf9YScMa8k0c2OYLJtfvTKP3y9pZVpqnhaJkCv8fAUynEE+kKSXGYEDeLFryy/Or+fjoC8+BtjvrL8KZEGl5qqyrlGd+OH9rTq3Z/Ct+MM6UNFITLYW7u+YPbxR4sLg/PWIIEsRZxSE1ylNBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795537031; c=relaxed/relaxed;
	bh=mfYD05fmwGBPG5inWLr9lgGGGWcCZk4GV9ECpl4k2uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzm/2Yoz+SERy4kVaVd1Tsj7gXOxxq5SSG5sIAzPwqH1I9QCRLgoGeVi1jpRAdzJOVpdYk8K90xizU1R8jpsIVe6R32jp8hucSoWw/ltFQ6V/lYZ2klwkdni/Pl3st+6GbuUQyBv2sYdlAjVZl9B8TpFGM3d4M3o2YzgbJFNtjVBCKY8o8naMJKqL/X3/SOTykLqTQC6yjcra1It8NxwoBF98l/tPTKk9mNUfRkCMukjd7Iv8nIkY6E0bCfwubktVtXZ1Z23/E6HW/719M0zLP3n6TDvk/uT+3EpnjcTkN5LsHS8YTJLYCGTt/JE0LR5M0CujZ9ny1r0Mb0eF4jTGg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2VAOli0; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2VAOli0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYnyH1gzSz3bn4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:17:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6131A62790;
	Tue, 24 Nov 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795537029;
	b=HYvTA2TUhNDuXrqpc8Y1YmGxl+spQX1O8jtEZz25RWOf6s5tCyYUxF/UUUB/RUydwWks
	 M59KOx0CLa47sQXstwKbVulu29ZuY2geXKknCqObtwz/IJlldVeHguwcq52TYAgKzfvxG
	 vycmfOLQPNKsHS6t2ZhnfD8DTWr5CK/Ugewi5V7JnSoK9jsGL3oH0CTHzCdWFSJfsiR0j
	 sMo6MJV/PRyul/CJaYffy7fh7jL3bVaILjj4/5PYyF+pWgjLeR8qPqNy6PIqDqQiSyqxb
	 0qlMbohQVxdFcDEkG8NI3nhf9Thc0rXQqS48w472ndt1Hvax95F73hFV05iRHTztpUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537029;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mfYD05fmwGBPG5inWLr9lgGGGWcCZk4GV9ECpl4k2uY=;
	b=hoCtqSEzckxEGW+eroh97ziu4guOoODfIYMXi9Xigc0E3xdzAWwZhPj7C6OVdtVGyG5N
	 nuFD0D7L6hXYRpNGwhLotYfUq3PYkYZQL5r7eWtQckBSO2MRjxyurSDuoOBV7AKCMlf/V
	 UFeUQRe9aiqjpo4h1O33kOtSUAjCGQsokk+LIzXAUmkCLPDYSKqCHixlbwH7vx9N0mew3
	 8k56G+YOGUm51YLzCGLTruGsj6flemEFpyEZsvuzZuD5cVR2pMaIT/PDxxKOiKYfquykR
	 KFQGMV7kysY3A45D3JWAojvCIWNYbHPvR7c7w3058y4oLTDP+SUyEOwSGlZWn/NYOsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A81031F00A36;
	Tue, 24 Nov 2026 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537029;
	bh=mfYD05fmwGBPG5inWLr9lgGGGWcCZk4GV9ECpl4k2uY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=l2VAOli0UdeWifrrB4p4f5khKh2IrW5Tyl3osGCcQfI+oSebZL5IRQGallt7A0rC7
	 j8EXI2x08gKolNr8EPsoGKJGAMGCeXkuRP1ZMr2q2RPP3JvBiL/IApN38Et8Fv/luG
	 t0mh6pKTSnXW/GaZkzuji6hkzNCPMAIf/BzXXJGKNk7NS2C9+RIzJKnSLgIwoIMzv8
	 T7657jrKS8L1m4JHBP00vZTTT29ZJo8oHkIj2E5mj7pc6QDRkT/s+IMCiza9wVvWKq
	 tlUK6JZM4hIOsXn+o9ExX8pXi0jhkJ5sJYiVqbIR4JwSRaMATbzWb1dXpxUvF/mDQI
	 pPDkMOqna512w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8F11C4CAE0;
	Tue, 24 Nov 2026 16:16:47 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Tue, 24 Nov 2026 10:16:51 -0600
Subject: [PATCH v19 10/13] scsi: ibmvfc: add interrupt routine for
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
Message-Id: <20261124-ibmvfc-fpin-support-v19-10-2aaffe5fe7d2@linux.ibm.com>
References: <20261124-ibmvfc-fpin-support-v19-0-2aaffe5fe7d2@linux.ibm.com>
In-Reply-To: <20261124-ibmvfc-fpin-support-v19-0-2aaffe5fe7d2@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537005; l=5369;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=sGREPEBxvlOz1vxADAwMjJHJageFaZvLQ4wWJACi/l0=;
 b=4TCzDsFLYRfvqH2f3tAjW18K4e96i+oDmZaYAkKG/Fhdwzw/IgWryUonswKLqDc03s9tZQiYh
 X0zu0pKgl+uDiKX9sEOC/4QUfsC3dJNsxptgUSGj046p5JedEPxGV+0
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
index 761d4b1638fc..50c225b22b8b 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4461,6 +4461,106 @@ static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_queue *scrq)
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
2.56.1



