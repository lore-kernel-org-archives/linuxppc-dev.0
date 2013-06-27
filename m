Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3DC52C034C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 07:00:23 +1000 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 18:00:15 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 9377B1DC0066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 17:00:13 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RKwpNa33226818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 17:58:51 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RL0Ckx003614
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 18:00:12 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] eeh: add eeh_dev to the cache during boot
Date: Thu, 27 Jun 2013 18:00:10 -0300
Message-Id: <1372366810-26739-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: paulus@samba.org, shangw@linux.vnet.ibm.com,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit f8f7d63fd96ead101415a1302035137a866f8998 ("powerpc/eeh: Trace eeh
device from I/O cache") broke EEH on pseries for devices that were
present during boot and have not been hotplugged/DLPARed.

eeh_check_failure will get the eeh_dev from the cache, and will get
NULL. eeh_addr_cache_build adds the addresses to the cache, but eeh_dev
for the giving pci_device is not set yet. Just reordering the call to
eeh_addr_cache_insert_dev works fine. The ordering is similar to the one
in eeh_add_device_late.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---

Note that this is broken since v3.7-rc1 and this patch applies on top of
v3.10-rc7. Just changing the patches will apply it on top of
next-20130626, where it has moved to arch/powerpc/kernel/.

I also realized when writing the log that maybe calling
eeh_add_device_late instead could be a better option. Please, share your
comments.

---
 arch/powerpc/platforms/pseries/eeh_cache.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_cache.c b/arch/powerpc/platforms/pseries/eeh_cache.c
index 5a4c879..5ce3ba7 100644
--- a/arch/powerpc/platforms/pseries/eeh_cache.c
+++ b/arch/powerpc/platforms/pseries/eeh_cache.c
@@ -294,8 +294,6 @@ void __init eeh_addr_cache_build(void)
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
 
 	for_each_pci_dev(dev) {
-		eeh_addr_cache_insert_dev(dev);
-
 		dn = pci_device_to_OF_node(dev);
 		if (!dn)
 			continue;
@@ -308,6 +306,8 @@ void __init eeh_addr_cache_build(void)
 		dev->dev.archdata.edev = edev;
 		edev->pdev = dev;
 
+		eeh_addr_cache_insert_dev(dev);
+
 		eeh_sysfs_add_device(dev);
 	}
 
-- 
1.7.1
