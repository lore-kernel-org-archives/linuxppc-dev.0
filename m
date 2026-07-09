Return-Path: <linuxppc-dev+bounces-23973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55DFC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx8cg2WsRz2xnp;
	Fri, 10 Jul 2026 08:23:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783635811;
	cv=none; b=Hsb3unkSA7MCb0OLfOze+n0jEAOetFEh5EX6WX1NKPA1OuVWn+lo/6AfehnR0C94PPxjaolIeVlV/rq7foy9Iv2hiLTXv4c5GKcXtPnAPh1wrf4EfBYmCJDbG1uE8KX/fxM4iCcD8deXbadmv0lW4+O6HDr1S8p6fLcoPC+zofcSzwSn5L2yV0Hs0TUWaIzO+ywv8shy4lVqElrUTitXQjxgVZAZWDr+SThN3piupxzJTeDyLbsXtgCF2iPtOV+OTzu9U+1ZT9OQvPIq82dw4zcNIRJBtZC6kOkDyL7wm+q4fF5MaPx9quvLej/jwQGQ0rM/vmIIgb1V1isNn6z8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783635811; c=relaxed/relaxed;
	bh=DgoLeZ0/25+A0/8D/NxLiDPJvKV6h8IrJAxWnjH2sT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooO1jaow2BGUQHnoOpYbhv85f099lvCYXPLRwBfuSjqe3lk/R5hvkApggapLIU0ZCFd9O+w9+GhZk5xe2z1RdTFOPAdzlhFqGwyV+oOmD4jw/BvU9nEYyVXS6TTU7U4LHhWmvWEY8zDjjO+I67DLxnbEavMASbnt7eRc8yedjfkO1gLP5YyulcO3ndjYNs4aECohvlOG/cmdH777r11ifN19qfTTCLtFloJU4aP0pytYVf1sYk4rofv8VU4g+EgqQ/ugAN7hzNXZwFDvHH6bg8hRkP6KW5/xVYE5fEgCn1A1bXljVEGwFlGWVc0vNNnYf4UP7EhZe9Rbqnl9gnQJXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gJiv51/f; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gJiv51/f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx8cd5K78z2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:23:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635810; x=1815171810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxx6q3PaUXThy7077PBdEcj1YAhyEf5rMxD7v3MrfBU=;
  b=gJiv51/fvROrzJOFJqsqQ3f+uV0aGlrgPQtMy/2xsm+2bhV4U40yFf7/
   1fEobFgHvUCwfbJswwPdQxX6ARg6woDys8EnWFciOqAH3fJHrIKLfEe4q
   uWiV4Gj0jrQFB9MTLKvtN/56gyIMI5ItgPRaU0k4Mzn1yLTgw26p7+luq
   8HveFN9rvf5q+hldPatkSSI1Gt2v/Btfncv7s7VS/kLp+CnVximqi5aw8
   XkIj6OUctqG+tbd7LVvqdLP58r98WzF5FWTmMWAhzKJ7ORhPUAp6Ba5df
   Q/iXxtrcrWoprVpfO2IynDVGA5pHqJ4dh0EZnqEwShoxP564WNxC6KCSV
   A==;
X-CSE-ConnectionGUID: 0mIV3WHSSOCAtspG9oIlBw==
X-CSE-MsgGUID: XYsL1ruNRXG8V7CJ32Jh6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84213679"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84213679"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:23:26 -0700
X-CSE-ConnectionGUID: quniZ9VdSxak3XEDt5pNeA==
X-CSE-MsgGUID: 8t1vTq8uS3mfFzTFwhmBFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248335410"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:23:26 -0700
Date: Thu, 9 Jul 2026 15:23:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 7.1.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT allocation
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-2-5ac5a2d6797f@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>

commit a3af84b0fa00ead01fcd0e28b5d773ff25990a0d upstream.

Enable hardening against JIT spraying when Spectre-v2 mitigations are in
use. Specifically, issue an IBPB flush on BPF JIT memory reuse. Skip
enabling the IBPB flush if the BPF dispatcher is already using a retpoline
sequence.

This hardening applies only when BPF-JIT is in use. Guard the enabling
under CONFIG_BPF_JIT so that bugs.c still builds with CONFIG_BPF_JIT=n.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 ++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4f4b5e8a1574..b68892e6d58c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -388,6 +388,10 @@ extern void srso_alias_return_thunk(void);
 extern void entry_untrain_ret(void);
 extern void write_ibpb(void);
 
+#ifdef CONFIG_BPF_JIT
+extern void bpf_arch_ibpb(void);
+#endif
+
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..d9af230c0512 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/kvm_types.h>
 
 #include <asm/spec-ctrl.h>
@@ -1651,8 +1652,21 @@ static inline const char *spectre_v2_module_string(void)
 {
 	return spectre_v2_bad_module ? " - vulnerable module loaded" : "";
 }
+
+/*
+ * The "retpoline sequence" is the "call;mov;ret" sequence that
+ * replaces normal indirect branch instructions. Differentiate
+ * *the* retpoline sequence from the LFENCE-prefixed indirect
+ * branches that simply use the retpoline infrastructure.
+ */
+static inline bool retpoline_seq_enabled(void)
+{
+	return boot_cpu_has(X86_FEATURE_RETPOLINE) && !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE);
+}
+
 #else
 static inline const char *spectre_v2_module_string(void) { return ""; }
+static inline bool retpoline_seq_enabled(void) { return false; }
 #endif
 
 #define SPECTRE_V2_LFENCE_MSG "WARNING: LFENCE mitigation is not recommended for this CPU, data leaks possible!\n"
@@ -2095,8 +2109,7 @@ static void __init bhi_apply_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (retpoline_seq_enabled()) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2238,6 +2251,27 @@ static void __init spectre_v2_update_mitigation(void)
 		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
 
+#ifdef CONFIG_BPF_JIT
+static void __bpf_arch_ibpb(void *unused)
+{
+	write_ibpb();
+}
+
+void bpf_arch_ibpb(void)
+{
+	on_each_cpu(__bpf_arch_ibpb, NULL, 1);
+}
+
+static bool __init cpu_wants_ibpb_bpf(void)
+{
+	/* A genuine retpoline already neutralizes ring0 indirect predictions */
+	if (retpoline_seq_enabled())
+		return false;
+
+	return boot_cpu_has(X86_FEATURE_IBPB);
+}
+#endif
+
 static void __init spectre_v2_apply_mitigation(void)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
@@ -2314,6 +2348,14 @@ static void __init spectre_v2_apply_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
+
+#ifdef CONFIG_BPF_JIT
+	if (cpu_wants_ibpb_bpf()) {
+		static_call_update(bpf_arch_pred_flush, bpf_arch_ibpb);
+		static_branch_enable(&bpf_pred_flush_enabled);
+		pr_info("Enabling IBPB for BPF\n");
+	}
+#endif
 }
 
 static void update_stibp_msr(void * __unused)
@@ -3490,9 +3532,7 @@ static const char *spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
-		 rrsba_disabled)
+	else if (retpoline_seq_enabled() && rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";

-- 
2.43.0



