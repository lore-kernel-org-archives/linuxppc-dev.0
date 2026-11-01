Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59051606A33E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCzmn7kc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdyn3QKbz2yqs;
	Mon, 02 Nov 2026 02:28:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546913;
	cv=none; b=DrCMLBEbzhLNaxLOg0j/Kx3NTyOcXH3r5CeTKr5X4+YBrJH6gxskq1kbghjdEsKbaxddEWsdrhuW2TyHwFEURVO6cxwkaKOhviLPnSrTymrMPsmH/hwm2dWGtrymnJVAC2z67/jMx5LBS79vn7cvS08zEnfDObw+NP3stxarUKGS9bLxceTDHqSOom/kj+DAoMObAkEO2XIZcGmgQ0feHZz+3JSsw5Xom2sL/LULNNZbBex6m6Htf1mYlZMUN5G+0Zvw4CF3iZbwn3yyGTyGCFStWPyDLvGndcbcCB+xOkIm1mayEpZqI4DohxVpG6nWf/9omw3hNKg97fvOLiKSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546913; c=relaxed/relaxed;
	bh=TeZ6IgkzEeK3FNGEWnZ121HpRlWxGruZFzuJFvAehYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ooUOnhG2Y7ZiHQc9s2DTuX8c9I39mvPwYef0PgbIpUTQ7a2lkBtILWvjR+J4NJ6hIv4Rd5wLOgVCcZ/1igoGoMiRn+jvp2DIa+J7hyqmInGc5wz5wpjK06Qz/4HQ5GGuiwfmCuHmehuX6hmQb7ASjXsxz90ehDFuMoTuBE4tiZBNWJgJMwLB67ndUFvPBpBzGDP+54tTPCQ6bLcpIuqGDcababFALOtyou/MDVs0YA+TyYff7N48b2mxyMhYFZV1vw7MOrA8klq5P5ms0oV1JBnm34+wyXYxYSqRxrNuBMzbb80aXrp25wsVsH1R65BIW77e065+Vawe4mrE5nYBfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCzmn7kc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCzmn7kc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com [IPv6:2607:f8b0:4864:20::1236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdym5LhTz2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:32 +1100 (AEDT)
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1792221c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546910; x=1794151710; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TeZ6IgkzEeK3FNGEWnZ121HpRlWxGruZFzuJFvAehYc=;
        b=XCzmn7kcvi+ieaKl/lGElybuSmSUqlYr1cjxY6ql7OArwunxy8j+F2LhWbLD2Pdod3
         A8tOQ2b1+WKweIXE4o9pgQzxs6gXxp6ycBFn5FcaJd9YY1vMIc+GBwzgfUTbPU9pZ4el
         0I5GV52VYLTM5krLAfa7ERTkCgO6js74giwVrvyUCyUhqvz0ZM2E1WuoIj0Uf+drVA/A
         ppYzes8cc04TL4dXMM2a582mfez9E4WO61DOdN2I+Y2AEDlRyH2HxwhG1K1ipvkJqZ97
         PigwYCLtqKPlbttiMcQ4GrbywXTuDL7WV9ARgCx4VUBR01Pa62lNxbSBWl9GD2K++vxd
         T2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546910; x=1794151710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TeZ6IgkzEeK3FNGEWnZ121HpRlWxGruZFzuJFvAehYc=;
        b=DP/zAAMmSEZGTgOPcGlUbW4Oh2+xN7mPQzDlms1HVjE9eSVjuaEllA5l3wZDHk60Gj
         OldEZ2fSmNNvYFZTqJoQ1+TnZIaDskjydanBlUomWAT1Dz89DKQunwtUabUX/Fh6SlIO
         nq12C2JrUFleyCSsMxOlTqabo8GvADpBRukcVrzHMcnHSzbtdNwWMMhZmPXmlc/oF0kG
         j5pTpFwH2S5XJg6p6c+1lgTH0Ht+HVwEroyz+BXqteq8SdHiP2n8nvdvg8cvqDboPwbZ
         QJXlOpgxMNGk+id6N7oczt61i5KPHJwVMb/cXTf77VcgnFJ7IaWmSieYF45+ohoG2xZP
         +JTw==
X-Gm-Message-State: AFq9FYICg196FNePZqZ8fG6xPKfraG2eYOwLmUzBZw1p2KdWAxj/KDa9
	+7b4bch3dD2g0GeY0dVh+bFEdSf84XguNz8ZJimcA4uyaVk9tOYZbB9sOkFmeg==
X-Gm-Gg: AYBFou26WWlxhBbiKPMWnArwAOAgMfbx9qNAHxXo5LMHRwU0bmIb3VVgLb7al0RFQUj
	RvHtR3HeZJD8YG2mxZlu9Gq2fTSCCAIWANH2p1YgIduH7qu3QIHwU2dd6uN1KX89qWtU7rxg3sK
	KvPBh+nv0dlGJQWD5YGY1MH/sNzqQs9jTHzugNWF2EXmX+ew7DNy8GkbKoxSdXYgBxLOYDgBeny
	d10RA3d0Kwrnzc/XZrMDG3b/smfEcjyYlYIOaMPyr9oNjOoS2TgUandXhfb3gHUiaQznwWiDb++
	BCZMUp/0sq+3LFz0TLYpAQiz+7agoNM8LG9llS3pq7NgKT9VcG55A/d9eL3rfKEDv9PJQ8SmQXx
	P/J4u+oY2f/+zgxoE7fdij4cIQX63BpngVwOJFw78W0dEIXsiWtzOKbBYfwidTHwOFpBysnjgtK
	e0U40cf8SWToXCbWXo6pMtRFtjjtXFNDUssAE//b0hgp9xJM0Sc6DHCKJPd03+A8MyvSlBC1QOw
	e3x0qZas59k/SHQnk1XXLYCrsK9z4zDAxrbxrb2gQLvIpsl8TzmBgl1kjKEYvT8rGxmXzFjH26q
	lbgoWYES+Kh5S2GYmZESRNKxENTPRnEIqw==
X-Received: by 2002:a05:701b:4590:20b0:193:5449:b889 with SMTP id a92af1059eb24-1ac6088a33amr10627985c88.45.1793546910336;
        Sun, 01 Nov 2026 07:28:30 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:29 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 2/7] KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:58:07 +0530
Message-Id: <aa74d5ca5ad53a2fa03a7224126f28899ca9b308.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This problem was caught when running KVM PPC selftests on big-endian.
__ffs() doc clearly says:
  "Undefined if no bit exists, so code should check against 0 first"

This cause KVM to deliever an arbitary interrupt to the guest and was
causing guest to hang up while running these selftests.

On checking further - GCC was emitting 0 in this case, which caused
System Reset in guest while running kvm selftests.

Use find_first_bit() instead, which reads the word once and returns the
bitmap size when no bit is set, instead of reading *pending twice
thereby causing TOCTOU as pointed by Sashiko.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2efbe05caed7..5de4b6e86656 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -401,7 +401,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pending_exceptions)
 		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exceptions);
 #endif
-	priority = __ffs(*pending);
+	priority = find_first_bit(pending, BITS_PER_BYTE * sizeof(*pending));
 	while (priority < BOOK3S_IRQPRIO_MAX) {
 		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
 		    clear_irqprio(vcpu, priority)) {
-- 
2.39.5


