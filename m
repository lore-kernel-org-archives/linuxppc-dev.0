Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0FAC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:48:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984A420693
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 16:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984A420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Zpmp391SzDqP1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 03:48:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Zphn5c86zDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 03:45:13 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACF3B3005148;
 Thu,  4 Apr 2019 16:45:11 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AED0608EB;
 Thu,  4 Apr 2019 16:45:08 +0000 (UTC)
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Date: Thu,  4 Apr 2019 11:44:12 -0500
Message-Id: <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1554396090.git.jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 04 Apr 2019 16:45:12 +0000 (UTC)
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Configure x86 runtime CPU speculation bug mitigations in accordance with
the 'cpu_spec_mitigations=' cmdline options.  This affects Meltdown,
Spectre v2, Speculative Store Bypass, and L1TF.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 15 +++++++++
 arch/x86/include/asm/processor.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++++++---
 arch/x86/kvm/vmx/vmx.c                        |  2 ++
 arch/x86/mm/pti.c                             |  4 ++-
 5 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ac42e510bd6e..29dc03971630 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2552,6 +2552,11 @@
 
 			off
 				Disable all speculative CPU mitigations.
+				Equivalent to: nopti [x86]
+					       nospectre_v2 [x86]
+					       spectre_v2_user=off [x86]
+					       spec_store_bypass_disable=off [x86]
+					       l1tf=off [x86]
 
 			auto (default)
 				Mitigate all speculative CPU vulnerabilities,
@@ -2560,12 +2565,22 @@
 				surprised by SMT getting disabled across kernel
 				upgrades, or who have other ways of avoiding
 				SMT-based attacks.
+				Equivalent to: pti=auto [x86]
+					       spectre_v2=auto [x86]
+					       spectre_v2_user=auto [x86]
+					       spec_store_bypass_disable=auto [x86]
+					       l1tf=flush [x86]
 
 			auto,nosmt
 				Mitigate all speculative CPU vulnerabilities,
 				disabling SMT if needed.  This is for users who
 				always want to be fully mitigated, even if it
 				means losing SMT.
+				Equivalent to: pti=auto [x86]
+					       spectre_v2=auto [x86]
+					       spectre_v2_user=auto [x86]
+					       spec_store_bypass_disable=auto [x86]
+					       l1tf=flush,nosmt [x86]
 
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2bb3a648fc12..7e95b310f869 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -982,6 +982,7 @@ void microcode_check(void);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
+	L1TF_MITIGATION_DEFAULT,
 	L1TF_MITIGATION_FLUSH_NOWARN,
 	L1TF_MITIGATION_FLUSH,
 	L1TF_MITIGATION_FLUSH_NOSMT,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2da82eff0eb4..65b95fb95ba5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -308,8 +308,11 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
-	if (ret < 0)
+	if (ret < 0) {
+		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
+			return SPECTRE_V2_USER_CMD_NONE;
 		return SPECTRE_V2_USER_CMD_AUTO;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -444,8 +447,11 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
-	if (ret < 0)
+	if (ret < 0) {
+		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
+			return SPECTRE_V2_CMD_NONE;
 		return SPECTRE_V2_CMD_AUTO;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -677,8 +683,11 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	} else {
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
-		if (ret < 0)
+		if (ret < 0) {
+			if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
+				return SPEC_STORE_BYPASS_CMD_NONE;
 			return SPEC_STORE_BYPASS_CMD_AUTO;
+		}
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -955,7 +964,7 @@ void x86_spec_ctrl_setup_ap(void)
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_DEFAULT;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
@@ -1010,8 +1019,23 @@ static void __init l1tf_select_mitigation(void)
 
 	override_cache_bits(&boot_cpu_data);
 
+	if (l1tf_mitigation == L1TF_MITIGATION_DEFAULT) {
+		switch (cpu_spec_mitigations) {
+		case CPU_SPEC_MITIGATIONS_OFF:
+			l1tf_mitigation = L1TF_MITIGATION_OFF;
+			break;
+		case CPU_SPEC_MITIGATIONS_AUTO:
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+			break;
+		case CPU_SPEC_MITIGATIONS_AUTO_NOSMT:
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+			break;
+		}
+	}
+
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
+	case L1TF_MITIGATION_DEFAULT:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
 	case L1TF_MITIGATION_FLUSH:
 		break;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab432a930ae8..83b5bdc3c777 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -233,6 +233,7 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
+		case L1TF_MITIGATION_DEFAULT:
 			l1tf = VMENTER_L1D_FLUSH_COND;
 			break;
 		case L1TF_MITIGATION_FULL:
@@ -6686,6 +6687,7 @@ static int vmx_vm_init(struct kvm *kvm)
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
 		case L1TF_MITIGATION_FULL:
+		case L1TF_MITIGATION_DEFAULT:
 			/*
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 139b28a01ce4..6d3bf680bf95 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/cpu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/hypervisor.h>
@@ -115,7 +116,8 @@ void __init pti_check_boottime_disable(void)
 		}
 	}
 
-	if (cmdline_find_option_bool(boot_command_line, "nopti")) {
+	if (cmdline_find_option_bool(boot_command_line, "nopti") ||
+	    cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF) {
 		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on command line.");
 		return;
-- 
2.17.2

