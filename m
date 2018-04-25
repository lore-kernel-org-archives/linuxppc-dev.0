Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJHW0zNwzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:43:34 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <geoff@infradead.org>, <joe@perches.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] powerpc/xics: add missing of_node_put() in error path
Date: Wed, 25 Apr 2018 19:27:07 +0800
Message-ID: <20180425112707.16392-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device node obtained with of_find_compatible_node() should be
released by calling of_node_put().  But it was not released when
of_get_property() failed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/sysdev/xics/xics-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 77e864d..e54a9e6 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -448,7 +448,10 @@ static void __init xics_get_server_size(void)
 		return;
 	isize = of_get_property(np, "ibm,interrupt-server#-size", NULL);
 	if (!isize)
+	{
+		of_node_put(np);
 		return;
+	}
 	xics_interrupt_server_size = be32_to_cpu(*isize);
 	of_node_put(np);
 }
-- 
2.7.0
