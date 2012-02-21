Return-Path: <B13201@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C65EB6FAB
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2012 15:51:22 +1100 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <agraf@suse.de>, <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: [PATCH v5 4/4] KVM: PPC: epapr: Update other hypercall invoking
Date: Tue, 21 Feb 2012 12:46:13 +0800
Message-ID: <1329799573-8820-4-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-2-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Liu Yu <yu.liu@freescale.com>,
 B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Discard the old way that invoke hypercall,
instead, use epapr paravirt.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
v5: new patch

 arch/powerpc/include/asm/epapr_hcalls.h |   22 +++++++++---------
 arch/powerpc/include/asm/fsl_hcalls.h   |   36 +++++++++++++++---------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/epapr_hcalls.h b/arch/powerpc/include/asm/epapr_hcalls.h
index 0ff3f24..42f2328 100644
--- a/arch/powerpc/include/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/asm/epapr_hcalls.h
@@ -188,7 +188,7 @@ static inline unsigned int ev_int_set_config(unsigned int interrupt,
 	r5  = priority;
 	r6  = destination;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4), "+r" (r5), "+r" (r6)
 		: : EV_HCALL_CLOBBERS4
 	);
@@ -217,7 +217,7 @@ static inline unsigned int ev_int_get_config(unsigned int interrupt,
 	r11 = EV_HCALL_TOKEN(EV_INT_GET_CONFIG);
 	r3 = interrupt;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "=r" (r4), "=r" (r5), "=r" (r6)
 		: : EV_HCALL_CLOBBERS4
 	);
@@ -247,7 +247,7 @@ static inline unsigned int ev_int_set_mask(unsigned int interrupt,
 	r3 = interrupt;
 	r4 = mask;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -272,7 +272,7 @@ static inline unsigned int ev_int_get_mask(unsigned int interrupt,
 	r11 = EV_HCALL_TOKEN(EV_INT_GET_MASK);
 	r3 = interrupt;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "=r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -300,7 +300,7 @@ static inline unsigned int ev_int_eoi(unsigned int interrupt)
 	r11 = EV_HCALL_TOKEN(EV_INT_EOI);
 	r3 = interrupt;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -339,7 +339,7 @@ static inline unsigned int ev_byte_channel_send(unsigned int handle,
 	r7 = be32_to_cpu(p[2]);
 	r8 = be32_to_cpu(p[3]);
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3),
 		  "+r" (r4), "+r" (r5), "+r" (r6), "+r" (r7), "+r" (r8)
 		: : EV_HCALL_CLOBBERS6
@@ -378,7 +378,7 @@ static inline unsigned int ev_byte_channel_receive(unsigned int handle,
 	r3 = handle;
 	r4 = *count;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4),
 		  "=r" (r5), "=r" (r6), "=r" (r7), "=r" (r8)
 		: : EV_HCALL_CLOBBERS6
@@ -416,7 +416,7 @@ static inline unsigned int ev_byte_channel_poll(unsigned int handle,
 	r11 = EV_HCALL_TOKEN(EV_BYTE_CHANNEL_POLL);
 	r3 = handle;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "=r" (r4), "=r" (r5)
 		: : EV_HCALL_CLOBBERS3
 	);
@@ -449,7 +449,7 @@ static inline unsigned int ev_int_iack(unsigned int handle,
 	r11 = EV_HCALL_TOKEN(EV_INT_IACK);
 	r3 = handle;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "=r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -473,7 +473,7 @@ static inline unsigned int ev_doorbell_send(unsigned int handle)
 	r11 = EV_HCALL_TOKEN(EV_DOORBELL_SEND);
 	r3 = handle;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -493,7 +493,7 @@ static inline unsigned int ev_idle(void)
 
 	r11 = EV_HCALL_TOKEN(EV_IDLE);
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "=r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
diff --git a/arch/powerpc/include/asm/fsl_hcalls.h b/arch/powerpc/include/asm/fsl_hcalls.h
index 922d9b5..3abb583 100644
--- a/arch/powerpc/include/asm/fsl_hcalls.h
+++ b/arch/powerpc/include/asm/fsl_hcalls.h
@@ -96,7 +96,7 @@ static inline unsigned int fh_send_nmi(unsigned int vcpu_mask)
 	r11 = FH_HCALL_TOKEN(FH_SEND_NMI);
 	r3 = vcpu_mask;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -151,7 +151,7 @@ static inline unsigned int fh_partition_get_dtprop(int handle,
 	r9 = (uint32_t)propvalue_addr;
 	r10 = *propvalue_len;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11),
 		  "+r" (r3), "+r" (r4), "+r" (r5), "+r" (r6), "+r" (r7),
 		  "+r" (r8), "+r" (r9), "+r" (r10)
@@ -205,7 +205,7 @@ static inline unsigned int fh_partition_set_dtprop(int handle,
 	r9 = (uint32_t)propvalue_addr;
 	r10 = propvalue_len;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11),
 		  "+r" (r3), "+r" (r4), "+r" (r5), "+r" (r6), "+r" (r7),
 		  "+r" (r8), "+r" (r9), "+r" (r10)
@@ -229,7 +229,7 @@ static inline unsigned int fh_partition_restart(unsigned int partition)
 	r11 = FH_HCALL_TOKEN(FH_PARTITION_RESTART);
 	r3 = partition;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -262,7 +262,7 @@ static inline unsigned int fh_partition_get_status(unsigned int partition,
 	r11 = FH_HCALL_TOKEN(FH_PARTITION_GET_STATUS);
 	r3 = partition;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "=r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -295,7 +295,7 @@ static inline unsigned int fh_partition_start(unsigned int partition,
 	r4 = entry_point;
 	r5 = load;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4), "+r" (r5)
 		: : EV_HCALL_CLOBBERS3
 	);
@@ -317,7 +317,7 @@ static inline unsigned int fh_partition_stop(unsigned int partition)
 	r11 = FH_HCALL_TOKEN(FH_PARTITION_STOP);
 	r3 = partition;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -376,7 +376,7 @@ static inline unsigned int fh_partition_memcpy(unsigned int source,
 #endif
 	r7 = count;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11),
 		  "+r" (r3), "+r" (r4), "+r" (r5), "+r" (r6), "+r" (r7)
 		: : EV_HCALL_CLOBBERS5
@@ -399,7 +399,7 @@ static inline unsigned int fh_dma_enable(unsigned int liodn)
 	r11 = FH_HCALL_TOKEN(FH_DMA_ENABLE);
 	r3 = liodn;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -421,7 +421,7 @@ static inline unsigned int fh_dma_disable(unsigned int liodn)
 	r11 = FH_HCALL_TOKEN(FH_DMA_DISABLE);
 	r3 = liodn;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -447,7 +447,7 @@ static inline unsigned int fh_vmpic_get_msir(unsigned int interrupt,
 	r11 = FH_HCALL_TOKEN(FH_VMPIC_GET_MSIR);
 	r3 = interrupt;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "=r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -469,7 +469,7 @@ static inline unsigned int fh_system_reset(void)
 
 	r11 = FH_HCALL_TOKEN(FH_SYSTEM_RESET);
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "=r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -506,7 +506,7 @@ static inline unsigned int fh_err_get_info(int queue, uint32_t *bufsize,
 	r6 = addr_lo;
 	r7 = peek;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4), "+r" (r5), "+r" (r6),
 		  "+r" (r7)
 		: : EV_HCALL_CLOBBERS5
@@ -542,7 +542,7 @@ static inline unsigned int fh_get_core_state(unsigned int handle,
 	r3 = handle;
 	r4 = vcpu;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -572,7 +572,7 @@ static inline unsigned int fh_enter_nap(unsigned int handle, unsigned int vcpu)
 	r3 = handle;
 	r4 = vcpu;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -597,7 +597,7 @@ static inline unsigned int fh_exit_nap(unsigned int handle, unsigned int vcpu)
 	r3 = handle;
 	r4 = vcpu;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3), "+r" (r4)
 		: : EV_HCALL_CLOBBERS2
 	);
@@ -618,7 +618,7 @@ static inline unsigned int fh_claim_device(unsigned int handle)
 	r11 = FH_HCALL_TOKEN(FH_CLAIM_DEVICE);
 	r3 = handle;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
@@ -645,7 +645,7 @@ static inline unsigned int fh_partition_stop_dma(unsigned int handle)
 	r11 = FH_HCALL_TOKEN(FH_PARTITION_STOP_DMA);
 	r3 = handle;
 
-	__asm__ __volatile__ ("sc 1"
+	asm volatile("bl	epapr_hypercall_start"
 		: "+r" (r11), "+r" (r3)
 		: : EV_HCALL_CLOBBERS1
 	);
-- 
1.7.0.4
