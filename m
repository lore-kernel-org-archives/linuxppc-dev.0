Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc/tm: Make room for hypervisor in abort cause codes
Date: Mon, 27 May 2013 14:09:37 +1000
Message-Id: <1369627781-31088-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1369627781-31088-1-git-send-email-mikey@neuling.org>
References: <1369627781-31088-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAPR carves out 0xff-0xe0 for hypervisor use of transactional memory software
abort cause codes.  Unfortunately we don't respect this currently.

Below fixes this to move our cause codes to below this region.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> # 3.9 only
---
 arch/powerpc/include/asm/reg.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a613651..8f6a94b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -113,14 +113,15 @@
 
 /* Reason codes describing kernel causes for transaction aborts.  By
    convention, bit0 is copied to TEXASR[56] (IBM bit 7) which is set if
-   the failure is persistent.
+   the failure is persistent.  PAPR saves 0xff-0xe0 for the hypervisor.
 */
-#define TM_CAUSE_RESCHED	0xfe
-#define TM_CAUSE_TLBI		0xfc
-#define TM_CAUSE_FAC_UNAV	0xfa
-#define TM_CAUSE_SYSCALL	0xf9 /* Persistent */
-#define TM_CAUSE_MISC		0xf6
-#define TM_CAUSE_SIGNAL		0xf4
+#define TM_CAUSE_PERSISTENT	0x01
+#define TM_CAUSE_RESCHED	0xde
+#define TM_CAUSE_TLBI		0xdc
+#define TM_CAUSE_FAC_UNAV	0xda
+#define TM_CAUSE_SYSCALL	0xd8  /* future use */
+#define TM_CAUSE_MISC		0xd6  /* future use */
+#define TM_CAUSE_SIGNAL		0xd4
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define MSR_64BIT	MSR_SF
-- 
1.7.10.4
