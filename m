Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmLXf5vyFzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 12:07:46 +1000 (AEST)
Date: Fri, 15 Apr 2016 12:07:24 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander
 Graf <agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH 2/3] powerpc: Update cpu_user_features2 in scan_features()
Message-ID: <20160415120724.40180a50@kryten>
In-Reply-To: <20160404211112.66b0756f@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404211112.66b0756f@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

scan_features() updates cpu_user_features but not cpu_user_features2.

Amongst other things, cpu_user_features2 contains the user TM feature
bits which we must keep in sync with the kernel TM feature bit.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/prom.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9a3a7c6..99709bb 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -148,23 +148,24 @@ static struct ibm_pa_feature {
 	unsigned long	cpu_features;	/* CPU_FTR_xxx bit */
 	unsigned long	mmu_features;	/* MMU_FTR_xxx bit */
 	unsigned int	cpu_user_ftrs;	/* PPC_FEATURE_xxx bit */
+	unsigned int	cpu_user_ftrs2;	/* PPC_FEATURE2_xxx bit */
 	unsigned char	pabyte;		/* byte number in ibm,pa-features */
 	unsigned char	pabit;		/* bit number (big-endian) */
 	unsigned char	invert;		/* if 1, pa bit set => clear feature */
 } ibm_pa_features[] __initdata = {
-	{0, 0, PPC_FEATURE_HAS_MMU,	0, 0, 0},
-	{0, 0, PPC_FEATURE_HAS_FPU,	0, 1, 0},
-	{CPU_FTR_CTRL, 0, 0,		0, 3, 0},
-	{CPU_FTR_NOEXECUTE, 0, 0,	0, 6, 0},
-	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
-	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
-	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 0, 5, 0, 0},
+	{0, 0, PPC_FEATURE_HAS_MMU, 0,		0, 0, 0},
+	{0, 0, PPC_FEATURE_HAS_FPU, 0,		0, 1, 0},
+	{CPU_FTR_CTRL, 0, 0, 0,			0, 3, 0},
+	{CPU_FTR_NOEXECUTE, 0, 0, 0,		0, 6, 0},
+	{CPU_FTR_NODSISRALIGN, 0, 0, 0,		1, 1, 1},
+	{0, MMU_FTR_CI_LARGE_PAGE, 0, 0,		1, 2, 0},
+	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 0, 0, 5, 0, 0},
 	/*
 	 * If the kernel doesn't support TM (ie. CONFIG_PPC_TRANSACTIONAL_MEM=n),
 	 * we don't want to turn on CPU_FTR_TM here, so we use CPU_FTR_TM_COMP
 	 * which is 0 if the kernel doesn't support TM.
 	 */
-	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
+	{CPU_FTR_TM_COMP, 0, 0, 0,		22, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
@@ -195,10 +196,12 @@ static void __init scan_features(unsigned long node, const unsigned char *ftrs,
 		if (bit ^ fp->invert) {
 			cur_cpu_spec->cpu_features |= fp->cpu_features;
 			cur_cpu_spec->cpu_user_features |= fp->cpu_user_ftrs;
+			cur_cpu_spec->cpu_user_features2 |= fp->cpu_user_ftrs2;
 			cur_cpu_spec->mmu_features |= fp->mmu_features;
 		} else {
 			cur_cpu_spec->cpu_features &= ~fp->cpu_features;
 			cur_cpu_spec->cpu_user_features &= ~fp->cpu_user_ftrs;
+			cur_cpu_spec->cpu_user_features2 &= ~fp->cpu_user_ftrs2;
 			cur_cpu_spec->mmu_features &= ~fp->mmu_features;
 		}
 	}
-- 
2.7.4
