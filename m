Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/pseries: Fix IBM_ARCH_VEC_NRCORES_OFFSET for POWER8
 updates
In-reply-to: <30008.1352442191@neuling.org>
References: <1351661656-6986-1-git-send-email-mikey@neuling.org>
 <1351661656-6986-4-git-send-email-mikey@neuling.org>
 <30008.1352442191@neuling.org>
Date: Thu, 15 Nov 2012 14:53:12 +1100
Message-ID: <23719.1352951592@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In supporting POWER8 we added 16 bytes to the start of the
ibm_architecture_vec, but forgot to add this to
IBM_ARCH_VEC_NRCORES_OFFSET.

This caused us to hit this warning in early boot:
  WARNING ! ibm_architecture_vec structure inconsistent: 805372128

This add this extra 16 bytes of offset.  

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 9ffb542..779f340 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -773,7 +773,7 @@ static unsigned char ibm_architecture_vec[] = {
 	 * must match by the macro below. Update the definition if
 	 * the structure layout changes.
 	 */
-#define IBM_ARCH_VEC_NRCORES_OFFSET	101
+#define IBM_ARCH_VEC_NRCORES_OFFSET	117
 	W(NR_CPUS),			/* number of cores supported */
 	0,
 	0,
