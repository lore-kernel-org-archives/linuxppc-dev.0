Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ0R20CbszDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 10:09:33 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17N3edX067370
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 18:09:32 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28fft4x90s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 18:09:31 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 09:09:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8985A2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 10:09:26 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17N9Ieu25821374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 10:09:26 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17N8rDj025606
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 10:08:54 +1100
Date: Wed, 8 Feb 2017 10:08:29 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 imunsie@au1.ibm.com
Subject: Re: [PATCH] drivers/misc/cxl: Avoid unnecessary error message
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
Message-Id: <20170207230829.GA10885@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 07:14:33PM +1100, Andrew Donnellan wrote:
>On 31/01/17 14:43, Gavin Shan wrote:
>>The following error message was observed. It's complaining M32
>>memory window is missed on virtual PHB, which is a bit confusing.
>>The problem is the memory windows are never updated from its
>>device-tree node.
>>
>>   PCI: Memory resource 0 not set for host bridge \
>>   /pciex@3fffe40000000/pci@0/device@0
>>
>>This avoids the unnecessary error message by updating the PHB's
>>memory windows with pci_process_bridge_OF_ranges(). The function
>>is exported as well.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>I talked this over with Gavin in person today.
>
>We don't set a memory window on the vPHB or its devices because it's not
>necessary.
>
>The effect of this patch is to copy the memory resources from the *real* PHB
>to the vPHB, as given through the device tree. It shouldn't have any
>practical effect other than squashing this message.
>

Andrew, thanks for the explanation. I will provide more details
as reply to Michael's thread. We might need alternative fix for
this issue. Lets have more discussion in that thread if needed.

>
>>---
>> arch/powerpc/kernel/pci-common.c | 1 +
>> drivers/misc/cxl/vphb.c          | 9 +++++++++
>> 2 files changed, 10 insertions(+)
>>
>>diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>index 74bec54..b5ffd8a 100644
>>--- a/arch/powerpc/kernel/pci-common.c
>>+++ b/arch/powerpc/kernel/pci-common.c
>>@@ -824,6 +824,7 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
>> 		}
>> 	}
>> }
>>+EXPORT_SYMBOL_GPL(pci_process_bridge_OF_ranges);
>>
>> /* Decide whether to display the domain number in /proc */
>> int pci_proc_domain(struct pci_bus *bus)
>>diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
>>index 3519ace..8382761 100644
>>--- a/drivers/misc/cxl/vphb.c
>>+++ b/drivers/misc/cxl/vphb.c
>>@@ -215,6 +215,15 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
>> 	if (!phb)
>> 		return -ENODEV;
>>
>>+	/* Parse IO and memory ranges */
>>+	if (dev_is_pci(parent)) {
>
>Is this ever going to be false?
>

Yeah, I think it can be removed and to declare @pdev at the top of the function.

>>+		struct pci_dev *pdev;
>
>I think we tend to keep declarations up at the top of the function?
>

I think it's not bad idea if @pdev is invisible out of the block
of code, for a bit better code readability. However, those who
are maintaining the code might have their own personal tastes.
If it's your preferrence, I need to follow for sure.

>>+
>>+		pdev = to_pci_dev(parent);
>>+		vphb_dn = pnv_pci_get_phb_node(pdev);
>>+		pci_process_bridge_OF_ranges(phb, vphb_dn, false);
>>+	}
>>+
>> 	/* Setup parent in sysfs */
>> 	phb->parent = parent;
>>
>>

Thanks,
Gavin
