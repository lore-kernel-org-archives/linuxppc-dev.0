Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9116CDDF39
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:49 +1000 (EST)
Message-Id: <20070705170237.519898000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:48 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 15/35] Export HID registers via sysfs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Export some of the HID registers via sysfs. Useful when debugging.


Index: 2.6.21/arch/powerpc/kernel/sysfs.c
===================================================================
--- 2.6.21.orig/arch/powerpc/kernel/sysfs.c
+++ 2.6.21/arch/powerpc/kernel/sysfs.c
@@ -197,6 +197,17 @@ SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3
 SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
 SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
 
+SYSFS_PMCSETUP(hid0, SPRN_HID0);
+SYSFS_PMCSETUP(hid1, SPRN_HID1);
+SYSFS_PMCSETUP(hid4, SPRN_HID4);
+SYSFS_PMCSETUP(hid5, SPRN_HID5);
+SYSFS_PMCSETUP(ima0, SPRN_PA6T_IMA0);
+SYSFS_PMCSETUP(ima1, SPRN_PA6T_IMA1);
+SYSFS_PMCSETUP(ima2, SPRN_PA6T_IMA2); 
+SYSFS_PMCSETUP(imaat, SPRN_PA6T_IMAAT);
+SYSFS_PMCSETUP(btcr, SPRN_PA6T_BTCR);
+SYSFS_PMCSETUP(pccr, SPRN_PA6T_PCCR);
+SYSFS_PMCSETUP(rpccr, SPRN_PA6T_RPCCR);
 
 static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
 static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
@@ -228,6 +239,16 @@ static struct sysdev_attribute pa6t_attr
 	_SYSDEV_ATTR(pmc3, 0600, show_pa6t_pmc3, store_pa6t_pmc3),
 	_SYSDEV_ATTR(pmc4, 0600, show_pa6t_pmc4, store_pa6t_pmc4),
 	_SYSDEV_ATTR(pmc5, 0600, show_pa6t_pmc5, store_pa6t_pmc5),
+	_SYSDEV_ATTR(hid0, 0600, show_hid0, store_hid0),
+	_SYSDEV_ATTR(hid1, 0600, show_hid1, store_hid1),
+	_SYSDEV_ATTR(hid4, 0600, show_hid4, store_hid4),
+	_SYSDEV_ATTR(hid5, 0600, show_hid5, store_hid5),
+	_SYSDEV_ATTR(ima0, 0600, show_ima0, store_ima0),
+	_SYSDEV_ATTR(ima1, 0600, show_ima1, store_ima1),
+	_SYSDEV_ATTR(ima2, 0600, show_ima2, store_ima2),
+	_SYSDEV_ATTR(imaat, 0600, show_imaat, store_imaat),
+	_SYSDEV_ATTR(btcr, 0600, show_btcr, store_btcr),
+	_SYSDEV_ATTR(pccr, 0600, show_pccr, store_pccr),
 };
 
 

--
