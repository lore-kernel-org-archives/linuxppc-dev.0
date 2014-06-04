Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39DEE1A0836
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 11:49:48 +1000 (EST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D4B01400DE
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2014 11:49:46 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 4 Jun 2014 07:19:43 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D9AF4394003E
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2014 07:19:38 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s541npKn9503144
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2014 07:19:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s541ncVR005407
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2014 07:19:38 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
 gwshan@linux.vnet.ibm.com
Subject: [PATCH] powerpc/eeh: skip eeh sysfs when eeh is disabled
Date: Wed,  4 Jun 2014 09:49:17 +0800
Message-Id: <1401846557-10014-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When eeh is not enabled, and hotplug two pci devices on the same bus, eeh
related sysfs would be added twice for the first added pci device. Since the
eeh_dev is not created when eeh is not enabled.

This patch adds the check, if eeh is not enabled, eeh sysfs will not be
created.

After applying this patch, following warnings are reduced:

sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:00.0/eeh_mode'
sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:00.0/eeh_config_addr'
sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:00.0/eeh_pe_config_addr'

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index 5d753d4..e2595ba 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -59,6 +59,9 @@ void eeh_sysfs_add_device(struct pci_dev *pdev)
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
 	int rc=0;
 
+	if (!eeh_enabled())
+		return;
+
 	if (edev && (edev->mode & EEH_DEV_SYSFS))
 		return;
 
-- 
1.7.9.5
