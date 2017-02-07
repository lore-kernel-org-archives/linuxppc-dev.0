Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHcc70Q5zzDqNy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 19:16:06 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1789QuO087433
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 03:16:04 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28faaagr13-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 03:15:59 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 7 Feb 2017 18:15:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AE7052BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 19:15:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v178FkMZ26607680
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 19:15:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v178EwL0010454
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 19:14:59 +1100
Subject: Re: [PATCH] drivers/misc/cxl: Avoid unnecessary error message
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: imunsie@au1.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 7 Feb 2017 19:14:33 +1100
MIME-Version: 1.0
In-Reply-To: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/01/17 14:43, Gavin Shan wrote:
> The following error message was observed. It's complaining M32
> memory window is missed on virtual PHB, which is a bit confusing.
> The problem is the memory windows are never updated from its
> device-tree node.
>
>    PCI: Memory resource 0 not set for host bridge \
>    /pciex@3fffe40000000/pci@0/device@0
>
> This avoids the unnecessary error message by updating the PHB's
> memory windows with pci_process_bridge_OF_ranges(). The function
> is exported as well.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

I talked this over with Gavin in person today.

We don't set a memory window on the vPHB or its devices because it's not 
necessary.

The effect of this patch is to copy the memory resources from the *real* 
PHB to the vPHB, as given through the device tree. It shouldn't have any 
practical effect other than squashing this message.


> ---
>  arch/powerpc/kernel/pci-common.c | 1 +
>  drivers/misc/cxl/vphb.c          | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 74bec54..b5ffd8a 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -824,6 +824,7 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_GPL(pci_process_bridge_OF_ranges);
>
>  /* Decide whether to display the domain number in /proc */
>  int pci_proc_domain(struct pci_bus *bus)
> diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
> index 3519ace..8382761 100644
> --- a/drivers/misc/cxl/vphb.c
> +++ b/drivers/misc/cxl/vphb.c
> @@ -215,6 +215,15 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
>  	if (!phb)
>  		return -ENODEV;
>
> +	/* Parse IO and memory ranges */
> +	if (dev_is_pci(parent)) {

Is this ever going to be false?

> +		struct pci_dev *pdev;

I think we tend to keep declarations up at the top of the function?

> +
> +		pdev = to_pci_dev(parent);
> +		vphb_dn = pnv_pci_get_phb_node(pdev);
> +		pci_process_bridge_OF_ranges(phb, vphb_dn, false);
> +	}
> +
>  	/* Setup parent in sysfs */
>  	phb->parent = parent;
>
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
