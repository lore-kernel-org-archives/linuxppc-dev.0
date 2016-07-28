Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0FQc1ByLzDqRP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:59:03 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6S1wvQr140511
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:59:00 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24eun1gdtd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:59:00 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 28 Jul 2016 11:58:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ECACC2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:58:48 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6S1wmIZ18022508
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:58:48 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6S1wmas007289
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 11:58:48 +1000
Date: Thu, 28 Jul 2016 11:58:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powernv/pci: Add PHB register dump debugfs handle
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20160727061404.13831-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160727061404.13831-1-ruscur@russell.cc>
Message-Id: <20160728015847.GA17212@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2016 at 04:14:04PM +1000, Russell Currey wrote:
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
>V2 changes:
>	- use a simple attribute instead of full fops thanks to mpe
>	- miscellanous fixes thanks to Gavin
>	- rename from "regdump" to "dump_regs"
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 43 ++++++++++++++++++++++++++++++-
> 1 file changed, 42 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 891fc4a..2b9f114 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -3018,6 +3018,42 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
> 	}
> }
>
>+#ifdef CONFIG_DEBUG_FS
>+static int pnv_pci_diag_data_set(void *data, u64 val)
>+{
>+	struct pci_controller *hose;
>+	struct pnv_phb *phb;
>+	int ret;

s/int/int64_t

>+
>+	if (val != 1)
>+		return -EINVAL;

if (val != 1ULL)

>+
>+	hose = (struct pci_controller *)data;
>+	if (!hose)
>+		return -EFAULT;
>+
>+	phb = hose->private_data;
>+	if (!phb)
>+		return -EFAULT;

hose = (struct pci_controller *)data;
if (!hose || !hose->private_data)
	return -ENODEV;

phb = hose->private_data;

>+
>+	/* Retrieve the diag data from firmware */

Unnecessary comments as the code is obvious.

>+	ret = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>+					  PNV_PCI_DIAG_BUF_SIZE);
>+	if (ret != OPAL_SUCCESS)
>+		return -EIO;
>+
>+	/* Print the diag data to the kernel log */

Same as above.

>+	pnv_pci_dump_phb_diag_data(phb->hose, phb->diag.blob);
>+	return 0;
>+}
>+
>+DEFINE_SIMPLE_ATTRIBUTE(pnv_pci_diag_data_fops,
>+			NULL,
>+			pnv_pci_diag_data_set,
>+			"%llu\n");
>+

Can be squeezed to 2 lines:

DEFINE_SIMPLE_ATTRIBUTE(pnv_pci_diag_data_fops, NULL,
			pnv_pci_diag_data_set, "%llu\n");

>+#endif /* CONFIG_DEBUG_FS */
>+
> static void pnv_pci_ioda_create_dbgfs(void)
> {
> #ifdef CONFIG_DEBUG_FS
>@@ -3033,9 +3069,14 @@ static void pnv_pci_ioda_create_dbgfs(void)
>
> 		sprintf(name, "PCI%04x", hose->global_number);
> 		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
>-		if (!phb->dbgfs)
>+		if (!phb->dbgfs) {
> 			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
> 				__func__, hose->global_number);
>+			continue;
>+		}
>+
>+		debugfs_create_file("dump_regs", 0200, phb->dbgfs, hose,
>+				    &pnv_pci_diag_data_fops);

I still think "diag-data" is more indicative. It's also consistent with
the handler's name (pnv_pci_diag_data_set())?

> 	}
> #endif /* CONFIG_DEBUG_FS */
> }

Thanks,
Gavin
