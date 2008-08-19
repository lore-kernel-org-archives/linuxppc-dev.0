Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CEDC7DE0F9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 11:46:07 +1000 (EST)
Date: Tue, 19 Aug 2008 11:45:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] hotplug/rpaphp: remove unused error path code
Message-Id: <20080819114555.c0d2bd50.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alex Chiang <achiang@hp.com>, LKML <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linuxppc-dev@ozlabs.org,
	Linda Xie <lxie@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit f46753c5e354b857b20ab8e0fe7b2579831dc369 ("PCI: introduce pci_slot") removed the need for this error path.  Eliminate this warning:

drivers/pci/hotplug/rpaphp_slot.c: In function 'rpaphp_register_slot':
drivers/pci/hotplug/rpaphp_slot.c:151: warning: label 'sysfs_fail' defined but not used

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pci/hotplug/rpaphp_slot.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 9b714ea..5088450 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -147,9 +147,5 @@ int rpaphp_register_slot(struct slot *slot)
 	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
 	info("Slot [%s] registered\n", slot->name);
 	return 0;
-
-sysfs_fail:
-	pci_hp_deregister(php_slot);
-	return retval;
 }
 
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
