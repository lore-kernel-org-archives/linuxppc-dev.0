Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DE90DDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 23:53:55 +1000 (EST)
From: Andy Whitcroft <apw@shadowen.org>
Sender: Andy Whitcroft <apw@shadowen.org>
To: gregkh@suse.de
Subject: [PATCH] update sysfs kset initialisation in PPC64 DLPAR IO driver
References: <464322F3.3010808@shadowen.org>
Message-ID: <2c705c055fcd12202673ee8a3056153b@pinky>
Date: Thu, 10 May 2007 15:00:50 +0100
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Move the rpadlpar device from "struct subsystem" to "struct kset"
following the changes in sysfs.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---

	Ok, this patch seems to sort out the compile problem
	here and indeed boots and runs kernbench.  Perhaps
	you could confirm this is sufficient.


diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index 6c5be3f..ed4de59 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -129,13 +129,13 @@ struct kobj_type ktype_dlpar_io = {
 };
 
 struct kset dlpar_io_kset = {
-	.subsys = &pci_hotplug_slots_subsys,
 	.kobj = {.name = DLPAR_KOBJ_NAME, .ktype=&ktype_dlpar_io,},
 	.ktype = &ktype_dlpar_io,
 };
 
 int dlpar_sysfs_init(void)
 {
+	kobj_set_kset_s(&dlpar_io_kset, pci_hotplug_slots_subsys);
 	if (kset_register(&dlpar_io_kset)) {
 		printk(KERN_ERR "rpadlpar_io: cannot register kset for %s\n",
 				dlpar_io_kset.kobj.name);
