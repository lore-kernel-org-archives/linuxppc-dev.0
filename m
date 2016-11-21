Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMc1M1RfczDvhX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:03:03 +1100 (AEDT)
Date: Mon, 21 Nov 2016 16:02:35 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 4/4] powerpc/64: Define new ISA v3.00 logical PVR value and
 PCR register value
Message-ID: <20161121050235.GG26748@fergus.ozlabs.ibm.com>
References: <1479704214-29147-1-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479704214-29147-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

ISA 3.00 adds the logical PVR value 0x0f000005, so add a definition for
this.

Define PCR_ARCH_207 to reflect ISA 2.07 compatibility mode in the processor
compatibility register (PCR).

[paulus@ozlabs.org - moved dummy PCR_ARCH_300 value into next patch]

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/reg.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d2f868a..9214e6f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -377,6 +377,12 @@
 #define   PCR_VEC_DIS	(1ul << (63-0))	/* Vec. disable (bit NA since POWER8) */
 #define   PCR_VSX_DIS	(1ul << (63-1))	/* VSX disable (bit NA since POWER8) */
 #define   PCR_TM_DIS	(1ul << (63-2))	/* Trans. memory disable (POWER8) */
+/*
+ * These bits are used in the function kvmppc_set_arch_compat() to specify and
+ * determine both the compatibility level which we want to emulate and the
+ * compatibility level which the host is capable of emulating.
+ */
+#define   PCR_ARCH_207	0x8		/* Architecture 2.07 */
 #define   PCR_ARCH_206	0x4		/* Architecture 2.06 */
 #define   PCR_ARCH_205	0x2		/* Architecture 2.05 */
 #define	SPRN_HEIR	0x153	/* Hypervisor Emulated Instruction Register */
@@ -1218,6 +1224,7 @@
 #define PVR_ARCH_206	0x0f000003
 #define PVR_ARCH_206p	0x0f100003
 #define PVR_ARCH_207	0x0f000004
+#define PVR_ARCH_300	0x0f000005
 
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
-- 
2.7.4
