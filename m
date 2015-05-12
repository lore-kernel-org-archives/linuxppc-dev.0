Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD6841A0392
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:30:10 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 12 May 2015 17:30:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2DC8E2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:30:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4C7Txim8781972
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:30:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4C7TZRn032671
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:29:35 +1000
Date: Tue, 12 May 2015 15:29:17 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/9] powerpc/pci_dn: cache vf_index in pci_dn
Message-ID: <20150512072917.GA16788@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150511022104.GA7459@gwshan> <20150511055412.GA1632@richard>
 <20150512061558.GA18734@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150512061558.GA18734@gwshan>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 04:15:58PM +1000, Gavin Shan wrote:
>On Mon, May 11, 2015 at 01:54:12PM +0800, Wei Yang wrote:
>>On Mon, May 11, 2015 at 12:21:04PM +1000, Gavin Shan wrote:
>>>On Mon, May 04, 2015 at 03:07:31PM +0800, Wei Yang wrote:
>>>>This patch caches the index of a VF in its PF in pci_dn.
>>>>
>>>
>>>At least you can mention the purpose of vf_index to make the commit log
>>>complete. The following message looks better?
>>>
>>>The patch caches the VF index in pci_dn, which can be used to calculate
>>>VF's bus, device and function number. Those information helps to locate
>>>the VF's PCI device instance when doing hotplug during EEH recovery if
>>>necessary.
>>>
>>
>>Thanks, looks better. I added it in the log.
>>
>>>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>>>---
>>>> arch/powerpc/include/asm/pci-bridge.h |    1 +
>>>> arch/powerpc/kernel/pci_dn.c          |    5 +++--
>>>> 2 files changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>>index 1811c44..9582aa2 100644
>>>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>>>@@ -199,6 +199,7 @@ struct pci_dn {
>>>> #ifdef CONFIG_PCI_IOV
>>>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>>>> 	u16     num_vfs;		/* number of VFs enabled*/
>>>>+	int     vf_index;		/* Index to PF for VF dev */
>>>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>>					/* VF index in the PF */
>>
>>Ok, changed in the code.
>>
>>>
>>>And I believe it can be "unsigned int", or u16. We should have
>>>non-negative vf_index, no?
>>
>>Take a look in the virtfn_add(), the index in drivers/pci/iov.c is int. So I
>>copy that.
>>
>>>
>>>> 	int     offset;			/* PE# for the first VF PE */
>>>> #define M64_PER_IOV 4
>>>> 	int     m64_per_iov;
>>>>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>>>index b3b4df9..bf0fb873 100644
>>>>--- a/arch/powerpc/kernel/pci_dn.c
>>>>+++ b/arch/powerpc/kernel/pci_dn.c
>>>>@@ -138,7 +138,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>>>>
>>>> #ifdef CONFIG_PCI_IOV
>>>> static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>>>-					   struct pci_dev *pdev,
>>>>+					   struct pci_dev *pdev, int vf_index,
>>>
>>>					   struct pci_dev *pdev,
>>>					   int vf_index;
>>
>>Some reason for this comment?
>>
>>That does not exceed 80 characters.
>>
>
>No, it doesn't exceed 80 characters as you said. You take one of the following
>formats, not the one you're using:
>
>add_one_dev_pci_data(foo1, foo2,          add_one_dev_pci_data(foo1,
>                     foo3, foo4,                               foo2,
>                     foo5, foo6);                                :
>                                                               foo6);
>

Thanks

>>>> 					   int busno, int devfn)
>>>> {
>>>> 	struct pci_dn *pdn;
>>>>@@ -157,6 +157,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>>> 	pdn->parent = parent;
>>>> 	pdn->busno = busno;
>>>> 	pdn->devfn = devfn;
>>>>+	pdn->vf_index = vf_index;
>>>> #ifdef CONFIG_PPC_POWERNV
>>>> 	pdn->pe_number = IODA_INVALID_PE;
>>>> #endif
>>>>@@ -196,7 +197,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>>>> 		return NULL;
>>>>
>>>> 	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>>>>-		pdn = add_one_dev_pci_data(parent, NULL,
>>>>+		pdn = add_one_dev_pci_data(parent, NULL, i,
>>>> 					   pci_iov_virtfn_bus(pdev, i),
>>>> 					   pci_iov_virtfn_devfn(pdev, i));
>>>> 		if (!pdn) {
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me
