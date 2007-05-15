Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85327DDEDC
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 05:47:35 +1000 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat
	Linux)) id 1Ho2zZ-0003ge-RT
	for linuxppc-dev@ozlabs.org; Tue, 15 May 2007 20:47:29 +0100
Date: Tue, 15 May 2007 20:47:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linuxppc-dev@ozlabs.org
Subject: [viro@ftp.linux.org.uk: [PATCH] rpadlpar breakage - fallout of struct
	subsystem removal]
Message-ID: <20070515194729.GE4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[oops - typo in Cc in original posting]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/pci/hotplug/rpadlpar_sysfs.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index 6c5be3f..df07606 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -129,8 +129,9 @@ struct kobj_type ktype_dlpar_io = {
 };
 
 struct kset dlpar_io_kset = {
-	.subsys = &pci_hotplug_slots_subsys,
-	.kobj = {.name = DLPAR_KOBJ_NAME, .ktype=&ktype_dlpar_io,},
+	.kobj = {.name = DLPAR_KOBJ_NAME,
+		 .ktype = &ktype_dlpar_io,
+		 .parent = &pci_hotplug_slots_subsys.kobj},
 	.ktype = &ktype_dlpar_io,
 };
 
-- 
1.5.0-rc2.GIT


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
