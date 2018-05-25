Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40shp43zJMzF1fp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 20:10:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 19/23] powerpc/pseries: Fix clearing of security
 feature flags
Date: Fri, 25 May 2018 20:09:50 +1000
Message-Id: <20180525100954.31599-20-mpe@ellerman.id.au>
In-Reply-To: <20180525100954.31599-1-mpe@ellerman.id.au>
References: <20180525100954.31599-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

The H_CPU_BEHAV_* flags should be checked for in the 'behaviour' field
of 'struct h_cpu_char_result' -- 'character' is for H_CPU_CHAR_*
flags.

Found by playing around with QEMU's implementation of the hypercall:

  H_CPU_CHAR=0xf000000000000000
  H_CPU_BEHAV=0x0000000000000000

  This clears H_CPU_BEHAV_FAVOUR_SECURITY and H_CPU_BEHAV_L1D_FLUSH_PR
  so pseries_setup_rfi_flush() disables 'rfi_flush'; and it also
  clears H_CPU_CHAR_L1D_THREAD_PRIV flag. So there is no RFI flush
  mitigation at all for cpu_show_meltdown() to report; but currently
  it does:

  Original kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/meltdown
    Mitigation: RFI Flush

  Patched kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/meltdown
    Not affected

  H_CPU_CHAR=0x0000000000000000
  H_CPU_BEHAV=0xf000000000000000

  This sets H_CPU_BEHAV_BNDS_CHK_SPEC_BAR so cpu_show_spectre_v1() should
  report vulnerable; but currently it doesn't:

  Original kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
    Not affected

  Patched kernel:

    # cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
    Vulnerable

Brown-paper-bag-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: f636c14790ea ("powerpc/pseries: Set or clear security feature flags")
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
(cherry picked from commit 0f9bdfe3c77091e8704d2e510eb7c2c2c6cde524)
---
 arch/powerpc/platforms/pseries/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ba0a36c577ca..3cb12d27f168 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -484,13 +484,13 @@ static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
 	 */
-	if (!(result->character & H_CPU_BEHAV_FAVOUR_SECURITY))
+	if (!(result->behaviour & H_CPU_BEHAV_FAVOUR_SECURITY))
 		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
 
-	if (!(result->character & H_CPU_BEHAV_L1D_FLUSH_PR))
+	if (!(result->behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
 		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
 
-	if (!(result->character & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
+	if (!(result->behaviour & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
 		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);
 }
 
-- 
2.14.1
