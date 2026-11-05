Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F2606D815
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALTdeZ6f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL8K35n0cz2yDs;
	Fri, 06 Nov 2026 04:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793899383;
	cv=pass; b=aIPizaKwzuBe9YlbHfGZ2BUqyhHfJJewgfLrgVIMKl2xzrnUEzsqddZKsCNdBd030ht2DaFm/dhsy7LLnTylZ92CRscxZAHl/xkPuXN6APB3CHUNYAdgfFB4kc6VWX/NZxpcLoMJuJDgceMK+n4fr7L2BnCmVP1Af50Y1OIpeaBkXua0RELBgEM9P4j5tepWO0v+jf5Rn/qEFoKoRxiJ65GSH+/A0PajCfNQ2KPGqxsf7ZC0F6f5Hh7rDr5lF3dKtDyayU7RDIW8rZzdS5sPcxSeZRiipnvYTOph51hD19Km6kit8nEIG60c0ttkqTar6GedcpCvnTlE6S80Ig80gw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793899383; c=relaxed/relaxed;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFGiVeVStrNK4HUhwSejbu4YqCyeqGJa83QdBxXYe38UBQlBLa7ryiao3Wm5AFr9yhlu1lO2M2rCX6Xt5BTyjFNoDBX6jTID6Xo6Lc7g7IcpaKK7enI0xDcSFU5fLT9IMLUof5Ror4bPRrjF5WNsTyvr8qRQnkDkoeJ1GICtBJXviaipKZY1u2bUQp9y51mcad1DFIZpb2f0vQUuHjb0dnm1p6ut+srNjeA9lB8gRD6VrjVGzu7+AU506c+TKZ5BLAavyBcTYB0YxoQblaEz3E6CHbBxi0ALiWCf9xYC1igOpO/eLa3hHax/wZSObtWaTrgKM9LHWvXNlmcprVRTmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALTdeZ6f; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ALTdeZ6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL8K22fb6z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:23:02 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 643D142A7E;
	Thu,  5 Nov 2026 17:23:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793899380;
	b=nKQpYCqHSW7yDVHF1ewf+t80bRJzkDMWqgXeFcMV4/W6oKeaf8H8z7UXjCRk8wRvuVSr
	 D1zSUdblc5a7/0pJ5wxbkTpIdJiZFM/YqveXtqRX3agrdljkqg/e5NDUT/mGsFTaprvLa
	 B/w1CiQoK22C0jzG+EufZZKx9Vh4yfcnOFFYR5VN0w1QgkUEQB6Ld5Gu9sov9yYzfO6pQ
	 1M+xDyVJ11f1eSBpTLMdjYae+/Dekf4WOWtjoj3Xuo2e+v8T10Vpuyh9J9OZcpG/Al8ku
	 A168Tt72giOsJCsZjwNm/nxZMtS12R8jAD/1zIcHZPefS7GcEKyuLvQDav0pfCzgmLQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899380;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	b=ABNwrL0kqNRQ9lh4f6tJDUGA5p4YpLIffeMW6/WgtnDyGu766lcxooF75vtMY7oVRzex
	 YhecQ0977QA6lHtMeiKeHxNc3zDzraTwIWxDEKGa0n2vHu6hZJ/WyyOiy7lg6OqrPC00+
	 haJJJI8FQ5vLoHZ5cZVb4OmheglbTqp2kbEFYQeT+L2dKshgUS7bJpEc7871/81IGpo+o
	 zG3Ol8N/K1MfzbvO3XumLKBNly14wNLnpCr6+ECupZDxUo/70k7muunn4+9qNY2yb6OcC
	 surloG04euqPIevJycI52d/VEGcqKnvxlzO9OJu+DncMYrel4yn11yAyQ5hBMo5swDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C322F1F00919;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899380;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ALTdeZ6frgGXNc38GVMk0PrKA9oQ+7CUFBzd9SIz5VHgZHhxwpqjRvEFpSMjKC/gp
	 jf1WWLxdKLIaPbolVhNI/RS1OD92GGrHi7uiUXZM5CNp79dsfPMrXk+KV+43AlkL2r
	 JqVQ3MSrVU9+T9t1btbE17t3hFelU+565HN3hB7X7W7e/K/Epk9DoAp1eI/8E5fcbs
	 4OvhEBGQbS4YGpAyrjb1M77C7N56/jhxqpo2Dll1E8Dj2GqQALCoqbwZd04UXuRISK
	 vWtM4l9WiU5M5mHJhDgzx23IouTpiWaP4lnMht1O6FxKY+BjD4ev0ItcddFyFh+KVw
	 zurhI8xB2c8XQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 47C3547372;
	Thu,  5 Nov 2026 17:22:58 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 05 Nov 2026 11:22:55 -0600
Subject: [PATCH v18 02/13] scsi: ibmvfc: fix potential clobbering of rc
 after failed irq setup
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-ibmvfc-fpin-support-v18-2-d683b74736a3@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793899377; l=1351;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=nvE9rGLbRD6+mhvHw9wBWLEiRdGSv55IfTVTSl/45g0=;
 b=4y8qDzRzYG/kzx6Q8TlxM/H6fu1T6qWmkhTlblv0WhXXN+GyD3yt4/vaqwkqquHbbPfYY7sFu
 E/vFjQsIi6+AE3lKWOk4aIp64y489l0OCFM4R+PbX34/TpzdAcOBq8+
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tyrel Datwyler <tyreld@linux.ibm.com>

Fix a variable-shadowing bug in ibmvfc_register_channel() where the
irq_failed cleanup loop reused rc for the H_FREE_SUB_CRQ hcall result,
clobbering the error code returned to the caller.

Introduce hcall_rc for the cleanup loop instead.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 7818838669ae..145d559041f1 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6391,6 +6391,7 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	struct vio_dev *vdev = to_vio_dev(dev);
 	struct ibmvfc_queue *scrq = &channels->scrqs[index];
 	int rc = -ENOMEM;
+	int hcall_rc;
 
 	ENTER;
 
@@ -6446,8 +6447,8 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 
 irq_failed:
 	do {
-		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
-	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
+		hcall_rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
+	} while (hcall_rc == H_BUSY || H_IS_LONG_BUSY(hcall_rc));
 reg_failed:
 	LEAVE;
 	return rc;

-- 
2.56.0



