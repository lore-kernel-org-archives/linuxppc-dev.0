Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 548141A1735
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 07:59:36 +1100 (AEDT)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8B3CD1409A0
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 07:59:35 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 13:59:33 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C51BE3E40030
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:29 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHKxTgT27328588
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:29 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHKxRLB014763
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:29 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v3 3/9] powerpc/xics: Add icp_native_cause_ipi_rm
Date: Thu, 17 Dec 2015 14:59:05 -0600
Message-Id: <1450385951-25128-4-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function to cause an IPI by directly updating the MFFR register
in the XICS. The function is meant for real-mode callers since
they cannot use the smp_ops->cause_ipi function which uses an
ioremapped address.

Normal usage is for the the KVM real mode code to set the IPI message
using smp_muxed_ipi_message_pass and then invoke icp_native_cause_ipi_rm
to cause the actual IPI.

The function requires kvm_hstate.xics_phys to have been initialized
with the physical address of XICS.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/xics.h       |  1 +
 arch/powerpc/sysdev/xics/icp-native.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 0e25bdb..2546048 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -30,6 +30,7 @@
 #ifdef CONFIG_PPC_ICP_NATIVE
 extern int icp_native_init(void);
 extern void icp_native_flush_interrupt(void);
+extern void icp_native_cause_ipi_rm(int cpu);
 #else
 static inline int icp_native_init(void) { return -ENODEV; }
 #endif
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index eae3265..afdf62f 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -159,6 +159,27 @@ static void icp_native_cause_ipi(int cpu, unsigned long data)
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+void icp_native_cause_ipi_rm(int cpu)
+{
+	/*
+	 * Currently not used to send IPIs to another CPU
+	 * on the same core. Only caller is KVM real mode.
+	 * Need the physical address of the XICS to be
+	 * previously saved in kvm_hstate in the paca.
+	 */
+	unsigned long xics_phys;
+
+	/*
+	 * Just like the cause_ipi functions, it is required to
+	 * include a full barrier (out8 includes a sync) before
+	 * causing the IPI.
+	 */
+	xics_phys = paca[cpu].kvm_hstate.xics_phys;
+	out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
+}
+#endif
+
 /*
  * Called when an interrupt is received on an off-line CPU to
  * clear the interrupt, so that the CPU can go back to nap mode.
-- 
1.8.3.4
