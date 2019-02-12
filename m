Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEA0C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:00:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DED21855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="EiKYcvmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DED21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z4894jsrzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:00:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z46G5R0gzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 11:58:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="EiKYcvmn"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 43z46G4h5nz9s5c; Tue, 12 Feb 2019 11:58:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43z46G3syvz9sDr; Tue, 12 Feb 2019 11:58:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1549933126; bh=dfGqYHqqveniBa3KxQDo/sV1ciDm2pvPrUOVrW8XC7M=;
 h=Date:From:To:Cc:Subject:From;
 b=EiKYcvmnAt/foOegqtvk/TF83J0V5qOxCsJrnLJGtaetSp+PcWtD967YmEAYL9bed
 E/n4E0lXf6Gey9C54yBzw6TqqZOiSwRDZElsse+S4HksWzfnRbi74yaegbv3Dooz2d
 VHfv6+YQQGji5bKZ0FmzdeF9lUdNsRFghsdvReW10I0KCpn9YG7qOsrF02dUykkA+6
 BpUA0//RskrAbLlMgUcgCt4018AhDB6p9MDhbKEXZMbwBFAEWg5xBpji+yqNmYfY8F
 bn4mQi+Sna8a89OdT/CXMEnOJg+m3oPgqjBc7gKRlK4N/eeUL3XNAzGko4xZJgRMSw
 LWXZoMJqPqJuw==
Date: Tue, 12 Feb 2019 11:58:29 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Don't reprogram SLW image on every KVM
 guest entry/exit
Message-ID: <20190212005829.GB7353@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Michael Ellerman <michael@ellerman.id.au>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via stop-api
only on Hotplug", 2017-07-21) added two calls to opal_slw_set_reg()
inside pnv_cpu_offline(), with the aim of changing the LPCR value in
the SLW image to disable wakeups from the decrementer while a CPU is
offline.  However, pnv_cpu_offline() gets called each time a secondary
CPU thread is woken up to participate in running a KVM guest, that is,
not just when a CPU is offlined.

Since opal_slw_set_reg() is a very slow operation (with observed
execution times around 20 milliseconds), this means that an offline
secondary CPU can often be busy doing the opal_slw_set_reg() call
when the primary CPU wants to grab all the secondary threads so that
it can run a KVM guest.  This leads to messages like "KVM: couldn't
grab CPU n" being printed and guest execution failing.

There is no need to reprogram the SLW image on every KVM guest entry
and exit.  So that we do it only when a CPU is really transitioning
between online and offline, this moves the calls to
pnv_program_cpu_hotplug_lpcr() into pnv_smp_cpu_kill_self().

Fixes: 24be85a23d1f ("powerpc/powernv: Clear PECE1 in LPCR via stop-api only on Hotplug")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/powernv.h    |  2 ++
 arch/powerpc/platforms/powernv/idle.c | 27 ++-------------------------
 arch/powerpc/platforms/powernv/smp.c  | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/powernv.h b/arch/powerpc/include/asm/powernv.h
index 2f3ff7a27881..d85fcfea32ca 100644
--- a/arch/powerpc/include/asm/powernv.h
+++ b/arch/powerpc/include/asm/powernv.h
@@ -23,6 +23,8 @@ extern int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 				unsigned long *flags, unsigned long *status,
 				int count);
 
+void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val);
+
 void pnv_tm_init(void);
 #else
 static inline void powernv_set_nmmu_ptcr(unsigned long ptcr) { }
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 35f699ebb662..e52f9b06dd9c 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -458,7 +458,8 @@ EXPORT_SYMBOL_GPL(pnv_power9_force_smt4_release);
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #ifdef CONFIG_HOTPLUG_CPU
-static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
+
+void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
 {
 	u64 pir = get_hard_smp_processor_id(cpu);
 
@@ -481,20 +482,6 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 {
 	unsigned long srr1;
 	u32 idle_states = pnv_get_supported_cpuidle_states();
-	u64 lpcr_val;
-
-	/*
-	 * We don't want to take decrementer interrupts while we are
-	 * offline, so clear LPCR:PECE1. We keep PECE2 (and
-	 * LPCR_PECE_HVEE on P9) enabled as to let IPIs in.
-	 *
-	 * If the CPU gets woken up by a special wakeup, ensure that
-	 * the SLW engine sets LPCR with decrementer bit cleared, else
-	 * the CPU will come back to the kernel due to a spurious
-	 * wakeup.
-	 */
-	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
-	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
 
 	__ppc64_runlatch_off();
 
@@ -526,16 +513,6 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 
 	__ppc64_runlatch_on();
 
-	/*
-	 * Re-enable decrementer interrupts in LPCR.
-	 *
-	 * Further, we want stop states to be woken up by decrementer
-	 * for non-hotplug cases. So program the LPCR via stop api as
-	 * well.
-	 */
-	lpcr_val = mfspr(SPRN_LPCR) | (u64)LPCR_PECE1;
-	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
-
 	return srr1;
 }
 #endif
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 0d354e19ef92..db09c7022635 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -39,6 +39,7 @@
 #include <asm/cpuidle.h>
 #include <asm/kexec.h>
 #include <asm/reg.h>
+#include <asm/powernv.h>
 
 #include "powernv.h"
 
@@ -153,6 +154,7 @@ static void pnv_smp_cpu_kill_self(void)
 {
 	unsigned int cpu;
 	unsigned long srr1, wmask;
+	u64 lpcr_val;
 
 	/* Standard hot unplug procedure */
 	/*
@@ -174,6 +176,19 @@ static void pnv_smp_cpu_kill_self(void)
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		wmask = SRR1_WAKEMASK_P8;
 
+	/*
+	 * We don't want to take decrementer interrupts while we are
+	 * offline, so clear LPCR:PECE1. We keep PECE2 (and
+	 * LPCR_PECE_HVEE on P9) enabled so as to let IPIs in.
+	 *
+	 * If the CPU gets woken up by a special wakeup, ensure that
+	 * the SLW engine sets LPCR with decrementer bit cleared, else
+	 * the CPU will come back to the kernel due to a spurious
+	 * wakeup.
+	 */
+	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
+	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
+
 	while (!generic_check_cpu_restart(cpu)) {
 		/*
 		 * Clear IPI flag, since we don't handle IPIs while
@@ -246,6 +261,16 @@ static void pnv_smp_cpu_kill_self(void)
 
 	}
 
+	/*
+	 * Re-enable decrementer interrupts in LPCR.
+	 *
+	 * Further, we want stop states to be woken up by decrementer
+	 * for non-hotplug cases. So program the LPCR via stop api as
+	 * well.
+	 */
+	lpcr_val = mfspr(SPRN_LPCR) | (u64)LPCR_PECE1;
+	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
+
 	DBG("CPU%d coming online...\n", cpu);
 }
 
-- 
2.11.0

