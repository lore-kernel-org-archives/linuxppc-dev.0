Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4046083605
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfSZA/29
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL8K24WX8z2xqh;
	Fri, 06 Nov 2026 04:23:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793899382;
	cv=pass; b=cdstxU1WvHPdH5DIbZgZbmR90WexJnVAQokfTjr6G5xcMutoeje/b/lZUnYkRrLvLIX9yvLA+FZQcLtwSxVQj6vwxljeWTJytrW7ukGjL/afO/wjDkUq+V5NbztlYibKxYz35XQQROQnMFgIPI9/MX5QEOiofmDqp8RB31cPF+H7h0WjzF7xYzUanS6WxUkJMTiUHiFFu+apSV2NXDBn/a4TehEx67kmf/IzhHgrvEXaO5Y6cN4ieqORMBuLIgv6uOc/Dg7savn9ANaEzTYDa/fiTjzV5AuTwwIn29dpL1KeJ7TYE0V8ulWyj0q2zHXUTdSdtd0FHaFpy6qHwH3inw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793899382; c=relaxed/relaxed;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9ewnhJ8wWE34hSgYeZfhmTLrWjIM/LwAQDAmk/ymWKqlP0ShqxzUhr6mkKShFYo4dQIt//yhqV4GRwdBOELs/sMa0REUX0G3Tar3hJMI4EN5vVsCHW6lt9z1lJNUI6jusS7AdZuo2PvgFbNXl62mOuhvfWT4vvsnstg0t2NlVS3lgm1EnLEjfz/Ud0AkxCCCeBQartZFhRtlQFYNhaxNHfH+XgX+7izsJK4Eef6GtRxlmL7livfT9xgwK3nygp80Qnp79CCJK2lrzFBxpVQNO4hxEn48dbdt/I1x8XT/YsTrkIf6pK6Plsck+cEsXa+2DSPghlNLycDvw6VJ910DQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfSZA/29; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfSZA/29;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL8K16Mkhz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:23:01 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C2C7407D7;
	Thu,  5 Nov 2026 17:22:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793899379;
	b=bBMG8mML/pn/b1n1iHLgsdHG/9yWFeM3bt0hXRp1Ba7BxPkrLscTkeiNQ5LRKWXnXTiO
	 S+MAgAkoL/BsP74yOMLqAXDQQX/Tl2rLAvIhfIuNlBk7oVkK9U8bZajMa/czgvZD60h8G
	 okt29yDtifN5hfLJ///slXRKwrQbSVkRFhf8JXxtHGhTNHq2nbv6dp/inFTlVmS5UYlF1
	 VsNIfnKS5SY+1eJXhHLp8kVwl944kWsnG9m3nbuCFwZM45sht0xV+D5mCcqfwpDnHUW+O
	 mYwbh7Ca657NW0x7D9IzXpFBp201omdD80WOshBY3epSXtP8ddQZhsFM3cfDx+TpjdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	b=Tw2kslxDOlut8xXlm/dEbIe4qvznlHl3LWYs9BF3e+dnCjPYQpjYfUwXLaPqAmI1beDJ
	 9Q1aw2CvEgIpTVhScHZGmG1Xepf71KVZqvWAZZ5UZcJexk1P6CYSgKMOQpISvnoAV2oSE
	 ecLfbwVc/KQMfp2uxNn9EUITqcMylT7B/+YaUX3MPHWlzaOu2ZBAtxS8R/X6uhExdvguW
	 43x9V4kDXke/P4pFiX5fXm+cGRjp9+et35a5Ax6kRnLqmY0sSMIMffCG4PeReSPEeZq8t
	 puLp7KkTP/XqkBJvRiYPAT5dvXglumhtYmHOITDi1R7hO90boEjy6jkAK5j+iAorwww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C35561F0093A;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899379;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UfSZA/29xF14R8B8joRstOhluBmewgMURYPXh4t/uOucWeLq9FTEy2yDy5YOkjDu2
	 VowqcGy64gGpGLe3BnNFekZeUZdifN/w86iAZ8uNH4YjxkPHOHe1eRd0FA6iJAqsZv
	 zLhBEAqs5nPwF1XHtqHk7KICW6Il6H1k9vqT/OAdLZZ+eEI7nBMTDLgCf/lxI4vZKP
	 xma8M1BOlk5NgChje/mSNskc2wg6teiHgbNpE6HAXP4a+uahdWuDDcpwq8JlbMSH01
	 CtBaZDJKJ0MRvzS6QUj7NC70+/NhbO25gCeMie8dsA2J/RJmvS02Lt2LanjTM9w2Xs
	 ws5Uf1FUw4bJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 388B04736A;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 05 Nov 2026 11:22:54 -0600
Subject: [PATCH v18 01/13] scsi: ibmvfc: fix IRQ leak and guard deregister
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
Message-Id: <20261105-ibmvfc-fpin-support-v18-1-d683b74736a3@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793899377; l=1764;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=sg9Lbgea4G1OveFwjkYaq90w+e+5hioGkpYGXVuzHdo=;
 b=kzuAwRrzj/87SL7IW2LrsUJeY7mTiiLjjYCxMzcXZtnXPbJ2NEoooUbnDtO9YpLq63MeSpNs4
 qaR8MBXoE5+D2x+vr+7JRpswGlK/bLECQYZtvxYOiUKxIlBAFX7ssX4
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



