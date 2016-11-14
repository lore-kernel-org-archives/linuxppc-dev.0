Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHBPm4DGFzDvQr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:35:24 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id c4so2567212pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 16:35:24 -0800 (PST)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, agraf@suse.com
Subject: [PATCH V4 1/2] powerpc: Define new ISA v3.00 logical PVR value and
 PCR register value
Date: Mon, 14 Nov 2016 11:35:07 +1100
Message-Id: <1479083708-11797-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1479083708-11797-1-git-send-email-sjitindarsingh@gmail.com>
References: <1479083708-11797-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISA 3.00 adds the logical PVR value 0x0f000005, so add a definition for
this.

Define PCR_ARCH_207 to reflect ISA 2.07 compatibility mode in the processor
compatibility register (PCR).

The next patch changes the algorithm used to determine the required PCR
value in the function kvmppc_set_arch_compat(). We use the PCR_ARCH_XXX
bits to specify and determine the compatibility level which we want to
emulate as well as the compatibility levels which the host is capable
of emulating. To show that we can emulate a v3.00 guest (which is actually
a v3.00 host with no compatility bits set, at the moment) we need a
PCR_ARCH_300 bit to represent this, however currently there is no such bit
defined by the ISA. Thus we define a 'dummy' v3.00 compat bit to be used.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/reg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 9cd4e8c..30d897a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -377,6 +377,16 @@
 #define   PCR_VEC_DIS	(1ul << (63-0))	/* Vec. disable (bit NA since POWER8) */
 #define   PCR_VSX_DIS	(1ul << (63-1))	/* VSX disable (bit NA since POWER8) */
 #define   PCR_TM_DIS	(1ul << (63-2))	/* Trans. memory disable (POWER8) */
+/*
+ * These bits are used in the function kvmppc_set_arch_compat() to specify and
+ * determine both the compatibility level which we want to emulate and the
+ * compatibility level which the host is capable of emulating. Thus we need a
+ * bit to show that we are capable of emulating an ISA v3.00 guest however as
+ * yet no such bit has been defined in the PCR register. Thus we have to define
+ * a 'dummy' value to be used.
+ */
+#define   PCR_ARCH_300	0x10		/* Dummy Architecture 3.00 */
+#define   PCR_ARCH_207	0x8		/* Architecture 2.07 */
 #define   PCR_ARCH_206	0x4		/* Architecture 2.06 */
 #define   PCR_ARCH_205	0x2		/* Architecture 2.05 */
 #define	SPRN_HEIR	0x153	/* Hypervisor Emulated Instruction Register */
@@ -1218,6 +1228,7 @@
 #define PVR_ARCH_206	0x0f000003
 #define PVR_ARCH_206p	0x0f100003
 #define PVR_ARCH_207	0x0f000004
+#define PVR_ARCH_300	0x0f000005
 
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
-- 
2.5.5
