Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FE606A696
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nP+bcFsF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYny10P0Yz2xNT;
	Wed, 25 Nov 2026 03:16:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795537016;
	cv=pass; b=n3bUR0nGaEypEMDCxtp+xMDuMYvJ1Nb0LKXquTbg1092YEYskRu172GtgQfoAgr5715o71HJPnbm0y3Vx6Xl77HUuqaWBt3/FAU8m+KTslneNe72GOHPn4n5dT+TSRcyEBK65InZG7ibjV6lw5Yb5XH2ZDIuBc63dXq/HBDdsOEhzWi2FO1LBGD5/mHgq2FBQrZZ16P7lKNXblpHFXjOlOj3mpv6nD45qhtyMxBlJmzjKvua88pcpXAAHtkIxw1N0NoTdjUHIWRyPDgjZZ0iBl88ImNQGIIII42A2iBcNL+69B21bqUN8DpoGHRwYpLI63PqiTzcbYjGEuLPG6EQ6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795537016; c=relaxed/relaxed;
	bh=gmO8WK/XYAGFz3EaR4NrkEaqBQyrDCkQ7hDGo7QdChI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8NTvOV0OVhXeX2eudeG1BJEOBBtCZkeliPMW54cQzCPuezswoNAW3r/to7fyeKjW7CMyBMEW4uMJYY0omoRXqNGjeF/XbVSSh2uDrRn5nk1gSTEmt3GH9tEO5L7Z+vojzbY3uYNwAPsJ4yvn2vY/Bn10k4H30Oig/PDg3e7lqqE6CkIgkSPxJ7/TU3CcA971uZU5qwummm4GU0nLZKuCnNXude6u61J/VsP3GEsKP/IKG3hdFq7fv4tSy/tZgs5+13QC+PL2X9fPfUvlTEwZizoGW6V/ws9Sdc3+RiMjr2Iq3sxM7Uj5eeKIDaKEwRmXN9BEXct5qarCF6gSwsP6Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nP+bcFsF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nP+bcFsF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYnxz0sXlz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:16:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A352C62781;
	Tue, 24 Nov 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795537011;
	b=FMFTGezFGd5xkKWlM8Z1QALlGL0TyPLbAk1makGFZ0OhWN7cBtn2p03qNQeqs1DrNaa+
	 Rm4kPjzxdm+kLSJuIjLhxwPmR/vF9rJ2Xq9z2FZJ6HzvYmPNlVNdKv727PAKnCa/Sz9Xo
	 akHBz1tvaZYC4HQaLY/N0oRV5GNgEYT9n9mtleeBwR89YQPLCqIMSbPejuKeC0t2+lkNI
	 xqvJ6ehSZs8G3QAcYxBeiAXbvc9NuJydyFW0DQ3rWKv2/rHwx/0ykzJgqYWR63VVNFeyZ
	 sXhvsVqzBS1fSM4RmY6FUb+C7Fju7hgj7ONNTtJa5F8yAlzYugUWaynuOk98sEQ9AOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537011;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=gmO8WK/XYAGFz3EaR4NrkEaqBQyrDCkQ7hDGo7QdChI=;
	b=AMoKAsI9KKqgxNNpRCGiqt6SWEDh4UCW0BF2lpPA/c5V9sCeUNElzzw5+pDZ04LBHRe2
	 kYLn/CMHLBj9lSYNqtwRyBdHIQh9O1ANL7s/Y7OwDYjxUiP4jBTLyA8oyZnGpqgPl6inZ
	 4sW79dx2DcQRYRvmY32Azs9f2Ao1O2ZIGa8ncV5rN42UPH+1mTvzSdaWaRTvuEHkE3Ai3
	 bA6xnPd+cXW6vmLxXiCoPSgRRN8oPSa3lHobVo/PUaHMsf3zWhUZqzc5r1xV7BF5IWW8X
	 CLSUrL7pn1yBPPdjpIdywWe6zo5CpfSQYcfcSPZBVhV8/rN8TFXLdlCI/D5DTi4G1oA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2001B1F000C6;
	Tue, 24 Nov 2026 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537011;
	bh=gmO8WK/XYAGFz3EaR4NrkEaqBQyrDCkQ7hDGo7QdChI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nP+bcFsFkkbxOKDpXy0+Uvo9Vt2gqCGYySGEGgkkWHWDyJ1ZenUcsD+Ju167WcZJR
	 Uo7WxtC6U9J+jDR9pZBJCU6Yh4goO5lPJb59PaBNb2XE7qG/Ht1vQtnNzNumEoJ3KE
	 W1Hot+pHLZvnIezTdn5s39XNY1UVnRLQQ2sr/T7bCrDkhNbxMZCHH2iswgEzGrdW9v
	 hDW8X/FIJDgfq4yRZvwd4UKkAuRwP+/7lKsZFOyN9mWj7/exgaa9FzfgH1KbyPlVUP
	 oYwhKXTGN5haaJhzLE6qTrv4JadCZdByjhGvILbaF2Ay4zyBgG1VamzWRhm2gBQuyt
	 EBsquaHOk7QfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A55E34CAC0;
	Tue, 24 Nov 2026 16:16:46 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Tue, 24 Nov 2026 10:16:43 -0600
Subject: [PATCH v19 02/13] scsi: ibmvfc: fix potential clobbering of rc
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
Message-Id: <20261124-ibmvfc-fpin-support-v19-2-2aaffe5fe7d2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537005; l=1351;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=B2oTXqd2z+xsBH3KJ9um6J4W5WfCu3b/JIH5kj/iEbo=;
 b=4k7QnReDZKjqkEOwFGxtpXE0DUSi8VPXfwXO8qC7ktKgpa80rlMxg8rCKwjG+wDRVHdhpujj0
 YJZo8AXan7jBmVB81D+iIw99owT6lgrxNmI3zoV37hTHkGaoZXd8Z6w
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
2.56.1



