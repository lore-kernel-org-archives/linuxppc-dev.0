Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY6sy3sGDzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 23:45:26 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 83so9978480pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 06:45:26 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: tyreld@linux.vnet.ibm.com, paulus@samba.org, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] scsi: ibmvscsi_tgt: constify vio_device_id
Date: Thu, 17 Aug 2017 19:15:07 +0530
Message-Id: <1502977507-2954-3-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1502977507-2954-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502977507-2954-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vio_device_id are not supposed to change at runtime. All functions
working with vio_device_id provided by <asm/vio.h> work with
const vio_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 659ab48..7575276 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3956,7 +3956,7 @@ static struct class ibmvscsis_class = {
 	.dev_groups	= ibmvscsis_dev_groups,
 };
 
-static struct vio_device_id ibmvscsis_device_table[] = {
+static const struct vio_device_id ibmvscsis_device_table[] = {
 	{ "v-scsi-host", "IBM,v-scsi-host" },
 	{ "", "" }
 };
-- 
2.7.4
