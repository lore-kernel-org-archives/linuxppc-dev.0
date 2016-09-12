Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXhWl730VzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 18:57:07 +1000 (AEST)
From: Jeremy Kerr <jk@ozlabs.org>
To: Corey Minyard <minyard@acm.org>, openipmi-developer@lists.sourceforge.net
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] ipmi: Add a reference from BMC devices to their interfaces
Date: Mon, 12 Sep 2016 16:55:34 +0800
Message-Id: <1473670537-26428-2-git-send-email-jk@ozlabs.org>
In-Reply-To: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
References: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In an upcoming change, we'll want to grab a reference to the ipmi_smi_t
from a struct bmc_device. This change adds a pointer to allow this.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index d8619998..41990bb 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -195,6 +195,7 @@ struct ipmi_proc_entry {
 struct bmc_device {
 	struct platform_device pdev;
 	struct ipmi_device_id  id;
+	ipmi_smi_t             intf;
 	unsigned char          guid[16];
 	int                    guid_set;
 	char                   name[16];
@@ -2796,6 +2797,7 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
 	}
 	intf->intf_num = -1; /* Mark it invalid for now. */
 	kref_init(&intf->refcount);
+	intf->bmc->intf = intf;
 	intf->bmc->id = *device_id;
 	intf->si_dev = si_dev;
 	for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
-- 
2.7.4
