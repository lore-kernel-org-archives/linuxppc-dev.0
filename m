Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJBqz3957zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 17:58:23 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v186roxV043104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 01:58:21 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28faw93swc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 01:58:20 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 8 Feb 2017 16:58:18 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 121AD357805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 17:58:15 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v186w6GI30474412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 17:58:14 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v186vg56031891
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 17:57:43 +1100
Subject: Re: [PATCH v2] powerpc/kernel: Remove error message in
 pcibios_setup_phb_resources()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1486523463-19953-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: imunsie@au1.ibm.com, mpe@ellerman.id.au
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 8 Feb 2017 17:57:17 +1100
MIME-Version: 1.0
In-Reply-To: <1486523463-19953-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5325febc-dc6b-8b71-fcc6-6074a732ade1@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/17 14:11, Gavin Shan wrote:
> The CAPI driver creates virtual PHB (vPHB) from the CAPI adapter.
> The vPHB's IO and memory windows aren't built from device-tree node
> as we do for normal PHBs. A error message is thrown in below path
> when trying to probe AFUs contained in the adapter. The error message
> is confusing and unnecessary.
>
>     cxl_probe()
>     pci_init_afu()
>     cxl_pci_vphb_add()
>     pcibios_scan_phb()
>     pcibios_setup_phb_resources()
>
> This removes the error message. We might have the case where the
> first memory window on real PHB isn't populated properly because
> of error in "ranges" property in the device-tree node. We can check
> the device-tree instead for that. This also removes one unnecessary
> blank line in the function.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
> v2: Removes the error message instead of avoiding it
> ---
>  arch/powerpc/kernel/pci-common.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 74bec54..05bfdae 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1559,16 +1559,10 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
>  	/* Hookup PHB Memory resources */
>  	for (i = 0; i < 3; ++i) {
>  		res = &hose->mem_resources[i];
> -		if (!res->flags) {
> -			if (i == 0)
> -				printk(KERN_ERR "PCI: Memory resource 0 not set for "
> -				       "host bridge %s (domain %d)\n",
> -				       hose->dn->full_name, hose->global_number);
> +		if (!res->flags)
>  			continue;
> -		}
> -		offset = hose->mem_offset[i];
> -
>
> +		offset = hose->mem_offset[i];
>  		pr_debug("PCI: PHB MEM resource %d = %pR off 0x%08llx\n", i,
>  			 res, (unsigned long long)offset);
>
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
