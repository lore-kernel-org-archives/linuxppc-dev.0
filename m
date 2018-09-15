Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42C97K1JqZzF31k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 21:26:02 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: <qiang.zhao@nxp.com>, <leoyang.li@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fsl/qe: Fix copy-paste error in ucc_get_tdm_sync_shift
Date: Sat, 15 Sep 2018 19:10:05 +0800
Message-ID: <20180915111005.10028-1-yuehaibing@huawei.com>
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

if 'mode' is COMM_DIR_TX, 'shift' should use TX_SYNC_SHIFT_BASE

Fixes: bb8b2062aff3 ("fsl/qe: setup clock source for TDM mode")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/fsl/qe/ucc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
index c646d87..681f7d4 100644
--- a/drivers/soc/fsl/qe/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -626,7 +626,7 @@ static u32 ucc_get_tdm_sync_shift(enum comm_dir mode, u32 tdm_num)
 {
 	u32 shift;
 
-	shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : RX_SYNC_SHIFT_BASE;
+	shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : TX_SYNC_SHIFT_BASE;
 	shift -= tdm_num * 2;
 
 	return shift;
-- 
1.8.3.1
