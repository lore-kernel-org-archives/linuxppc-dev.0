Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E825E1A0B72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 13:05:50 +1100 (AEDT)
Received: by pasz6 with SMTP id z6so57825088pas.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 19:05:48 -0700 (PDT)
Subject: Re: [PATCH V10 03/12] powerpc/pci: Cache VF index in pci_dn
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5632D077.40304@ozlabs.ru>
Date: Fri, 30 Oct 2015 13:05:43 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/26/2015 02:15 PM, Wei Yang wrote:
> The patch caches the VF index in pci_dn, which can be used to calculate
> VF's bus, device and function number. Those information helps to locate
> the VF's PCI device instance when doing hotplug during EEH recovery if
> necessary.


The patch itself does not make much sense and quite small, I'd merge it 
into the one which makes use of this new vf_index.

>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/pci-bridge.h | 1 +
>   arch/powerpc/kernel/pci_dn.c          | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index b3a226b..3d7e537 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -210,6 +210,7 @@ struct pci_dn {
>   #define IODA_INVALID_PE		(-1)
>   #ifdef CONFIG_PPC_POWERNV
>   	int	pe_number;
> +	int     vf_index;		/* VF index in the PF */
>   #ifdef CONFIG_PCI_IOV
>   	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>   	u16     num_vfs;		/* number of VFs enabled*/
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index b3b4df9..f771130 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>   #ifdef CONFIG_PCI_IOV
>   static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>   					   struct pci_dev *pdev,
> +					   int vf_index,
>   					   int busno, int devfn)
>   {
>   	struct pci_dn *pdn;
> @@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>   	pdn->parent = parent;
>   	pdn->busno = busno;
>   	pdn->devfn = devfn;
> +	pdn->vf_index = vf_index;
>   #ifdef CONFIG_PPC_POWERNV
>   	pdn->pe_number = IODA_INVALID_PE;
>   #endif
> @@ -196,7 +198,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>   		return NULL;
>
>   	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
> -		pdn = add_one_dev_pci_data(parent, NULL,
> +		pdn = add_one_dev_pci_data(parent, NULL, i,
>   					   pci_iov_virtfn_bus(pdev, i),
>   					   pci_iov_virtfn_devfn(pdev, i));
>   		if (!pdn) {
>


-- 
Alexey
