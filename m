Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpPgy3h9BzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:36:14 +1000 (AEST)
Message-ID: <1460975767.5963.1.camel@ellerman.id.au>
Subject: [PATCH v2 1/3] powerpc: scan_features() updates incorrect bits for
 REAL_LE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>, David
 Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Mon, 18 Apr 2016 20:36:07 +1000
In-Reply-To: <20160415120613.1bbdc5d5@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404211112.66b0756f@kryten>
 <20160415120613.1bbdc5d5@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

The REAL_LE feature entry in the ibm_pa_feature struct is missing an MMU
feature value, meaning all the remaining elements initialise the wrong
values.

This means instead of checking for byte 5, bit 0, we check for byte 0,
bit 0, and then we incorrectly set the CPU feature bit as well as MMU
feature bit 1 and CPU user feature bits 0 and 2 (5).

Checking byte 0 bit 0 (IBM numbering), means we're looking at the
"Memory Management Unit (MMU)" feature - ie. does the CPU have an MMU.
In practice that bit is set on all platforms which have the property.

This means we set CPU_FTR_REAL_LE always. In practice that seems not to
matter because all the modern cpus which have this property also
implement REAL_LE, and we've never needed to disable it.

We're also incorrectly setting MMU feature bit 1, which is:

  #define MMU_FTR_TYPE_8xx		0x00000002

Luckily the only place that looks for MMU_FTR_TYPE_8xx is in Book3E
code, which can't run on the same cpus as scan_features(). So this also
doesn't matter in practice.

Finally in the CPU user feature mask, we're setting bits 0 and 2. Bit 2
is not currently used, and bit 0 is:

  #define PPC_FEATURE_PPC_LE		0x00000001

Which says the CPU supports the old style "PPC Little Endian" mode.
Again this should be harmless in practice as no 64-bit CPUs implement
that mode.

Fix the code by adding the missing initialisation of the MMU feature.

Also add a comment marking CPU user feature bit 2 (0x4) as reserved. It
would be unsafe to start using it as old kernels incorrectly set it.

Fixes: 44ae3ab3358e ("powerpc: Free up some CPU feature bits by moving out MMU-related features")
Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
[mpe: Flesh out changelog, add comment reserving 0x4]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/uapi/asm/cputable.h | 1 +
 arch/powerpc/kernel/prom.c               | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index 8dde19962a5b..f63c96cd3608 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -31,6 +31,7 @@
 #define PPC_FEATURE_PSERIES_PERFMON_COMPAT \
 					0x00000040
 
+/* Reserved - do not use		0x00000004 */
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7030b035905d..080c96b44a7f 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -158,7 +158,7 @@ static struct ibm_pa_feature {
 	{CPU_FTR_NOEXECUTE, 0, 0,	0, 6, 0},
 	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
 	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
-	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
+	{CPU_FTR_REAL_LE, 0, PPC_FEATURE_TRUE_LE, 5, 0, 0},
 	/*
 	 * If the kernel doesn't support TM (ie. CONFIG_PPC_TRANSACTIONAL_MEM=n),
 	 * we don't want to turn on CPU_FTR_TM here, so we use CPU_FTR_TM_COMP
-- 
2.5.0
