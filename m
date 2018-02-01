Return-Path: <qiang.zhao@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0044.outbound.protection.outlook.com [104.47.42.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXD0g4NWjzDqqN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 19:33:37 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>
CC: <dan.carpenter@oracle.com>, <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH] QE: Correct a clerical mistake
Date: Thu, 1 Feb 2018 14:54:32 +0800
Message-ID: <20180201065432.22096-1-qiang.zhao@nxp.com>
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

Shift should be TX_SYNC_SHIFT_BASE if mode != COMM_DIR_RX

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/soc/fsl/qe/ucc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.1
