Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdB2g0B04zDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:22:02 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O4JIp1008521
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:22:00 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2chhg3n2fs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 00:21:59 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 24 Aug 2017 14:21:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7O4LtWJ36175884
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:21:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7O4Lt6G017910
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 14:21:55 +1000
Subject: Re: [PATCH kernel 1/5] powerpc/pci: Remove unused parameter from
 add_one_dev_pci_data()
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170823101901.33961-1-aik@ozlabs.ru>
 <20170823102823.7F12CC603E@b03ledav006.gho.boulder.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 24 Aug 2017 14:21:54 +1000
MIME-Version: 1.0
In-Reply-To: <20170823102823.7F12CC603E@b03ledav006.gho.boulder.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <320978b9-6d64-4809-7247-9d13aca6eaff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/08/17 20:18, Alexey Kardashevskiy wrote:
> pdev is always NULL, remove it.
> 
> To make checkpatch.pl happy, this also removes the "out of memory"
> message.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/kernel/pci_dn.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index 592693437070..0256372b72de 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -139,7 +139,6 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>   
>   #ifdef CONFIG_PCI_IOV
>   static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
> -					   struct pci_dev *pdev,
>   					   int vf_index,
>   					   int busno, int devfn)
>   {
> @@ -150,10 +149,8 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>   		return NULL;
>   
>   	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
> -	if (!pdn) {
> -		dev_warn(&pdev->dev, "%s: Out of memory!\n", __func__);
> +	if (!pdn)
>   		return NULL;
> -	}
>   
>   	pdn->phb = parent->phb;
>   	pdn->parent = parent;
> @@ -167,13 +164,6 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>   	INIT_LIST_HEAD(&pdn->list);
>   	list_add_tail(&pdn->list, &parent->child_list);
>   
> -	/*
> -	 * If we already have PCI device instance, lets
> -	 * bind them.
> -	 */
> -	if (pdev)
> -		pdev->dev.archdata.pci_data = pdn;
> -
>   	return pdn;
>   }
>   #endif
> @@ -201,7 +191,7 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>   	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>   		struct eeh_dev *edev __maybe_unused;
>   
> -		pdn = add_one_dev_pci_data(parent, NULL, i,
> +		pdn = add_one_dev_pci_data(parent, i,
>   					   pci_iov_virtfn_bus(pdev, i),
>   					   pci_iov_virtfn_devfn(pdev, i));
>   		if (!pdn) {
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
