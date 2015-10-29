Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D91F1A0BE5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 10:41:00 +1100 (AEDT)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43FFD1412DD
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2015 10:40:59 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 29 Oct 2015 17:40:57 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A62BC1FF002D
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2015 17:29:06 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9TNdUkw2032096
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2015 16:39:30 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9TNes5i003222
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2015 17:40:54 -0600
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc/smp: Add smp_muxed_ipi_rm_message_pass
Date: Thu, 29 Oct 2015 18:40:45 -0500
Message-Id: <1446162045-26496-3-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1446162045-26496-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1446162045-26496-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function supports IPI message passing for real
mode callers.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/smp.h |  1 +
 arch/powerpc/kernel/smp.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 9ef9c37..851a37a 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -124,6 +124,7 @@ extern const char *smp_ipi_name[];
 /* for irq controllers with only a single ipi */
 extern void smp_muxed_ipi_set_data(int cpu, unsigned long data);
 extern void smp_muxed_ipi_message_pass(int cpu, int msg);
+extern void smp_muxed_ipi_rm_message_pass(int cpu, int msg);
 extern irqreturn_t smp_ipi_demux(void);
 
 void smp_init_pSeries(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a53a130..8c07bfad 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -53,6 +53,9 @@
 #include <asm/vdso.h>
 #include <asm/debug.h>
 #include <asm/kexec.h>
+#ifdef CONFIG_KVM_XICS
+#include <asm/xics.h>
+#endif
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -235,6 +238,33 @@ void smp_muxed_ipi_message_pass(int cpu, int msg)
 	smp_ops->cause_ipi(cpu, info->data);
 }
 
+#if defined(CONFIG_KVM_XICS) && defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
+/*
+ * Message passing code for real mode callers. It does not use the
+ * smp_ops->cause_ipi function to cause an IPI, because those functions
+ * access the MFFR through an ioremapped address.
+ */
+void smp_muxed_ipi_rm_message_pass(int cpu, int msg)
+{
+	struct cpu_messages *info = &per_cpu(ipi_message, cpu);
+	char *message = (char *)&info->messages;
+	unsigned long xics_phys;
+
+	/*
+	 * Order previous accesses before accesses in the IPI handler.
+	 */
+	smp_mb();
+	message[msg] = 1;
+
+	/*
+	 * cause_ipi functions are required to include a full barrier
+	 * before doing whatever causes the IPI.
+	 */
+	xics_phys = paca[cpu].kvm_hstate.xics_phys;
+	out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
+}
+#endif
+
 #ifdef __BIG_ENDIAN__
 #define IPI_MESSAGE(A) (1uL << ((BITS_PER_LONG - 8) - 8 * (A)))
 #else
-- 
1.8.3.4
