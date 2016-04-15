Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmLWS3qymzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 12:06:44 +1000 (AEST)
Date: Fri, 15 Apr 2016 12:06:13 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander
 Graf <agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH 1/3] powerpc: scan_features() updates incorrect bits
Message-ID: <20160415120613.1bbdc5d5@kryten>
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

The real LE feature entry in the ibm_pa_feature struct has the
wrong number of elements. Instead of checking for byte 5, bit 0,
we check for byte 0, bit 0, and we also incorrectly update cpu user
feature bit 5.

Fixes: 44ae3ab3358e ("powerpc: Free up some CPU feature bits by moving out MMU-related features")
Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7030b03..9a3a7c6 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -158,7 +158,7 @@ static struct ibm_pa_feature {
 	{CPU_FTR_NOEXECUTE, 0, 0,	0, 6, 0},
 	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
 	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
-	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
+	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 0, 5, 0, 0},
 	/*
 	 * If the kernel doesn't support TM (ie. CONFIG_PPC_TRANSACTIONAL_MEM=n),
 	 * we don't want to turn on CPU_FTR_TM here, so we use CPU_FTR_TM_COMP
-- 
2.7.4
