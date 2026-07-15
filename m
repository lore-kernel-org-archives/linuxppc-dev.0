Return-Path: <linuxppc-dev+bounces-24305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A6C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 21:28:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0q665ShRz303X;
	Thu, 16 Jul 2026 07:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784150894;
	cv=none; b=cCr+Hr3ggDtpxpwjuViL8onZ/PLRpykwtXdis2fw7OnycYP7V3azeVmnOn9ZBsuy0y3ITYoG0VQCuHSfQNYVEKwg5UWHglBRyyizg+G4ccYp4lnr80wCCWLO3kLO7/93qbsB+OJVaKBDDaTCTtWjYATYvahEdHaxQlL43t0MTP6vsvm7tuFtPrYIkqeT2zd3UjRYkRKtLrfQLXFlMOMIcexHtIt/qK9UkNnTmfVcI4GTtVoJeO3QfGR2ee4dswxwUBdgg1alNXDELcsE+A1rskbucUvfxUSXOFHf9VZaq/+lXGLImuh4c4OMcbW2gKS1Usc9TVxHRhFwvE8J7lQ1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784150894; c=relaxed/relaxed;
	bh=hf1hfqS8wYmbHhO48A8LkaMU6pOZwkPB1ucKmJ9h4vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJT9Estn7R5s7HdNE9T8nPpavaS6xHIv54WZJuqNQU1z8K40Uj7cq7t/6CLLuspg5kPN072Gvqn8M4lQ1RKfUgUwIiD/mG5hpAULMWNTZouxdgXgP8jB1qJOTJQsvPV8N6rnaFokI9USbydxHjT1VyN+J8AYc7zBHy9RRQRABjsdypA4h/oKBKrtsfntaPQ5fb7DUFBUAtH+qEmfzH+tkX9lymIxdt+Fdxz6vYyYLmf8jmTurRuZ0q0lZDZEou5JsxS7kgE1lP9WQb3MbweHsnEFG549LI+a98+D9DjkcZQ/cc8tdDhpqfE2DubscC582JU2Qsl0FnVSP73TVBreig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ILHf2jW9; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ILHf2jW9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0q6545cDz2ywn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 07:28:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784150894; x=1815686894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HMjVlSfmfpM/URLl6ilanx3x2avTx9DJMkDh0cQRLF8=;
  b=ILHf2jW9CFVmnZPvY6/PhVcJQF0JNCyyJcHTqivRwwPLI4pMhJq5qL4w
   J3wQwwAmYPzYMUlVpMoboNHGoi9VtjL8cApjmKirH61cJl0xz5odPBLPl
   296+rmzbD6DBYGxOBmGbxKM94jVOGO7H2VWKjj5USmRfA4rBj3zwmzfGZ
   w0sJYe0g7Mnmyk2yRPcvl3Vx5dfrY67wQhMMkW9iz5BLJoEdh0LagQs48
   aQMyHjZ9zsCS+/8UCzJYaMVsxEAugFR/nWSGO8ZriRGR4nLKfBhImTX+/
   LjJNrYTM2uGfiqsbGPgc9JQBXEFxKuZFxw44Td3rJZUDb5rJfA3mCrXhW
   Q==;
X-CSE-ConnectionGUID: ym4rAur2RNOhPjsBCenOLQ==
X-CSE-MsgGUID: alzu+nAyR1iLKngZKovMQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88632016"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88632016"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:28:10 -0700
X-CSE-ConnectionGUID: pRvCTwlhRUejcRZf+qZz6w==
X-CSE-MsgGUID: Jc70PhqsQhCmCGcP4OUcTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="254546902"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:28:10 -0700
Date: Wed, 15 Jul 2026 14:28:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.12.y 2/6] x86/bugs: Enable IBPB flush on BPF JIT allocation
Message-ID: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-2-d8585a9aed80@linux.intel.com>
X-Mailer: b4 0.16-dev
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
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
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>

commit a3af84b0fa00ead01fcd0e28b5d773ff25990a0d upstream.

Enable hardening against JIT spraying when Spectre-v2 mitigations are in
use. Specifically, issue an IBPB flush on BPF JIT memory reuse. Skip
enabling the IBPB flush if the BPF dispatcher is already using a retpoline
sequence.

This hardening applies only when BPF-JIT is in use. Guard the enabling
under CONFIG_BPF_JIT so that bugs.c still builds with CONFIG_BPF_JIT=n.

  [ pawan: Use entry_ibpb() instead of write_ibpb(). JIT hardening enable
	   moved to spectre_v2_select_mitigation() because there is no
	   spectre_v2_apply_mitigation()]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 ++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f2cc7754918c..2e0812a8ed77 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -405,6 +405,10 @@ extern void srso_alias_return_thunk(void);
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
+#ifdef CONFIG_BPF_JIT
+extern void bpf_arch_ibpb(void);
+#endif
+
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
 #endif
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 939401b5d2ef..12544fdcadd6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -16,6 +16,7 @@
 #include <linux/sched/smt.h>
 #include <linux/pgtable.h>
 #include <linux/bpf.h>
+#include <linux/filter.h>
 
 #include <asm/spec-ctrl.h>
 #include <asm/cmdline.h>
@@ -1360,8 +1361,21 @@ static inline const char *spectre_v2_module_string(void)
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
@@ -1843,8 +1857,7 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (retpoline_seq_enabled()) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -1868,6 +1881,27 @@ static void __init bhi_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 }
 
+#ifdef CONFIG_BPF_JIT
+static void __bpf_arch_ibpb(void *unused)
+{
+	entry_ibpb();
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
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -2051,6 +2085,14 @@ static void __init spectre_v2_select_mitigation(void)
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
 
+#ifdef CONFIG_BPF_JIT
+	if (cpu_wants_ibpb_bpf()) {
+		static_call_update(bpf_arch_pred_flush, bpf_arch_ibpb);
+		static_branch_enable(&bpf_pred_flush_enabled);
+		pr_info("Enabling IBPB for BPF\n");
+	}
+#endif
+
 	/* Set up IBPB and STIBP depending on the general spectre V2 command */
 	spectre_v2_cmd = cmd;
 }
@@ -3239,9 +3281,7 @@ static const char *spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
-		 rrsba_disabled)
+	else if (retpoline_seq_enabled() && rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";

-- 
2.43.0



