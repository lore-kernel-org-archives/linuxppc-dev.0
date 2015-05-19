Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 556F31A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 15:25:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 19 May 2015 15:25:13 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 66B512CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 15:25:11 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4J5P3bQ17760472
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 15:25:11 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4J5OcLh025570
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 15:24:39 +1000
Date: Tue, 19 May 2015 13:24:20 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V6 01/10] PCI/IOV: Rename and export
 virtfn_add/virtfn_remove
Message-ID: <20150519052419.GA7710@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431999312-10517-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431999312-10517-2-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn,

This patch set is dedicated for the VF EEH on Power. Most of them are in
powerpc arch, while this first one is PCI core related. Those following
patches are review and ack from Gavin, your ack to this one is important.

I'd appreciated it a lot if you have time to take a look at this one.

Thanks a lot.

On Tue, May 19, 2015 at 09:35:03AM +0800, Wei Yang wrote:
>During EEH recovery, hotplug is applied to the devices which don't
>have drivers or their drivers don't support EEH. However, the hotplug,
>which was implemented based on PCI bus, can't be applied to VF directly.
>
>The patch renames virtn_{add,remove}() and exports them so that they
>can be used in PCI hotplug during EEH recovery.
>
>[gwshan: changelog]
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> drivers/pci/iov.c   |   10 +++++-----
> include/linux/pci.h |    2 ++
> 2 files changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index ee0ebff..cc941dd 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -108,7 +108,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
> 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
> }
>
>-static int virtfn_add(struct pci_dev *dev, int id, int reset)
>+int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset)
> {
> 	int i;
> 	int rc = -ENOMEM;
>@@ -183,7 +183,7 @@ failed:
> 	return rc;
> }
>
>-static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>+void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset)
> {
> 	char buf[VIRTFN_ID_LEN];
> 	struct pci_dev *virtfn;
>@@ -320,7 +320,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	}
>
> 	for (i = 0; i < initial; i++) {
>-		rc = virtfn_add(dev, i, 0);
>+		rc = pci_iov_virtfn_add(dev, i, 0);
> 		if (rc)
> 			goto failed;
> 	}
>@@ -332,7 +332,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>
> failed:
> 	for (j = 0; j < i; j++)
>-		virtfn_remove(dev, j, 0);
>+		pci_iov_virtfn_remove(dev, j, 0);
>
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);
>@@ -361,7 +361,7 @@ static void sriov_disable(struct pci_dev *dev)
> 		return;
>
> 	for (i = 0; i < iov->num_VFs; i++)
>-		virtfn_remove(dev, i, 0);
>+		pci_iov_virtfn_remove(dev, i, 0);
>
> 	pcibios_sriov_disable(dev);
>
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index 353db8d..94bacfa 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -1679,6 +1679,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
>
> int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
> void pci_disable_sriov(struct pci_dev *dev);
>+int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset);
>+void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset);
> int pci_num_vf(struct pci_dev *dev);
> int pci_vfs_assigned(struct pci_dev *dev);
> int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>-- 
>1.7.9.5

-- 
Richard Yang
Help you, Help me
