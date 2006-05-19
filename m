Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8F4CB67CF9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:09:53 +1000 (EST)
Date: Fri, 19 May 2006 16:53:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 07/14] powerpc: iSeries PCI devices can now have a devpsec
	attribute
Message-Id: <20060519165311.37b445a3.sfr@canb.auug.org.au>
In-Reply-To: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
References: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/pci_64.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

bfe21d083414576fccd84ead574adffea99968c1
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index e1b3b3e..30a4e6a 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -886,8 +886,8 @@ int pci_mmap_page_range(struct pci_dev *
 	return ret;
 }
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
-static ssize_t pci_show_devspec(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t pci_show_devspec(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev;
 	struct device_node *np;
@@ -899,13 +899,10 @@ static ssize_t pci_show_devspec(struct d
 	return sprintf(buf, "%s", np->full_name);
 }
 static DEVICE_ATTR(devspec, S_IRUGO, pci_show_devspec, NULL);
-#endif /* CONFIG_PPC_MULTIPLATFORM */
 
 void pcibios_add_platform_entries(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PPC_MULTIPLATFORM
 	device_create_file(&pdev->dev, &dev_attr_devspec);
-#endif /* CONFIG_PPC_MULTIPLATFORM */
 }
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
-- 
1.3.1.ge923
