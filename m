Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCf4f6XCjzDvTG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 17:08:18 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 144so9841374pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 22:08:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: add definitions for new H_SIGNAL_SYS_RESET
 hcall
Date: Tue,  8 Nov 2016 17:08:06 +1100
Message-Id: <20161108060806.16168-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This has not made its way to a PAPR release yet, but we have an hcall
number assigned.

  H_SIGNAL_SYS_RESET = 0x380

  Syntax:
  hcall(uint64 H_SIGNAL_SYS_RESET, /* generate a system reset NMI on   */
                                   /* the threads indicated by target  */
        int64 target); /* thread target selection */
        /* -1 = target all online threads including the caller         */
        /* -2 = target all online threads except for the caller        */
        /* All other negative values: reserved                         */
        /* Positive values: The thread to be targeted,                 */
        /* obtained from the value of the "ibm,ppc-interrupt-server#s" */
        /* property of the CPU in the OF device tree                   */

  Semantics:
  - If the NMI handlers are not registered, terminate the partition.
  - Invalid target: return H_Parameter.
  - Otherwise: Generate a system reset NMI on target thread(s),
    return H_Success.

This will be used by crash/debug code to get stuck CPUs into a known state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I'll get the NMI stuff resubmitted soon, but just wanted to send
out this hcall addition now, for reference.

Thanks,
Nick

 arch/powerpc/include/asm/hvcall.h         | 8 +++++++-
 arch/powerpc/include/asm/plpar_wrappers.h | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 708edeb..d52ef28 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -275,7 +275,8 @@
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
 #define H_SET_MODE		0x31C
-#define MAX_HCALL_OPCODE	H_SET_MODE
+#define H_SIGNAL_SYS_RESET	0x380
+#define MAX_HCALL_OPCODE	H_SIGNAL_SYS_RESET
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
@@ -306,6 +307,11 @@
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE	3
 #define H_SET_MODE_RESOURCE_LE			4
 
+/* Values for argument to H_SIGNAL_SYS_RESET */
+#define H_SIGNAL_SYS_RESET_ALL			-1
+#define H_SIGNAL_SYS_RESET_ALLBUTSELF		-2
+/* >= 0 values are CPU number */
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 1b39424..9642ae8 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -340,4 +340,9 @@ static inline long plapr_set_watchpoint0(unsigned long dawr0, unsigned long dawr
 	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR, dawr0, dawrx0);
 }
 
+static inline long plapr_signal_sys_reset(long cpu)
+{
+	return plpar_hcall_norets(H_SIGNAL_SYS_RESET, cpu);
+}
+
 #endif /* _ASM_POWERPC_PLPAR_WRAPPERS_H */
-- 
2.10.2
