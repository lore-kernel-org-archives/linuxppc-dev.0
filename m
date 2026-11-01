Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B862606A32F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ugpP49o
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHdyj0nlpz30WQ;
	Mon, 02 Nov 2026 02:28:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793546909;
	cv=none; b=Zi4VI0qRLOG/5+tg1SMK5WOHKvoTlU1YrbVHldgCV66ziJS7TT4VSKw+xRxKw3HLbDqqk6fJBmdC7adrEe5FyQ152Zmqs5D0W+r/DELEF6AM1+TVkYlVriQ9qItLUwaQcJFILfcCJ0wMY7M+Hho91cxs/ivyz8IMLCLvamInMSs14AYId5FCp4d6+Ffl6lJ1y7HNWaEVtqfLXZg0/lIS69+LF0b0x7G0chxEecnIEkZdiee02UD3whhlokIfpbA+IAdpqiG2uCzFStJMGiVGyDM3qjjm0vwz1y5QMfY77bgy55FqdKwdcx5QeXyBd5SjJdcFdyhczKP88zu25XjD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793546909; c=relaxed/relaxed;
	bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCtADLv+sf3EnjQ2zplrLoTDxYhLgMyL2d/R58Pl1zPSVbQe5zy83o0ZriJLozoTh/jwG+fb02/mFVVODcqeSHRKDACQj9HGjIc5/I2k9F0PQ5SaWXTLbV4fnRRsP+b/tkO+IrtcmLDVUXF1MWNs88nvT+lEwljjAZTguAGw8aIBGUEKs1s1NdKCSDobpUDamiwBv8LK/+T1QBIXi64reUy85RSNXBZG1Sxo3As5QRcnWFKHBSCD3lM8IOYuagcMzsN1+uknf6Lgjm1rp1xcczOnKX0MfHTaqYad17UOTCtm3FKJnN/XaZ2yV0o7KUGNpxQ1NZs6kwwuO3TiqV3oZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ugpP49o; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ugpP49o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHdyh1mF7z2yST
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 02:28:28 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1303180c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 07:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546906; x=1794151706; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=0ugpP49ozS1mamAnF9iVVfAOUdFwXCuo5kT8T6JZPvzMvTSdNmeEW1GpnOQsPvMvvG
         CACi9VO8SvUy2sFOnDNp6NXCP51qwQL3IzoOYAzSI1eTCQU8x2BauWjlNpqKj1BjSXEK
         VGYx7sN0sLZBRSQZGOzzWJp6EEPTmzfvOZ1RQ8gVFW8b8imet7DgWTUn8e30keLUE8SY
         jd2FQIu3OpazxlAxrn4bFKZXqrr5tRbEuGe9uFLgpYKtxJfu/gtt2z/xnS7YxOGIRqLd
         CCy6y7zEpZkczgW1Aufb8Tars4m5A99V1cXURynfPvKFX4l6qeKQ6A4RJz7lcZrd2avv
         /28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546906; x=1794151706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=Z+ljTsFh39QJHQetUo4RMrSyDqoXxUGbsgMMBPVOq4d+HYBL8194ZAfRPaCDReMff7
         +3p2Go8S1G/4EqJYcxg+I5aLKSgbB9tDxia+5H6pKMA3ewOkUoVPB540gJwg8Yisd/CA
         IAwBnI1iyWoU43ORLKYNr/FlEMaDTeaMTQ9q9yJqifani4tFoCDEegFIycFarathdcGj
         kpGZzbYWmjGefJPLkmDwORr7f3aDQjQTDbBZMtzGeBFXTKlZLH5g0ZlVOKhK9CJd1TmR
         MrCzcXW0c79jr97pElJb5d+8wdIbyLxbPl8mBmfJMg962pe18x8/l4NFKlkKGk6XjzZQ
         52UA==
X-Gm-Message-State: AFq9FYLyAZYAhfmBtfTNjAafmh/Yf2onmWnIF1pwZ8D9Vxn5CpOvjOus
	5VUqYDrAREohpqOYA7CCK2c/1cXon0p5vvuE1TXzbaU/cASR8BerEALYvFGsAQ==
X-Gm-Gg: AYBFou0K6PW/eYyge3pfMGOQrHFuqCJ4HB0BzYakMwqf20Q1P+5Fg9P+HoWUzvZQ5So
	E4S/+hZ76Qb18/Etq3kjNjlKZ9SVEY/v5fTffQiFA1/upqrdyMH8E4bD3t2hILdFuUaZlNYz+fa
	Q7ElMf4rEhnU1TOP2FHZILxAsQKe9MzCWaXViiZrlMMYgLx+en76E1J3WADIZr3kqk44WEp4O2L
	1fxKbS3JdGDX1RNlruMNoaLXB33EVpsdru746Zg77utFfhVLPIiCEC3eWd4xh9++NZ+kcwHX3Ev
	FfLKbwNFRILmbHQ389YR2A0zzHFnFLielmv3WSs8rwmp1AndTx8GDM2YLtlC/BvEzY5UnebQl+m
	yJwxcGGY2ijuS7XLlRTFZP99sZ2QbdRhSCABNP0tfgRusBK1zT7gRozQ1HjhRAfcVi+RnogPW6F
	VRvIiKVd/HuokUNJzFZNb4kWK5JLZ1KIqYHvWlYZAVW3KO/x57Sa22TUw2Y3x9WukF10psuUC/L
	kE8htH7MdJ4KbQiOTy9pDvi8EKQu8QzkNNue3czPHAWtK1BEwE2FN3Otibc5rN7Xq3pKn0B0Y8t
	RtdIhUSOkKJ50yEc/at02qJ1XWiVxk3OobxTboLA2uJ3s1cBeo/bbjI=
X-Received: by 2002:a05:701b:2086:20b0:153:3c50:ab85 with SMTP id a92af1059eb24-1ac5cb1c5fbmr12526852c88.12.1793546905701;
        Sun, 01 Nov 2026 07:28:25 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:25 -0800 (PST)
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
Subject: [PATCHv3 1/7] KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
Date: Sun,  1 Nov 2026 20:58:06 +0530
Message-Id: <4e883269c887f68f4d9d54f2675799df147a5db5.1793546707.git.ritesh.list@gmail.com>
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

kvmhv_vcpu_entry_p9() recovers the guest fault state from the paca
exception save area with

	vcpu->arch.fault_dsisr = exsave[EX_DSISR/sizeof(u64)];

but EX_DSISR is not a doubleword. It is a 32-bit field at offset 48 that
shares a doubleword with EX_CCR at offset 52 and the exception entry in
exceptions-64s.S stores it accordingly. For e.g.

	stw	r10,IAREA+EX_DSISR(r13)

This issue was caught when running kvm selftests on big-endian, where
this read would land in the high half and the truncation yields EX_CCR
instead - KVM acts on the guest's condition register as if it were
HDSISR.

The result is that every HDSI on a big-endian host is evaluated against a
bogus fault status i.e. it fails with below error:

	KVM: Got radix HV page fault with DSISR=84004840

Let's fix this by reading this field at it's natural width.

Fixes: 89d35b239101 ("KVM: PPC: Book3S HV P9: Implement the rest of the P9 path in C")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_p9_entry.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_p9_entry.c b/arch/powerpc/kvm/book3s_hv_p9_entry.c
index 34bc0a8a1288..16aa8582b888 100644
--- a/arch/powerpc/kvm/book3s_hv_p9_entry.c
+++ b/arch/powerpc/kvm/book3s_hv_p9_entry.c
@@ -529,6 +529,15 @@ unsigned long kvmppc_msr_hard_disable_set_facilities(struct kvm_vcpu *vcpu, unsi
 }
 EXPORT_SYMBOL_GPL(kvmppc_msr_hard_disable_set_facilities);
 
+/*
+ * EX_DSISR is a 32-bit field that shares a doubleword with EX_CCR.
+ * Small helper for reading it back at its natural width.
+ */
+static u32 exsave_dsisr(u64 *exsave)
+{
+	return *(u32 *)((void *)exsave + EX_DSISR);
+}
+
 int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpcr, u64 *tb)
 {
 	struct p9_host_os_sprs host_os_sprs;
@@ -770,7 +779,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	if (unlikely(trap == BOOK3S_INTERRUPT_MACHINE_CHECK)) {
 		vcpu->arch.fault_dar = exsave[EX_DAR/sizeof(u64)];
-		vcpu->arch.fault_dsisr = exsave[EX_DSISR/sizeof(u64)];
+		vcpu->arch.fault_dsisr = exsave_dsisr(exsave);
 		kvmppc_realmode_machine_check(vcpu);
 
 	} else if (unlikely(trap == BOOK3S_INTERRUPT_HMI)) {
@@ -781,7 +790,7 @@ int kvmhv_vcpu_entry_p9(struct kvm_vcpu *vcpu, u64 time_limit, unsigned long lpc
 
 	} else if (trap == BOOK3S_INTERRUPT_H_DATA_STORAGE) {
 		vcpu->arch.fault_dar = exsave[EX_DAR/sizeof(u64)];
-		vcpu->arch.fault_dsisr = exsave[EX_DSISR/sizeof(u64)];
+		vcpu->arch.fault_dsisr = exsave_dsisr(exsave);
 		vcpu->arch.fault_gpa = mfspr(SPRN_ASDR);
 
 	} else if (trap == BOOK3S_INTERRUPT_H_INST_STORAGE) {
-- 
2.39.5


