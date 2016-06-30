Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg2Gn6QDXzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:37:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5U1WAGC013609
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:37:35 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09q2bfu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:37:35 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 19:37:34 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Pat Wall <pjwall@mac.com>, matthew@a-eon.com, aperez@alexperez.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH v2 RFC] pasemi: Fix boot failure on 4.7-rc1
In-Reply-To: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
References: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
Date: Thu, 30 Jun 2016 07:07:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87poqz4fue.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Darren Stevens <darren@stevens-zone.net> writes:

>     Commit:d6a9996e84ac4beb7713e9485f4563e100a9b03e (powerpc/mm:
>     vmalloc abstraction in preparation for radix) turned kernel memory
>     and IO addresses from #defined constants to variables initialised
>     at runtime.
>     
>     On PA6T systems the setup_arch machine call initialises the onboard
>     PCI-e root-ports, and uses pci_io_base to do this, which is now before
>     its value has been set resulting in a panic right after 'booting 
>     linux via __start()'
>
>     Move the pci_io_base initialisation to the same place as vmalloc
>     ranges are set (hash__early_init_mmu()/radix__early_init_mmu())
>     
>     Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>     Signed-off-by: Darren Stevens <darren@stevens-zone.net>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

>     
> ---
>
> Tested on my AmigaOneX1000, I don't have access to a refence board system,
> and our developer with one is on honeymoon.
>
> I am hoping to follow this patch with others to reduce the size of the nemo
> patch we apply, eventually I'd like to see the patch gone, but that is a 
> very big job.
>
> Kind regards
> Darren
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 88a5eca..ab84c89 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -230,6 +230,7 @@ extern unsigned long __kernel_virt_size;
>  #define KERN_VIRT_SIZE  __kernel_virt_size
>  extern struct page *vmemmap;
>  extern unsigned long ioremap_bot;
> +extern unsigned long pci_io_base;
>  #endif /* __ASSEMBLY__ */
>
>  #include <asm/book3s/64/hash.h>
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 3759df5..a5ae49a 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -47,7 +47,6 @@ static int __init pcibios_init(void)
>
>  	printk(KERN_INFO "PCI: Probing PCI hardware\n");
>
> -	pci_io_base = ISA_IO_BASE;
>  	/* For now, override phys_mem_access_prot. If we need it,g
>  	 * later, we may move that initialization to each ppc_md
>  	 */
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 5b22ba0..b5b5fe6 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -922,6 +922,8 @@ void __init hash__early_init_mmu(void)
>  	vmemmap = (struct page *)H_VMEMMAP_BASE;
>  	ioremap_bot = IOREMAP_BASE;
>
> +	pci_io_base = ISA_IO_BASE;
> +
>  	/* Initialize the MMU Hash table and create the linear mapping
>  	 * of memory. Has to be done before SLB initialization as this is
>  	 * currently where the page size encoding is obtained.
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index e58707d..095fbfa 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -328,6 +328,9 @@ void __init radix__early_init_mmu(void)
>  	__vmalloc_end = RADIX_VMALLOC_END;
>  	vmemmap = (struct page *)RADIX_VMEMMAP_BASE;
>  	ioremap_bot = IOREMAP_BASE;
> +
> +	pci_io_base = ISA_IO_BASE;
> +
>  	/*
>  	 * For now radix also use the same frag size
>  	 */
