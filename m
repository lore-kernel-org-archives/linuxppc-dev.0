Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP4hV2pkpzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:38:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 2/2] powerpc/mm: Blacklist SLB symbols from kprobe
Date: Thu, 16 Feb 2017 16:38:45 +1100
Message-Id: <1487223525-2665-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1487223525-2665-1-git-send-email-mpe@ellerman.id.au>
References: <1487223525-2665-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't sensibly take a trap at this point. So, blacklist these
symbols.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slb_low.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 9beed92c1900..a85e06ea6c20 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -272,3 +272,11 @@ slb_compare_rr_to_size:
 	clrrdi	r3,r3,SID_SHIFT_1T	/* clear out non-ESID bits */
 	b	7b
 
+
+_ASM_NOKPROBE_SYMBOL(slb_allocate_realmode)
+_ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_linear)
+_ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_io)
+_ASM_NOKPROBE_SYMBOL(slb_compare_rr_to_size)
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+_ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_vmemmap)
+#endif
-- 
2.7.4
