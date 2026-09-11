Return-Path: <linuxppc-dev+bounces-27086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACB4C88E41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 04:57:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh2Mn6lqwz2yr1;
	Fri, 11 Sep 2026 14:57:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789102629;
	cv=none; b=UcxTphjk3h0fotslasJBIJjVJWvBJWlBIYAC+/SVQxHXj/tOhgOWTKYCPc1mgDB24dSjpKwbMVmd3sL2wg3GCaoucmNNzSsYxlBeG93lA7Ydi677PLySVEY44CTues+4V66+usohtBNheRaf5q26htZxGs7dOmIwc3Mn0jM6oNy7q0DEZv1eF4aJ3RIGH6Uy222cQiup0sYhN4WAUY6hV8F5r4QexBisnthPFATobemvcg5Gbuu8F4h1QrChOEhBmGatCCQ07VheWJW9RlobjYPg5R2gG+IduwaMpgN2MHV2uVN2xYjuQUUXGtcB3LBVEA9pl4OuZrTYM7flckLk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789102629; c=relaxed/relaxed;
	bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrwkNGyTUHf9SqDwcVFkgYiuP52QQu2FLZH8NidNGSrrAThDuS10ziXtpk+1GpRC88L+82uBt6kXu3rUdQUuE1C6THcUwPHrcQveNUWYvOHbOUXwj+g6FeZB6orzHGSognJlLo0Txo6nBQBN0OuRpquyv6BRKA2FTpD5PNo0oyBg/wwjv68PzGze61WrY45yDW9M8Kc8ckGAWmhxtcYHVG5gygToLDMfsirC/Qnn++Ev8jZjZ5pQVFzX19lc2tai5FNHu1UX7fWMlZXErZxafKx02ZU9USGc+dJR6OkO+iibymBObdLX57ngWev1WuJ+AEDpS/czSkZ0Z9pGcvR2zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZT0BQ6Am; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZT0BQ6Am;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2Mn27Hqz2yFj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 14:57:09 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cc4c1210748so424922a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102627; x=1789707427; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=ZT0BQ6AmRfjEiudH05eGXcN4MdrrnzMHISjidXnVJ3z0AK55TfWMjlEKjM39xQlFJL
         LQJW31w3I1y/9+gzHsaJlqdd5ay4e28+wO+rFsOtsQ2UQ1AUDJydaAG33mCxbmsGkfXa
         M1IftEUr1pnmybe1Qr10Yq3cmPwWCTWMjRY/v26xnYNrTrCkDpVzJPoNLAIV6X8Z8qwz
         5uhpRnKlfOyFgTQwVPqZZRI+ZFrB07Mb77R2hqTrJloKPjMg4yVCFWbSEHEh8QDzHOz4
         Zve+YdyzZx1VN0YZkNkcZAlmnurYNGjpGeXEzsqkEn9ey59f+S6MrgyDPdyqMT1L/pLu
         J23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102627; x=1789707427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=dXMCKXWxA61mTq4PfePkGqoBL+oqsYfLJXMG1yyXoZlU8bdrPJ7Ifc4uRFdb8uuLAw
         olzs0nTprZymYiIH5DQAEpAqKaClzLHubdEfCtQmGL61KzWDwCfKx90cOlzJgPj076H5
         iJFevH5RkX6lTK2ommU3ZiO8Z729YPr9b1dxl27yo5EDK+tEml2QWT3bRDgYYCimeDp0
         IK4PbfVq+b4gb57vBEErIVX1HyrZGFGL9d10Wsfp0JzMxGKXjbu1RCt+JNeMw8SN/uMg
         yM4OpRBtuo9mIaIf6XtQY7BCQKEkVpO+Bw+sWhzJYyqMVy6/7f8x04nqFhnitytMzk9o
         9p9w==
X-Gm-Message-State: AFuF++kHVBFCdwhiNfTOvbya/LphXzG29hnS0O/DVhlK/1j1i8U+iNdj
	PsNo+EM/uV/DXtv0RVrKfYu5mC0KiMjcCevNgJsAloz0H7t2tLKyB8PFhdq80yMd
X-Gm-Gg: AYBFou26aIdCwuWa8Qj2Ocf9jsmnLXXxFkiaNVeQN0eWwdEMGbea62eWbM89/Q2cGSh
	15ptg6nfRBc0G9m/vb6ipsSrpINu4kBWw5GFuGYcJwl0/Vitg2AQHUFrewgjs09Pfxd25wti+SV
	UbRQ9W1PLCcZrtYY9ReRnj4Dajrb2NRKJMpLTa37uS+l0MMEzAj3wAZLoK8bls+hU2ArkCKafgf
	yBYz3VW3z2/FcQ3pz6IY6o6AS7BIytsCPWZdjOrP/+TG5wPWVO9y7QMETsb13Xl3UdtyS9VyWVo
	XrQMS+v1yoxVeQoCt24ODo0wAFdsCj6BP9K2oakEAy174/pfvTyEAbHOrTxcp+Bx3+kZplKWJOV
	O+1kMhz+q4EAk4ldcGCVNH+gHzndUVGfTxtNecELvMmEoTGZcvK7CxvyhuqGHS1v5tO6GhRdHUC
	6vnYHOSRWewkyw9tTDNpPCNU3c1FHMN2V4kikredN2uxGEzGguFWvx1Sz3+SwkVUKei9+VqYEAT
	IP3d9h4Fk5ef3+7R/APi+8Luhn0nF66OKZngRF5GlSMSNutY2k0LkSh/c45P9qmHUJY+4vt
X-Received: by 2002:a05:6a21:e0a6:b0:3d2:89db:1688 with SMTP id adf61e73a8af0-3daecffe61cmr4643073637.2.1789102626978;
        Thu, 10 Sep 2026 21:57:06 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm2837953eec.12.2026.09.10.21.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:57:05 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 1/3] KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
Date: Fri, 11 Sep 2026 10:26:45 +0530
Message-Id: <5433192a9121d1006c01c98ab56aca4b42519454.1789099725.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789099725.git.ritesh.list@gmail.com>
References: <cover.1789099725.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit

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


