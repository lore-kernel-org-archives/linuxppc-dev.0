Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C96C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:13:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799742084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="pkK8wtdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799742084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qtcq0zy1zF3LN
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:13:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="pkK8wtdo";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qrvk2cZlzF3Jq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="pkK8wtdo"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qrvk0y19z9sBj; Thu,  4 Oct 2018 21:56:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Qrvj4kfczB4NM;
 Thu,  4 Oct 2018 21:56:33 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654193; bh=tMXhWrTA1aKUCNW3ricl1zy1H84baG+t1RR3Ajq2pUE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pkK8wtdoeOmT2n3b2cd6h3XlO0iuuKN5z8DLzGwSjiSv2zzoyG6NPseNNS9qjBn8I
 zqYc81ducf09ENSiJRKiPFgd14alCiUVIQ16bM7EnjY7ht/Hd4V0skI4e6NEJgd+aZ
 DKm9RUzUubmKF9ze/+gYNT8DHmUtflfRF6ARagi7SRSLRHdI3J5iCpLIWEvxSB8re5
 +seUAparWTnLSCEZkousY4EIUdwrrdfS1hy9IvlGqKva6qW2g3Zp5n7lcg0pY/dpVM
 bsh16Q5F8f3nexZXJbqCzs0rt2X7lp3pi95zLj4l/sc63v+Mibf4T+fySZ5gIPH4er
 VEIHc346bWOaw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 25/32] KVM: PPC: Book3S HV: Invalidate TLB when nested vcpu
 moves physical cpu
Date: Thu,  4 Oct 2018 21:56:02 +1000
Message-Id: <1538654169-15602-26-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This is only done at level 0, since only level 0 knows which physical
CPU a vcpu is running on.  This does for nested guests what L0 already
did for its own guests, which is to flush the TLB on a pCPU when it
goes to run a vCPU there, and there is another vCPU in the same VM
which previously ran on this pCPU and has now started to run on another
pCPU.  This is to handle the situation where the other vCPU touched
a mapping, moved to another pCPU and did a tlbiel (local-only tlbie)
on that new pCPU and thus left behind a stale TLB entry on this pCPU.

This introduces a limit on the the vcpu_token values used in the
H_ENTER_NESTED hcall -- they must now be less than NR_CPUS.

[paulus@ozlabs.org - made prev_cpu array be unsigned short[] to reduce
 memory consumption.]

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   3 +
 arch/powerpc/kvm/book3s_hv.c             | 101 +++++++++++++++++++------------
 arch/powerpc/kvm/book3s_hv_nested.c      |   5 ++
 3 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index aa5bf85..1e96027 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -52,6 +52,9 @@ struct kvm_nested_guest {
 	long refcnt;			/* number of pointers to this struct */
 	struct mutex tlb_lock;		/* serialize page faults and tlbies */
 	struct kvm_nested_guest *next;
+	cpumask_t need_tlb_flush;
+	cpumask_t cpu_in_guest;
+	unsigned short prev_cpu[NR_CPUS];
 };
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ba58883..53a967ea 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2397,10 +2397,18 @@ static void kvmppc_release_hwthread(int cpu)
 
 static void radix_flush_cpu(struct kvm *kvm, int cpu, struct kvm_vcpu *vcpu)
 {
+	struct kvm_nested_guest *nested = vcpu->arch.nested;
+	cpumask_t *cpu_in_guest;
 	int i;
 
 	cpu = cpu_first_thread_sibling(cpu);
-	cpumask_set_cpu(cpu, &kvm->arch.need_tlb_flush);
+	if (nested) {
+		cpumask_set_cpu(cpu, &nested->need_tlb_flush);
+		cpu_in_guest = &nested->cpu_in_guest;
+	} else {
+		cpumask_set_cpu(cpu, &kvm->arch.need_tlb_flush);
+		cpu_in_guest = &kvm->arch.cpu_in_guest;
+	}
 	/*
 	 * Make sure setting of bit in need_tlb_flush precedes
 	 * testing of cpu_in_guest bits.  The matching barrier on
@@ -2408,13 +2416,23 @@ static void radix_flush_cpu(struct kvm *kvm, int cpu, struct kvm_vcpu *vcpu)
 	 */
 	smp_mb();
 	for (i = 0; i < threads_per_core; ++i)
-		if (cpumask_test_cpu(cpu + i, &kvm->arch.cpu_in_guest))
+		if (cpumask_test_cpu(cpu + i, cpu_in_guest))
 			smp_call_function_single(cpu + i, do_nothing, NULL, 1);
 }
 
 static void kvmppc_prepare_radix_vcpu(struct kvm_vcpu *vcpu, int pcpu)
 {
+	struct kvm_nested_guest *nested = vcpu->arch.nested;
 	struct kvm *kvm = vcpu->kvm;
+	int prev_cpu;
+
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		return;
+
+	if (nested)
+		prev_cpu = nested->prev_cpu[vcpu->arch.nested_vcpu_id];
+	else
+		prev_cpu = vcpu->arch.prev_cpu;
 
 	/*
 	 * With radix, the guest can do TLB invalidations itself,
@@ -2428,12 +2446,46 @@ static void kvmppc_prepare_radix_vcpu(struct kvm_vcpu *vcpu, int pcpu)
 	 * ran to flush the TLB.  The TLB is shared between threads,
 	 * so we use a single bit in .need_tlb_flush for all 4 threads.
 	 */
-	if (vcpu->arch.prev_cpu != pcpu) {
-		if (vcpu->arch.prev_cpu >= 0 &&
-		    cpu_first_thread_sibling(vcpu->arch.prev_cpu) !=
+	if (prev_cpu != pcpu) {
+		if (prev_cpu >= 0 &&
+		    cpu_first_thread_sibling(prev_cpu) !=
 		    cpu_first_thread_sibling(pcpu))
-			radix_flush_cpu(kvm, vcpu->arch.prev_cpu, vcpu);
-		vcpu->arch.prev_cpu = pcpu;
+			radix_flush_cpu(kvm, prev_cpu, vcpu);
+		if (nested)
+			nested->prev_cpu[vcpu->arch.nested_vcpu_id] = pcpu;
+		else
+			vcpu->arch.prev_cpu = pcpu;
+	}
+}
+
+static void kvmppc_radix_check_need_tlb_flush(struct kvm *kvm, int pcpu,
+					      struct kvm_nested_guest *nested)
+{
+	cpumask_t *need_tlb_flush;
+	int lpid;
+
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		return;
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		pcpu &= ~0x3UL;
+
+	if (nested) {
+		lpid = nested->shadow_lpid;
+		need_tlb_flush = &nested->need_tlb_flush;
+	} else {
+		lpid = kvm->arch.lpid;
+		need_tlb_flush = &kvm->arch.need_tlb_flush;
+	}
+
+	mtspr(SPRN_LPID, lpid);
+	isync();
+	smp_mb();
+
+	if (cpumask_test_cpu(pcpu, need_tlb_flush)) {
+		radix__local_flush_tlb_lpid_guest(lpid);
+		/* Clear the bit after the TLB flush */
+		cpumask_clear_cpu(pcpu, need_tlb_flush);
 	}
 }
 
@@ -3127,8 +3179,6 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		spin_unlock(&core_info.vc[sub]->lock);
 
 	if (kvm_is_radix(vc->kvm)) {
-		int tmp = pcpu;
-
 		/*
 		 * Do we need to flush the process scoped TLB for the LPAR?
 		 *
@@ -3139,17 +3189,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		 *
 		 * Hash must be flushed in realmode in order to use tlbiel.
 		 */
-		mtspr(SPRN_LPID, vc->kvm->arch.lpid);
-		isync();
-
-		if (cpu_has_feature(CPU_FTR_ARCH_300))
-			tmp &= ~0x3UL;
-
-		if (cpumask_test_cpu(tmp, &vc->kvm->arch.need_tlb_flush)) {
-			radix__local_flush_tlb_lpid_guest(vc->kvm->arch.lpid);
-			/* Clear the bit after the TLB flush */
-			cpumask_clear_cpu(tmp, &vc->kvm->arch.need_tlb_flush);
-		}
+		kvmppc_radix_check_need_tlb_flush(vc->kvm, pcpu, NULL);
 	}
 
 	/*
@@ -3868,11 +3908,10 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 			  struct kvm_vcpu *vcpu, u64 time_limit,
 			  unsigned long lpcr)
 {
-	int trap, r, pcpu, pcpu0;
+	int trap, r, pcpu;
 	int srcu_idx;
 	struct kvmppc_vcore *vc;
 	struct kvm_nested_guest *nested = vcpu->arch.nested;
-	unsigned long lpid;
 
 	trace_kvmppc_run_vcpu_enter(vcpu);
 
@@ -3945,22 +3984,8 @@ int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
 	vc->vcore_state = VCORE_RUNNING;
 	trace_kvmppc_run_core(vc, 0);
 
-	lpid = vc->kvm->arch.lpid;
-	if (nested)
-		lpid = nested->shadow_lpid;
-	mtspr(SPRN_LPID, lpid);
-	isync();
-
-	/* See comment above in kvmppc_run_core() about this */
-	pcpu0 = pcpu;
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		pcpu0 &= ~0x3UL;
-
-	if (cpumask_test_cpu(pcpu0, &vc->kvm->arch.need_tlb_flush)) {
-		radix__local_flush_tlb_lpid_guest(lpid);
-		/* Clear the bit after the TLB flush */
-		cpumask_clear_cpu(pcpu0, &vc->kvm->arch.need_tlb_flush);
-	}
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		kvmppc_radix_check_need_tlb_flush(vc->kvm, pcpu, nested);
 
 	trace_hardirqs_on();
 	guest_enter_irqoff();
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 35f8111..1a8c40d 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -167,6 +167,9 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	if (err)
 		return H_PARAMETER;
 
+	if (l2_hv.vcpu_token >= NR_CPUS)
+		return H_PARAMETER;
+
 	/* translate lpid */
 	l2 = kvmhv_get_nested(vcpu->kvm, l2_hv.lpid, true);
 	if (!l2)
@@ -411,6 +414,8 @@ struct kvm_nested_guest *kvmhv_alloc_nested(struct kvm *kvm, unsigned int lpid)
 		goto out_free2;
 	gp->shadow_lpid = shadow_lpid;
 
+	memset(gp->prev_cpu, -1, sizeof(gp->prev_cpu));
+
 	return gp;
 
  out_free2:
-- 
2.7.4

