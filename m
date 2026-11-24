Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19860A262B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAQ9rwHq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYny71yqTz30g6;
	Wed, 25 Nov 2026 03:17:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795537023;
	cv=pass; b=UkpTZqr8kgaZQfE8ci8MR1LlXOGnuhEeDvWkLHRYHSHc1kpX058OwXQPybThYY8nCAyBliNtrd5yw+qBg01AB5p6GM7GLShWuT1Ac8SEJ5e5hTcl8jc8xV00S/xIDySZx1JR3pqwtf8/xcFfhonFijoZRkWL/GMswpRSsa39pu+J5mgogJo6EpZkTXWxojL9/d1Pi7CVPEBtHq2y1bAebEOp3wIT8dwmGurqWwEeVVM73tOQEyQNNgMgwzpFhow5PA7GdHnwbDNiJNejf2RV0qKChlRUM7twkeUO756j2HovxEOHIpbeqg/ZMCpCw4W94fPUzoNFj/E47mz6gkpaHw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795537023; c=relaxed/relaxed;
	bh=jspJBdqKEb+H13c3qSQ5BmPQnjRCpyeq69giT3i6xv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZnH1S1kAs7YAR/98ZgDdzdtILT8PqnFmtDUPbliCJg1NL8vc715OWEz0m+KnlPZ5m3KLmcUuUAuhpAaME/NvM4+nm5oDA2xHafm+QwYS+ltF3rdjo95S/I/M5xvOpWG/LAD/kSrsg/NzGURoEgFXE1s30VgfavhXWgza2wUDAFpRiVcg/bCxCG07QVkJ+lQXv6QOgG9KcOqGkftTMtr2htkJbzyDpGj3wkOLaPuP9SlqdNPsD+CqgIG5eEi3Qa/CaXubk3EHvljvE1v1d1uT90yLkca8WA/RZDBDOxypoHQgiH07nsk5i0go2upPmNxxj35PWTKZ4613DLUO/IOeA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAQ9rwHq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAQ9rwHq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYny50rfpz2yQn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 03:17:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4872E4139C;
	Tue, 24 Nov 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795537019;
	b=xAY5O0dFPtffcl8I6TKIzBO0rtQJD2f6aztfS0Jfhccblg+ym1dP4gI/Wprsrt9IGGFk
	 ZgE8GVe1pbq4JqNqo2LPDF84TxZOPcx6EOkEnmD0F9fhOz2k7zxPF3m9dQv5rrhn+yzxB
	 1F3EXdCBRimVJZfJAGoriNkCNJRnipEP6e9lWTy1HyKn8KZSjbkhYZOgi3vv6A9H7RVHI
	 3ls6JfIszWs99BCMPuW8riGgmYTWEJSy9/W6ekd4VhwBMzs5GpUoLHswQ+oiL8tiM0L1N
	 vEyO5p2826yjyFaehsEIPuyhltpfOz52R4upIE99j14Zyee4xvG+K59OZOjxapX4fPQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537019;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jspJBdqKEb+H13c3qSQ5BmPQnjRCpyeq69giT3i6xv8=;
	b=rnUCBAGL8am2exwzSxCaL0J0ZwsR8XNCyFra1OPxte+lho8Ag15hBiUxRtNjk0zlubrS
	 bcjNW1KcQ46RF/rk7+2vVORtP2rxWnZ1av7gLVeW+MLYKQ87YkddergXF2JEeFfc1QtyC
	 N/i+/hZ+q+4HjR/kgezoyWWKTbR2NJm+DqwXFfjlQ6gCj0FjHoeFPZjthbVEMQl+CMKOq
	 DyBKNQapFBL8O3wzwEZxTCzX4vQLQ0jmVHOJJ8OnO3Ofo35iMy9L4FvogCibMBZIPOyF2
	 0yREz5l0gQSsULBNIOd6toGfhPpy0iBOaeDIUmciEsIpVnO/Xk+0ojfPt0zxFisCXiQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 597F61F000D1;
	Tue, 24 Nov 2026 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537019;
	bh=jspJBdqKEb+H13c3qSQ5BmPQnjRCpyeq69giT3i6xv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IAQ9rwHqxwkGECHTPRjgDYoRPLXlNWMxB6PLR49Rijto8oT8VuI25ofq4XTKeY4KH
	 zKJhuGvurc4RvTYuEDoOSXO0bS2GXhXlJ8FPMkUY7097ayh2e9VaOdwS3FRfKGl0EQ
	 jp1Ak/EMrSyQ+7QZQpzd8+pEHm9a0gEQ6SuAAP+NEZ6fSYDiIDnE9/vHhFVGtMeppF
	 VmNtLm2wY382OX5BarCVtecn6248vRqEFxvXVdMnU8JvfKooRzLUaEphshGisM6Eml
	 RchKyjV3DkavMK5he8PqthZnOGAzoHXqbbdbttHqNALtPX0mdiWeUzTUBY9/DO1Wxe
	 ChxTSeyOv/2Ng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DDCA14CAC8;
	Tue, 24 Nov 2026 16:16:46 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Tue, 24 Nov 2026 10:16:45 -0600
Subject: [PATCH v19 04/13] scsi: ibmvfc: fix stale rc and IRQ mapping leak
 in ibmvfc_register_channel()
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
Message-Id: <20261124-ibmvfc-fpin-support-v19-4-2aaffe5fe7d2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537005; l=1891;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=R1fwBOFIv7ALLwmtsW+fLJtMBhHyBifL/pLD08lbt+c=;
 b=/dgiwgVPFh+cHntIdLk4XQ1IKnKkNv86H0HLU2FIdbyNkRWMGYpuuqH6xuCD1G2paUjwdm9e2
 vg6LMC96/k1ABqNX01wFFg3sdTEPsSLb/mfUreRWiziqxCM6v30b4BN
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

The default: case of the protocol switch in ibmvfc_register_channel()
jumps to irq_failed without setting rc, leaving a stale value from
h_reg_sub_crq() (0 or H_CLOSED) that the caller sees as success even
though the sub-CRQ was just freed. The mapping created by
irq_create_mapping() is also never disposed, leaving scrq->irq non-zero.

Set rc = -EINVAL in the default: case. Introduce an irq_mapping_failed:
label that calls irq_dispose_mapping() and clears scrq->irq before
falling through to irq_failed, and jump to it from both the default:
case and the request_irq() failure path, eliminating the duplicate
inline dispose/clear in the latter.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 65829c3d2eea..77c685f6f959 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6429,16 +6429,15 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	default:
 		dev_err(dev, "Unknown channel protocol (%d)\n",
 			channels->protocol);
-		goto irq_failed;
+		rc = -EINVAL;
+		goto irq_mapping_failed;
 	}
 
 	rc = request_irq(scrq->irq, scrq->handler, 0, scrq->name, scrq);
 
 	if (rc) {
 		dev_err(dev, "Couldn't register sub-crq[%d] irq\n", index);
-		irq_dispose_mapping(scrq->irq);
-		scrq->irq = 0;
-		goto irq_failed;
+		goto irq_mapping_failed;
 	}
 
 	scrq->hwq_id = index;
@@ -6446,6 +6445,9 @@ static int ibmvfc_register_channel(struct ibmvfc_host *vhost,
 	LEAVE;
 	return 0;
 
+irq_mapping_failed:
+	irq_dispose_mapping(scrq->irq);
+	scrq->irq = 0;
 irq_failed:
 	do {
 		hcall_rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);

-- 
2.56.1



