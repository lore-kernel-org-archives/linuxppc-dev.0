Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4D606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzRq+/JF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd360kdqz2xgv;
	Mon, 02 Nov 2026 01:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544434;
	cv=none; b=bpJpbRbhjpFTGJzOQ4ZKbOTRWwtF1TGqlZZb2/9qA0F5ER/Ndnou91VOD3gCm8wM3A0sSogn+IXcwiDUWlRIv5GbL4fpDc5z6GxdkpUxZI1J2kDl8WJgLV10sDasrJNH8Nt5/g2RsBbFRbxgreU63PMWjyCQ7DeYPZWL3UvmkCBEWTCME5l6vnaCN8A8K4WdN6hTEl9ywsyEBlfH5hAUKtvGBU3FmPpnCYyWBsXbykpfVvLZw77SRWCS3w35jZiDuxjuh7RuYId9CBbAuABzgrWdeYVeF/gtzEd9wCLFtZxZ0XhQhTO64pv2Al/dMPevH605bHUOb6Yf8mZOMjtqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544434; c=relaxed/relaxed;
	bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWDV3AUwl62BGvQGnDtxuEATy8T5lo01bVsKaWeWrOjHzZz02/0NKKyQjDj963gMDUnZMXHH9iwhkqJ+HPTbWHPLb4f70GsosW7c41nEbw6MYszXnhviH8sa+QXhq45ldHhXi5l4nvVgTbuwO/UAPcQKAn3llp6QUWYZ7EhkNvHRk4Tq943lvjiRGeY+c6aNAYkVO6JEcTdjl4iFbEMTVtS3gNLISEqGAiyiqDxy5cSffjwP89BHrq1odzb5HDjjBx/DrZ3qqZAGXk3SeBeHK0Yr94rXFNhx0DKJN4CdXHEeRF2uq4HG6t7a7Eo2D7yTfrO8Si99mzlRz55tNcswgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzRq+/JF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzRq+/JF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd353hgjz3bbf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:47:13 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-36a17a332ecso3643231eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544431; x=1794149231; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=LzRq+/JFQ3vys/u1EUpQ2xOO+pzXtUJqLFr6fEhkSZui7iwuL4Ef3LyWmvVE4Z2/Vg
         1Ivui8P8PMV+mn5fLkCpVhCbgCd/3so+CTuYXt0khy6ZzCWqsnYr8zxOjwXaTjjJX7CA
         Xva7/rGaH7EhD6PSxNQkPPFSg1PyVjk2B3w2HObOs5Nv++TvmZygaCTMuz84MeGOLOkc
         LtFGO/0/EuxKnCcL6wJKAcYZ+q71druIdeOfCcOv582omikBVMeUadElywRUvJAUzPjI
         a0FkMapaY/rG9EQMJ/vPtU/pZneQ31bD6QGIHBVB4iZJptvQdchms6lfetEMNLi1WS4j
         +P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544431; x=1794149231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qduAH+VDk53vSkstbY9xaGv+g9KfxKxHxkbXDOSNrm4=;
        b=JKinzJBdDHJ+CmlT3d3jrjLiFjwSEbITEIhQF+e8aOdaMsO9mvbs7VFqbN267ROiOj
         Vbl1RPzb2CugmILgu1nEKs8FIzPHWN8Iqvv1S3XbJmnN1JlOpco79ZzmhLIkq6PcIGFf
         zIhgR8AKl/MtN9nWo0Q6RA6Iv1yqoFx1h1u0PctDQ0NHqYbhSIy1XDlGcdz3vv081dzP
         3lIhGeYreGn6RXWugnFMNcEndQGTnKj/9unKQFYiV1TXiwYfn0cY/9p5+lF1vK9kxVDt
         a1Y7NlIBexDEr4EQDLFW3ckL7QYjZBtgrJ/RCA4ZvZ/m/q/KKiKGxQWBl7fNJNN5CdVx
         BYqA==
X-Gm-Message-State: APuU4Z+7xgYRxV/iaqkFyN2nemPpppz9yngaOuUtkN5VC/mCPtF/Q2HH
	dWCFbhR722SX/ZmH0v4IxQ9DO/cInUwqcIbHkGqhaZjreMB/OGfgJeZUiIYuCQ==
X-Gm-Gg: AYBFou24LLae5XTGqbc45O2p6UqSBgYkVrsQz/LGgvD6FlDKm9BcrEeZK0CYk2t7aJx
	ZC7V5nSX0U5ERgGuTBXL1MTAJjLwN9b7MYKmNEwEb42TU2l883gDU2izbP0DEDEt0c02U3m3xDV
	dZsumkgHwFdhKinUZfHQuTBCYqLsFiF1CvoZ//XaCIOoh08Kqz09pbytMao9ih0XqrEGtZW1Pgx
	uJQCqZvmQ8dgaG9jGBk8iTPzvyo6AOR8S1apy7TsLtQ2oYCNimqNsgZMMCOv6V3zlHn3iE65my/
	HiD2M77RGyb+cdSybFjqZNLD12mMc51LunIeuGtU4hxhI+w09AyTpNwO6qkB8CH0G5i0R6li4nh
	aXNESjim4rVDy/Vdr6H/Qp4AmaHkfzBuWbkZr1t2fjxCYdxtt2VDfE1lSBfFySEoDsd/5KT36R7
	aZdaPQMvIZqXqmoxjEdexcjge++vTdI3sv2yx35qtddwWJ2KDIsHQVUEDBVdjmjRKql39j05Hzu
	kYVS698pxrJ28L1vtBI1Xu3XIvJ812YZNLPK60UjO2fEYCu7sF5qmhHw7AJ0aAMCyzv13eGNPex
	5AMugCvDvZRISjESDdfurahnIb4JTJPw7Q==
X-Received: by 2002:a05:7301:4b0a:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36a424199eamr11896233eec.23.1793544431471;
        Sun, 01 Nov 2026 06:47:11 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:10 -0800 (PST)
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
Subject: [PATCHv2 5/7] KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
Date: Sun,  1 Nov 2026 20:16:30 +0530
Message-Id: <183d9a0e755f3735ebd531accb9c193cb40317ce.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
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

The previous patch caps KVM_CAP_MAX_VCPU_ID at 2048 on nestedv2 but
nothing actually enforces it. The generic KVM_CREATE_VCPU path only
checks the id against KVM_MAX_VCPU_IDS, which is 8 * NR_CPUS on HV.
That means a VMM that ignores the capability can still pass a larger id.
That id goes all the way down to H_GUEST_CREATE_VCPU, where the L0
rejects it and prints, ...

        KVM: Create Guest vcpu hcall failed, rc=-56

...for every such attempt before failing the ioctl with -EINVAL anyway.

Check the id in kvm_arch_vcpu_precreate() instead so it fails early with
the same -EINVAL. Note that PowerNV and nestedv1 are not affected.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cf620b6534de..5f9cfc34bec2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -778,6 +778,9 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,

 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
+	if (kvmhv_is_nestedv2() && id >= KVM_MAX_VCPU_IDS_NESTEDv2)
+		return -EINVAL;
+
 	return 0;
 }

--
2.39.5


