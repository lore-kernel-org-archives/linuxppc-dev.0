Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 335821A0373
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 10:45:20 +1100 (AEDT)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA34B1402D6
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2015 10:45:18 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 16:45:16 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7861519D803F
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:33:20 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPNjDFN28377204
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:13 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPNjCPp022615
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2015 16:45:13 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v2 3/9] powerpc/powernv: Add icp_native_cause_ipi_rm
Date: Wed, 25 Nov 2015 17:44:50 -0600
Message-Id: <1448495096-24759-4-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1448495096-24759-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function to cause an IPI. Requires kvm_hstate.xics_phys
to be initialized with physical address of XICS.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/xics.h       |  1 +
 arch/powerpc/sysdev/xics/icp-native.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index eae3265..e39b18a 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -159,6 +159,25 @@ static void icp_native_cause_ipi(int cpu, unsigned long data)
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
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
+
 /*
  * Called when an interrupt is received on an off-line CPU to
  * clear the interrupt, so that the CPU can go back to nap mode.
-- 
1.8.3.4
