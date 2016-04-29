Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDym1cH6zDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 69/70] powerpc/mm/radix: Use firmware feature to enable
 Radix MMU
Date: Fri, 29 Apr 2016 23:26:32 +1000
Message-Id: <1461936393-10131-69-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We use the existing "ibm,pa-features" device-tree property to enable
Radix MMU mode. This means we default to hash mode unless firmware tells
us it's OK to start using Radix mode.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 1b082c729c29..d924cd60fc8e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -166,6 +166,7 @@ static struct ibm_pa_feature {
 	 * which is 0 if the kernel doesn't support TM.
 	 */
 	{CPU_FTR_TM_COMP, 0, 0,		22, 0, 0},
+	{0, MMU_FTR_RADIX, 0,		40, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
-- 
2.5.0
