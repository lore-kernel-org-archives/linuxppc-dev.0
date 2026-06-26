Return-Path: <linuxppc-dev+bounces-23017-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782D7CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:56:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmszn67tVz2yYd;
	Fri, 26 Jun 2026 20:56:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782471381;
	cv=none; b=DRrE5lg49UPCwjwfmucOkS6l/7y9DiE4OBZPGvr9QjO4pmHzFrtO25HoV12Jv7kCRqG2c5IdTb26uYRWN1fODMiiLBgIctB1T3RX5S5Fqbffj46p6DaowQmA4EJsfIY8QDX6sjxEYSIkbbADAF8pM+Zip1DGVU7JT7KJ2ZXBC3EjspNKWAEmzU0DyTbCdpyH+pLuC1igZNJZuhDSLFHBRh+vDKIM8CYHJHYNxOSSbfYg5leQv6HJIxzmj5OJiKOvSFoJJ1psWVXH7ym2Q3eEZ81X3m+mRbbSgKI4Z6fX1ju58yNYpcNVvOJ4HeA8M6Pdo2aMgne+sMshUB97Y3CaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782471381; c=relaxed/relaxed;
	bh=ynUqAtv7brfarr/o+AaTrcXvFX8xzgL33PEwIVBnQQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7tw2vhCQ6ANMfx/Ln5kckBR/dp5NLL5jGMrj7k1/tOnjOSQpbSDCKs9PCeV9cF3FcWtRYBh12/5ugZkSFfmcBzo+gNirxVPGCXkn0c0QhTttRcUz4vD7wr+h5GDMUPKu5n+iXKtKRr83HxoW1t5LyeafFMYpEe7gFpGraI6Vp2wGiIAcW4loigjY3lkn71sX6SxRyUmWsjWWYlkxiqeahhoctUe66TnvnyzKK2DKkwqiO97kP4JVi95azQkyHtS1MUucebGPlS4ym9yZllqJSJ4fghoLJutk7DipsOkbAV28LB6zCPKargiEfc1fA/Bntkw6V2q6fovrj3O8c82sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bTXpd9XZ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bTXpd9XZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vishalc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmszn1Mgyz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 20:56:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIH192919861;
	Fri, 26 Jun 2026 10:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ynUqAtv7brfarr/o+
	AaTrcXvFX8xzgL33PEwIVBnQQw=; b=bTXpd9XZGcxE82TCw7PT4XiVmx2qaz/4E
	NWXtk/4aL6ofq/hTmZOsFXusVPZ901V+qQ9iSeRGApZpnpZsjsNrZAbi4sJECjMv
	UGDjUpziDN87N1Lfnmb1FAh9jb1Dgit9fN/daTANezHBH6zrAfFUrq/Z92Q+2sST
	hxNrs1H/oW/vpWTETZVeUuOFudend336Ow/JN/4zutm4svrnrh4hh3NFqkE1qnWU
	pH55FtKdsIuqy+vOYL0iQVxVzYg6K+NtBYFXVlGJkJNRRLDK3Do7KOQ7qOvloBsV
	GX/oxMRCTpRbyOrXVTbpbuTgl7NaO4IsiUyV7KB6gw5dtClHkr3CA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr6g00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 10:55:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QAo8Ov023161;
	Fri, 26 Jun 2026 10:55:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwtuy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 10:55:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QAtp6V24838454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 10:55:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73CC020040;
	Fri, 26 Jun 2026 10:55:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C9962004B;
	Fri, 26 Jun 2026 10:55:49 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 10:55:49 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        gautam@linux.ibm.com, bigeasy@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 1/1] KVM: powerpc/book3s_hv: Use generic xfer to guest work function
Date: Fri, 26 Jun 2026 16:23:01 +0530
Message-ID: <20260626105449.2897924-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626105449.2897924-2-vishalc@linux.ibm.com>
References: <20260626105449.2897924-2-vishalc@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3e5abd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4VjbuBxFWgCYz5P0O64A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA4NyBTYWx0ZWRfX3t0UT5ubNJg1
 e0Ju70iY/DZlOsPdp0HozN8v8JfDlTQqM3032Zd1f78Hr6d0UChraexJfYBAxWubw65BCTqvDwe
 eT7m7KYWfSJDCcBoHcJ0im5OLrkzUpizoI0VVR5NCUt3D04vAwJHMrKm+Dg5/MKA21zJjdSYuiz
 BqAvopuYGxSDQ24TTed6QaJ7brWdz5RAu6P69aM+FngSEv/4snIxxc1MWGevb2RDiJIM1Q01olb
 zBEIlZkhlQeJlT40zlOYX5KdfGVJeczGrSJQtr0mkE3WSIgmyQAgR8Yr4ZLmLZas4d7HXng1SYq
 B1WWUooN0+f8hCiepZ3ijkVhuuhABrJQ0dt2ra7+HHwv7cybkmc22ALjkewq4OGLm9PynkU66DD
 V/Es4z+uqPhELq5inRzyrA9RCZ7VgtRzHtuyM15f9su8MfTOO1K/yBkc5jH69+ET9W71NeoG69H
 gaeG+HmlTrAYfxeKupQ==
X-Proofpoint-GUID: Kwy7peUFLNixGJjQ1MkK9u9HHjXNkCXI
X-Proofpoint-ORIG-GUID: XNY5LW5xptq8orItsOU9ihfmc4GQOj5K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA4NyBTYWx0ZWRfX7H2j3JoBJ7jO
 mEUfk2fsKrIjURjWqHtR50hbANSgW1z02//abwSKTvPJV7tKdL5gHjcSa+yLuTIg/sPjLqZ08K8
 NFM0w9vIxZ7V4SyEiLf/Ywe2N9BiD3Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260087

Use the generic infrastructure to check for and handle pending work
before transitioning into guest mode, replacing the open-coded
need_resched() and cond_resched() checks.

This picks up handling for TIF_NOTIFY_RESUME, which was previously
ignored, meaning task work will now be correctly handled on every
guest re-entry.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/powerpc/kvm/Kconfig     |  1 +
 arch/powerpc/kvm/book3s_hv.c | 58 +++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 9a0d1c1aca6c..36aec58c5f22 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -81,6 +81,7 @@ config KVM_BOOK3S_64_HV
 	depends on KVM_BOOK3S_64 && PPC_POWERNV
 	select KVM_BOOK3S_HV_POSSIBLE
 	select KVM_BOOK3S_HV_PMU
+	select VIRT_XFER_TO_GUEST_WORK
 	select CMA
 	help
 	  Support running unmodified book3s_64 guest kernels in
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..b012512342e6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3850,10 +3850,20 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 * and return without going into the guest(s).
 	 * If the mmu_ready flag has been cleared, don't go into the
 	 * guest because that means a HPT resize operation is in progress.
+	 *
+	 * xfer_to_guest_mode_work_pending() is the IRQs-disabled recheck for
+	 * pending guest-mode work (reschedule, signals, and TIF_NOTIFY_RESUME
+	 * task_work such as the deferred CFS throttle). It is the pre-POWER9
+	 * analog of the final gate in kvmhv_run_single_vcpu(), and a superset
+	 * of the old need_resched() check: it catches work that raced in after
+	 * the drain in kvmppc_run_vcpu(), so a CPU-bound vCPU is throttled here
+	 * instead of running one more guest dispatch past its quota. IRQs are
+	 * hard-disabled just above, so the non-__ variant (which asserts that)
+	 * is the correct one.
 	 */
 	local_irq_disable();
 	hard_irq_disable();
-	if (lazy_irq_pending() || need_resched() ||
+	if (lazy_irq_pending() || xfer_to_guest_mode_work_pending() ||
 	    recheck_signals_and_mmu(&core_info)) {
 		local_irq_enable();
 		vc->vcore_state = VCORE_INACTIVE;
@@ -4824,10 +4834,24 @@ static int kvmppc_run_vcpu(struct kvm_vcpu *vcpu)
 		vc->runner = vcpu;
 		if (n_ceded == vc->n_runnable) {
 			kvmppc_vcore_blocked(vc);
-		} else if (need_resched()) {
+		} else if (__xfer_to_guest_mode_work_pending()) {
 			kvmppc_vcore_preempt(vc);
-			/* Let something else run */
-			cond_resched_lock(&vc->lock);
+			/*
+			 * Let something else run, and run pending guest-mode
+			 * work (reschedule, and TIF_NOTIFY_RESUME task_work such
+			 * as the deferred CFS throttle) before we would re-enter
+			 * the guest, so a CPU-bound vCPU is actually throttled
+			 * here instead of running past its quota. This is a
+			 * superset of the old need_resched() check. Use the raw
+			 * helper, not the kvm_ wrapper: signals (KVM_EXIT_INTR
+			 * and the signal_exits stat) are accounted by this path's
+			 * existing handling below, so going through the wrapper
+			 * here would double-count them. The helper may schedule(),
+			 * so the vcore lock is dropped around it.
+			 */
+			spin_unlock(&vc->lock);
+			xfer_to_guest_mode_handle_work();
+			spin_lock(&vc->lock);
 			if (vc->vcore_state == VCORE_PREEMPT)
 				kvmppc_vcore_end_preempt(vc);
 		} else {
@@ -4899,8 +4923,21 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 		}
 	}
 
-	if (need_resched())
-		cond_resched();
+	/*
+	 * Run pending work before (re-)entering the guest, most importantly
+	 * task_work queued via TWA_RESUME (e.g. the deferred CFS bandwidth
+	 * throttle, which only sets TIF_NOTIFY_RESUME). Without this a CPU-bound
+	 * vCPU that keeps returning RESUME_GUEST never reaches an exit-to-user
+	 * point, so the throttle is never enforced and the task runs far beyond
+	 * its quota. The helper also handles reschedule and signals, replacing
+	 * the cond_resched() that was here. It may schedule(), so it runs before
+	 * preemption and IRQs are disabled, with no vcore/KVM locks held. This
+	 * is the per-reentry site shared by the bare-metal and pseries (nested)
+	 * paths, so both are covered.
+	 */
+	r = kvm_xfer_to_guest_mode_handle_work(vcpu);
+	if (r)	/* -EINTR: signal pending, exit to userspace (KVM_EXIT_INTR) */
+		return r;
 
 	kvmppc_update_vpas(vcpu);
 
@@ -4916,7 +4953,14 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	if (signal_pending(current))
 		goto sigpend;
-	if (need_resched() || !kvm->arch.mmu_ready)
+	/*
+	 * Re-check for pending guest-mode work with IRQs disabled, to catch
+	 * anything (e.g. a TIF_NOTIFY_RESUME task_work such as the deferred CFS
+	 * throttle) that raced in after the check above. Bail back to the outer
+	 * loop, which re-enters here and runs the work. This is a superset of
+	 * the previous need_resched() check.
+	 */
+	if (xfer_to_guest_mode_work_pending() || !kvm->arch.mmu_ready)
 		goto out;
 
 	vcpu->cpu = pcpu;
-- 
2.54.0


