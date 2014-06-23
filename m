Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BFF91A0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 15:41:31 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 15:41:31 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 10B863578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 15:41:28 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N5JCnq53805222
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 15:19:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N5fQXw001352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 15:41:27 +1000
Date: Mon, 23 Jun 2014 15:41:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 08/17] PCI: Add weak pcibios_sriov_resource_size()
 interface
Message-ID: <20140623054128.GA9831@shangw>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-9-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402365399-5121-9-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, bhelgaas@google.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2014 at 09:56:30AM +0800, Wei Yang wrote:
>When retrieving sriov resource size in pci_sriov_resource_size(), it will
>divide the total IOV resource size with the totalVF number. This is true for
>most cases, while may not be correct on some specific platform.
>
>For example on powernv platform, in order to fix the IOV BAR into a hardware
>alignment, the IOV resource size would be expended. This means the original
>method couldn't work.
>
>This patch introduces a weak pcibios_sriov_resource_size() interface, which
>gives platform a chance to implement specific method to calculate the sriov
>resource size.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> drivers/pci/iov.c   |   27 +++++++++++++++++++++++++--
> include/linux/pci.h |    3 +++
> 2 files changed, 28 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index cc87773..9fd4648 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -45,6 +45,30 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
> 		pci_remove_bus(virtbus);
> }
>
>+resource_size_t __weak pcibios_sriov_resource_size(struct pci_dev *dev, int resno)
>+{
>+	return 0;
>+}
>+

Please define the prototype of weak function in header files (e.g.
linux/include/pci.h) :-)

If you missed doing same thing for the weak functions added in the
previous patches, you need fix it as well.

>+resource_size_t pci_sriov_resource_size(struct pci_dev *dev, int resno)
>+{
>+	u64 size;

I guess it'd better to be "resource_size_t". 

>+	struct pci_sriov *iov;
>+
>+	if (!dev->is_physfn)
>+		return 0;
>+
>+	size = pcibios_sriov_resource_size(dev, resno);
>+	if (size != 0)
>+		return size;
>+
>+	iov = dev->sriov;
>+	size = resource_size(dev->resource + resno);
>+	do_div(size, iov->total_VFs);
>+
>+	return size;
>+}
>+
> static int virtfn_add(struct pci_dev *dev, int id, int reset)
> {
> 	int i;
>@@ -81,8 +105,7 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
> 			continue;
> 		virtfn->resource[i].name = pci_name(virtfn);
> 		virtfn->resource[i].flags = res->flags;
>-		size = resource_size(res);
>-		do_div(size, iov->total_VFs);
>+		size = pci_sriov_resource_size(dev, i + PCI_IOV_RESOURCES);
> 		virtfn->resource[i].start = res->start + size * id;
> 		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
> 		rc = request_resource(res, &virtfn->resource[i]);
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index ddb1ca0..315c150 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -1637,6 +1637,7 @@ int pci_num_vf(struct pci_dev *dev);
> int pci_vfs_assigned(struct pci_dev *dev);
> int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
> int pci_sriov_get_totalvfs(struct pci_dev *dev);
>+resource_size_t pci_sriov_resource_size(struct pci_dev *dev, int resno);
> #else
> static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
> {
>@@ -1658,6 +1659,8 @@ static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
> { return 0; }
> static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
> { return 0; }
>+static inline resource_size_t pci_sriov_resource_size(struct pci_dev *dev, int resno)
>+{ return -1; }
> #endif
>
> #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)

Thanks,
Gavin
