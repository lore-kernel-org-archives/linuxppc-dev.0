Return-Path: <segooon@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 457131007D3
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jul 2010 02:03:51 +1000 (EST)
Received: by ewy2 with SMTP id 2so1381261ewy.15
	for <linuxppc-dev@ozlabs.org>; Sat, 03 Jul 2010 09:03:49 -0700 (PDT)
From: Kulikov Vasiliy <segooon@gmail.com>
To: Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: [PATCH 04/19] arch/powerpc/platforms/pseries: use for_each_pci_dev()
Date: Sat,  3 Jul 2010 20:03:48 +0400
Message-Id: <1278173029-11541-1-git-send-email-segooon@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use for_each_pci_dev() to simplify the code.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 arch/powerpc/platforms/pseries/eeh_cache.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index 30b987b..8ed0d2d 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -288,8 +288,7 @@ void __init pci_addr_cache_build(void)
 
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
 
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-
+	for_each_pci_dev(dev) {
 		pci_addr_cache_insert_device(dev);
 
 		dn = pci_device_to_OF_node(dev);
-- 
1.7.0.4
