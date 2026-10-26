Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274E606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=f608s+15
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD4CQ21FDz2yPR;
	Tue, 27 Oct 2026 06:57:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793044626;
	cv=none; b=niQTrJNkcZNx6RMMScH/bmoElV6P76ZJQxokWv8snEV3aGG7q73/sHIdgnzo1lbiDy4+dV/FhEobmU24t38mLTcT3mGNw0JMpuktcA8KQETmGrQOJYUJayPl+bs1Fs6cpZLGN4eUYyW+bvbyoxbHnMR0tswEKpvIxYWOpwkeRTc8ae3hoivy6XPTq2Hmi5HxSWQdXSlg2C/1YcSqEdOfMAMRzYSHytcgSgICNmGFL4dIZKl8G9foRtTyDKRxTy7Bsgl7A1sJaTST6kZYjs04vZmjLWusNHG6FEgGXYTL+uRJ3ICa93YrOj/Sd+9c0tydDCkP2rlriCHJFx40I2XoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793044626; c=relaxed/relaxed;
	bh=Z4jGd5Zh1+L1LJCrBnBDsKwIyWcB7a2BkfTKeB8G4WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzcGQGr/hzQ/Kw6UMorOt8PaiY7JVDkM06K3RPrFB0bYLKJSThZwSOuBplHGJl2pW1YSjTKdp2wjunK3+2poSt+6Rjo01yCXi2ODpOQNCmDAzgmAZrun+cquM+SOZRaJpojJpQXvseumvybvgOqoCSy5EWxKeplSF7KbMPJXoHGLW5vHxqW3Ly4YOHdEmH32hRfCCzjkiK4Ux/23K2owoGdKgwTJzGo/+B7up21etCQSZLwmOYKEJwhlkmmaBcKqVzTnPCPr6hbBIQ95lPfRja/bvydRO2cwZxTWbViPSDG0hTqalPlDqFyoOrGA7Q8TBRXwCaoplrSO5Ue3swUgIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org; dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=f608s+15; dkim-atps=neutral; spf=pass (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org) smtp.mailfrom=acm.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=f608s+15;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=acm.org (client-ip=199.89.1.14; helo=011.lax.mailroute.net; envelope-from=bvanassche@acm.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 231 seconds by postgrey-1.37 at boromir; Tue, 27 Oct 2026 06:57:05 AEDT
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD4CP0fCqz2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 06:57:04 +1100 (AEDT)
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jD46v05BVz1XM30g;
	Mon, 26 Oct 2026 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1793044386; x=1795636387; bh=Z4jGd5Zh1+L1LJCrBnBDsKwIyWcB7a2BkfT
	KeB8G4WQ=; b=f608s+15EKsPZtFmXhhYUAiBVIXES8fzj6bK/qGB943CfTh6eEs
	ecd5l40Hyi3/1IsPB1s4Lao0bJ+DxapF1ze3CgxwEASzPJEn0ehhKWg/aNVUt/Ks
	xk7BLFiuVO1nop0PFWAMvSxHzcHte88DLBKUITv3CHD56x3mfG3pAAV6fBLYaau2
	8Sc05/VI7DjJWwM39/K5OHPKcZ4cnzwksBnIjeRpV3BhJqs+QblQrAvr3UBJiMrY
	54oYPATb78o+Q2CHVW7hUJcxCRyPnre5CcfVf29Hywjb6UugVahxV1fhJE8ZSlNv
	7vggzIrgXJIiZjnmU1RNf1bO4C4/B7qqTDg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H6DJu_4K8ou7; Mon, 26 Oct 2026 19:53:06 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jD46n5QVqz1XM4Tl;
	Mon, 26 Oct 2026 19:53:05 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Qian Cai <cai@lca.pw>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] powerpc/iommu: Fix an RCU read lock leak in mm_iommu_is_devmem()
Date: Mon, 26 Oct 2026 12:52:50 -0700
Message-ID: <56f0c45723ee53149a21ceb599010e957457afd8.1793044370.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mm_iommu_is_devmem() returns true from inside its RCU read-side
critical section without calling rcu_read_unlock(). Neither caller,
iommu_tce_xchg_no_kill() nor tce_page_is_contained(), drops the RCU
read lock, so every successful lookup leaks one RCU read lock. Fix this
by calling rcu_read_unlock() before returning true. The pointer to the
list element is not used after the RCU read lock is dropped.

Fixes: b5952f8125ae ("powerpc/mm/book3s64/iommu: fix some RCU-list locks"=
)
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/powerpc/mm/book3s64/iommu_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3=
s64/iommu_api.c
index 60d00c9e7f19..e1e43573e8a8 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -371,6 +371,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigne=
d long hpa,
 			 * and the caller needs to distinguish this situation.
 			 */
 			*size =3D min(1UL << pageshift, end - hpa);
+			rcu_read_unlock();
 			return true;
 		}
 	}

