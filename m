Return-Path: <linuxppc-dev+bounces-28601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56FDCA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 18:23:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw3Md2Xzjz30TL;
	Thu, 01 Oct 2026 04:23:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790792621;
	cv=none; b=jCQ9Bc256dkopnSgmvUPLnkS4g+szyUIxPP3gWVYZNXVLeL3w3MAguiycEgJuae2oQO3VPyWplno6T+pWeGy/zXxN7cB71IB3bAhiuhL3EJav66vmnI0VBRCcl5tvPPgBfmYfOUYzHvOd+nCizmMNTM2VKjHIn3PHNwRhxKGx68L3tDvn+R7za4fKNuNIiRRhNTFU+1rtfraWXGTvW8gYVcc2s1dQGaCYbyqSJOeu9wjJBrlFN3aAbqRwF2D1a+9gfjq0LPChYdZERU4YizfUCY17LQzsO5HZUap18X73RaahLKpbHC6qhKrGawDR6SDuShqnlUH8aRUEs6PfOvhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790792621; c=relaxed/relaxed;
	bh=kngFhnSdx8BLUWfZp2b3fWbsnpMfo183mifoaOtTuIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPUTtaAFXq9YtsotKbkgdflxJmpi0gxEr2XnZwTq96K5mnrLA+R+l7hA+VsjbvDKTwaHGmVpLmq7MiYeYnEKz/TawQO7NhY+U9kzVLft4vhbxlI9O05wptqffy1qOOgL82DV0q63Vth2gqIaWRAkIKgeXyzc0U4qf6TMocgh0AkOlMVzxohLuDXrBbNfK20n07OA/j6S/WxpNBv6yMn/ZnVv/fF59SGCZHdyQn1/8mii06PlR5f42GpylOPdBCbZzz3OZATWIPLYEbxbInwFo3EIH1rN0oIxsYn27vLkbJDwzZn6g4ZLhBqLDYQqJPuQSCoJY0uDp/i+qXAwuzXrFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SDR2sQ2B; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SDR2sQ2B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw3Mb2jb5z2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 04:23:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 90F0A43796;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6878DC4AF14;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790792617;
	bh=1KaWdWi/RkZIIfrkC3jMiQBwvEHXuNO0nSYjyJcie6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SDR2sQ2BAXdIHUZxnlNL2+28+R6Wjgc3l2GxoveL5tNNnIysv2F/RmblJXu9qt5ZY
	 5z+uTA76xi6BltMtnCSl6qkUA+cT9Geg7rKZbz4J0Y4kfwAxYlfjqlt8NClqsJ+oCK
	 RE+oBxR4CizLfGIbuQQAmEJD5B0mtntp9ly6XOEDTXV+eYDDTd+T8o9Ur9rFqXtupi
	 KCt0GkwQnKpmB2jiFigW+FkjE+OiWYTmmqlJp7nQyMY9mD5TaDzuBO3D6f3rL6qUhh
	 e6e/lSkYV9EvnCJwuoMlPyrluJjGioX4MGIkKR+vm3aQTuNTypeQMz36tiVdSXFGDc
	 c+mz8PZJE5Osw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B02ECA5FCF;
	Wed, 30 Sep 2026 18:23:37 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Wed, 30 Sep 2026 13:23:30 -0500
Subject: [PATCH v12 02/11] scsi: ibmvfc: fix potential clobbering of rc
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ibmvfc-fpin-support-v12-2-53a3fff7d77b@linux.ibm.com>
References: <20260930-ibmvfc-fpin-support-v12-0-53a3fff7d77b@linux.ibm.com>
In-Reply-To: <20260930-ibmvfc-fpin-support-v12-0-53a3fff7d77b@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790792616; l=1351;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=bbPsPyhWTG28FH0lecC51eTB+1kMWqBl+dMJDP40IGY=;
 b=ZbY3zQ6w2RV95z8m039m1RE8eT5Df3x0jpk+eNaeZfXReGAIuhRwGt/FBRvkHDZxKKmqPVkew
 RgSbKlb4e2mA145eZfqDK9U+d/OrbvInnm+DCXeyNxgpXuaTRkJwHSo
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com

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
index 1cd0f80cc9df..e847e0e5f0c2 100644
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
2.55.0



