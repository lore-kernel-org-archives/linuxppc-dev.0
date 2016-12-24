Return-Path: <mrahul.krishnan@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tm0YZ2H2xzDw7g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 20:38:10 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id c4so14943199pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 01:38:10 -0800 (PST)
Date: Sat, 24 Dec 2016 15:08:00 +0530
From: Rahul Krishnan <mrahul.krishnan@gmail.com>
To: benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: hotplug: This patch removes unnecessary return
 statement using spatch tool
Message-ID: <20161224093800.GA24893@rahul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch removes unnecessary return statement using spatch tool

Signed-off-by: Rahul Krishnan <mrahul.krishnan@gmail.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index dc67f39..78ce2c7 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -455,7 +455,6 @@ static inline int is_dlpar_capable(void)
 
 int __init rpadlpar_io_init(void)
 {
-	int rc = 0;
 
 	if (!is_dlpar_capable()) {
 		printk(KERN_WARNING "%s: partition not DLPAR capable\n",
@@ -463,8 +462,7 @@ int __init rpadlpar_io_init(void)
 		return -EPERM;
 	}
 
-	rc = dlpar_sysfs_init();
-	return rc;
+	return dlpar_sysfs_init();
 }
 
 void rpadlpar_io_exit(void)
-- 
2.7.4
