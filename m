Return-Path: <geliangtang@163.com>
Received: from m50-134.163.com (m50-134.163.com [123.125.50.134])
 by lists.ozlabs.org (Postfix) with ESMTP id 095381A032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 00:30:02 +1100 (AEDT)
From: Geliang Tang <geliangtang@163.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <scottwood@freescale.com>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: Geliang Tang <geliangtang@163.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] powerpc: fix a problematic usage of WARN()
Date: Wed, 25 Nov 2015 21:12:20 +0800
Message-Id: <84a366614b84091cd4bd354e8b65dd51c1762a52.1448456395.git.geliangtang@163.com>
In-Reply-To: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
In-Reply-To: <06d69890c56bd84a831a1dccee26e34b4988a241.1448456395.git.geliangtang@163.com>
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
 <8bb789c0803579a01e1ee977ed67408c422acd79.1448456395.git.geliangtang@163.com>
 <582529c23f77af64373f59fa92e29186df700d79.1448456395.git.geliangtang@163.com>
 <7701ed112cc71a9a17ba5b3022166011a98d0dca.1448456395.git.geliangtang@163.com>
 <e20618e9dd688161c7a539bc041b7951efeac351.1448456395.git.geliangtang@163.com>
 <06d69890c56bd84a831a1dccee26e34b4988a241.1448456395.git.geliangtang@163.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WARN() takes a condition and a format string. The condition was
omitted. So I added it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5c03a6a..726a9fb 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -127,7 +127,7 @@ static void setup_tlb_core_data(void)
 		    !mmu_has_feature(MMU_FTR_USE_TLBRSRV) &&
 		    book3e_htw_mode != PPC_HTW_E6500) {
 			/* Should we panic instead? */
-			WARN_ONCE("%s: unsupported MMU configuration -- expect problems\n",
+			WARN_ONCE(1, "%s: unsupported MMU configuration -- expect problems\n",
 				  __func__);
 		}
 	}
-- 
2.5.0
