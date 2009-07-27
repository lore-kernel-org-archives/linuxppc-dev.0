Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1E420B8423
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 10:19:16 +1000 (EST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43685DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 10:19:14 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id n6R0JATe015096
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 05:49:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6R0JAlr2461792
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 05:49:10 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6R0J9v6019352
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 05:49:09 +0530
Date: Mon, 27 Jul 2009 05:49:05 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 6/6] Adapt kexec and samples code to recognise PPC64
	hardware breakpoint usage
Message-ID: <20090727001905.GG13562@in.ibm.com>
References: <20090726235854.574539012@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
 
