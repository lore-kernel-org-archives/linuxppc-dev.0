Return-Path: <kernelfans@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KZXx5k3xzF1NW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 16:51:45 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y5-v6so511235pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 23:51:45 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 3/4] drivers/base: clean up the usage of
 devices_kset_move_last()
Date: Tue,  3 Jul 2018 14:50:41 +0800
Message-Id: <1530600642-25090-4-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
correct device's shutdown order"). So later we can revert it safely.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 684b994..db3deb8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
 
-	/*
-	 * Devices that have not been registered yet will be put to the ends
-	 * of the lists during the registration, so skip them here.
-	 */
-	if (device_is_registered(dev))
-		devices_kset_move_last(dev);
-
 	if (device_pm_initialized(dev))
 		device_pm_move_last(dev);
 
-- 
2.7.4
