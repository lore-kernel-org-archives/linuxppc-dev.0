Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7fPn65myzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 17:10:21 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id u12so3165305pfl.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 23:10:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/powernv: Avoid the secondary hold spinloop for
 OPAL boot
Date: Fri,  6 Oct 2017 16:10:03 +1000
Message-Id: <20171006061005.29891-2-npiggin@gmail.com>
In-Reply-To: <20171006061005.29891-1-npiggin@gmail.com>
References: <20171006061005.29891-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL boot does not insert secondaries at 0x60 to wait at the secondary
hold spinloop. Instead it keeps them held in firmware until the
opal_start_cpu call is made, which directs them where the caller
specifies. Linux inserts them into generic_secondary_smp_init(), which
is after the secondary hold spinloop (they go on to spin at the per-CPU
paca loops, but that is another step).

So avoid waiting on this spinloop when booting with OPAL firmware.
It always just times out.

This saves 100ms boot time on bare metal, and 10s of seconds when
booting the simulator in SMP.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/head_64.S  |  4 +++-
 arch/powerpc/kernel/setup_64.c | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index c9e760ec7530..1ebfb3f2cbbb 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -60,7 +60,9 @@
  *   1. The MMU is off, processor in HV mode, primary CPU enters at 0
  *      with device-tree in gpr3. We also get OPAL base in r8 and
  *	entry in r9 for debugging purposes
- *   2. Secondary processors enter at 0x60 with PIR in gpr3
+ *   2. Secondary processors enter as directed by opal_start_cpu(), which
+ *      is generic_secondary_smp_init, with PIR in gpr3. The secondary spin
+ *      code is not used.
  *
  *  For Book3E processors:
  *   1. The MMU is on running in AS0 in a state defined in ePAPR
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3f2453858f60..eada0a7b73f8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -363,8 +363,18 @@ void early_setup_secondary(void)
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC_CORE)
 static bool use_spinloop(void)
 {
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3E))
-		return true;
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S)) {
+		/*
+		 * With OPAL, secondaries do not use the secondary hold
+		 * spinloop, rather they are held in firmware until
+		 * opal_start_cpu() sends them to generic_secondary_smp_init
+		 * directly.
+		 */
+		if (firmware_has_feature(FW_FEATURE_OPAL))
+			return false;
+		else
+			return true;
+	}
 
 	/*
 	 * When book3e boots from kexec, the ePAPR spin table does
-- 
2.13.3
