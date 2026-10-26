Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25277606A336
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2lKkDH/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCzDb2c5dz30BJ;
	Tue, 27 Oct 2026 03:12:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793031167;
	cv=pass; b=J22+6pmvwXAqKeBkEtLNe2VwNGGr7aZcyNTAvlk0c8VcvTtEtVEdfKHIezxwydJUXbm3VUeDpMj2eiXYyJoRa2QczYV1SV+30IfCEoVXrBqthvpGsJFkgiHf+WYF4oEDyxlXS117SgXoX3SftRaKEG5UnyMpzOo6Tdidp1Do+UdOfE86mags2apicefgxtjsTG9Zgv71DrUbQSF2yqGEk5cAUUWOEPHqCcVt2G4KyIzmNQTrKASYobgJEmbkew11wPRIdM9P7RX5Z+9qWbLw4EPp/qPxRRMlX/R9+RlYOSP3IJzBEDDjmfh+9U//CgIff59oNalXFJRP7oSyCUkxZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793031167; c=relaxed/relaxed;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWOjFdwu6vvJcctKUEn4R/zSDsTP32VbSd1a5RwQab+Gozqk52X+hRU+vpRN6o8xdN3IPgyYexw3rQE1+9VsSYZHUdR8DIsyBzDMFW4MJbtTVZqiI/Ko5udFg2yzq4KEcNmjT1GTz4sF5hSP5YfTD0UodpuaeJ4R9AePfPnxbRq/W5Fi/LFL5+KKdeyyiYmjbLFMvAPaJAiitzcqHI758tIEL4OBaFixZKIjVpgNcy8IvioZtQyqt7shNj49ggbyAV1W+UAl3DM3CWxq0wTJkn+oHgSlP/z3VBJWvFuR/X1x3mPKpDZAPwmR1cMzcd3r4BeuMIic0PT3wguMyly++Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2lKkDH/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2lKkDH/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCzDV1l8kz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 03:12:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 12DFD60239;
	Mon, 26 Oct 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793031158;
	b=WrES6PQi7UVopr/SZ2JajxpXeVbyVkZ7MZZnpduFeAjOFr5hPJl07k6FQT4XY/Tmn7if
	 AN0XA/2lCsHj1Rx48ZB3tfYcN99pND39l5t40pE5Uy+ehWFrKEpahtNqwecYUa7+oRDk3
	 J/WHpWwLgWuO7aj6hX8+ngLdujNSQ93GAfk+DKz6sfd/RwFJehJE98m2wxsCUSS33CjUb
	 hAyeMuq+fTqwU8IY6/6ObkhBUkv8h0SVLhhw3gMstdei0FX9duX0svdt9cBDeNwsLrokR
	 /gBBiRoXNqTx3dm23e4pefQx7nFUK1T5E6LOTxULZi6i+x67Fu3II1ce2KM7pwjQdUw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031158;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	b=upNvLUwjro/+Wuu2pMPUqGbtZsrnOfmhJdGUsgLLMSZ9BkV0x2PgyogRhP/Ct1UeuMBA
	 3TySKqS1Bw4jXcDbPQAg9BBnlFQpaZ6CHs2oANesFDDn5q4yxc7bBG6OEpHJgQDz8Cfb3
	 G3tKaObG136bbvnZzIUFchqXuepK+YAhrcPhj6RWhiROAQfK8n+sAfXPs9LQCXlFDu9J3
	 tW6PNw8Q7uh10P8MjsAZqkYjY7is2DEOJpYndSX41bV12WhoJ895S/XqK5tPQ/V7dWhbs
	 WGbRRd58MTAnCuITpCiInBRCu2Pu/FUMUtlTsaH0m1u20nSpIiaR6Vyl8NEtFW4rEow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D6E401F031E2;
	Mon, 26 Oct 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793031158;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U2lKkDH/C5qkdeMZvHbP2B8V49AWdfHTVYuoZnGIAfKIPjpusnRkFZtoadL8q0F26
	 kuYuLiOkcfxl6CIsNz5C89jeWvlQpI3VLj4iU6lx/L+o0KYR6i9aRQzVN2jhiWGQam
	 93MuJDRZcYw+oWD+SFpoNS3FMBKRal0Uhn1D8iIA2S8G6WCrWvSrzdttZCcAn6pmUT
	 bdhkoBJEfw3iAfRcwaJ9mpaYRUGhJH3mXfJpbLowgrS4Vjy+FdB9libgHNwdC2+SC8
	 z6UgXblGT9IdZhKiz7SqH0lmLgwgmkQ9K8Tcv34G20+d69mXDOTr2XalOaFywXIrJz
	 9b7wf6Vv99KEQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4393744D7B;
	Mon, 26 Oct 2026 16:12:36 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 26 Oct 2026 11:12:33 -0500
Subject: [PATCH v16 01/12] scsi: ibmvfc: fix IRQ leak and guard deregister
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
Message-Id: <20261026-ibmvfc-fpin-support-v16-1-a900aa657ed5@linux.ibm.com>
References: <20261026-ibmvfc-fpin-support-v16-0-a900aa657ed5@linux.ibm.com>
In-Reply-To: <20261026-ibmvfc-fpin-support-v16-0-a900aa657ed5@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793031155; l=1764;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=sg9Lbgea4G1OveFwjkYaq90w+e+5hioGkpYGXVuzHdo=;
 b=XZfD35vk6f1v48C9oZxH3Bfuy0PBEgn8Yg8hr2GEXc02S24T6UaQ52slTslvsmUZGoPWXIR7L
 ilFNsVLTlhtDigTnWwDXGwCLcBGh14K58wvPeVLKrDkXaY0MZBPQVoY
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



