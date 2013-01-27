Return-Path: <yinghai@kernel.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "aserp1040.oracle.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBD542C015A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 06:25:02 +1100 (EST)
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <jiang.liu@huawei.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 Taku Izumi <izumi.taku@jp.fujitsu.com>, Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v3 21/22] PCI: Kill pci_find_next_bus
Date: Sun, 27 Jan 2013 11:23:48 -0800
Message-Id: <1359314629-18651-22-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Cc: linux-ia64@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, David Howells <dhowells@redhat.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>,
 x86@kernel.org, linux-altix@sgi.com, Doug Thompson <dougthompson@xmission.com>,
 Matt Turner <mattst88@gmail.com>, linux-edac@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Yinghai Lu <yinghai@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No user now, remove it.

That name is misleading as it only for root buses.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: linux-edac@vger.kernel.org
Cc: x86@kernel.org
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: linux-altix@sgi.com
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: David Howells <dhowells@redhat.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: microblaze-uclinux@itee.uq.edu.au
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: linux-am33-list@redhat.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/pci/search.c |   37 +++++++------------------------------
 include/linux/pci.h  |    4 ----
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index db0c3a9..329c533 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -79,44 +79,22 @@ static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
  */
 struct pci_bus * pci_find_bus(int domain, int busnr)
 {
-	struct pci_bus *bus = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
 	struct pci_bus *tmp_bus;
 
-	while ((bus = pci_find_next_bus(bus)) != NULL)  {
-		if (pci_domain_nr(bus) != domain)
+	for_each_pci_host_bridge(host_bridge) {
+		if (pci_domain_nr(host_bridge->bus) != domain)
 			continue;
-		tmp_bus = pci_do_find_bus(bus, busnr);
-		if (tmp_bus)
+		tmp_bus = pci_do_find_bus(host_bridge->bus, busnr);
+		if (tmp_bus) {
+			put_device(&host_bridge->dev);
 			return tmp_bus;
+		}
 	}
 	return NULL;
 }
 
 /**
- * pci_find_next_bus - begin or continue searching for a PCI bus
- * @from: Previous PCI bus found, or %NULL for new search.
- *
- * Iterates through the list of known PCI busses.  A new search is
- * initiated by passing %NULL as the @from argument.  Otherwise if
- * @from is not %NULL, searches continue from next device on the
- * global list.
- */
-struct pci_bus * 
-pci_find_next_bus(const struct pci_bus *from)
-{
-	struct list_head *n;
-	struct pci_bus *b = NULL;
-
-	WARN_ON(in_interrupt());
-	down_read(&pci_bus_sem);
-	n = from ? from->node.next : pci_root_buses.next;
-	if (n != &pci_root_buses)
-		b = pci_bus_b(n);
-	up_read(&pci_bus_sem);
-	return b;
-}
-
-/**
  * pci_get_slot - locate PCI device for a given PCI slot
  * @bus: PCI bus on which desired PCI device resides
  * @devfn: encodes number of PCI slot in which the desired PCI 
@@ -356,7 +334,6 @@ EXPORT_SYMBOL(pci_dev_present);
 
 /* For boot time work */
 EXPORT_SYMBOL(pci_find_bus);
-EXPORT_SYMBOL(pci_find_next_bus);
 /* For everyone */
 EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 67879cb..bb07db2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -763,7 +763,6 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
-struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_host_bridge *pci_get_next_host_bridge(struct pci_host_bridge *from);
 struct pci_dev *pci_get_device(unsigned int vendor, unsigned int device,
@@ -1404,9 +1403,6 @@ static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
 static inline void pci_unblock_cfg_access(struct pci_dev *dev)
 { }
 
-static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
-{ return NULL; }
-
 static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
 						unsigned int devfn)
 { return NULL; }
-- 
1.7.10.4
