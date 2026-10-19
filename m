Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF3606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoNRN5Pa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7qcr1t3vz2yqw;
	Tue, 20 Oct 2026 09:15:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.105.4.254 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792448155;
	cv=pass; b=dkKWsWcvE35GvAV6xvk29tphRhjEHO5gJCKaVxQzZPSSYqqLSYgsGT1S+6G3uWq20UK2EkiHdP76QWTUzdu0n5m59T2l94ualwIgyw4fIAwcBI1/wkcTw/YYP51WgYsZKJ/S5qASJw6CuWNemykYY79l5KX8VIakwJkRsCtHza4kCMmTlTRE4U5/RbKyqHTBpN5z0r2pRcxo7XKmYp2OeRq/R77VvWhaUpTO6lGxuclEMq+QAP1+iHJI/kuwDD1GeccsLuEC3sKN6JCg+T0fOFwn6xct9UJNFJv+iIvlk6v9NJYWXni3blSpASd4T6hJWublvKJ+xLEP/GEqKi08xA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792448155; c=relaxed/relaxed;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHaOUk/IGi/nJFLyYdunw4T81C0RZ1XqgPfj1c8B6UZJALXfygpm1a29NZm/b9VdioQSirPpF1SnQctPBROes9r40U/2wvK0pWEmM9wOcaAJALAwoQVyTQmRAuuGh0Z/QC4GG+ECor3DXO19C1hoDxAlMRSLG7AaD1bRvl4n8iaAthrWWCnryY2CaNyDB9aonYGTNrJQ3TsW1+tYNVacH1C633f/SQ4vH59iMpv2sAU+iCXwitAiuTOsIWUTPB6DHe0Kv+VPe5Ky6zxFBOKAH3kCyWbxeFwx/7v9fyuT85KsgpfIxuRHmjVwBq8M+ORJDFz5xGth5CW6WcmM4UUKEg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoNRN5Pa; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NoNRN5Pa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7qcp2fXgz2y8f
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 09:15:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9835460210;
	Mon, 19 Oct 2026 22:15:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792448150;
	b=M/uMNA4OV3maeaJShNlv47pYjzQBGU9CLbgRpzKlJNnpSl1X18NhWSyJ7Bu0mdjRa8d4
	 HKio6rBVaYQRa8pohz8WgfaDIp2VOd41wYCcnIuP0JuNuXevyZzWpOCpJrPE7vDbhMj8x
	 KtSVaqq1qigXTxsCLizjauQwtpygycYzrG5sxSaDKwKxjivM6JsntRcUShLctU+2lc/mV
	 rUpgjxz/Flo+zxbkPI9Oggm1drq9oVC8rTuCXSD4K1N5OTeGGrrfsjy8VrzfsF8RMllBs
	 X2nOQTRkqw4ZOfhRYHeeQpNorylp1/bWLqDVNo+zfQUfnLm8q5O3MsIs4+qUwTpIZOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792448150;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	b=3CldibCDgdf/sGK5kpVaMN7SSMPDSLno0XzDmYbzYuBdCdx4hSE/Q7mpH1Mjj1c3pxaU
	 64QNhRs1u/5CFcx+aihTRon3APBZAkrVBeEJL1pveQ+8S4PYWbTlCISYZ3HFC85wytoN6
	 0xcNhLJGOPRf/DIrrW72rOr6719SZsOS2zh6CAgHgXtOdsnaG/7zKMyDuwpA26gRdVHGf
	 3FoAfDFCGKyeV7t33aklraY9X27fm9qSqPjYKmNM9yv0HrOP52utmsC6FpZWuSbcAje2U
	 ex1TpePI9XT8n6o53Ye1YUcVNoh7Fnred5f25rI9jnXyuwE3Tqqc26nKMwRyEvKm9OA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BD3D51F000C8;
	Mon, 19 Oct 2026 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792448150;
	bh=C8U2KCtW2gkZ7Clqkc7+4hsRlGxw+1f7tFdd8uYfw3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NoNRN5PanC8iTmmDSh7t2n10LtHk7w5WDwRS182Gu+9vCL/oRTjNoiw1L976yZb1J
	 PV0ekCivBuFd8Zc9Y3eDsjh9YxQppkvoeAj+F9X61R6o5M1an/k3kQ9m5gnbjIDUUS
	 uqZcFB5YWd8V2dKwfMIAa8pHWfpu2+hu9q5gHfuW6njtzlwkJrV8nyKo+KcCPm6mpg
	 fVzlag6hk8inTIvfZKhYhT5VRrvnTSTY7V3ERXnpYgFGJixez6hLPvJJ3Fh0zFov5m
	 +6GsxnIKc8jiDoBJAMtZldA5mP9udnRbGhaQ3YyVdlJcMqinIBKkSdW4Snlo+rx5ip
	 RYUeJbCQt/ojQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1F26040644;
	Mon, 19 Oct 2026 22:15:49 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 19 Oct 2026 17:15:46 -0500
Subject: [PATCH v15 01/11] scsi: ibmvfc: fix IRQ leak and guard deregister
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
Message-Id: <20261019-ibmvfc-fpin-support-v15-1-a858726e178a@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792448148; l=1764;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=sg9Lbgea4G1OveFwjkYaq90w+e+5hioGkpYGXVuzHdo=;
 b=XHxxpKyKOPUSQxOCELptGm/YkrQMCTGpzBDPZT3aXC/9GvbutqZxbf8oQ/HxjEYHy0DP1Lav3
 gEx5uFoozvHARXWZk0D/oz85SQm/10uimR2LWSk+IZxZRyzEONZAXFE
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



