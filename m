Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C0D05B7A2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 19:08:38 +1000 (EST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84E4ADDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:08:38 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5A96qub016893
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:06:52 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5A98aHt467318
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:08:36 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5A98akU018081
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:08:36 +1000
Date: Wed, 10 Jun 2009 14:38:29 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 6/6] Adapt kexec and samples code to recognise PPC64
	hardware breakpoint usage
Message-ID: <20090610090829.GG14478@in.ibm.com>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
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
 
