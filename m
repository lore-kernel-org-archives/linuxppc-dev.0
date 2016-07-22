Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwgt80ldkzDrHZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:37:03 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6M6Y3Fs037478
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 02:37:01 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24as6gsbwx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 02:37:01 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 22 Jul 2016 16:36:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2F2972CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:36:56 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6M6auWx29622448
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:36:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6M6atLZ031320
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 16:36:55 +1000
Date: Fri, 22 Jul 2016 16:36:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20160722052336.3340-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160722052336.3340-1-ruscur@russell.cc>
Message-Id: <20160722063655.GA28438@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 22, 2016 at 03:23:36PM +1000, Russell Currey wrote:
>On EEH events the kernel will print a dump of relevant registers.
>If EEH is unavailable (i.e. CONFIG_EEH is disabled, a new platform
>doesn't have EEH support, etc) this information isn't readily available.
>
>Add a new debugfs handler to trigger a PHB register dump, so that this
>information can be made available on demand.
>
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 35 +++++++++++++++++++++++++++++++
> 1 file changed, 35 insertions(+)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 891fc4a..ada2f3c 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -3018,6 +3018,38 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
> 	}
> }
>
>+#ifdef CONFIG_DEBUG_FS
>+static ssize_t pnv_pci_debug_write(struct file *filp,
>+				   const char __user *user_buf,
>+				   size_t count, loff_t *ppos)
>+{
>+	struct pci_controller *hose = filp->private_data;
>+	struct pnv_phb *phb;
>+	int ret = 0;

Needn't initialize @ret in advance. The code might be simpler, but it's
only a personal preference:

	struct pci_controller *hose = filp->private_data;
	struct pnv_phb *phb = hose ? hose->private_data : NULL;

	if (!phb)
		return -ENODEV;

>+
>+	if (!hose)
>+		return -EFAULT;
>+
>+	phb = hose->private_data;
>+	if (!phb)
>+		return -EFAULT;
>+
>+	ret = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>+					  PNV_PCI_DIAG_BUF_SIZE);
>+
>+	if (!ret)
>+		pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
>+
>+	return ret < 0 ? ret : count;

return ret == OPAL_SUCCESS ? count : -EIO;

>+}
>+
>+static const struct file_operations pnv_pci_debug_ops = {
>+	.open	= simple_open,
>+	.llseek	= no_llseek,
>+	.write	= pnv_pci_debug_write,

It might be reasonable to dump the diag-data on read if it is trying
to do it on write.

>+};
>+#endif /* CONFIG_DEBUG_FS */
>+
> static void pnv_pci_ioda_create_dbgfs(void)
> {
> #ifdef CONFIG_DEBUG_FS
>@@ -3036,6 +3068,9 @@ static void pnv_pci_ioda_create_dbgfs(void)
> 		if (!phb->dbgfs)
> 			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
> 				__func__, hose->global_number);
>+
>+		debugfs_create_file("regdump", 0200, phb->dbgfs, hose,
>+				    &pnv_pci_debug_ops);

"diag-data" might be indicating or a better one you can name :)

Thanks,
Gavin

> 	}
> #endif /* CONFIG_DEBUG_FS */
> }
>-- 
>2.9.0
>
