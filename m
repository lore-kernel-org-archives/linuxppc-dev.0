Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB19EC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 17:11:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EB921928
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 17:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc9O97dG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EB921928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LwCc01WHzDqv4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:11:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wc9O97dG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wc9O97dG"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Lw8j2LbmzDqdP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 04:09:24 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y4so2762037pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=oLq1RySX5DcvDMbOEFP5BgSrya9SEq7fEhR/fJs7t54=;
 b=Wc9O97dGrI8DorsGOFrj3IPj5p4amAAEushjQvvVS7trQSgkTb59Cyf+GWi2aaIcDn
 2ANMTd8m++m0057k5kxXBaH8oILzUyc1f++bNxHtnsrzQ3qCndQkYyYYLS93XlRth7qS
 jBnLhu3kAdqcEduzIKwIv+8wiNM1RCfAmARb6371LQTsu2NFUQgpkG9V3kU4voTopa7C
 H97aDoImxWC+FfC+IFfL9auQ0YJOyjCppab4ufUbXUREVp4bdCHi/8j8Xq0GARMYJ7Xz
 qBg4TTt+lR0r1SM2QfjQp6fw7ZcnlT0zqKAV47E2y4Rsz8qLke4IXO3a14MIDUPVEEgd
 HfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=oLq1RySX5DcvDMbOEFP5BgSrya9SEq7fEhR/fJs7t54=;
 b=EaF000rG8KJBt0cyIj9qZmGbVrs5b/keo2bbzJBh+0uaXqGM5WHxvqMZq493GpAwov
 1ywQ7PL/ue/00uzPjq5iosmlxMrM7UWfW4Yo7XPYnuK9D//OslVrrglV0AfmSGzt4Cwn
 FxwZasYCYwNC1Rc64ZXHKLZTm+JJ0/ywYywUXe/c453Rkq6EFpx4SBYuIbtWbL/3tO8+
 SJMVa9ymKM51b1xiSLmazaORvta/oRRJ8nYZzWEeAyKf9NTXZbndRE00GN69d4JmjkZX
 FJEeCrP+qRjbobd2J4p2QYpyyS0Uj02W1YUufvhKOF/g/fYV5Gto2d2//ibF7ShHcAV1
 d/6Q==
X-Gm-Message-State: AA+aEWYJtADcleaFpWbE+f59VUicJaJph+pIbahB0cB+1jDf9VQeU2Y2
 uk5+xdtALzoo0KqAXTop5U2AB01O
X-Google-Smtp-Source: AFSGD/Xa9WjOOV+/DKbLhiTLsyGt2sEDF8YBdqlXlMrtcN6VnAKsgpI7U6QyVz9hmX4NarKber+m5A==
X-Received: by 2002:a62:5182:: with SMTP id f124mr3364050pfb.238.1545412162004; 
 Fri, 21 Dec 2018 09:09:22 -0800 (PST)
Received: from roar.ibm.com (14-202-191-79.tpgi.com.au. [14.202.191.79])
 by smtp.gmail.com with ESMTPSA id b68sm36483630pfg.160.2018.12.21.09.09.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Dec 2018 09:09:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc/powernv: move OPAL call wrapper tracing and
 interrupt handling to C
Date: Sat, 22 Dec 2018 03:09:02 +1000
Message-Id: <20181221170902.18982-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
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
Cc: Stewart Smith <stewart@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The OPAL call wrapper gets interrupt disabling wrong. It disables
interrupts just by clearing MSR[EE], which has two problems:

- It doesn't call into the IRQ tracing subsystem, which means tracing
  across OPAL calls does not always notice IRQs have been disabled.

- It doesn't go through the IRQ soft-mask code, which causes a minor
  bug. MSR[EE] can not be restored by saving the MSR then clearing
  MSR[EE], because a racing interrupt while soft-masked because a
  masked interrupt could race and clear MSR[EE] between the two steps.
  This can cause MSR[EE] to be incorrectly enabled when the OPAL call
  returns. Fortunately that should just take an interrupt and re-run
  the masked handler to fix things, but it's sloppy.

The wapper also saves MSR to PACA, which is not re-entrant if the
nested MSRs does not match, which could be a problem if a SRESET
interrupts a real-mode call, for example.

To fix this, move the tracing and IRQ handling code to C, and call
into asm when everything is ready to go. Save MSR on stack.

Performance cost is kept to a minimum with a few optimisations,

- The endian switch upon return is combined with the MSR restore,
  which avoids an expensive context synchronizing operation for LE
  kernels. This makes up for the additional mtmsrd to enable
  interrupts with local_irq_enable().

- The bl/blr branches are balanced to avoid link stack corruption and
  reduce mispredicts. This requires a skiboot link stack fix as well.

Even so, a NULL call goes from 410ns to 430ns (POWER9) after this.
I would have expected it to come out much closer or even a little
ahead, can't see why it's ~70 cycles slower. Might have to do some
trace analysis.
---
 arch/powerpc/include/asm/asm-prototypes.h     |  10 +-
 arch/powerpc/platforms/powernv/Makefile       |   5 +-
 arch/powerpc/platforms/powernv/opal-call.c    | 277 ++++++++++++++
 .../platforms/powernv/opal-tracepoints.c      |  88 -----
 .../powerpc/platforms/powernv/opal-wrappers.S | 344 ++----------------
 5 files changed, 322 insertions(+), 402 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-call.c
 delete mode 100644 arch/powerpc/platforms/powernv/opal-tracepoints.c

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index ec691d489656..4c0599e5bfaf 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -37,13 +37,11 @@ void kexec_copy_flush(struct kimage *image);
 extern struct static_key hcall_tracepoint_key;
 void __trace_hcall_entry(unsigned long opcode, unsigned long *args);
 void __trace_hcall_exit(long opcode, long retval, unsigned long *retbuf);
-/* OPAL tracing */
-#ifdef HAVE_JUMP_LABEL
-extern struct static_key opal_tracepoint_key;
-#endif
 
-void __trace_opal_entry(unsigned long opcode, unsigned long *args);
-void __trace_opal_exit(long opcode, unsigned long retval);
+/* OPAL */
+int64_t __opal_call(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+		    int64_t a4, int64_t a5, int64_t a6, int64_t a7,
+		    int64_t opcode, uint64_t msr);
 
 /* VMX copying */
 int enter_vmx_usercopy(void);
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b540ce8eec55..da2e99efbd04 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
-obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
+obj-y			+= setup.o opal-call.o opal-wrappers.o opal.o opal-async.o
+obj-y			+= idle.o opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
@@ -11,7 +11,6 @@ obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
-obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
 obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
new file mode 100644
index 000000000000..172fea114a92
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/percpu.h>
+#include <linux/jump_label.h>
+#include <asm/opal-api.h>
+#include <asm/trace.h>
+#include <asm/asm-prototypes.h>
+
+#ifdef CONFIG_TRACEPOINTS
+/*
+ * Since the tracing code might execute OPAL calls we need to guard against
+ * recursion.
+ */
+static DEFINE_PER_CPU(unsigned int, opal_trace_depth);
+
+static void __trace_opal_entry(s64 a0, s64 a1, s64 a2, s64 a3,
+			       s64 a4, s64 a5, s64 a6, s64 a7,
+			       unsigned long opcode)
+{
+	unsigned int *depth;
+	unsigned long args[8];
+
+	depth = this_cpu_ptr(&opal_trace_depth);
+
+	if (*depth)
+		return;
+
+	args[0] = a0;
+	args[1] = a1;
+	args[2] = a2;
+	args[3] = a3;
+	args[4] = a4;
+	args[5] = a5;
+	args[6] = a6;
+	args[7] = a7;
+
+	(*depth)++;
+	trace_opal_entry(opcode, &args[0]);
+	(*depth)--;
+}
+
+static void __trace_opal_exit(unsigned long opcode, unsigned long retval)
+{
+	unsigned int *depth;
+
+	depth = this_cpu_ptr(&opal_trace_depth);
+
+	if (*depth)
+		return;
+
+	(*depth)++;
+	trace_opal_exit(opcode, retval);
+	(*depth)--;
+}
+
+static DEFINE_STATIC_KEY_FALSE(opal_tracepoint_key);
+
+int opal_tracepoint_regfunc(void)
+{
+	static_branch_inc(&opal_tracepoint_key);
+	return 0;
+}
+
+void opal_tracepoint_unregfunc(void)
+{
+	static_branch_dec(&opal_tracepoint_key);
+}
+
+static s64 __opal_call_trace(s64 a0, s64 a1, s64 a2, s64 a3,
+			     s64 a4, s64 a5, s64 a6, s64 a7,
+			      unsigned long opcode, unsigned long msr)
+{
+	s64 ret;
+
+	__trace_opal_entry(a0, a1, a2, a3, a4, a5, a6, a7, opcode);
+	ret = __opal_call(a0, a1, a2, a3, a4, a5, a6, a7, opcode, msr);
+	__trace_opal_exit(opcode, ret);
+
+	return ret;
+}
+
+#define DO_TRACE (static_branch_unlikely(&opal_tracepoint_key))
+
+#else /* CONFIG_TRACEPOINTS */
+
+static s64 __opal_call_trace(s64 a0, s64 a1, s64 a2, s64 a3,
+			     s64 a4, s64 a5, s64 a6, s64 a7,
+			      unsigned long opcode, unsigned long msr)
+{
+}
+
+#define DO_TRACE false
+#endif /* CONFIG_TRACEPOINTS */
+
+#define OPAL_CALL(name, opcode)					\
+int64_t name(int64_t a0, int64_t a1, int64_t a2, int64_t a3,	\
+	     int64_t a4, int64_t a5, int64_t a6, int64_t a7)	\
+{								\
+	unsigned long flags;					\
+	unsigned long msr = mfmsr();				\
+	bool mmu = (msr & (MSR_IR|MSR_DR));			\
+	int64_t ret;						\
+								\
+	msr &= ~MSR_EE;						\
+								\
+	if (unlikely(!mmu))					\
+		return __opal_call(a0, a1, a2, a3, a4, a5, a6, a7, opcode, msr); \
+								\
+	local_save_flags(flags);				\
+	hard_irq_disable();					\
+								\
+	if (DO_TRACE) {						\
+		ret = __opal_call_trace(a0, a1, a2, a3, a4, a5, a6, a7, opcode, msr); \
+	} else {						\
+		ret = __opal_call(a0, a1, a2, a3, a4, a5, a6, a7, opcode, msr); \
+	}							\
+								\
+	local_irq_restore(flags);				\
+								\
+	return ret;						\
+}
+
+OPAL_CALL(opal_invalid_call,			OPAL_INVALID_CALL);
+OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
+OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
+OPAL_CALL(opal_console_write_buffer_space,	OPAL_CONSOLE_WRITE_BUFFER_SPACE);
+OPAL_CALL(opal_rtc_read,			OPAL_RTC_READ);
+OPAL_CALL(opal_rtc_write,			OPAL_RTC_WRITE);
+OPAL_CALL(opal_cec_power_down,			OPAL_CEC_POWER_DOWN);
+OPAL_CALL(opal_cec_reboot,			OPAL_CEC_REBOOT);
+OPAL_CALL(opal_cec_reboot2,			OPAL_CEC_REBOOT2);
+OPAL_CALL(opal_read_nvram,			OPAL_READ_NVRAM);
+OPAL_CALL(opal_write_nvram,			OPAL_WRITE_NVRAM);
+OPAL_CALL(opal_handle_interrupt,		OPAL_HANDLE_INTERRUPT);
+OPAL_CALL(opal_poll_events,			OPAL_POLL_EVENTS);
+OPAL_CALL(opal_pci_set_hub_tce_memory,		OPAL_PCI_SET_HUB_TCE_MEMORY);
+OPAL_CALL(opal_pci_set_phb_tce_memory,		OPAL_PCI_SET_PHB_TCE_MEMORY);
+OPAL_CALL(opal_pci_config_read_byte,		OPAL_PCI_CONFIG_READ_BYTE);
+OPAL_CALL(opal_pci_config_read_half_word,	OPAL_PCI_CONFIG_READ_HALF_WORD);
+OPAL_CALL(opal_pci_config_read_word,		OPAL_PCI_CONFIG_READ_WORD);
+OPAL_CALL(opal_pci_config_write_byte,		OPAL_PCI_CONFIG_WRITE_BYTE);
+OPAL_CALL(opal_pci_config_write_half_word,	OPAL_PCI_CONFIG_WRITE_HALF_WORD);
+OPAL_CALL(opal_pci_config_write_word,		OPAL_PCI_CONFIG_WRITE_WORD);
+OPAL_CALL(opal_set_xive,			OPAL_SET_XIVE);
+OPAL_CALL(opal_get_xive,			OPAL_GET_XIVE);
+OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER);
+OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
+OPAL_CALL(opal_pci_eeh_freeze_clear,		OPAL_PCI_EEH_FREEZE_CLEAR);
+OPAL_CALL(opal_pci_eeh_freeze_set,		OPAL_PCI_EEH_FREEZE_SET);
+OPAL_CALL(opal_pci_err_inject,			OPAL_PCI_ERR_INJECT);
+OPAL_CALL(opal_pci_shpc,			OPAL_PCI_SHPC);
+OPAL_CALL(opal_pci_phb_mmio_enable,		OPAL_PCI_PHB_MMIO_ENABLE);
+OPAL_CALL(opal_pci_set_phb_mem_window,		OPAL_PCI_SET_PHB_MEM_WINDOW);
+OPAL_CALL(opal_pci_map_pe_mmio_window,		OPAL_PCI_MAP_PE_MMIO_WINDOW);
+OPAL_CALL(opal_pci_set_phb_table_memory,	OPAL_PCI_SET_PHB_TABLE_MEMORY);
+OPAL_CALL(opal_pci_set_pe,			OPAL_PCI_SET_PE);
+OPAL_CALL(opal_pci_set_peltv,			OPAL_PCI_SET_PELTV);
+OPAL_CALL(opal_pci_set_mve,			OPAL_PCI_SET_MVE);
+OPAL_CALL(opal_pci_set_mve_enable,		OPAL_PCI_SET_MVE_ENABLE);
+OPAL_CALL(opal_pci_get_xive_reissue,		OPAL_PCI_GET_XIVE_REISSUE);
+OPAL_CALL(opal_pci_set_xive_reissue,		OPAL_PCI_SET_XIVE_REISSUE);
+OPAL_CALL(opal_pci_set_xive_pe,			OPAL_PCI_SET_XIVE_PE);
+OPAL_CALL(opal_get_xive_source,			OPAL_GET_XIVE_SOURCE);
+OPAL_CALL(opal_get_msi_32,			OPAL_GET_MSI_32);
+OPAL_CALL(opal_get_msi_64,			OPAL_GET_MSI_64);
+OPAL_CALL(opal_start_cpu,			OPAL_START_CPU);
+OPAL_CALL(opal_query_cpu_status,		OPAL_QUERY_CPU_STATUS);
+OPAL_CALL(opal_write_oppanel,			OPAL_WRITE_OPPANEL);
+OPAL_CALL(opal_pci_map_pe_dma_window,		OPAL_PCI_MAP_PE_DMA_WINDOW);
+OPAL_CALL(opal_pci_map_pe_dma_window_real,	OPAL_PCI_MAP_PE_DMA_WINDOW_REAL);
+OPAL_CALL(opal_pci_reset,			OPAL_PCI_RESET);
+OPAL_CALL(opal_pci_get_hub_diag_data,		OPAL_PCI_GET_HUB_DIAG_DATA);
+OPAL_CALL(opal_pci_get_phb_diag_data,		OPAL_PCI_GET_PHB_DIAG_DATA);
+OPAL_CALL(opal_pci_fence_phb,			OPAL_PCI_FENCE_PHB);
+OPAL_CALL(opal_pci_reinit,			OPAL_PCI_REINIT);
+OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
+OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
+OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
+OPAL_CALL(opal_get_dpo_status,			OPAL_GET_DPO_STATUS);
+OPAL_CALL(opal_set_system_attention_led,	OPAL_SET_SYSTEM_ATTENTION_LED);
+OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
+OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);
+OPAL_CALL(opal_pci_msi_eoi,			OPAL_PCI_MSI_EOI);
+OPAL_CALL(opal_pci_get_phb_diag_data2,		OPAL_PCI_GET_PHB_DIAG_DATA2);
+OPAL_CALL(opal_xscom_read,			OPAL_XSCOM_READ);
+OPAL_CALL(opal_xscom_write,			OPAL_XSCOM_WRITE);
+OPAL_CALL(opal_lpc_read,			OPAL_LPC_READ);
+OPAL_CALL(opal_lpc_write,			OPAL_LPC_WRITE);
+OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
+OPAL_CALL(opal_reinit_cpus,			OPAL_REINIT_CPUS);
+OPAL_CALL(opal_read_elog,			OPAL_ELOG_READ);
+OPAL_CALL(opal_send_ack_elog,			OPAL_ELOG_ACK);
+OPAL_CALL(opal_get_elog_size,			OPAL_ELOG_SIZE);
+OPAL_CALL(opal_resend_pending_logs,		OPAL_ELOG_RESEND);
+OPAL_CALL(opal_write_elog,			OPAL_ELOG_WRITE);
+OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
+OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
+OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
+OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
+OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
+OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
+OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
+OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
+OPAL_CALL(opal_dump_read,			OPAL_DUMP_READ);
+OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
+OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
+OPAL_CALL(opal_write_oppanel_async,		OPAL_WRITE_OPPANEL_ASYNC);
+OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
+OPAL_CALL(opal_dump_resend_notification,	OPAL_DUMP_RESEND);
+OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
+OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
+OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
+OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
+OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
+OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
+OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
+OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
+OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
+OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CAPI_MODE);
+OPAL_CALL(opal_tpo_write,			OPAL_WRITE_TPO);
+OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
+OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
+OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
+OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
+OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
+OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
+OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
+OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
+OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
+OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
+OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
+OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
+OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
+OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
+OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
+OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
+OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
+OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
+OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
+OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
+OPAL_CALL(opal_xive_reset,			OPAL_XIVE_RESET);
+OPAL_CALL(opal_xive_get_irq_info,		OPAL_XIVE_GET_IRQ_INFO);
+OPAL_CALL(opal_xive_get_irq_config,		OPAL_XIVE_GET_IRQ_CONFIG);
+OPAL_CALL(opal_xive_set_irq_config,		OPAL_XIVE_SET_IRQ_CONFIG);
+OPAL_CALL(opal_xive_get_queue_info,		OPAL_XIVE_GET_QUEUE_INFO);
+OPAL_CALL(opal_xive_set_queue_info,		OPAL_XIVE_SET_QUEUE_INFO);
+OPAL_CALL(opal_xive_donate_page,		OPAL_XIVE_DONATE_PAGE);
+OPAL_CALL(opal_xive_alloc_vp_block,		OPAL_XIVE_ALLOCATE_VP_BLOCK);
+OPAL_CALL(opal_xive_free_vp_block,		OPAL_XIVE_FREE_VP_BLOCK);
+OPAL_CALL(opal_xive_allocate_irq,		OPAL_XIVE_ALLOCATE_IRQ);
+OPAL_CALL(opal_xive_free_irq,			OPAL_XIVE_FREE_IRQ);
+OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_INFO);
+OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
+OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
+OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
+OPAL_CALL(opal_signal_system_reset,		OPAL_SIGNAL_SYSTEM_RESET);
+OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
+OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
+OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
+OPAL_CALL(opal_imc_counters_init,		OPAL_IMC_COUNTERS_INIT);
+OPAL_CALL(opal_imc_counters_start,		OPAL_IMC_COUNTERS_START);
+OPAL_CALL(opal_imc_counters_stop,		OPAL_IMC_COUNTERS_STOP);
+OPAL_CALL(opal_pci_set_p2p,			OPAL_PCI_SET_P2P);
+OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
+OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
+OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
+OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
+OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
+OPAL_CALL(opal_quiesce,				OPAL_QUIESCE);
+OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
+OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
+OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
+OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
+OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
+OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
+OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
+OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
diff --git a/arch/powerpc/platforms/powernv/opal-tracepoints.c b/arch/powerpc/platforms/powernv/opal-tracepoints.c
deleted file mode 100644
index 1ab7d26c0a2c..000000000000
--- a/arch/powerpc/platforms/powernv/opal-tracepoints.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/percpu.h>
-#include <linux/jump_label.h>
-#include <asm/trace.h>
-#include <asm/asm-prototypes.h>
-
-#ifdef HAVE_JUMP_LABEL
-struct static_key opal_tracepoint_key = STATIC_KEY_INIT;
-
-int opal_tracepoint_regfunc(void)
-{
-	static_key_slow_inc(&opal_tracepoint_key);
-	return 0;
-}
-
-void opal_tracepoint_unregfunc(void)
-{
-	static_key_slow_dec(&opal_tracepoint_key);
-}
-#else
-/*
- * We optimise OPAL calls by placing opal_tracepoint_refcount
- * directly in the TOC so we can check if the opal tracepoints are
- * enabled via a single load.
- */
-
-/* NB: reg/unreg are called while guarded with the tracepoints_mutex */
-extern long opal_tracepoint_refcount;
-
-int opal_tracepoint_regfunc(void)
-{
-	opal_tracepoint_refcount++;
-	return 0;
-}
-
-void opal_tracepoint_unregfunc(void)
-{
-	opal_tracepoint_refcount--;
-}
-#endif
-
-/*
- * Since the tracing code might execute OPAL calls we need to guard against
- * recursion.
- */
-static DEFINE_PER_CPU(unsigned int, opal_trace_depth);
-
-void __trace_opal_entry(unsigned long opcode, unsigned long *args)
-{
-	unsigned long flags;
-	unsigned int *depth;
-
-	local_irq_save(flags);
-
-	depth = this_cpu_ptr(&opal_trace_depth);
-
-	if (*depth)
-		goto out;
-
-	(*depth)++;
-	preempt_disable();
-	trace_opal_entry(opcode, args);
-	(*depth)--;
-
-out:
-	local_irq_restore(flags);
-}
-
-void __trace_opal_exit(long opcode, unsigned long retval)
-{
-	unsigned long flags;
-	unsigned int *depth;
-
-	local_irq_save(flags);
-
-	depth = this_cpu_ptr(&opal_trace_depth);
-
-	if (*depth)
-		goto out;
-
-	(*depth)++;
-	trace_opal_exit(opcode, retval);
-	preempt_enable();
-	(*depth)--;
-
-out:
-	local_irq_restore(flags);
-}
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 251528231a9e..9e6c04698bc6 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -17,317 +17,51 @@
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 
-	.section	".text"
-
-#ifdef CONFIG_TRACEPOINTS
-#ifdef HAVE_JUMP_LABEL
-#define OPAL_BRANCH(LABEL)					\
-	ARCH_STATIC_BRANCH(LABEL, opal_tracepoint_key)
-#else
-
-	.section	".toc","aw"
-
-	.globl opal_tracepoint_refcount
-opal_tracepoint_refcount:
-	.8byte	0
-
-	.section	".text"
-
-/*
- * We branch around this in early init by using an unconditional cpu
- * feature.
- */
-#define OPAL_BRANCH(LABEL)					\
-BEGIN_FTR_SECTION;						\
-	b	1f;						\
-END_FTR_SECTION(0, 1);						\
-	ld	r11,opal_tracepoint_refcount@toc(r2);		\
-	cmpdi	r11,0;						\
-	bne-	LABEL;						\
-1:
-
-#endif
-
-#else
-#define OPAL_BRANCH(LABEL)
-#endif
-
 /*
- * DO_OPAL_CALL assumes:
- * r0  = opal call token
- * r12 = msr
- * LR has been saved
+ * r3-r10i		- OPAL call arguments
+ * STK_PARAM(R11)	- OPAL opcode
+ * STK_PARAM(R12)	- MSR to restore
  */
-#define DO_OPAL_CALL()			\
-	mfcr	r11;			\
-	stw	r11,8(r1);		\
-	li	r11,0;			\
-	ori	r11,r11,MSR_EE;		\
-	std	r12,PACASAVEDMSR(r13);	\
-	andc	r12,r12,r11;		\
-	mtmsrd	r12,1;			\
-	LOAD_REG_ADDR(r11,opal_return);	\
-	mtlr	r11;			\
-	li	r11,MSR_DR|MSR_IR|MSR_LE;\
-	andc	r12,r12,r11;		\
-	mtspr	SPRN_HSRR1,r12;		\
-	LOAD_REG_ADDR(r11,opal);	\
-	ld	r12,8(r11);		\
-	ld	r2,0(r11);		\
-	mtspr	SPRN_HSRR0,r12;		\
+_GLOBAL_TOC(__opal_call)
+	mflr	r0
+	std	r0,PPC_LR_STKOFF(r1)
+	ld	r12,STK_PARAM(R12)(r1)
+	li	r0,MSR_IR|MSR_DR|MSR_LE
+	ori	r0,r0,MSR_LE
+	andc	r12,r12,r0
+	LOAD_REG_ADDR(r11, opal_return)
+	mtlr	r11
+	LOAD_REG_ADDR(r11, opal)
+	ld	r2,0(r11)
+	ld	r11,8(r11)
+	mtspr	SPRN_HSRR0,r11
+	mtspr	SPRN_HSRR1,r12
+	/* set token to r0 */
+	ld	r0,STK_PARAM(R11)(r1)
 	hrfid
-
-#define OPAL_CALL(name, token)		\
- _GLOBAL_TOC(name);			\
-	mfmsr	r12;			\
-	mflr	r0;			\
-	andi.	r11,r12,MSR_IR|MSR_DR; 	\
-	std	r0,PPC_LR_STKOFF(r1);	\
-	li	r0,token;		\
-	beq	opal_real_call;         \
-	OPAL_BRANCH(opal_tracepoint_entry) \
-	DO_OPAL_CALL()
-
-
 opal_return:
 	/*
-	 * Fixup endian on OPAL return... we should be able to simplify
-	 * this by instead converting the below trampoline to a set of
-	 * bytes (always BE) since MSR:LE will end up fixed up as a side
-	 * effect of the rfid.
+	 * Restore MSR on OPAL return. The MSR is set to big-endian.
 	 */
-	FIXUP_ENDIAN_HV
-	ld	r2,PACATOC(r13);
-	lwz	r4,8(r1);
-	ld	r5,PPC_LR_STKOFF(r1);
-	ld	r6,PACASAVEDMSR(r13);
-	mtcr	r4;
-	mtspr	SPRN_HSRR0,r5;
-	mtspr	SPRN_HSRR1,r6;
-	hrfid
-
-opal_real_call:
-	mfcr	r11
-	stw	r11,8(r1)
-	/* Set opal return address */
-	LOAD_REG_ADDR(r11, opal_return_realmode)
-	mtlr	r11
-	li	r11,MSR_LE
-	andc	r12,r12,r11
-	mtspr	SPRN_HSRR1,r12
-	LOAD_REG_ADDR(r11,opal)
-	ld	r12,8(r11)
-	ld	r2,0(r11)
-	mtspr	SPRN_HSRR0,r12
-	hrfid
-
-opal_return_realmode:
-	FIXUP_ENDIAN_HV
-	ld	r2,PACATOC(r13);
-	lwz	r11,8(r1);
-	ld	r12,PPC_LR_STKOFF(r1)
-	mtcr	r11;
-	mtlr	r12
-	blr
-
-#ifdef CONFIG_TRACEPOINTS
-opal_tracepoint_entry:
-	stdu	r1,-STACKFRAMESIZE(r1)
-	std	r0,STK_REG(R23)(r1)
-	std	r3,STK_REG(R24)(r1)
-	std	r4,STK_REG(R25)(r1)
-	std	r5,STK_REG(R26)(r1)
-	std	r6,STK_REG(R27)(r1)
-	std	r7,STK_REG(R28)(r1)
-	std	r8,STK_REG(R29)(r1)
-	std	r9,STK_REG(R30)(r1)
-	std	r10,STK_REG(R31)(r1)
-	mr	r3,r0
-	addi	r4,r1,STK_REG(R24)
-	bl	__trace_opal_entry
-	ld	r0,STK_REG(R23)(r1)
-	ld	r3,STK_REG(R24)(r1)
-	ld	r4,STK_REG(R25)(r1)
-	ld	r5,STK_REG(R26)(r1)
-	ld	r6,STK_REG(R27)(r1)
-	ld	r7,STK_REG(R28)(r1)
-	ld	r8,STK_REG(R29)(r1)
-	ld	r9,STK_REG(R30)(r1)
-	ld	r10,STK_REG(R31)(r1)
-
-	/* setup LR so we return via tracepoint_return */
-	LOAD_REG_ADDR(r11,opal_tracepoint_return)
-	std	r11,16(r1)
-
-	mfmsr	r12
-	DO_OPAL_CALL()
-
-opal_tracepoint_return:
-	std	r3,STK_REG(R31)(r1)
-	mr	r4,r3
-	ld	r3,STK_REG(R23)(r1)
-	bl	__trace_opal_exit
-	ld	r3,STK_REG(R31)(r1)
-	addi	r1,r1,STACKFRAMESIZE
-	ld	r0,16(r1)
+#ifdef __BIG_ENDIAN__
+	ld	r11,STK_PARAM(R12)(r1)
+	mtmsrd	r11
+#else
+	/* Endian switch must use rfi, byte reverse MSR load */
+	.short 0x4039	 /* li r10,STK_PARAM(R12)		*/
+	.byte (STK_PARAM(R12) >> 8) & 0xff
+	.byte STK_PARAM(R12) & 0xff
+
+	.long 0x280c6a7d /* ldbrx r11,r10,r1			*/
+	.long 0x05009f42 /* bcl 20,31,$+4			*/
+	.long 0xa602487d /* mflr r10				*/
+	.long 0x14004a39 /* addi r10,r10,20			*/
+	.long 0xa64b5a7d /* mthsrr0 r10				*/
+	.long 0xa64b7b7d /* mthsrr1 r11				*/
+	.long 0x2402004c /* hrfid				*/
+#endif
+	ld	r2,PACATOC(r13)
+	ld	r0,PPC_LR_STKOFF(r1)
 	mtlr	r0
 	blr
-#endif
-
 
-OPAL_CALL(opal_invalid_call,			OPAL_INVALID_CALL);
-OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
-OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
-OPAL_CALL(opal_console_write_buffer_space,	OPAL_CONSOLE_WRITE_BUFFER_SPACE);
-OPAL_CALL(opal_rtc_read,			OPAL_RTC_READ);
-OPAL_CALL(opal_rtc_write,			OPAL_RTC_WRITE);
-OPAL_CALL(opal_cec_power_down,			OPAL_CEC_POWER_DOWN);
-OPAL_CALL(opal_cec_reboot,			OPAL_CEC_REBOOT);
-OPAL_CALL(opal_cec_reboot2,			OPAL_CEC_REBOOT2);
-OPAL_CALL(opal_read_nvram,			OPAL_READ_NVRAM);
-OPAL_CALL(opal_write_nvram,			OPAL_WRITE_NVRAM);
-OPAL_CALL(opal_handle_interrupt,		OPAL_HANDLE_INTERRUPT);
-OPAL_CALL(opal_poll_events,			OPAL_POLL_EVENTS);
-OPAL_CALL(opal_pci_set_hub_tce_memory,		OPAL_PCI_SET_HUB_TCE_MEMORY);
-OPAL_CALL(opal_pci_set_phb_tce_memory,		OPAL_PCI_SET_PHB_TCE_MEMORY);
-OPAL_CALL(opal_pci_config_read_byte,		OPAL_PCI_CONFIG_READ_BYTE);
-OPAL_CALL(opal_pci_config_read_half_word,	OPAL_PCI_CONFIG_READ_HALF_WORD);
-OPAL_CALL(opal_pci_config_read_word,		OPAL_PCI_CONFIG_READ_WORD);
-OPAL_CALL(opal_pci_config_write_byte,		OPAL_PCI_CONFIG_WRITE_BYTE);
-OPAL_CALL(opal_pci_config_write_half_word,	OPAL_PCI_CONFIG_WRITE_HALF_WORD);
-OPAL_CALL(opal_pci_config_write_word,		OPAL_PCI_CONFIG_WRITE_WORD);
-OPAL_CALL(opal_set_xive,			OPAL_SET_XIVE);
-OPAL_CALL(opal_get_xive,			OPAL_GET_XIVE);
-OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER);
-OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
-OPAL_CALL(opal_pci_eeh_freeze_clear,		OPAL_PCI_EEH_FREEZE_CLEAR);
-OPAL_CALL(opal_pci_eeh_freeze_set,		OPAL_PCI_EEH_FREEZE_SET);
-OPAL_CALL(opal_pci_err_inject,			OPAL_PCI_ERR_INJECT);
-OPAL_CALL(opal_pci_shpc,			OPAL_PCI_SHPC);
-OPAL_CALL(opal_pci_phb_mmio_enable,		OPAL_PCI_PHB_MMIO_ENABLE);
-OPAL_CALL(opal_pci_set_phb_mem_window,		OPAL_PCI_SET_PHB_MEM_WINDOW);
-OPAL_CALL(opal_pci_map_pe_mmio_window,		OPAL_PCI_MAP_PE_MMIO_WINDOW);
-OPAL_CALL(opal_pci_set_phb_table_memory,	OPAL_PCI_SET_PHB_TABLE_MEMORY);
-OPAL_CALL(opal_pci_set_pe,			OPAL_PCI_SET_PE);
-OPAL_CALL(opal_pci_set_peltv,			OPAL_PCI_SET_PELTV);
-OPAL_CALL(opal_pci_set_mve,			OPAL_PCI_SET_MVE);
-OPAL_CALL(opal_pci_set_mve_enable,		OPAL_PCI_SET_MVE_ENABLE);
-OPAL_CALL(opal_pci_get_xive_reissue,		OPAL_PCI_GET_XIVE_REISSUE);
-OPAL_CALL(opal_pci_set_xive_reissue,		OPAL_PCI_SET_XIVE_REISSUE);
-OPAL_CALL(opal_pci_set_xive_pe,			OPAL_PCI_SET_XIVE_PE);
-OPAL_CALL(opal_get_xive_source,			OPAL_GET_XIVE_SOURCE);
-OPAL_CALL(opal_get_msi_32,			OPAL_GET_MSI_32);
-OPAL_CALL(opal_get_msi_64,			OPAL_GET_MSI_64);
-OPAL_CALL(opal_start_cpu,			OPAL_START_CPU);
-OPAL_CALL(opal_query_cpu_status,		OPAL_QUERY_CPU_STATUS);
-OPAL_CALL(opal_write_oppanel,			OPAL_WRITE_OPPANEL);
-OPAL_CALL(opal_pci_map_pe_dma_window,		OPAL_PCI_MAP_PE_DMA_WINDOW);
-OPAL_CALL(opal_pci_map_pe_dma_window_real,	OPAL_PCI_MAP_PE_DMA_WINDOW_REAL);
-OPAL_CALL(opal_pci_reset,			OPAL_PCI_RESET);
-OPAL_CALL(opal_pci_get_hub_diag_data,		OPAL_PCI_GET_HUB_DIAG_DATA);
-OPAL_CALL(opal_pci_get_phb_diag_data,		OPAL_PCI_GET_PHB_DIAG_DATA);
-OPAL_CALL(opal_pci_fence_phb,			OPAL_PCI_FENCE_PHB);
-OPAL_CALL(opal_pci_reinit,			OPAL_PCI_REINIT);
-OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
-OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
-OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
-OPAL_CALL(opal_get_dpo_status,			OPAL_GET_DPO_STATUS);
-OPAL_CALL(opal_set_system_attention_led,	OPAL_SET_SYSTEM_ATTENTION_LED);
-OPAL_CALL(opal_pci_next_error,			OPAL_PCI_NEXT_ERROR);
-OPAL_CALL(opal_pci_poll,			OPAL_PCI_POLL);
-OPAL_CALL(opal_pci_msi_eoi,			OPAL_PCI_MSI_EOI);
-OPAL_CALL(opal_pci_get_phb_diag_data2,		OPAL_PCI_GET_PHB_DIAG_DATA2);
-OPAL_CALL(opal_xscom_read,			OPAL_XSCOM_READ);
-OPAL_CALL(opal_xscom_write,			OPAL_XSCOM_WRITE);
-OPAL_CALL(opal_lpc_read,			OPAL_LPC_READ);
-OPAL_CALL(opal_lpc_write,			OPAL_LPC_WRITE);
-OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
-OPAL_CALL(opal_reinit_cpus,			OPAL_REINIT_CPUS);
-OPAL_CALL(opal_read_elog,			OPAL_ELOG_READ);
-OPAL_CALL(opal_send_ack_elog,			OPAL_ELOG_ACK);
-OPAL_CALL(opal_get_elog_size,			OPAL_ELOG_SIZE);
-OPAL_CALL(opal_resend_pending_logs,		OPAL_ELOG_RESEND);
-OPAL_CALL(opal_write_elog,			OPAL_ELOG_WRITE);
-OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
-OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
-OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
-OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
-OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
-OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
-OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
-OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
-OPAL_CALL(opal_dump_read,			OPAL_DUMP_READ);
-OPAL_CALL(opal_dump_ack,			OPAL_DUMP_ACK);
-OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
-OPAL_CALL(opal_write_oppanel_async,		OPAL_WRITE_OPPANEL_ASYNC);
-OPAL_CALL(opal_check_completion,		OPAL_CHECK_ASYNC_COMPLETION);
-OPAL_CALL(opal_dump_resend_notification,	OPAL_DUMP_RESEND);
-OPAL_CALL(opal_sync_host_reboot,		OPAL_SYNC_HOST_REBOOT);
-OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
-OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
-OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
-OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
-OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
-OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
-OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
-OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
-OPAL_CALL(opal_pci_set_phb_cxl_mode,		OPAL_PCI_SET_PHB_CAPI_MODE);
-OPAL_CALL(opal_tpo_write,			OPAL_WRITE_TPO);
-OPAL_CALL(opal_tpo_read,			OPAL_READ_TPO);
-OPAL_CALL(opal_ipmi_send,			OPAL_IPMI_SEND);
-OPAL_CALL(opal_ipmi_recv,			OPAL_IPMI_RECV);
-OPAL_CALL(opal_i2c_request,			OPAL_I2C_REQUEST);
-OPAL_CALL(opal_flash_read,			OPAL_FLASH_READ);
-OPAL_CALL(opal_flash_write,			OPAL_FLASH_WRITE);
-OPAL_CALL(opal_flash_erase,			OPAL_FLASH_ERASE);
-OPAL_CALL(opal_prd_msg,				OPAL_PRD_MSG);
-OPAL_CALL(opal_leds_get_ind,			OPAL_LEDS_GET_INDICATOR);
-OPAL_CALL(opal_leds_set_ind,			OPAL_LEDS_SET_INDICATOR);
-OPAL_CALL(opal_console_flush,			OPAL_CONSOLE_FLUSH);
-OPAL_CALL(opal_get_device_tree,			OPAL_GET_DEVICE_TREE);
-OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
-OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
-OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
-OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
-OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
-OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
-OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
-OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
-OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
-OPAL_CALL(opal_xive_reset,			OPAL_XIVE_RESET);
-OPAL_CALL(opal_xive_get_irq_info,		OPAL_XIVE_GET_IRQ_INFO);
-OPAL_CALL(opal_xive_get_irq_config,		OPAL_XIVE_GET_IRQ_CONFIG);
-OPAL_CALL(opal_xive_set_irq_config,		OPAL_XIVE_SET_IRQ_CONFIG);
-OPAL_CALL(opal_xive_get_queue_info,		OPAL_XIVE_GET_QUEUE_INFO);
-OPAL_CALL(opal_xive_set_queue_info,		OPAL_XIVE_SET_QUEUE_INFO);
-OPAL_CALL(opal_xive_donate_page,		OPAL_XIVE_DONATE_PAGE);
-OPAL_CALL(opal_xive_alloc_vp_block,		OPAL_XIVE_ALLOCATE_VP_BLOCK);
-OPAL_CALL(opal_xive_free_vp_block,		OPAL_XIVE_FREE_VP_BLOCK);
-OPAL_CALL(opal_xive_allocate_irq,		OPAL_XIVE_ALLOCATE_IRQ);
-OPAL_CALL(opal_xive_free_irq,			OPAL_XIVE_FREE_IRQ);
-OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_INFO);
-OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
-OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
-OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
-OPAL_CALL(opal_signal_system_reset,		OPAL_SIGNAL_SYSTEM_RESET);
-OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
-OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
-OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
-OPAL_CALL(opal_imc_counters_init,		OPAL_IMC_COUNTERS_INIT);
-OPAL_CALL(opal_imc_counters_start,		OPAL_IMC_COUNTERS_START);
-OPAL_CALL(opal_imc_counters_stop,		OPAL_IMC_COUNTERS_STOP);
-OPAL_CALL(opal_pci_set_p2p,			OPAL_PCI_SET_P2P);
-OPAL_CALL(opal_get_powercap,			OPAL_GET_POWERCAP);
-OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
-OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
-OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
-OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
-OPAL_CALL(opal_quiesce,				OPAL_QUIESCE);
-OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
-OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
-OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
-OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
-OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
-OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
-OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
-OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
-- 
2.18.0

