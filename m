Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50722DEC35
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:19:04 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4L7HOIP020145
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:17:24 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4L7J25a254430
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:19:03 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4L7J01c002836
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:19:02 +1000
Date: Thu, 21 May 2009 12:48:52 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 6/6] Adapt kexec and samples code to recognise PPC64
	hardware breakpoint usage
Message-ID: <20090521071852.GG693@in.ibm.com>
References: <20090521070751.156865078@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Modify kexec code to disable DABR registers before a reboot. Adapt the samples
code to populate PPC64-arch specific fields.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_64.c  |    3 +++
 samples/hw_breakpoint/data_breakpoint.c |    4 ++++
 2 files changed, 7 insertions(+)

Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/machine_kexec_64.c
@@ -24,6 +24,7 @@
 #include <asm/sections.h>	/* _end */
 #include <asm/prom.h>
 #include <asm/smp.h>
+#include <asm/hw_breakpoint.h>
 
 int default_machine_kexec_prepare(struct kimage *image)
 {
@@ -214,6 +215,7 @@ static void kexec_prepare_cpus(void)
 	put_cpu();
 
 	local_irq_disable();
+	hw_breakpoint_disable();
 }
 
 #else /* ! SMP */
@@ -233,6 +235,7 @@ static void kexec_prepare_cpus(void)
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(0, 0);
 	local_irq_disable();
+	hw_breakpoint_disable();
 }
 
 #endif /* SMP */
Index: linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/samples/hw_breakpoint/data_breakpoint.c
+++ linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c
@@ -54,6 +54,10 @@ static int __init hw_break_module_init(v
 	sample_hbp.info.type = HW_BREAKPOINT_WRITE;
 	sample_hbp.info.len = HW_BREAKPOINT_LEN_4;
 #endif /* CONFIG_X86 */
+#ifdef CONFIG_PPC64
+	sample_hbp.info.name = ksym_name;
+	sample_hbp.info.type = HW_BREAKPOINT_WRITE;
+#endif /* CONFIG_PPC64 */
 
 	sample_hbp.triggered = (void *)sample_hbp_handler;
 
