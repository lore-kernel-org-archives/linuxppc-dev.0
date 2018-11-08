Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE1EECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:11:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A250A2077B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 20:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="taDaUdki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A250A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rZF35PZWzF3T5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 07:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="taDaUdki";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="taDaUdki"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rZBF43qSzF3SH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 07:09:24 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 389A02077B;
 Thu,  8 Nov 2018 20:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541707762;
 bh=fUpLikS75hrABD8vxw9zvtufFSADWcBzJRzlonifLH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=taDaUdkiM0/XCziA9N0wGLLQbGy3VKkFAoHuy/jDgLpuqJAdJ0T78MGIshxRhT0E1
 xLFT1aW9kC0g6a+s0xaJucCGwZMuNX3WS77cBnDaUVMXjFAAhuMEC0CVktQ36TY/zQ
 p9rzRQDUKF0nPcpJC72UX95eOE245wQ3yPVo9Tr8=
Date: Thu, 8 Nov 2018 14:09:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181108200855.GE41183@google.com>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107234257.GC41183@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 linux-pci@vger.kernel.org, shyam_iyer@dell.com, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, Lukas Wunner <lukas@wunner.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver O'Halloran <oohall@gmail.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Jonathan Derrick <jonathan.derrick@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+cc Jonathan, Greg, Lukas, Russell, Sam, Oliver for discussion about
PCI error recovery in general]

On Wed, Nov 07, 2018 at 05:42:57PM -0600, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 05:15:00PM -0500, Alexandru Gagniuc wrote:
> > When a PCI device is gone, we don't want to send IO to it if we can
> > avoid it. We expose functionality via the irq_chip structure. As
> > users of that structure may not know about the underlying PCI device,
> > it's our responsibility to guard against removed devices.
> > 
> > .irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().
> > .irq_mask/unmask() are not. Guard them for completeness.
> > 
> > For example, surprise removal of a PCIe device triggers teardown. This
> > touches the irq_chips ops some point to disable the interrupts. I/O
> > generated here can crash the system on firmware-first machines.
> > Not triggering the IO in the first place greatly reduces the
> > possibility of the problem occurring.
> > 
> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> Applied to pci/misc for v4.21, thanks!

I'm having second thoughts about this.  One thing I'm uncomfortable
with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
instead of systematic, in the sense that I don't know how we convince
ourselves that this (and only this) is the correct place to put it.

Another is that the only place we call pci_dev_set_disconnected() is
in pciehp and acpiphp, so the only "disconnected" case we catch is if
hotplug happens to be involved.  Every MMIO read from the device is an
opportunity to learn whether it is reachable (a read from an
unreachable device typically returns ~0 data), but we don't do
anything at all with those.

The config accessors already check pci_dev_is_disconnected(), so this
patch is really aimed at MMIO accesses.  I think it would be more
robust if we added wrappers for readl() and writel() so we could
notice read errors and avoid future reads and writes.

Two compiled but untested patches below for your comments.  You can
mostly ignore the first; it's just boring interface changes.  The
important part is the second, which adds the wrappers.

These would be an alternative to the (admittedly much shorter) patch
here.  The wrappers are independent of MSI and could potentially be
exported from the PCI core for use by drivers.  I think it would be
better for drivers to use something like this instead of calling
pci_device_is_present() or pci_dev_is_disconnected() directly.

> > ---
> >  drivers/pci/msi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index f2ef896464b3..f31058fd2260 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
> >  {
> >  	struct msi_desc *desc = irq_data_get_msi_desc(data);
> >  
> > +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
> > +		return;
> > +
> >  	if (desc->msi_attrib.is_msix) {
> >  		msix_mask_irq(desc, flag);
> >  		readl(desc->mask_base);		/* Flush write to device */


commit 150346e09edbcaedc520a6d7dec2b16f3a53afa1
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Nov 8 09:17:51 2018 -0600

    PCI/MSI: Pass pci_dev into IRQ mask interfaces
    
    Add the struct pci_dev pointer to these interfaces:
    
      __pci_msix_desc_mask_irq()
      __pci_msi_desc_mask_irq()
      msix_mask_irq
      msi_mask_irq()
    
    The pci_dev pointer is currently unused, so there's no functional change
    intended with this patch.  A subsequent patch will use the pointer to
    improve error detection.

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9f6f392a4461..56bbee2cf761 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -462,9 +462,9 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 		if (!msi->irq)
 			continue;
 		if (msi->msi_attrib.is_msix)
-			__pci_msix_desc_mask_irq(msi, 1);
+			__pci_msix_desc_mask_irq(pdev, msi, 1);
 		else
-			__pci_msi_desc_mask_irq(msi, 1, 1);
+			__pci_msi_desc_mask_irq(pdev, msi, 1, 1);
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index af24ed50a245..d46ae506e296 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -170,7 +170,8 @@ static inline __attribute_const__ u32 msi_mask(unsigned x)
  * reliably as devices without an INTx disable bit will then generate a
  * level IRQ which will never be cleared.
  */
-u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+u32 __pci_msi_desc_mask_irq(struct pci_dev *dev, struct msi_desc *desc,
+			    u32 mask, u32 flag)
 {
 	u32 mask_bits = desc->masked;
 
@@ -179,15 +180,15 @@ u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 
 	mask_bits &= ~mask;
 	mask_bits |= flag;
-	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->mask_pos,
-			       mask_bits);
+	pci_write_config_dword(dev, desc->mask_pos, mask_bits);
 
 	return mask_bits;
 }
 
-static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
+static void msi_mask_irq(struct pci_dev *dev, struct msi_desc *desc, u32 mask,
+			 u32 flag)
 {
-	desc->masked = __pci_msi_desc_mask_irq(desc, mask, flag);
+	desc->masked = __pci_msi_desc_mask_irq(dev, desc, mask, flag);
 }
 
 static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
@@ -203,7 +204,8 @@ static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
  * file.  This saves a few milliseconds when initialising devices with lots
  * of MSI-X interrupts.
  */
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
+u32 __pci_msix_desc_mask_irq(struct pci_dev *dev, struct msi_desc *desc,
+			     u32 flag)
 {
 	u32 mask_bits = desc->masked;
 
@@ -218,21 +220,22 @@ u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 	return mask_bits;
 }
 
-static void msix_mask_irq(struct msi_desc *desc, u32 flag)
+static void msix_mask_irq(struct pci_dev *dev, struct msi_desc *desc, u32 flag)
 {
-	desc->masked = __pci_msix_desc_mask_irq(desc, flag);
+	desc->masked = __pci_msix_desc_mask_irq(dev, desc, flag);
 }
 
 static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
 
 	if (desc->msi_attrib.is_msix) {
-		msix_mask_irq(desc, flag);
+		msix_mask_irq(dev, desc, flag);
 		readl(desc->mask_base);		/* Flush write to device */
 	} else {
 		unsigned offset = data->irq - desc->irq;
-		msi_mask_irq(desc, 1 << offset, flag << offset);
+		msi_mask_irq(dev, desc, 1 << offset, flag << offset);
 	}
 }
 
@@ -401,7 +404,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	msi_mask_irq(entry, msi_mask(entry->msi_attrib.multi_cap),
+	msi_mask_irq(dev, entry, msi_mask(entry->msi_attrib.multi_cap),
 		     entry->masked);
 	control &= ~PCI_MSI_FLAGS_QSIZE;
 	control |= (entry->msi_attrib.multiple << 4) | PCI_MSI_FLAGS_ENABLE;
@@ -423,7 +426,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 
 	arch_restore_msi_irqs(dev);
 	for_each_pci_msi_entry(entry, dev)
-		msix_mask_irq(entry, entry->masked);
+		msix_mask_irq(dev, entry, entry->masked);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -612,28 +615,28 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 
 	/* All MSIs are unmasked by default, Mask them all */
 	mask = msi_mask(entry->msi_attrib.multi_cap);
-	msi_mask_irq(entry, mask, mask);
+	msi_mask_irq(dev, entry, mask, mask);
 
 	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(dev, entry, mask, ~mask);
 		free_msi_irqs(dev);
 		return ret;
 	}
 
 	ret = msi_verify_entries(dev);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(dev, entry, mask, ~mask);
 		free_msi_irqs(dev);
 		return ret;
 	}
 
 	ret = populate_msi_sysfs(dev);
 	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
+		msi_mask_irq(dev, entry, mask, ~mask);
 		free_msi_irqs(dev);
 		return ret;
 	}
@@ -721,7 +724,7 @@ static void msix_program_entries(struct pci_dev *dev,
 			entries[i++].vector = entry->irq;
 		entry->masked = readl(pci_msix_desc_addr(entry) +
 				PCI_MSIX_ENTRY_VECTOR_CTRL);
-		msix_mask_irq(entry, 1);
+		msix_mask_irq(dev, entry, 1);
 	}
 }
 
@@ -895,7 +898,7 @@ static void pci_msi_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI unmasked as initial states */
 	mask = msi_mask(desc->msi_attrib.multi_cap);
 	/* Keep cached state to be restored */
-	__pci_msi_desc_mask_irq(desc, mask, ~mask);
+	__pci_msi_desc_mask_irq(dev, desc, mask, ~mask);
 
 	/* Restore dev->irq to its default pin-assertion irq */
 	dev->irq = desc->msi_attrib.default_irq;
@@ -982,7 +985,7 @@ static void pci_msix_shutdown(struct pci_dev *dev)
 	/* Return the device with MSI-X masked as initial states */
 	for_each_pci_msi_entry(entry, dev) {
 		/* Keep cached states to be restored */
-		__pci_msix_desc_mask_irq(entry, 1);
+		__pci_msix_desc_mask_irq(dev, entry, 1);
 	}
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 0e9c50052ff3..1525ec9457a4 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -141,8 +141,9 @@ void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 
-u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
-u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
+u32 __pci_msix_desc_mask_irq(struct pci_dev *, struct msi_desc *desc, u32 flag);
+u32 __pci_msi_desc_mask_irq(struct pci_dev *, struct msi_desc *desc, u32 mask,
+			    u32 flag);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 

commit 9b51617cc910b5facdb4ab0442d6562422c916d7
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Nov 8 08:34:07 2018 -0600

    PCI/MSI: Avoid MMIO accesses to device if it's unreachable
    
    Add wrappers around MMIO accesses (readl/writel) to the device.  If we
    already know the device is unreachable because of hot-removal or a bus
    error, skip the MMIO access.
    
    In addition, if we're doing an MMIO read, check whether it returns ~0 data.
    If a read fails because of a bus error, host bridges typically synthesize
    ~0 data to complete the CPU's read.  If a read returns ~0, do a config read
    to determine whether the device is still reachable.  If the config read is
    successful, the ~0 data is probably valid data from the device.  If the
    config read fails, the device is unreachable, so mark it as disconnected.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d46ae506e296..0cf095eef69d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -31,6 +31,38 @@ int pci_msi_ignore_mask;
 
 #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
 
+static u32 mmio_readl(struct pci_dev *dev, const volatile void __iomem *addr)
+{
+	u32 val, id;
+
+	if (pci_dev_is_disconnected(dev))
+		return ~0;
+
+	val = readl(addr);
+
+	/*
+	 * If an MMIO read from the device returns ~0 data, that data may
+	 * be valid, or it may indicate a bus error.  If config space is
+	 * readable, assume it's valid data; otherwise, assume a bus error.
+	 */
+	if (val == ~0) {
+		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+		if (id == ~0)
+			pci_dev_set_disconnected(dev, NULL);
+	}
+
+	return val;
+}
+
+static void mmio_writel(struct pci_dev *dev, u32 val,
+			volatile void __iomem *addr)
+{
+	if (pci_dev_is_disconnected(dev))
+		return;
+
+	writel(val, addr);
+}
+
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 static int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
@@ -215,7 +247,8 @@ u32 __pci_msix_desc_mask_irq(struct pci_dev *dev, struct msi_desc *desc,
 	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	if (flag)
 		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	writel(mask_bits, pci_msix_desc_addr(desc) + PCI_MSIX_ENTRY_VECTOR_CTRL);
+	mmio_writel(dev, mask_bits,
+		    pci_msix_desc_addr(desc) + PCI_MSIX_ENTRY_VECTOR_CTRL);
 
 	return mask_bits;
 }
@@ -232,7 +265,7 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 
 	if (desc->msi_attrib.is_msix) {
 		msix_mask_irq(dev, desc, flag);
-		readl(desc->mask_base);		/* Flush write to device */
+		mmio_readl(dev, desc->mask_base); /* Flush write to device */
 	} else {
 		unsigned offset = data->irq - desc->irq;
 		msi_mask_irq(dev, desc, 1 << offset, flag << offset);
@@ -276,9 +309,11 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
 
-		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
-		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
-		msg->data = readl(base + PCI_MSIX_ENTRY_DATA);
+		msg->address_lo = mmio_readl(dev,
+					     base + PCI_MSIX_ENTRY_LOWER_ADDR);
+		msg->address_hi = mmio_readl(dev,
+					     base + PCI_MSIX_ENTRY_UPPER_ADDR);
+		msg->data = mmio_readl(dev, base + PCI_MSIX_ENTRY_DATA);
 	} else {
 		int pos = dev->msi_cap;
 		u16 data;
@@ -306,9 +341,11 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
 
-		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
-		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
-		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
+		mmio_writel(dev, msg->address_lo,
+			    base + PCI_MSIX_ENTRY_LOWER_ADDR);
+		mmio_writel(dev, msg->address_hi,
+			    base + PCI_MSIX_ENTRY_UPPER_ADDR);
+		mmio_writel(dev, msg->data, base + PCI_MSIX_ENTRY_DATA);
 	} else {
 		int pos = dev->msi_cap;
 		u16 msgctl;
@@ -722,8 +759,8 @@ static void msix_program_entries(struct pci_dev *dev,
 	for_each_pci_msi_entry(entry, dev) {
 		if (entries)
 			entries[i++].vector = entry->irq;
-		entry->masked = readl(pci_msix_desc_addr(entry) +
-				PCI_MSIX_ENTRY_VECTOR_CTRL);
+		entry->masked = mmio_readl(dev, pci_msix_desc_addr(entry) +
+					   PCI_MSIX_ENTRY_VECTOR_CTRL);
 		msix_mask_irq(dev, entry, 1);
 	}
 }
