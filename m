Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSWcc2xbtzDwBG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:02:08 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT4wVLg008774
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:02:06 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27128b52et-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:02:05 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Nov 2016 15:02:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DE7602BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:01:59 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAT51xWn53280866
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:02:00 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAT51wtJ005664
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 16:01:59 +1100
Date: Tue, 29 Nov 2016 16:03:20 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 6/7] PCI: Decouple IORESOURCE_ROM_ENABLE and
 PCI_ROM_ADDRESS_ENABLE
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041607.21453.52485.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129041607.21453.52485.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129050320.GB23115@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2016 at 10:16:07PM -0600, Bjorn Helgaas wrote:
>Remove the assumption that IORESOURCE_ROM_ENABLE == PCI_ROM_ADDRESS_ENABLE.
>PCI_ROM_ADDRESS_ENABLE is the ROM enable bit defined by the PCI spec, so if
>we're reading or writing a BAR register value, that's what we should use.
>IORESOURCE_ROM_ENABLE is a corresponding bit in struct resource flags.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/probe.c |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>index ab00267..cf7670e 100644
>--- a/drivers/pci/probe.c
>+++ b/drivers/pci/probe.c
>@@ -227,7 +227,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> 			mask64 = (u32)PCI_BASE_ADDRESS_MEM_MASK;
> 		}
> 	} else {
>-		res->flags |= (l & IORESOURCE_ROM_ENABLE);
>+		if (l & PCI_ROM_ADDRESS_ENABLE)
>+			res->flags |= IORESOURCE_ROM_ENABLE;
> 		l64 = l & PCI_ROM_ADDRESS_MASK;
> 		sz64 = sz & PCI_ROM_ADDRESS_MASK;
> 		mask64 = (u32)PCI_ROM_ADDRESS_MASK;
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
