Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45192C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 18:53:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EFC2085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 18:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EFC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YPfy1Xm6zDqNd
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 05:53:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.51.53; helo=5.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 341 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 05:51:40 AEDT
Received: from 5.mo178.mail-out.ovh.net (5.mo178.mail-out.ovh.net
 [46.105.51.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YPcr5Rb5zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 05:51:40 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.143.220])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4B56B44721
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:45:55 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 2A13818664BD;
 Mon,  7 Jan 2019 18:45:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 11/19] KVM: PPC: Book3S HV: add support for the XIVE native
 exploitation mode hcalls
Date: Mon,  7 Jan 2019 19:43:23 +0100
Message-Id: <20190107184331.8429-12-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11412965884339522519
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The XIVE native exploitation mode specs define a set of Hypervisor
calls to configure the sources and the event queues :

 - H_INT_GET_SOURCE_INFO

   used to obtain the address of the MMIO page of the Event State
   Buffer (PQ bits) entry associated with the source.

 - H_INT_SET_SOURCE_CONFIG

   assigns a source to a "target".

 - H_INT_GET_SOURCE_CONFIG

   determines which "target" and "priority" is assigned to a source

 - H_INT_GET_QUEUE_INFO

   returns the address of the notification management page associated
   with the specified "target" and "priority".

 - H_INT_SET_QUEUE_CONFIG

   sets or resets the event queue for a given "target" and "priority".
   It is also used to set the notification configuration associated
   with the queue, only unconditional notification is supported for
   the moment. Reset is performed with a queue size of 0 and queueing
   is disabled in that case.

 - H_INT_GET_QUEUE_CONFIG

   returns the queue settings for a given "target" and "priority".

 - H_INT_RESET

   resets all of the guest's internal interrupt structures to their
   initial state, losing all configuration set via the hcalls
   H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.

 - H_INT_SYNC

   issue a synchronisation on a source to make sure all notifications
   have reached their queue.

Calls that still need to be addressed :

   H_INT_SET_OS_REPORTING_LINE
   H_INT_GET_OS_REPORTING_LINE

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/kvm_ppc.h            |  43 ++
 arch/powerpc/kvm/book3s_xive.h                |  54 +++
 arch/powerpc/kvm/book3s_hv.c                  |  29 ++
 arch/powerpc/kvm/book3s_hv_builtin.c          | 196 +++++++++
 arch/powerpc/kvm/book3s_hv_rm_xive_native.c   |  47 +++
 arch/powerpc/kvm/book3s_xive_native.c         | 326 ++++++++++++++-
 .../powerpc/kvm/book3s_xive_native_template.c | 371 ++++++++++++++++++
 arch/powerpc/kvm/Makefile                     |   2 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |  52 +++
 9 files changed, 1118 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_rm_xive_native.c

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 1bb313f238fe..4cc897039485 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -602,6 +602,7 @@ extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
 extern void kvmppc_xive_native_init_module(void);
 extern void kvmppc_xive_native_exit_module(void);
+extern int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd);
 
 #else
 static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
@@ -634,6 +635,8 @@ static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
 static inline void kvmppc_xive_native_init_module(void) { }
 static inline void kvmppc_xive_native_exit_module(void) { }
+static inline int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 cmd)
+	{ return 0; }
 
 #endif /* CONFIG_KVM_XIVE */
 
@@ -682,6 +685,46 @@ int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
 int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
 void kvmppc_guest_entry_inject_int(struct kvm_vcpu *vcpu);
 
+int kvmppc_rm_h_int_get_source_info(struct kvm_vcpu *vcpu,
+				    unsigned long flag,
+				    unsigned long lisn);
+int kvmppc_rm_h_int_set_source_config(struct kvm_vcpu *vcpu,
+				      unsigned long flag,
+				      unsigned long lisn,
+				      unsigned long target,
+				      unsigned long priority,
+				      unsigned long eisn);
+int kvmppc_rm_h_int_get_source_config(struct kvm_vcpu *vcpu,
+				      unsigned long flag,
+				      unsigned long lisn);
+int kvmppc_rm_h_int_get_queue_info(struct kvm_vcpu *vcpu,
+				   unsigned long flag,
+				   unsigned long target,
+				   unsigned long priority);
+int kvmppc_rm_h_int_set_queue_config(struct kvm_vcpu *vcpu,
+				     unsigned long flag,
+				     unsigned long target,
+				     unsigned long priority,
+				     unsigned long qpage,
+				     unsigned long qsize);
+int kvmppc_rm_h_int_get_queue_config(struct kvm_vcpu *vcpu,
+				     unsigned long flag,
+				     unsigned long target,
+				     unsigned long priority);
+int kvmppc_rm_h_int_set_os_reporting_line(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long reportingline);
+int kvmppc_rm_h_int_get_os_reporting_line(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long target,
+					  unsigned long reportingline);
+int kvmppc_rm_h_int_esb(struct kvm_vcpu *vcpu, unsigned long flag,
+			unsigned long lisn, unsigned long offset,
+			unsigned long data);
+int kvmppc_rm_h_int_sync(struct kvm_vcpu *vcpu, unsigned long flag,
+			 unsigned long lisn);
+int kvmppc_rm_h_int_reset(struct kvm_vcpu *vcpu, unsigned long flag);
+
 /*
  * Host-side operations we want to set up while running in real
  * mode in the guest operating on the xics.
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 67e07b41061d..31e598e62589 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -268,5 +268,59 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
 int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio);
 int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
 
+int xive_rm_h_int_get_source_info(struct kvm_vcpu *vcpu,
+				    unsigned long flag,
+				    unsigned long lisn);
+int xive_rm_h_int_get_source_config(struct kvm_vcpu *vcpu,
+				      unsigned long flag,
+				      unsigned long lisn);
+int xive_rm_h_int_get_queue_info(struct kvm_vcpu *vcpu,
+				   unsigned long flag,
+				   unsigned long target,
+				   unsigned long priority);
+int xive_rm_h_int_get_queue_config(struct kvm_vcpu *vcpu,
+				     unsigned long flag,
+				     unsigned long target,
+				     unsigned long priority);
+int xive_rm_h_int_set_os_reporting_line(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long reportingline);
+int xive_rm_h_int_get_os_reporting_line(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long target,
+					  unsigned long reportingline);
+int xive_rm_h_int_esb(struct kvm_vcpu *vcpu, unsigned long flag,
+			unsigned long lisn, unsigned long offset,
+			unsigned long data);
+int xive_rm_h_int_sync(struct kvm_vcpu *vcpu, unsigned long flag,
+			 unsigned long lisn);
+
+extern int (*__xive_vm_h_int_get_source_info)(struct kvm_vcpu *vcpu,
+				    unsigned long flag,
+				    unsigned long lisn);
+extern int (*__xive_vm_h_int_get_source_config)(struct kvm_vcpu *vcpu,
+				      unsigned long flag,
+				      unsigned long lisn);
+extern int (*__xive_vm_h_int_get_queue_info)(struct kvm_vcpu *vcpu,
+				   unsigned long flag,
+				   unsigned long target,
+				   unsigned long priority);
+extern int (*__xive_vm_h_int_get_queue_config)(struct kvm_vcpu *vcpu,
+				     unsigned long flag,
+				     unsigned long target,
+				     unsigned long priority);
+extern int (*__xive_vm_h_int_set_os_reporting_line)(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long reportingline);
+extern int (*__xive_vm_h_int_get_os_reporting_line)(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long target,
+					  unsigned long reportingline);
+extern int (*__xive_vm_h_int_esb)(struct kvm_vcpu *vcpu, unsigned long flag,
+			unsigned long lisn, unsigned long offset,
+			unsigned long data);
+extern int (*__xive_vm_h_int_sync)(struct kvm_vcpu *vcpu, unsigned long flag,
+			 unsigned long lisn);
+
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5a066fc299e1..1fb17d529a88 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -930,6 +930,22 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			break;
 		}
 		return RESUME_HOST;
+	case H_INT_GET_SOURCE_INFO:
+	case H_INT_SET_SOURCE_CONFIG:
+	case H_INT_GET_SOURCE_CONFIG:
+	case H_INT_GET_QUEUE_INFO:
+	case H_INT_SET_QUEUE_CONFIG:
+	case H_INT_GET_QUEUE_CONFIG:
+	case H_INT_SET_OS_REPORTING_LINE:
+	case H_INT_GET_OS_REPORTING_LINE:
+	case H_INT_ESB:
+	case H_INT_SYNC:
+	case H_INT_RESET:
+		if (kvmppc_xive_enabled(vcpu)) {
+			ret = kvmppc_xive_native_hcall(vcpu, req);
+			break;
+		}
+		return RESUME_HOST;
 	case H_SET_DABR:
 		ret = kvmppc_h_set_dabr(vcpu, kvmppc_get_gpr(vcpu, 4));
 		break;
@@ -5153,6 +5169,19 @@ static unsigned int default_hcall_list[] = {
 	H_IPOLL,
 	H_XIRR,
 	H_XIRR_X,
+#endif
+#ifdef CONFIG_KVM_XIVE
+	H_INT_GET_SOURCE_INFO,
+	H_INT_SET_SOURCE_CONFIG,
+	H_INT_GET_SOURCE_CONFIG,
+	H_INT_GET_QUEUE_INFO,
+	H_INT_SET_QUEUE_CONFIG,
+	H_INT_GET_QUEUE_CONFIG,
+	H_INT_SET_OS_REPORTING_LINE,
+	H_INT_GET_OS_REPORTING_LINE,
+	H_INT_ESB,
+	H_INT_SYNC,
+	H_INT_RESET,
 #endif
 	0
 };
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index a71e2fc00a4e..db690f914d78 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -51,6 +51,42 @@ EXPORT_SYMBOL_GPL(__xive_vm_h_ipi);
 EXPORT_SYMBOL_GPL(__xive_vm_h_cppr);
 EXPORT_SYMBOL_GPL(__xive_vm_h_eoi);
 
+int (*__xive_vm_h_int_get_source_info)(struct kvm_vcpu *vcpu,
+				       unsigned long flag,
+				       unsigned long lisn);
+int (*__xive_vm_h_int_get_source_config)(struct kvm_vcpu *vcpu,
+					 unsigned long flag,
+					 unsigned long lisn);
+int (*__xive_vm_h_int_get_queue_info)(struct kvm_vcpu *vcpu,
+				      unsigned long flag,
+				      unsigned long target,
+				      unsigned long priority);
+int (*__xive_vm_h_int_get_queue_config)(struct kvm_vcpu *vcpu,
+					unsigned long flag,
+					unsigned long target,
+					unsigned long priority);
+int (*__xive_vm_h_int_set_os_reporting_line)(struct kvm_vcpu *vcpu,
+					     unsigned long flag,
+					     unsigned long line);
+int (*__xive_vm_h_int_get_os_reporting_line)(struct kvm_vcpu *vcpu,
+					     unsigned long flag,
+					     unsigned long target,
+					     unsigned long line);
+int (*__xive_vm_h_int_esb)(struct kvm_vcpu *vcpu, unsigned long flag,
+			   unsigned long lisn, unsigned long offset,
+			   unsigned long data);
+int (*__xive_vm_h_int_sync)(struct kvm_vcpu *vcpu, unsigned long flag,
+			    unsigned long lisn);
+
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_get_source_info);
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_get_source_config);
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_get_queue_info);
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_get_queue_config);
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_set_os_reporting_line);
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_get_os_reporting_line);
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_esb);
+EXPORT_SYMBOL_GPL(__xive_vm_h_int_sync);
+
 /*
  * Hash page table alignment on newer cpus(CPU_FTR_ARCH_206)
  * should be power of 2.
@@ -660,6 +696,166 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 }
 #endif /* CONFIG_KVM_XICS */
 
+#ifdef CONFIG_KVM_XIVE
+int kvmppc_rm_h_int_get_source_info(struct kvm_vcpu *vcpu,
+				    unsigned long flag,
+				    unsigned long lisn)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_get_source_info(vcpu, flag, lisn);
+	if (unlikely(!__xive_vm_h_int_get_source_info))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_get_source_info(vcpu, flag, lisn);
+}
+
+int kvmppc_rm_h_int_set_source_config(struct kvm_vcpu *vcpu,
+				      unsigned long flag,
+				      unsigned long lisn,
+				      unsigned long target,
+				      unsigned long priority,
+				      unsigned long eisn)
+{
+	return H_TOO_HARD;
+}
+
+int kvmppc_rm_h_int_get_source_config(struct kvm_vcpu *vcpu,
+				      unsigned long flag,
+				      unsigned long lisn)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_get_source_config(vcpu, flag, lisn);
+	if (unlikely(!__xive_vm_h_int_get_source_config))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_get_source_config(vcpu, flag, lisn);
+}
+
+int kvmppc_rm_h_int_get_queue_info(struct kvm_vcpu *vcpu,
+				   unsigned long flag,
+				   unsigned long target,
+				   unsigned long priority)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_get_queue_info(vcpu, flag, target,
+						    priority);
+	if (unlikely(!__xive_vm_h_int_get_queue_info))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_get_queue_info(vcpu, flag, target, priority);
+}
+
+int kvmppc_rm_h_int_set_queue_config(struct kvm_vcpu *vcpu,
+				     unsigned long flag,
+				     unsigned long target,
+				     unsigned long priority,
+				     unsigned long qpage,
+				     unsigned long qsize)
+{
+	return H_TOO_HARD;
+}
+
+int kvmppc_rm_h_int_get_queue_config(struct kvm_vcpu *vcpu,
+				     unsigned long flag,
+				     unsigned long target,
+				     unsigned long priority)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_get_queue_config(vcpu, flag, target,
+						      priority);
+	if (unlikely(!__xive_vm_h_int_get_queue_config))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_get_queue_config(vcpu, flag, target, priority);
+}
+
+int kvmppc_rm_h_int_set_os_reporting_line(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long line)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_set_os_reporting_line(vcpu, flag, line);
+	if (unlikely(!__xive_vm_h_int_set_os_reporting_line))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_set_os_reporting_line(vcpu, flag, line);
+}
+
+int kvmppc_rm_h_int_get_os_reporting_line(struct kvm_vcpu *vcpu,
+					  unsigned long flag,
+					  unsigned long target,
+					  unsigned long line)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_get_os_reporting_line(vcpu,
+							   flag, target, line);
+	if (unlikely(!__xive_vm_h_int_get_os_reporting_line))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_get_os_reporting_line(vcpu, flag, target, line);
+}
+
+int kvmppc_rm_h_int_esb(struct kvm_vcpu *vcpu, unsigned long flag,
+			 unsigned long lisn, unsigned long offset,
+			 unsigned long data)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_esb(vcpu, flag, lisn, offset, data);
+	if (unlikely(!__xive_vm_h_int_esb))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_esb(vcpu, flag, lisn, offset, data);
+}
+
+int kvmppc_rm_h_int_sync(struct kvm_vcpu *vcpu, unsigned long flag,
+			 unsigned long lisn)
+{
+	if (!kvmppc_xive_enabled(vcpu))
+		return H_TOO_HARD;
+	if (!xive_enabled())
+		return H_TOO_HARD;
+
+	if (is_rm())
+		return xive_rm_h_int_sync(vcpu, flag, lisn);
+	if (unlikely(!__xive_vm_h_int_sync))
+		return H_NOT_AVAILABLE;
+	return __xive_vm_h_int_sync(vcpu, flag, lisn);
+}
+
+int kvmppc_rm_h_int_reset(struct kvm_vcpu *vcpu, unsigned long flag)
+{
+	return H_TOO_HARD;
+}
+#endif /* CONFIG_KVM_XIVE */
+
 void kvmppc_bad_interrupt(struct pt_regs *regs)
 {
 	/*
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xive_native.c b/arch/powerpc/kvm/book3s_hv_rm_xive_native.c
new file mode 100644
index 000000000000..0e72a6ae0f07
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_rm_xive_native.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/err.h>
+#include <linux/kernel_stat.h>
+
+#include <asm/kvm_book3s.h>
+#include <asm/kvm_ppc.h>
+#include <asm/hvcall.h>
+#include <asm/xics.h>
+#include <asm/debug.h>
+#include <asm/synch.h>
+#include <asm/cputhreads.h>
+#include <asm/pgtable.h>
+#include <asm/ppc-opcode.h>
+#include <asm/pnv-pci.h>
+#include <asm/opal.h>
+#include <asm/smp.h>
+#include <asm/asm-prototypes.h>
+#include <asm/xive.h>
+#include <asm/xive-regs.h>
+
+#include "book3s_xive.h"
+
+/* XXX */
+#include <asm/udbg.h>
+//#define DBG(fmt...) udbg_printf(fmt)
+#define DBG(fmt...) do { } while (0)
+
+static inline void __iomem *get_tima_phys(void)
+{
+	return local_paca->kvm_hstate.xive_tima_phys;
+}
+
+#undef XIVE_RUNTIME_CHECKS
+#define X_PFX xive_rm_
+#define X_STATIC
+#define X_STAT_PFX stat_rm_
+#define __x_tima		get_tima_phys()
+#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_page))
+#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_page))
+#define __x_writeb	__raw_rm_writeb
+#define __x_readw	__raw_rm_readw
+#define __x_readq	__raw_rm_readq
+#define __x_writeq	__raw_rm_writeq
+
+#include "book3s_xive_native_template.c"
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 2518640d4a58..35d806740c3a 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -171,6 +171,56 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 	return rc;
 }
 
+static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
+					struct kvmppc_xive_src_block *sb,
+					struct kvmppc_xive_irq_state *state,
+					u32 server,
+					u8 priority,
+					u32 eisn)
+{
+	struct kvm *kvm = xive->kvm;
+	u32 hw_num;
+	int rc = 0;
+
+	/*
+	 * TODO: Do we need to safely mask and unmask a source ? can
+	 * we just let the guest handle the possible races ?
+	 */
+	arch_spin_lock(&sb->lock);
+
+	if (state->act_server == server && state->act_priority == priority &&
+	    state->eisn == eisn)
+		goto unlock;
+
+	pr_devel("new_act_prio=%d new_act_server=%d act_server=%d act_prio=%d\n",
+		 priority, server, state->act_server, state->act_priority);
+
+	kvmppc_xive_select_irq(state, &hw_num, NULL);
+
+	if (priority != MASKED) {
+		rc = kvmppc_xive_select_target(kvm, &server, priority);
+		if (rc)
+			goto unlock;
+
+		state->act_priority = priority;
+		state->act_server = server;
+		state->eisn = eisn;
+
+		rc = xive_native_configure_irq(hw_num, xive->vp_base + server,
+					       priority, eisn);
+	} else {
+		state->act_priority = MASKED;
+		state->act_server = 0;
+		state->eisn = 0;
+
+		rc = xive_native_configure_irq(hw_num, 0, MASKED, 0);
+	}
+
+unlock:
+	arch_spin_unlock(&sb->lock);
+	return rc;
+}
+
 static int kvmppc_xive_native_set_vc_base(struct kvmppc_xive *xive, u64 addr)
 {
 	u64 __user *ubufp = (u64 __user *) addr;
@@ -323,6 +373,20 @@ static int kvmppc_xive_native_get_tima_fd(struct kvmppc_xive *xive, u64 addr)
 	return put_user(ret, ubufp);
 }
 
+static int xive_native_validate_queue_size(u32 qsize)
+{
+	switch (qsize) {
+	case 12:
+	case 16:
+	case 21:
+	case 24:
+	case 0:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
 					 u64 addr)
 {
@@ -532,6 +596,248 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 	return ret;
 }
 
+static int kvmppc_h_int_set_source_config(struct kvm_vcpu *vcpu,
+					  unsigned long flags,
+					  unsigned long irq,
+					  unsigned long server,
+					  unsigned long priority,
+					  unsigned long eisn)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	int rc = 0;
+	u16 idx;
+
+	pr_devel("H_INT_SET_SOURCE_CONFIG flags=%08lx irq=%lx server=%ld priority=%ld eisn=%lx\n",
+		 flags, irq, server, priority, eisn);
+
+	if (flags & ~(XIVE_SPAPR_SRC_SET_EISN | XIVE_SPAPR_SRC_MASK))
+		return H_PARAMETER;
+
+	sb = kvmppc_xive_find_source(xive, irq, &idx);
+	if (!sb)
+		return H_P2;
+	state = &sb->irq_state[idx];
+
+	if (!(flags & XIVE_SPAPR_SRC_SET_EISN))
+		eisn = state->eisn;
+
+	if (priority != xive_prio_from_guest(priority)) {
+		pr_err("invalid priority for queue %ld for VCPU %ld\n",
+		       priority, server);
+		return H_P3;
+	}
+
+	/* TODO: handle XIVE_SPAPR_SRC_MASK */
+
+	rc = kvmppc_xive_native_set_source_config(xive, sb, state, server,
+						  priority, eisn);
+	if (!rc)
+		return H_SUCCESS;
+	else if (rc == -EINVAL)
+		return H_P4; /* no server found */
+	else
+		return H_HARDWARE;
+}
+
+static int kvmppc_h_int_set_queue_config(struct kvm_vcpu *vcpu,
+					 unsigned long flags,
+					 unsigned long server,
+					 unsigned long priority,
+					 unsigned long qpage,
+					 unsigned long qsize)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct xive_q *q;
+	int rc;
+	__be32 *qaddr = 0;
+	struct page *page;
+
+	pr_devel("H_INT_SET_QUEUE_CONFIG flags=%08lx server=%ld priority=%ld qpage=%08lx qsize=%ld\n",
+		 flags, server, priority, qpage, qsize);
+
+	if (flags & ~XIVE_SPAPR_EQ_ALWAYS_NOTIFY)
+		return H_PARAMETER;
+
+	if (xc->server_num != server) {
+		vcpu = kvmppc_xive_find_server(kvm, server);
+		if (!vcpu) {
+			pr_debug("Can't find server %ld\n", server);
+			return H_P2;
+		}
+		xc = vcpu->arch.xive_vcpu;
+	}
+
+	if (priority != xive_prio_from_guest(priority) || priority == MASKED) {
+		pr_err("invalid priority for queue %ld for VCPU %d\n",
+		       priority, xc->server_num);
+		return H_P3;
+	}
+	q = &xc->queues[priority];
+
+	rc = xive_native_validate_queue_size(qsize);
+	if (rc) {
+		pr_err("invalid queue size %ld\n", qsize);
+		return H_P5;
+	}
+
+	/* reset queue and disable queueing */
+	if (!qsize) {
+		rc = xive_native_configure_queue(xc->vp_id, q, priority,
+						 NULL, 0, true);
+		if (rc) {
+			pr_err("Failed to reset queue %ld for VCPU %d: %d\n",
+			       priority, xc->server_num, rc);
+			return H_HARDWARE;
+		}
+
+		if (q->qpage) {
+			put_page(virt_to_page(q->qpage));
+			q->qpage = NULL;
+		}
+
+		return H_SUCCESS;
+	}
+
+	page = gfn_to_page(kvm, gpa_to_gfn(qpage));
+	if (is_error_page(page)) {
+		pr_warn("Couldn't get guest page for %lx!\n", qpage);
+		return H_P4;
+	}
+	qaddr = page_to_virt(page) + (qpage & ~PAGE_MASK);
+
+	rc = xive_native_configure_queue(xc->vp_id, q, priority,
+					 (__be32 *) qaddr, qsize, true);
+	if (rc) {
+		pr_err("Failed to configure queue %ld for VCPU %d: %d\n",
+		       priority, xc->server_num, rc);
+		put_page(page);
+		return H_HARDWARE;
+	}
+
+	rc = kvmppc_xive_attach_escalation(vcpu, priority);
+	if (rc) {
+		xive_native_cleanup_queue(vcpu, priority);
+		return H_HARDWARE;
+	}
+
+	return H_SUCCESS;
+}
+
+static void kvmppc_xive_reset_sources(struct kvmppc_xive_src_block *sb)
+{
+	int i;
+
+	for (i = 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
+		struct kvmppc_xive_irq_state *state = &sb->irq_state[i];
+
+		if (!state->valid)
+			continue;
+
+		if (state->act_priority == MASKED)
+			continue;
+
+		arch_spin_lock(&sb->lock);
+		state->eisn = 0;
+		state->act_server = 0;
+		state->act_priority = MASKED;
+		xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
+		xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
+		if (state->pt_number) {
+			xive_vm_esb_load(state->pt_data, XIVE_ESB_SET_PQ_01);
+			xive_native_configure_irq(state->pt_number,
+						  0, MASKED, 0);
+		}
+		arch_spin_unlock(&sb->lock);
+	}
+}
+
+static int kvmppc_h_int_reset(struct kvmppc_xive *xive, unsigned long flags)
+{
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	unsigned int i;
+
+	pr_devel("H_INT_RESET flags=%08lx\n", flags);
+
+	if (flags)
+		return H_PARAMETER;
+
+	mutex_lock(&kvm->lock);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+		unsigned int prio;
+
+		if (!xc)
+			continue;
+
+		kvmppc_xive_disable_vcpu_interrupts(vcpu);
+
+		for (prio = 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
+
+			if (xc->esc_virq[prio]) {
+				free_irq(xc->esc_virq[prio], vcpu);
+				irq_dispose_mapping(xc->esc_virq[prio]);
+				kfree(xc->esc_virq_names[prio]);
+				xc->esc_virq[prio] = 0;
+			}
+
+			xive_native_cleanup_queue(vcpu, prio);
+		}
+	}
+
+	for (i = 0; i <= xive->max_sbid; i++) {
+		if (xive->src_blocks[i])
+			kvmppc_xive_reset_sources(xive->src_blocks[i]);
+	}
+
+	mutex_unlock(&kvm->lock);
+
+	return H_SUCCESS;
+}
+
+int kvmppc_xive_native_hcall(struct kvm_vcpu *vcpu, u32 req)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	int rc;
+
+	if (!xive || !vcpu->arch.xive_vcpu)
+		return H_FUNCTION;
+
+	switch (req) {
+	case H_INT_SET_QUEUE_CONFIG:
+		rc = kvmppc_h_int_set_queue_config(vcpu,
+						   kvmppc_get_gpr(vcpu, 4),
+						   kvmppc_get_gpr(vcpu, 5),
+						   kvmppc_get_gpr(vcpu, 6),
+						   kvmppc_get_gpr(vcpu, 7),
+						   kvmppc_get_gpr(vcpu, 8));
+		break;
+
+	case H_INT_SET_SOURCE_CONFIG:
+		rc = kvmppc_h_int_set_source_config(vcpu,
+						    kvmppc_get_gpr(vcpu, 4),
+						    kvmppc_get_gpr(vcpu, 5),
+						    kvmppc_get_gpr(vcpu, 6),
+						    kvmppc_get_gpr(vcpu, 7),
+						    kvmppc_get_gpr(vcpu, 8));
+		break;
+
+	case H_INT_RESET:
+		rc = kvmppc_h_int_reset(xive, kvmppc_get_gpr(vcpu, 4));
+		break;
+
+	default:
+		rc =  H_NOT_AVAILABLE;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(kvmppc_xive_native_hcall);
+
 static int xive_native_debug_show(struct seq_file *m, void *private)
 {
 	struct kvmppc_xive *xive = m->private;
@@ -614,10 +920,26 @@ struct kvm_device_ops kvm_xive_native_ops = {
 
 void kvmppc_xive_native_init_module(void)
 {
-	;
+	__xive_vm_h_int_get_source_info = xive_vm_h_int_get_source_info;
+	__xive_vm_h_int_get_source_config = xive_vm_h_int_get_source_config;
+	__xive_vm_h_int_get_queue_info = xive_vm_h_int_get_queue_info;
+	__xive_vm_h_int_get_queue_config = xive_vm_h_int_get_queue_config;
+	__xive_vm_h_int_set_os_reporting_line =
+		xive_vm_h_int_set_os_reporting_line;
+	__xive_vm_h_int_get_os_reporting_line =
+		xive_vm_h_int_get_os_reporting_line;
+	__xive_vm_h_int_esb = xive_vm_h_int_esb;
+	__xive_vm_h_int_sync = xive_vm_h_int_sync;
 }
 
 void kvmppc_xive_native_exit_module(void)
 {
-	;
+	__xive_vm_h_int_get_source_info = NULL;
+	__xive_vm_h_int_get_source_config = NULL;
+	__xive_vm_h_int_get_queue_info = NULL;
+	__xive_vm_h_int_get_queue_config = NULL;
+	__xive_vm_h_int_set_os_reporting_line = NULL;
+	__xive_vm_h_int_get_os_reporting_line = NULL;
+	__xive_vm_h_int_esb = NULL;
+	__xive_vm_h_int_sync = NULL;
 }
diff --git a/arch/powerpc/kvm/book3s_xive_native_template.c b/arch/powerpc/kvm/book3s_xive_native_template.c
index e7260da4a596..ccde2786d203 100644
--- a/arch/powerpc/kvm/book3s_xive_native_template.c
+++ b/arch/powerpc/kvm/book3s_xive_native_template.c
@@ -8,6 +8,279 @@
 #define XGLUE(a, b) a##b
 #define GLUE(a, b) XGLUE(a, b)
 
+X_STATIC int GLUE(X_PFX, h_int_get_source_info)(struct kvm_vcpu *vcpu,
+						unsigned long flags,
+						unsigned long irq)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct xive_irq_data *xd;
+	u32 hw_num;
+	u16 src;
+	unsigned long esb_addr;
+
+	pr_devel("H_INT_GET_SOURCE_INFO flags=%08lx irq=%lx\n", flags, irq);
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags)
+		return H_PARAMETER;
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb) {
+		pr_debug("source %lx not found !\n", irq);
+		return H_P2;
+	}
+	state = &sb->irq_state[src];
+
+	arch_spin_lock(&sb->lock);
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+
+	vcpu->arch.regs.gpr[4] = 0;
+	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
+		vcpu->arch.regs.gpr[4] |= XIVE_SPAPR_SRC_STORE_EOI;
+
+	/*
+	 * Force the use of the H_INT_ESB hcall in case of a Virtual
+	 * LSI interrupt. This is necessary under KVM to re-trigger
+	 * the interrupt if the level is still asserted
+	 */
+	if (state->lsi) {
+		vcpu->arch.regs.gpr[4] |= XIVE_SPAPR_SRC_LSI;
+		vcpu->arch.regs.gpr[4] |= XIVE_SPAPR_SRC_H_INT_ESB;
+	}
+
+	/*
+	 * Linux/KVM uses a two pages ESB setting, one for trigger and
+	 * one for EOI
+	 */
+	esb_addr = xive->vc_base + (irq << (PAGE_SHIFT + 1));
+
+	/* EOI/management page is the second/odd page */
+	if (xd->eoi_page &&
+	    !(vcpu->arch.regs.gpr[4] & XIVE_SPAPR_SRC_H_INT_ESB))
+		vcpu->arch.regs.gpr[5] = esb_addr + (1ull << PAGE_SHIFT);
+	else
+		vcpu->arch.regs.gpr[5] = -1;
+
+	/* Trigger page is always the first/even page */
+	if (xd->trig_page)
+		vcpu->arch.regs.gpr[6] = esb_addr;
+	else
+		vcpu->arch.regs.gpr[6] = -1;
+
+	vcpu->arch.regs.gpr[7] = PAGE_SHIFT;
+	arch_spin_unlock(&sb->lock);
+	return H_SUCCESS;
+}
+
+X_STATIC int GLUE(X_PFX, h_int_get_source_config)(struct kvm_vcpu *vcpu,
+						  unsigned long flags,
+						  unsigned long irq)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	u16 src;
+
+	pr_devel("H_INT_GET_SOURCE_CONFIG flags=%08lx irq=%lx\n", flags, irq);
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags)
+		return H_PARAMETER;
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb) {
+		pr_debug("source %lx not found !\n", irq);
+		return H_P2;
+	}
+	state = &sb->irq_state[src];
+
+	arch_spin_lock(&sb->lock);
+	vcpu->arch.regs.gpr[4] = state->act_server;
+	vcpu->arch.regs.gpr[5] = state->act_priority;
+	vcpu->arch.regs.gpr[6] = state->number;
+	arch_spin_unlock(&sb->lock);
+
+	return H_SUCCESS;
+}
+
+X_STATIC int GLUE(X_PFX, h_int_get_queue_info)(struct kvm_vcpu *vcpu,
+					       unsigned long flags,
+					       unsigned long server,
+					       unsigned long priority)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct xive_q *q;
+
+	pr_devel("H_INT_GET_QUEUE_INFO flags=%08lx server=%ld priority=%ld\n",
+		 flags, server, priority);
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags)
+		return H_PARAMETER;
+
+	if (xc->server_num != server) {
+		struct kvm_vcpu *vc;
+
+		vc = kvmppc_xive_find_server(vcpu->kvm, server);
+		if (!vc) {
+			pr_debug("server %ld not found\n", server);
+			return H_P2;
+		}
+		xc = vc->arch.xive_vcpu;
+	}
+
+	if (priority != xive_prio_from_guest(priority) || priority == MASKED) {
+		pr_debug("invalid priority for queue %ld for VCPU %ld\n",
+		       priority, server);
+		return H_P3;
+	}
+	q = &xc->queues[priority];
+
+	vcpu->arch.regs.gpr[4] = q->eoi_phys;
+	/* TODO: Power of 2 page size of the notification page */
+	vcpu->arch.regs.gpr[5] = 0;
+	return H_SUCCESS;
+}
+
+X_STATIC int GLUE(X_PFX, get_queue_state)(struct kvm_vcpu *vcpu,
+					  struct kvmppc_xive_vcpu *xc,
+					  unsigned long prio)
+{
+	int rc;
+	u32 qtoggle;
+	u32 qindex;
+
+	rc = xive_native_get_queue_state(xc->vp_id, prio, &qtoggle, &qindex);
+	if (rc)
+		return rc;
+
+	vcpu->arch.regs.gpr[4] |= ((unsigned long) qtoggle) << 62;
+	vcpu->arch.regs.gpr[7] = qindex;
+	return 0;
+}
+
+X_STATIC int GLUE(X_PFX, h_int_get_queue_config)(struct kvm_vcpu *vcpu,
+						 unsigned long flags,
+						 unsigned long server,
+						 unsigned long priority)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct xive_q *q;
+	u64 qpage;
+	u64 qsize;
+	u64 qeoi_page;
+	u32 escalate_irq;
+	u64 qflags;
+	int rc;
+
+	pr_devel("H_INT_GET_QUEUE_CONFIG flags=%08lx server=%ld priority=%ld\n",
+		 flags, server, priority);
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags & ~XIVE_SPAPR_EQ_DEBUG)
+		return H_PARAMETER;
+
+	if (xc->server_num != server) {
+		struct kvm_vcpu *vc;
+
+		vc = kvmppc_xive_find_server(vcpu->kvm, server);
+		if (!vc) {
+			pr_debug("server %ld not found\n", server);
+			return H_P2;
+		}
+		xc = vc->arch.xive_vcpu;
+	}
+
+	if (priority != xive_prio_from_guest(priority) || priority == MASKED) {
+		pr_debug("invalid priority for queue %ld for VCPU %ld\n",
+		       priority, server);
+		return H_P3;
+	}
+	q = &xc->queues[priority];
+
+	rc = xive_native_get_queue_info(xc->vp_id, priority, &qpage, &qsize,
+					&qeoi_page, &escalate_irq, &qflags);
+	if (rc)
+		return H_HARDWARE;
+
+	vcpu->arch.regs.gpr[4] = 0;
+	if (qflags & OPAL_XIVE_EQ_ALWAYS_NOTIFY)
+		vcpu->arch.regs.gpr[4] |= XIVE_SPAPR_EQ_ALWAYS_NOTIFY;
+
+	vcpu->arch.regs.gpr[5] = qpage;
+	vcpu->arch.regs.gpr[6] = qsize;
+	if (flags & XIVE_SPAPR_EQ_DEBUG) {
+		rc = GLUE(X_PFX, get_queue_state)(vcpu, xc, priority);
+		if (rc)
+			return H_HARDWARE;
+	}
+	return H_SUCCESS;
+}
+
+/* TODO H_INT_SET_OS_REPORTING_LINE */
+X_STATIC int GLUE(X_PFX, h_int_set_os_reporting_line)(struct kvm_vcpu *vcpu,
+						      unsigned long flags,
+						      unsigned long line)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+
+	pr_devel("H_INT_SET_OS_REPORTING_LINE flags=%08lx line=%ld\n",
+		 flags, line);
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags)
+		return H_PARAMETER;
+
+	return H_FUNCTION;
+}
+
+/* TODO H_INT_GET_OS_REPORTING_LINE*/
+X_STATIC int GLUE(X_PFX, h_int_get_os_reporting_line)(struct kvm_vcpu *vcpu,
+						      unsigned long flags,
+						      unsigned long server,
+						      unsigned long line)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+
+	pr_devel("H_INT_GET_OS_REPORTING_LINE flags=%08lx server=%ld line=%ld\n",
+		 flags, server, line);
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags)
+		return H_PARAMETER;
+
+	if (xc->server_num != server) {
+		struct kvm_vcpu *vc;
+
+		vc = kvmppc_xive_find_server(vcpu->kvm, server);
+		if (!vc) {
+			pr_debug("server %ld not found\n", server);
+			return H_P2;
+		}
+		xc = vc->arch.xive_vcpu;
+	}
+
+	return H_FUNCTION;
+
+}
+
 /*
  * TODO: introduce a common template file with the XIVE native layer
  * and the XICS-on-XIVE glue for the utility functions
@@ -25,3 +298,101 @@ static u8 GLUE(X_PFX, esb_load)(struct xive_irq_data *xd, u32 offset)
 #endif
 	return (u8)val;
 }
+
+static u8 GLUE(X_PFX, esb_store)(struct xive_irq_data *xd, u32 offset, u64 data)
+{
+	u64 val;
+
+	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
+		offset |= offset << 4;
+
+	val = __x_readq(__x_eoi_page(xd) + offset);
+#ifdef __LITTLE_ENDIAN__
+	val >>= 64-8;
+#endif
+	return (u8)val;
+}
+
+X_STATIC int GLUE(X_PFX, h_int_esb)(struct kvm_vcpu *vcpu, unsigned long flags,
+				    unsigned long irq, unsigned long offset,
+				    unsigned long data)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct xive_irq_data *xd;
+	u32 hw_num;
+	u16 src;
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags)
+		return H_PARAMETER;
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb) {
+		pr_debug("source %lx not found !\n", irq);
+		return H_P2;
+	}
+	state = &sb->irq_state[src];
+
+	if (offset > (1ull << PAGE_SHIFT))
+		return H_P3;
+
+	arch_spin_lock(&sb->lock);
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+
+	if (flags & XIVE_SPAPR_ESB_STORE) {
+		GLUE(X_PFX, esb_store)(xd, offset, data);
+		vcpu->arch.regs.gpr[4] = -1;
+	} else {
+		/* Virtual LSI EOI handling */
+		if (state->lsi && offset == XIVE_ESB_LOAD_EOI) {
+			GLUE(X_PFX, esb_load)(xd, XIVE_ESB_SET_PQ_00);
+			if (state->asserted && __x_trig_page(xd))
+				__x_writeq(0, __x_trig_page(xd));
+			vcpu->arch.regs.gpr[4] = 0;
+		} else {
+			vcpu->arch.regs.gpr[4] =
+				GLUE(X_PFX, esb_load)(xd, offset);
+		}
+	}
+	arch_spin_unlock(&sb->lock);
+
+	return H_SUCCESS;
+}
+
+X_STATIC int GLUE(X_PFX, h_int_sync)(struct kvm_vcpu *vcpu, unsigned long flags,
+				     unsigned long irq)
+{
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct xive_irq_data *xd;
+	u32 hw_num;
+	u16 src;
+
+	pr_devel("H_INT_SYNC flags=%08lx irq=%lx\n", flags, irq);
+
+	if (!xive)
+		return H_FUNCTION;
+
+	if (flags)
+		return H_PARAMETER;
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb) {
+		pr_debug("source %lx not found !\n", irq);
+		return H_P2;
+	}
+	state = &sb->irq_state[src];
+
+	arch_spin_lock(&sb->lock);
+
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+	xive_native_sync_source(hw_num);
+
+	arch_spin_unlock(&sb->lock);
+	return H_SUCCESS;
+}
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 806cbe488410..1a5c65c59b13 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -81,6 +81,8 @@ kvm-hv-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
 
 kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) := \
 	book3s_hv_rm_xics.o book3s_hv_rm_xive.o
+kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XIVE) += \
+	book3s_hv_rm_xive_native.o
 
 kvm-book3s_64-builtin-tm-objs-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
 	book3s_hv_tm_builtin.o
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9b8d50a7cbaf..25b9489de249 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2462,6 +2462,58 @@ hcall_real_table:
 	.long	0		/* 0x2fc - H_XIRR_X*/
 #endif
 	.long	DOTSYM(kvmppc_h_random) - hcall_real_table
+	.long	0		/* 0x304 */
+	.long	0		/* 0x308 */
+	.long	0		/* 0x30c */
+	.long	0		/* 0x310 */
+	.long	0		/* 0x314 */
+	.long	0		/* 0x318 */
+	.long	0		/* 0x31c */
+	.long	0		/* 0x320 */
+	.long	0		/* 0x324 */
+	.long	0		/* 0x328 */
+	.long	0		/* 0x32c */
+	.long	0		/* 0x330 */
+	.long	0		/* 0x334 */
+	.long	0		/* 0x338 */
+	.long	0		/* 0x33c */
+	.long	0		/* 0x340 */
+	.long	0		/* 0x344 */
+	.long	0		/* 0x348 */
+	.long	0		/* 0x34c */
+	.long	0		/* 0x350 */
+	.long	0		/* 0x354 */
+	.long	0		/* 0x358 */
+	.long	0		/* 0x35c */
+	.long	0		/* 0x360 */
+	.long	0		/* 0x364 */
+	.long	0		/* 0x368 */
+	.long	0		/* 0x36c */
+	.long	0		/* 0x370 */
+	.long	0		/* 0x374 */
+	.long	0		/* 0x378 */
+	.long	0		/* 0x37c */
+	.long	0		/* 0x380 */
+	.long	0		/* 0x384 */
+	.long	0		/* 0x388 */
+	.long	0		/* 0x38c */
+	.long	0		/* 0x390 */
+	.long	0		/* 0x394 */
+	.long	0		/* 0x398 */
+	.long	0		/* 0x39c */
+	.long	0		/* 0x3a0 */
+	.long	0		/* 0x3a4 */
+	.long	DOTSYM(kvmppc_rm_h_int_get_source_info) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_set_source_config) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_get_source_config) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_get_queue_info) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_set_queue_config) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_get_queue_config) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_set_os_reporting_line) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_get_os_reporting_line) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_esb) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_sync) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_int_reset) - hcall_real_table
 	.globl	hcall_real_table_end
 hcall_real_table_end:
 
-- 
2.20.1

