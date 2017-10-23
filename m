Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL88m4DHBzDqkl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:05:28 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p9so11158412pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 01:05:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 3/3] powerpc/powernv: Avoid waiting for secondary hold
 spinloop with OPAL
Date: Mon, 23 Oct 2017 18:05:07 +1000
Message-Id: <20171023080507.21974-4-npiggin@gmail.com>
In-Reply-To: <20171023080507.21974-1-npiggin@gmail.com>
References: <20171023080507.21974-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL boot does not insert secondaries at 0x60 to wait at the secondary
hold spinloop. Instead they are started later, and inserted at
generic_secondary_smp_init(), which is after the secondary hold
spinloop.

Avoid waiting on this spinloop when booting with OPAL firmware. This
wait always times out that case.

This saves 100ms boot time on powernv, and 10s of seconds of real time
when booting on the simulator in SMP.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/head_64.S  | 16 +++++++++++-----
 arch/powerpc/kernel/setup_64.c | 10 +++++++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index c9e760ec7530..0deef350004f 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -55,12 +55,18 @@
  *
  *  For pSeries or server processors:
  *   1. The MMU is off & open firmware is running in real mode.
- *   2. The kernel is entered at __start
+ *   2. The primary CPU enters at __start.
+ *   3. If the RTAS supports "query-cpu-stopped-state", then secondary
+ *      CPUs will enter as directed by "start-cpu" RTAS call, which is
+ *      generic_secondary_smp_init, with PIR in r3.
+ *   4. Else the secondary CPUs will enter at secondary_hold (0x60) as
+ *      directed by the "start-cpu" RTS call, with PIR in r3.
  * -or- For OPAL entry:
- *   1. The MMU is off, processor in HV mode, primary CPU enters at 0
- *      with device-tree in gpr3. We also get OPAL base in r8 and
- *	entry in r9 for debugging purposes
- *   2. Secondary processors enter at 0x60 with PIR in gpr3
+ *   1. The MMU is off, processor in HV mode.
+ *   2. The primary CPU enters at 0 with device-tree in r3, OPAL base
+ *      in r8, and entry in r9 for debugging purposes.
+ *   3. Secondary CPUs enter as directed by OPAL_START_CPU call, which
+ *      is at generic_secondary_smp_init, with PIR in r3.
  *
  *  For Book3E processors:
  *   1. The MMU is on running in AS0 in a state defined in ePAPR
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3f2453858f60..ecaab70e4b78 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -363,8 +363,16 @@ void early_setup_secondary(void)
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC_CORE)
 static bool use_spinloop(void)
 {
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3E))
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S)) {
+		/*
+		 * See comments in head_64.S -- not all platforms insert
+		 * secondaries at __secondary_hold and wait at the spin
+		 * loop.
+		 */
+		if (firmware_has_feature(FW_FEATURE_OPAL))
+			return false;
 		return true;
+	}
 
 	/*
 	 * When book3e boots from kexec, the ePAPR spin table does
-- 
2.13.3
