Return-Path: <baolex.ni@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3bR36sPrzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 22:41:03 +1000 (AEST)
From: Baole Ni <baolex.ni@intel.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, m.chehab@samsung.com,
 m.szyprowski@samsung.com, kyungmin.park@samsung.com,
 k.kozlowski@samsung.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, ursula.braun@de.ibm.com, chuansheng.liu@intel.com,
 baolex.ni@intel.com
Subject: [PATCH 0965/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:22 +0800
Message-Id: <20160802120322.14393-1-baolex.ni@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/tty/hvc/hvc_iucv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index 8b70a16..9234097 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -1065,9 +1065,9 @@ static struct device_driver hvc_iucv_driver = {
 };
 
 /* IUCV HVC device attributes */
-static DEVICE_ATTR(termid, 0640, hvc_iucv_dev_termid_show, NULL);
-static DEVICE_ATTR(state, 0640, hvc_iucv_dev_state_show, NULL);
-static DEVICE_ATTR(peer, 0640, hvc_iucv_dev_peer_show, NULL);
+static DEVICE_ATTR(termid, S_IRUSR | S_IWUSR | S_IRGRP, hvc_iucv_dev_termid_show, NULL);
+static DEVICE_ATTR(state, S_IRUSR | S_IWUSR | S_IRGRP, hvc_iucv_dev_state_show, NULL);
+static DEVICE_ATTR(peer, S_IRUSR | S_IWUSR | S_IRGRP, hvc_iucv_dev_peer_show, NULL);
 static struct attribute *hvc_iucv_dev_attrs[] = {
 	&dev_attr_termid.attr,
 	&dev_attr_state.attr,
@@ -1475,4 +1475,4 @@ static	int __init hvc_iucv_config(char *val)
 
 device_initcall(hvc_iucv_init);
 __setup("hvc_iucv=", hvc_iucv_config);
-core_param(hvc_iucv_allow, hvc_iucv_filter, vmidfilter, 0640);
+core_param(hvc_iucv_allow, hvc_iucv_filter, vmidfilter, S_IRUSR | S_IWUSR | S_IRGRP);
-- 
2.9.2
