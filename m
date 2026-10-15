Return-Path: <linuxppc-dev+bounces-29558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCAECCA462
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:07:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5BHy3Zgkz2xlw;
	Fri, 16 Oct 2026 02:07:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792076830;
	cv=none; b=GtuqKe365PkIvc8+KtRMvqW62sBgPlRbnktR3cBO5vvpS81AdzMlQwUCt423Nly11iPnI+UDossmGonV8TanYmg6bxQ2kqsRrPFu40rTvhw44uCJ6kHgojcACdyru5ei9iLZ/XHdb4dqU7ad1Hfz6i69waBM9ZHQkSqnSDBidn9eLEWEr1I0hHYiVyijz1Wj0eQ5pc2+YSJ9A5d2nTgcHfdJLAwj9NJFN/8lDL6//bjuIOosxvE1qadED/GzQN59OC8skPydbMz7mWhYKGbVmLzQtDsjSamiR9QzxIcShf1gPsikUD1KHO0zkaNCvDigHA1AxZ2g4AGwoSq9Xb6mNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792076830; c=relaxed/relaxed;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3S/T98Tyz4zbLe7XB1SicOwzsk5e/7CVCoBp8qOh65sLIywaz8A+VnE/VtZZSIMN+ZDG2twYcGQz042r2qxyv7Bxo1wEDQenpWswUsGAuOcD8+Zk+2slniJV/Z/MMgiT4aBArXRdM4sFmZff7d2oEw2go9z+pm9qoe9JMS289INkw/K/CT/ZyLU87aJyga9X5wLQ+QtSKk6sfd63I9Q0nq4q9QpL7LkHx9dn2XNg0HDiKz3QFiiRrn1QUM1ZXsmSrtNAtGyOesBUjMs1cqtklKEFQWGihfVrN35LuvT1/jTOx52Mm0qdz7/x9UXxr/SEcazJRVVi9LDSR3ESYTvVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UVryW4l9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UVryW4l9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5BHs2CwWz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 02:07:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B2E686020C;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A91AC2BCF5;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792076822;
	bh=F1tNK4LvSB95qeM3y8c58Zeylxaw0twuE7juiA3LHAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UVryW4l9rGqnN2SzUPTzUeabok9kIct9NTH08IdSpcFU+Wg1yv9JXln8sGJH+IbGT
	 3XbTEUhTJ1sOhYD33SIHLKKOCztmtOEwa22Vdn94Z5gT33B2JBrJOP4cX+LXxgcw+u
	 liMwuwvOl8OmYNGJcassqafLeFWULLlS/wU76GKyA+rd8V5llM0+rih89kJkWctlst
	 gy4EsjgtarIKYqUTs4UYuUfsn0MmddBTVvv1zrYWGPDjSZV+2sxLBhEVNhP6yNepxZ
	 /Apda4ySzV8psw0xdj1YHwPSfGCy2yk5Nf+Y2z9d1YQ0pLo286dvEQR6z+ysHJiaQA
	 8p9qqLQexn7Lw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6BDCC6B34;
	Thu, 15 Oct 2026 15:07:02 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 15 Oct 2026 10:07:00 -0500
Subject: [PATCH v14 01/11] scsi: ibmvfc: fix IRQ leak and guard deregister
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ibmvfc-fpin-support-v14-1-a0b063b8d825@linux.ibm.com>
References: <20261015-ibmvfc-fpin-support-v14-0-a0b063b8d825@linux.ibm.com>
In-Reply-To: <20261015-ibmvfc-fpin-support-v14-0-a0b063b8d825@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792076820; l=1764;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=sg9Lbgea4G1OveFwjkYaq90w+e+5hioGkpYGXVuzHdo=;
 b=MplTtmFEl2uF9VIFYJXBkOuSUVHDJ92F+peFfBLNhyxvYYhJPENb77YHn6bOj256N2UDH4qsJ
 SL/6RLGWmlLCdoFrZrlG74es5IcdjuYjRN4pBB1zt1S8cvtF+3rh7Da
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

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



