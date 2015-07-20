Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6F931A0A2F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 22:14:48 +1000 (AEST)
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, Russell King
 <linux@arm.linux.org.uk>, <dja@axtens.net>,
 <linux-xtensa@linux-xtensa.org>, <x86@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, <linux-mips@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Rusty Russell <rusty@rustcorp.com.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-s390@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
 <linux-ia64@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-am33-list@redhat.com>,
 Liviu Dudau <liviu@dudau.co.uk>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Yijing Wang
 <wangyijing@huawei.com>
Subject: [PATCH part3 v12 03/10] PCI: Remove declaration for
 pci_get_new_domain_nr()
Date: Mon, 20 Jul 2015 20:01:11 +0800
Message-ID: <1437393678-4077-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
References: <1437393678-4077-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_get_new_domain_nr() is only used in drivers/pci/pci.c,
remove the declaration in include/linux/pci.h.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c   |    4 ++--
 include/linux/pci.h |    3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..59032e2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4476,14 +4476,14 @@ static void pci_no_domains(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
 static atomic_t __domain_nr = ATOMIC_INIT(-1);
 
-int pci_get_new_domain_nr(void)
+static int pci_get_new_domain_nr(void)
 {
 	return atomic_inc_return(&__domain_nr);
 }
 
-#ifdef CONFIG_PCI_DOMAINS_GENERIC
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static int use_dt_domains = -1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f7e4204..4524592 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1319,12 +1319,10 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
  */
 #ifdef CONFIG_PCI_DOMAINS
 extern int pci_domains_supported;
-int pci_get_new_domain_nr(void);
 #else
 enum { pci_domains_supported = 0 };
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
-static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #endif /* CONFIG_PCI_DOMAINS */
 
 /*
@@ -1445,7 +1443,6 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 
 static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
-static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
-- 
1.7.1
