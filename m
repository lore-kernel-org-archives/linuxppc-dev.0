Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27A608362C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAsoDnNj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJQ7j2l9tz3byF;
	Tue, 03 Nov 2026 08:38:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793655537;
	cv=pass; b=AZoeTddZvjpJlWnkeDPwcAMkKE9WUmoR6tr17oEl7fa5J69JIOrBJwNxdbp/GmgkN5vp+VFnZfe7FxpmVcQ/oVaBNJ3mdCiv8/Sa3/nE1GFGLZ8oD2fPlvBAgEd114iDSXBfWrJowr6D+XWzc2UB3dakwkql40AG4ynoSwqH0YWmUx6QxuDiO0zsgkWWmjCpx5j8DeNvjU/DWV0DXITIc2YG14+2PbpYY1m0U/DkfQySspDDExZhTSczpRMtZyZ4PR4FvOgC/Z9q6ISjLmfOc40lxjzlD02W+U70in0QiG6fV5/nBkav7Pb4bhxOktPJYrptPJsQ45qGsB14Hcvxcw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793655537; c=relaxed/relaxed;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gj2O0l5MAJ26Cq/UEdNP8g3Jtiz3EpOiu12PUNQeDhc1mAJlQwwv+1XWgnTcXLlybhY1zS04J22gbQEBC+t9WFBxkkmcVW+G8fHThPZcB0qmczxMloutdGZR2nGMOYhoopmalCtE+NoiZ4AcNhzgZSzcCLHFFMhMBHqxGkIJA5cGey/Hi/KXtK1kYNtRgZw5ibGR4vz9d3ycrg9qD75L0NFu1C9l77AYxhpB544ldfWzKcsQ9aJbGcf91e5wNF8QFu7DKXw2yF4Eb+3ksXXf0JNjNIeRRyjnBXqY6+TccPE4EzefoE8a1IOvEg7BYOdnn36IReN0htw1GtM6TQ2G6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAsoDnNj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TAsoDnNj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJQ7h10FCz2xb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:38:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3B06C60136;
	Mon,  2 Nov 2026 21:38:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793655532;
	b=xkGA17BVsDlMEl99w75sV1r5uRxjxaVy+gXBZkETmgzoVgezJtLd87xoh88oydwb89rV
	 8tvCqqXWU8quo72TCon1fKByO00opYBAwPj+WMLtVI/86vhRKujiEPd8OhU+Qyzj0ZGNz
	 cZL2+vhj6vo+86bREpbVJVDxUjEnjnfEYhQ2s7lCETJ57TjNSHJtFv3l2UH0udslAf8KX
	 auPm3df05qdm73y7Qoc5/eOPuUzcwbA0kxnXGMqbiVdV1XEEJY8ks81rS5skd4r96Lp1i
	 JSGQT1hrsP+DeBSozUkB/Xx9AQXrPXMcdxuHSRl+Vssk4BakKgNMy8z2qRmMO6tQNug==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793655532;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	b=G7wLIbRlnEgCk60sp2Z6ISfbooRwH58YmCAjANBi9vnCh/KgBjpjPn9ivLozBukyVeR4
	 U63CQllkU2iEbZa6GmXyXWp2uRsxvNT1Iigk36QBIfTSbNHVL750//0OUTXf14eFsdWjC
	 65l9YMtnHG5OuxxPvUcj6CYb0fOT28tBs09lAtaF484sdKgSgjpeJaKEM5BtTEb6rfcZC
	 /ZJLGW9YZXnDzXZCjIsfBjLgim5nMkanDXXe+Uo2+mWyBbTOKQorKhX4h6ArbTWnW8RUW
	 Mf/CBleRHkNc85VQeHuo2Ft6gonTqOVwQgER8C97y2ML/pVXMvxYlc+gWnVyJSJrtoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 047F31F00A18;
	Mon,  2 Nov 2026 21:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655532;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TAsoDnNjXOKpdA1iHOrFYVDqFJQKkuJ8wZdI+KivjwHLbRN+3aYnuzM39/GmTOMta
	 gVV192GENoUdhpCdWDoeMZT74b9Xqa3nbviownLLNt10i+m78+bv5kGLqYFqKHlb0T
	 9m9t6HVYlTBp2Bh3roUtBeEagVAyV0ugN9FgGhkoCMh7nPzkaI8NvACnK7BAR5yW83
	 uDlZ28KNTbpFlM0yOAOBHxkWb4B34Y+NzTEiqBL9YPM9nRmU5LjjmrWWffVGhXGWpg
	 LyvtY1/y1BqZ+LmwOIqkhd1ahT/w4mv7Plu+rb+4x8Ckol0PtmUF0/U/6j6qPUyfJO
	 HMNCQHI4chN4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6AB874668E;
	Mon,  2 Nov 2026 21:38:51 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 02 Nov 2026 15:38:41 -0600
Subject: [PATCH v17 01/13] scsi: ibmvfc: fix IRQ leak and guard deregister
 on channel reg failure
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
Message-Id: <20261102-ibmvfc-fpin-support-v17-1-9ee5f195ac91@linux.ibm.com>
References: <20261102-ibmvfc-fpin-support-v17-0-9ee5f195ac91@linux.ibm.com>
In-Reply-To: <20261102-ibmvfc-fpin-support-v17-0-9ee5f195ac91@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793655530; l=1764;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=sg9Lbgea4G1OveFwjkYaq90w+e+5hioGkpYGXVuzHdo=;
 b=45xxY4dh4MIM2qOyHO9asCK0c0MOKlLV12Tfu6Pyc4sTfPn+uhXZuJBAmFyT3O4GIZpcNvaqq
 QaB+9YE6akbC3aERLyzrtVJ/zKZ702GkDKILIEieahZ9vO8oo0g8p94
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

If request_irq() fails during ibmvfc_register_channel(), the error path
disposes of the IRQ mapping via irq_dispose_mapping() but leaves scrq->irq
populated with the stale virq number. A subsequent call to
ibmvfc_deregister_channel() during teardown or reset cleanup then
unconditionally invokes free_irq() and irq_dispose_mapping() on the stale
IRQ descriptor, triggering kernel warnings.

Fix this by:
1. Explicitly setting scrq->irq to 0 after irq_dispose_mapping() in the
   ibmvfc_register_channel() error path.
2. Guarding free_irq() and irq_dispose_mapping() with a check for scrq->irq
   in ibmvfc_deregister_channel() so unmapped or unregistered queues are
   safely skipped.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 0b154e07299c..7818838669ae 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6435,6 +6435,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	if (rc) {
 		dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
 		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
 		goto irq_failed;
 	}
 
@@ -6463,9 +6464,11 @@ static void ibmvfc_deregister_channel(struct ibmvfc_host *vhost,
 
 	ENTER;
 
-	free_irq(scrq->irq, scrq);
-	irq_dispose_mapping(scrq->irq);
-	scrq->irq = 0;
+	if (scrq->irq) {
+		free_irq(scrq->irq, scrq);
+		irq_dispose_mapping(scrq->irq);
+		scrq->irq = 0;
+	}
 
 	do {
 		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address,

-- 
2.56.0



