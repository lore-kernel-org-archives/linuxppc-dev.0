Return-Path: <m.szyprowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D460D1A0292
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 19:36:23 +1000 (EST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N8U006HWO0CXS40@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 17 Jul 2014 10:36:12 +0100 (BST)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH] CMA: generalize CMA reserved area management functionality
 (fixup)
Date: Thu, 17 Jul 2014 11:36:07 +0200
Message-id: <1405589767-17513-1-git-send-email-m.szyprowski@samsung.com>
In-reply-to: <53C78ED7.7030002@samsung.com>
References: <53C78ED7.7030002@samsung.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MAX_CMA_AREAS is used by other subsystems (i.e. arch/arm/mm/dma-mapping.c),
so we need to provide correct definition even if CMA is disabled.
This patch fixes this issue.

Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/cma.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 9a18a2b1934c..c077635cad76 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -5,7 +5,11 @@
  * There is always at least global CMA area and a few optional
  * areas configured in kernel .config.
  */
+#ifdef CONFIG_CMA
 #define MAX_CMA_AREAS	(1 + CONFIG_CMA_AREAS)
+#else
+#define MAX_CMA_AREAS	(0)
+#endif
 
 struct cma;
 
-- 
1.9.2
