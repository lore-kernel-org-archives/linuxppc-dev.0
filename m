Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC5121A0181
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 19:38:49 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 21 Aug 2014 15:08:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5D381E004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 15:10:49 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7L9f5bi64684088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 15:11:05 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7L9cffL029794
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 15:08:41 +0530
Date: Thu, 21 Aug 2014 17:38:39 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 2/3] MSI: Use __read_msi_msg() instead of read_msi_msg()
Message-ID: <20140821093839.GA15667@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1408072469-9959-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408072469-9959-1-git-send-email-wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 15, 2014 at 11:14:29AM +0800, Yijing Wang wrote:
>Read_msi_msg() only be called in rtas_setup_msi_irqs(),

 read_msi_msg()

This code looks good to me, while I can't apply on top of 3.17-rc1.
If you rebase it, it would be more convenient for maintainer to merge.

>use __read_msi_msg() instead of read_msi_msg for
>simplification. And rename __read_msi_msg() to
>read_msi_msg().
>
>Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>CC: linuxppc-dev@lists.ozlabs.org
>---
> arch/powerpc/platforms/pseries/msi.c |    2 +-
> arch/x86/pci/xen.c                   |    2 +-
> drivers/pci/msi.c                    |    9 +--------
> include/linux/msi.h                  |    3 +--
> 4 files changed, 4 insertions(+), 12 deletions(-)
>
>diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
>index 0c882e8..591650b 100644
>--- a/arch/powerpc/platforms/pseries/msi.c
>+++ b/arch/powerpc/platforms/pseries/msi.c
>@@ -484,7 +484,7 @@ again:
> 		irq_set_msi_desc(virq, entry);
>
> 		/* Read config space back so we can restore after reset */
>-		read_msi_msg(virq, &msg);
>+		read_msi_msg(entry, &msg);
> 		entry->msg = msg;
> 	}
>
>diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
>index 905956f..4656099 100644
>--- a/arch/x86/pci/xen.c
>+++ b/arch/x86/pci/xen.c
>@@ -228,7 +228,7 @@ static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> 		return 1;
>
> 	list_for_each_entry(msidesc, &dev->msi_list, list) {
>-		__read_msi_msg(msidesc, &msg);
>+		read_msi_msg(msidesc, &msg);
> 		pirq = MSI_ADDR_EXT_DEST_ID(msg.address_hi) |
> 			((msg.address_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xff);
> 		if (msg.data != XEN_PIRQ_MSI_DATA ||
>diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>index 988224f..cbb41d6 100644
>--- a/drivers/pci/msi.c
>+++ b/drivers/pci/msi.c
>@@ -259,7 +259,7 @@ void default_restore_msi_irqs(struct pci_dev *dev)
> 	}
> }
>
>-void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>+void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> {
> 	BUG_ON(entry->dev->current_state != PCI_D0);
>
>@@ -289,13 +289,6 @@ void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> 	}
> }
>
>-void read_msi_msg(unsigned int irq, struct msi_msg *msg)
>-{
>-	struct msi_desc *entry = irq_get_msi_desc(irq);
>-
>-	__read_msi_msg(entry, msg);
>-}
>-
> void get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> {
> 	/* Assert that the cache is valid, assuming that
>diff --git a/include/linux/msi.h b/include/linux/msi.h
>index e3adf93..4d7c0f5 100644
>--- a/include/linux/msi.h
>+++ b/include/linux/msi.h
>@@ -15,10 +15,9 @@ struct irq_data;
> struct msi_desc;
> void mask_msi_irq(struct irq_data *data);
> void unmask_msi_irq(struct irq_data *data);
>-void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>+void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
> void get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
> void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>-void read_msi_msg(unsigned int irq, struct msi_msg *msg);
> void write_msi_msg(unsigned int irq, struct msi_msg *msg);
>
> struct msi_desc {
>-- 
>1.7.1
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
