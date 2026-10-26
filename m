Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22071606A326
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/9EQ19p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCzDY5F5Wz2yql;
	Tue, 27 Oct 2026 03:12:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793031165;
	cv=pass; b=HAMitDFo1WqpWF2DN7Yum4oTF1rpM/hwBIXEnplcZFb1wwQFpdtPCeXYTCDNJ8cbVrcgBasrYEL+Cm+Ijj9RVQnlL7YNhSFsLamMjhfQYX9oJUj5NuP12YoJWU1psGIID1mJ9mafyr6CTORyI2rQeTedrkehLEFIKI2IqUtXSl47Fh5c3mxK2hpRTYhB8oXTuA5YNuUmP2bSnZII/RCcDAUPxsWQW2nCs0lbZSnscRKQGQh10KcDlQ7AyavuHIUVjVClvlSvOnnzY0wl/Oaw9dUkEVHzILMGetPg3/F03j9rxei2AKU0fC61m+AsCM5GjiJh+E2266DCK9junaoZSQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793031165; c=relaxed/relaxed;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnjVwffaBfyCoDRzbJjOFIb++QCiy7dFOC/xQ9bYavDGvkYh8uUimLjWUe6x0mwuCnqe6vPZ0tzCufWXDTi8r8z8bk+1SGzM9ISzlYfCGo++lLRgQ5hnUzzOG10gCuFT8MhEyoIEsx88sUKdH72B/fAn3LQTHA7ZHslBrjGpnbvfzY3tl0oxkXa+iWBSQUsrThGeyVsT/ZAcVtqMqV/+DeWyhPYBvpIhgdTC6ytWwvanBfCqGIm46KcJk27VVxLn5GqsDuFKDCPpn6cNSTZsYbHRgzOzXmMc91YXxl7eouEel2NLlHQ3AhZAiwLUna+OaAsrmUaYW8tkWCnERuAqUw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/9EQ19p; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/9EQ19p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+davemarq.linux.ibm.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCzDS6yzsz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 03:12:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 026B843F3D;
	Mon, 26 Oct 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793031157;
	b=ncboZK0vgKOsq3RCRpKDZub6YXgrj+GyVWjgs4ENiZnqf/bAY5MYwFv970Bkyujd96hu
	 LTx7oapD/lL5fgc4mzQSMTZvkmid2EHBNJnVxyCFJwcm8l0DWjiVpcT2sA/XMTQYtFBBO
	 bbHc014HYoVAOFyubARufhPhVaJvJ01+HC+bShee1vh87mP2123xKyx7z9CF+y10BZhdr
	 rjtVQT410aEDZFaRa9hqbkitYJ+kb46plXngCsMbxxrEOU0rVxTxfkUb0fXKGaOI7uwlm
	 XVPrILUpGKROw2ReOl2TGHSbTDAfgeW73ECfjfCmAOXh1MY/KncGug534JnE1SwoKKg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031157;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	b=brJBazGgNdA0NDKnRgrAvjoZkYZ28zc8/NS+NgxmvIFusmkWp7e6YOQ4V1nOAxEHAyPn
	 LmvLsUvPpaxzYMXkeVE/TQU+Y2mg3wpoaEdqviLhEeFhL5AkNqr5VZ/ILGFuBlbtyZomY
	 /5uw+lXsAIl9q7agQUXbyP4WUb5Hv0yapm4eAxR9s4wSlmxMvJPFtMzPgm3icv8gjCwWV
	 TUQfMMpk3w2zkM0K1mcbBntTIJt+ev0UCnl1l+0PKYpyUtM90DwMPgaOvlj0YrfzCTUTK
	 hdR7a5cxocG12eogmK7pUfdD40z1ANAyyTsyWSaM9zkIEr3M077M8ASh16MzFRvfYeQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D5D381F01829;
	Mon, 26 Oct 2026 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793031157;
	bh=6uMcoAQqwVWg4ZD2SLJD0mX50qt6CYwlXqXbX/bVuJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X/9EQ19pCfF6ha+LfKjJLeqHt94hbjVOKDlWPdOUNkz2gxKZ3n9F5RN2G2SN+lZ8k
	 OiHqxgSyDrKBHdvOchcrHFRsxVuI350klfpLKJDAsXWGAESYDkTdPPpjWAH32WBvRn
	 l7xPPxGT/CP8WOlBtXnAMr2V+07hopDkyWGDOvjnTnCM70oDyo7mBdOtAh8rw2VPRw
	 j1AAALZYCAcFyf/yLiVYszv8Aj7WCdEs+vaR3Giae72lg7ivIlYCRD3+TO4/KII3OU
	 8NTQZ+1iBTZXe4kVIqOdN76e/emLLEZ4KVZRponVDuZwZFfnlOai+qubNcu1xePOTe
	 FtiPDvLWgmANw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B73044D89;
	Mon, 26 Oct 2026 16:12:36 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 26 Oct 2026 11:12:34 -0500
Subject: [PATCH v16 02/12] scsi: ibmvfc: fix potential clobbering of rc
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
Message-Id: <20261026-ibmvfc-fpin-support-v16-2-a900aa657ed5@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793031155; l=1351;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=nvE9rGLbRD6+mhvHw9wBWLEiRdGSv55IfTVTSl/45g0=;
 b=Hjm7diUp5Mo5hKh2f5/03Lb2FOe/gXl9qe3oHiM0UoorYWtmloijaLbSe9SN02JSBWzMxPoq+
 7yVtrbeusSBADhnh9BziKIt3x0F6amH2s3R43fe0yCVFhtgC1FJDdUU
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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



