Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id A1D37DDD0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 17:34:29 +1000 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l497YSLs020898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 16:34:28 +0900 (JST)
Date: Wed, 09 May 2007 16:34:08 +0900 (JST)
Message-Id: <200705090734.l497YJqU004144@toshiba.co.jp>
Subject: [PATCH 1/4] celleb: fix supporting for multiple pci domains
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Celleb has multiple PCI host bridges (phbs). Previous boot logic gives
non-overlapped bus IDs between PCI host bridges so you can identify
PHB by bus ID. But newer boot logic gives same bus ID between PHBs (it
gives bus ID 0 as root bus.) So we have to set 'phb->buid' as
non-zero.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c:1.1.1.3 linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c:1.25.2.2
--- linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c:1.1.1.3	Wed Apr 18 13:53:48 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/pci.c	Tue May  8 14:20:03 2007
@@ -457,6 +457,7 @@
 
 	pr_debug("PCI: celleb_setup_phb() %s\n", name);
 	phb_set_bus_ranges(dev, phb);
+	phb->buid = 1;
 
 	if (strcmp(name, "epci") == 0) {
 		phb->ops = &celleb_epci_ops;
