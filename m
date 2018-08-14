Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qHNr1Sw4zF0WL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 12:58:50 +1000 (AEST)
From: zhong jiang <zhongjiang@huawei.com>
To: <tony.luck@intel.com>, <fenghua.yu@intel.com>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <oleg@redhat.com>,
 <rppt@linux.vnet.ibm.com>, <dhowells@redhat.com>,
 <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>
CC: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] ia64: Use ARRAY_SIZE to replace its implementation
Date: Tue, 14 Aug 2018 10:46:53 +0800
Message-ID: <1534214814-9043-2-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
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

We prefer to ARRAY_SIZE rather than duplicating its implementation.
So just replace it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/ia64/kernel/perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index a9d4dc6..6cbe6e0 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -4645,7 +4645,7 @@ static char *pfmfs_dname(struct dentry *dentry, char *buffer, int buflen)
 /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
 /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
 };
-#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
+#define PFM_CMD_COUNT	ARRAY_SIZE(pfm_cmd_tab)
 
 static int
 pfm_check_task_state(pfm_context_t *ctx, int cmd, unsigned long flags)
-- 
1.7.12.4
