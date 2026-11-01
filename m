Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3260A2604
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yckuDIqm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHd2n5n8Sz2yTK;
	Mon, 02 Nov 2026 01:46:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793544417;
	cv=none; b=TnGRi+arsMsbcL35iSwLtn5O8zON9uNUKvpJbtlykHqlaRc8jFAytXou04b6MFT+5xIUBSRYnv7uewh8K37nHxeGkDiGWkGenQp78nUEJgWH0+cJAzaPeD0igkxhxLvlk25LoW3uddUUnTW9IsHJffkltyhyl2zjBurVtk6ZnGJjtHtQxzeKrTvEDqr0qF5voh1j6dOMUeEeybAcovWJ4dhH30cWYlxIihHoKq8fOQWH3EYu3B+pQCM9eKnXe1fCdKXiLHbykAZ9bJjsdxgsebGqHhVv5uh2S9SQWXMrtQqA6C6FGXs1TB/dV5LUe0vZpd9XWbcEEPg3yka21a7TNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793544417; c=relaxed/relaxed;
	bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLPnWEdDrMS6t6Z9Jhz72Cx7oYZH2jHdp1HSBY21MiRu960pWkgK+RjAkcPqi9gb26KkafxcLOlZfmuQrXLgFpDw7DVO5rMC1CvKNO7puGAZmx+KbQjiC0z50Emn7E/u/pAFaHU3ZWoIt/e9ySjRqvgsIVYGZKdZOAfirPv5hhEG4WYT6+r4yMd47voxA+9wfRRQsxZjQYPB1mPLVq7UURNmMHrjJZSxdBtoUfajYnbY/HfiCHGh+/gvjtspMOwC1z9X4gIngwv+o+quIXuDm75Tja3PADjYCGHh7ChNlRft+ah3943NNYRyE7D4ThBEPhyYdVAav/WGLOqEnGs4wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yckuDIqm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yckuDIqm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHd2l62WNz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 01:46:55 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-35b2c599f43so3005325eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 06:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544413; x=1794149213; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=yckuDIqmwWx7CLZAjrqPhpfTBywg+NqU5QY6WSmH5xNiowotzPkJEzC4t4h0dMpRGP
         h/zOS5OxYSb1oZHv6MTTinRg33q+RLuB0HRbeXocVOHURcaivmRHLYqBC7JEnwMAsESF
         B+h8zcenltDL9GnJs9pRncULKeR0oahAoMPXJ/BZMNyEv1/FQdDHxgXuOT8o3kU182Db
         6NBk9FWyxvT0EaoJ/JjgN+JG0Kq0AtWORETchrmpr8fq/1CjBbOMi9dIf7+o/GDBcTr4
         5o/2qkaYz1upfvOdJPt9bLtQbuPp6i86JXg1f/USa7GGNZLYl3wIgPVFg16nMY+ci6ww
         VdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544413; x=1794149213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmpZZXMsdqMV2V4eNDvwbvfcyiTszzMT6zcGXuns9Y8=;
        b=AANr/kpu8MqNJwf9p9lxlbNGgcPEdxHr3YBRwxr+xoSFIwbwWRzdHuhbFOFE0xw0g+
         EN8nBZCynJV4ufhiaSXlbTcTPbGw6fGo6XvLjgBZecC46TzV4oqtjTSxJZrc1J1xVArn
         awfq+hmbGXv3j7Xj/hheezm7BreSQA7aE+p1z/wKZKD2qeTfwy5WghTVvsfbwSW8Ot48
         tc+Y/hNWjy5ByPtsIxmzNvNHR2UwmYXBMxffODq4+efm1nAtVXsDTQ0huI3E68NyWXKw
         r0EZkXrYVcPUVrQybpOE73++UFpescZnlokVBuAdvOaSmNdzUmphfWoN040ZSWq7zvdY
         Ekmw==
X-Gm-Message-State: AFq9FYIQjkdtKMzakgXLrw9CRAs7H3c1bBle2SU5XE+8YR/Dr1I0aYK4
	ImC7gfVv6ZYstcI9VpC8u3C2+bxcg6DJynxw4+PbqJPvfOUZC6JXZSrF1VebCA==
X-Gm-Gg: AYBFou3s25lkqvSefj/pmNOKyP2XVCB6wH4ANQD2YOG8sXA3VZ5Agn31hDMJQFSlUeG
	YkbhbK1WM4VPM+8HaY8hYTvXVa2Cyhb1Hz5/Xtl+VATLIxfV/8ncNEbJaz1CpRhxMS3wN75QjFV
	rhHpcaNxxaphE37qcFdyMor7/rlTUAmqqcWU34wu9stlHTk+tiIgBQUUDpC1QBjo+/yTyYC6kJM
	XLzv/Auh2rxYhBQJRSLBbW3n5kFxrAf6JOHKzQxOTtPrj/YiBYwLgJfqyTs8tPgENz+l0dFA/45
	xvL0OQY2XDSLlTTJVSAjJbVJFGRvxurMlfTdXpckkStPmSGJYrrtf/nLETyOEDwli3v+x8NbTRx
	N3+5/XqBhqkmaDMu0uc0yBUHRkFjxI2bRMIu1y6tGRHsloDZtD20Rx2wa0Ws9XMFwJVyuMQ314E
	oFfVufBh5OCY+nrwVE7gGR8tU1mxLKw07QajrKPBMnfvC5+0m5WfdZM5clmD4b+y7TMyl/1tviY
	+f/JBkjYp5KAYtEtPnhf8I4ykWDMky9E2vwriUcQok7RZQypNxH4mj9FxZaSYf2aJrwy4/cwsZX
	4EcmpqLxrcgDC8AppDX3Bk+WbJ7HkF1RJg==
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr14058549eec.27.1793544412069;
        Sun, 01 Nov 2026 06:46:52 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:46:51 -0800 (PST)
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
Subject: [PATCHv2 1/7] KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
Date: Sun,  1 Nov 2026 20:16:26 +0530
Message-Id: <4e883269c887f68f4d9d54f2675799df147a5db5.1793543627.git.ritesh.list@gmail.com>
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


