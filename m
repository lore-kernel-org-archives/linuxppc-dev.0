Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59gH53FwzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:26:51 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Fix definition of SIAR and SDAR registers
Date: Thu, 12 May 2016 13:26:44 +0200
Message-Id: <1463052404-18092-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SIAR and SDAR registers are available twice, one time as SPRs
780 / 781 (unprivileged, but read-only), and one time as the SPRs
796 / 797 (privileged, but read and write). The Linux kernel code
currently uses the unprivileged  SPRs - while this is OK for reading,
writing to that register of course does not work.
Since the KVM code tries to write to this register, too (see the mtspr
in book3s_hv_rmhandlers.S), the contents of this register sometimes get
lost for the guests, e.g. during migration of a VM.
To fix this issue, simply switch to the privileged SPR numbers instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/include/asm/reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f5f4c66..ce3e1b7 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -752,13 +752,13 @@
 #define SPRN_PMC6	792
 #define SPRN_PMC7	793
 #define SPRN_PMC8	794
-#define SPRN_SIAR	780
-#define SPRN_SDAR	781
 #define SPRN_SIER	784
 #define   SIER_SIPR		0x2000000	/* Sampled MSR_PR */
 #define   SIER_SIHV		0x1000000	/* Sampled MSR_HV */
 #define   SIER_SIAR_VALID	0x0400000	/* SIAR contents valid */
 #define   SIER_SDAR_VALID	0x0200000	/* SDAR contents valid */
+#define SPRN_SIAR	796
+#define SPRN_SDAR	797
 #define SPRN_TACR	888
 #define SPRN_TCSCR	889
 #define SPRN_CSIGR	890
-- 
1.8.3.1
