Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EB606EE80
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxH5zRls
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJQ7g5PzKz2xN4;
	Tue, 03 Nov 2026 08:38:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793655535;
	cv=pass; b=MeizFeYRKvquOOT6Chsd39RX/MiuSNihfuMSF1TnDb1gKiUuwF6dk//CYvvlRu2L98ut09dml7LzwVeC0ihS2Hk5Ve3nrsW9jurW4zvG1pjECXJ85DxY3h8f9GlKqjfJMTZl9/Y2tbwNv/tM5/BXXkjG2iXJ0CBqS5u0bfuXTPoviEK8xAUU0RZHEQCKNKgNVnowlRsINtC9BpHT41vqkPQi+cAOp7V55wc6z3Dm5T0Ob7uREGATyVKWpLFpr2fub3ah7xkpZSljaZkQiaEtTCNfF+cRjH9/CTjw+yYJnfGQLGHxiFj5txN1PI335GseL0/wTT2ez7mlGEE2dmgkjw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793655535; c=relaxed/relaxed;
	bh=DbkrQequ7AF6sVYRJT9J5w5lL5iEEJOND8Z1gQX388Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmdAMZ8AL0RCCucfQm/1SGFPN7TAwvaEA2aFboBNLTTbJxkrNEwUH8+G2IhCFKlpMwxypQPbwlV6x+pT03aafNAPbqscYFpi9/WM1cObfL8D7FRQHDBvB6LZ+k185T5cWO57leRMg1y+zJwr4kyshF/VK3eBM8j9ahDqi8Pn7A9IaInL8AZIiRab+euNy2j8fCdDTGbDZGJedk7xSV3KZGFkvODmuNLMx/NxNfm+n5zBBBtjcdaY2i1zvnHC8nnnrca64CkdlWdKRPMhX0RKSrqr9ym9PCbfbkyV/3hXpiuLPJmqV7MS2Yyl4JEzQur7XpfL2DimRbXlhu/UfgPUig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxH5zRls; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxH5zRls;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJQ7f6z4Tz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 08:38:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F7C140760;
	Mon,  2 Nov 2026 21:38:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793655533;
	b=u8N7qHWkzvIPlafznhWSQ6WpL70QUQoZ7d4OM6XqRFHxwCciShbUabhkBuExMZy99BXV
	 4Iybik3YJqHR266r5hDIAiV6IgYnQci1/wqOWi71vcsPpFCuqQg6/21n9QYehA8LBNt4g
	 qrRc5UqQt8FrcMzAUha1bX8krGXI73/xkUMx54dNtknke2ASVlTWCzqN40fgRbnnCB8lx
	 +5FfNbRX9AavSGG6MJ9OE8SIkzPvOoZg9NT7LlhhV+vgrI0d81IZ50OGAytJORWgmH6wI
	 gaNyoAP/jn5OuI2xbqalWNQ6eEEEYSMpCgT6wt0SMZ95GCAzDxvDVDiTHv5RaYyBg7A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793655533;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DbkrQequ7AF6sVYRJT9J5w5lL5iEEJOND8Z1gQX388Y=;
	b=zRyhmIGNtgu5F0ZzkxUuFItiT9kgjLXhVXiOgw8QcdHfogeTBkOb5SuB4S4TeaIuqgYx
	 9u0pPjcmypRzmsV1jETESb3KIwp5BwOD7STqraBJrJ7QMTgBKUoNHVyO+h17CRg50MN6I
	 R9Pnq9EifQEIWo5yD+sUirJUq6er4XNllVKsS+be74rBFM6+UVMww2qjuZ+lrLnqn2d8J
	 9QcGeB4n0NTjSC8C4CFL3qzOY6XzSyX70GmWQLFaTViJos8Eg7d3X4+rS8dBpbQHAmWgU
	 m8Tr7xzxVrzQFn1BrBHyIdwjwi/iIcAB0OSUVDR06SQapBW5jXaYILSQv710bA9vl/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 103001F00A1B;
	Mon,  2 Nov 2026 21:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655533;
	bh=DbkrQequ7AF6sVYRJT9J5w5lL5iEEJOND8Z1gQX388Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WxH5zRlss8MhN+Tt+FD6xxRM8HIydrMjBqgHyJrh1KCCqJ8JbLTPmAmE1mrysNyn1
	 R38rIcUvcajy+9pT9Nx4gW7JbacDxLtT16fMytoB8Xn91PKJnmpuoZ+e/yIFxiRwsP
	 a/tiI8D72xVMdF4Pf0XeY84hUK0X53/EZbgc8WwBB2hCYkRA0FVz5FWrZSEt/V+hz3
	 FoRHB/AoS3Ukcbd27Xv1qiK2VlN9JpisDZB/w4F2p1XJONelsVPj11ngUKgIFdE4Go
	 ctGeixBBW8QViPunQbiFaGl7EIu4f/lZlWdE+Oa3SzdoTY+H39ACi+d/3JIr7Eec1q
	 RMj3eEjWFYCSw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 91FA34669E;
	Mon,  2 Nov 2026 21:38:51 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 02 Nov 2026 15:38:44 -0600
Subject: [PATCH v17 04/13] scsi: ibmvfc: fix stale rc and IRQ mapping leak
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
Message-Id: <20261102-ibmvfc-fpin-support-v17-4-9ee5f195ac91@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793655530; l=1891;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=/Cbr+Mc/ALiDF3jQHtDNe+BbKVW2N2r2WvK/BWAfFYc=;
 b=XwY7/1eguYo5JKHNNWg7a6c1Q5CgtTU5+GDV+HE6ZUWRZra+N2RiKETFPlVul6PbONETVH5YT
 gx85y6UAXXyBty2QQNmPFBfyXHhzp0IDdaxZ8/T0ghzuFStXBhTTBft
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
2.56.0



