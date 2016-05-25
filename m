Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF3VM5G3nzDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 17:16:26 +1000 (AEST)
Subject: PAGE_GUARDED
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <fa1a315f-6337-f88a-4be7-000f7d8495a8@xenosoft.de>
Date: Wed, 25 May 2016 08:58:03 +0200
MIME-Version: 1.0
In-Reply-To: <87d1obqxg9.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh,

Thank you for your help. I tried

/* Workaround for lack of device tree */
                        if (primary) {
                                __ioremap_at(range.cpu_addr, (void 
*)ISA_IO_BASE,
                                range.size, HPTE_R_C | HPTE_R_M);
                        hose->io_base_virt = (void *)_IO_BASE;
                        printk("Initialised io_base_virt 0x%lx _IO_BASE 
0x%llx\n", (unsigned long)hose->io_base_virt, (unsigned long long)_IO_BASE);
                     }

Unfortunately the kernel doesn't boot.

Cheers,

Christian

On 24 May 2016 at 5:37 PM, Aneesh Kumar K.V wrote:
> You can look at commit 72176dd0ad36c ("powerpc/mm: Use a helper for
> finding pte bits mapping I/O area") to find similar conversion we did.
>
> For ex:
>   	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
> 		     size, _PAGE_NO_CACHE|_PAGE_GUARDED);
>
> gets replaced by
>
>   	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
> 		     size, pgprot_val(pgprot_noncached(__pgprot(0))));
>
> Now that gets mapped to the below hpte bits
>
> pte bit -> _PAGE_NON_IDEMPOTENT
>
> Which get converted in htab_convert_pte_flags(unsigned long pteflags)
> to
>
> 	if ((pteflags & _PAGE_CACHE_CTL ) == _PAGE_NON_IDEMPOTENT)
> 		rflags |= (HPTE_R_I | HPTE_R_G);
>
> BTW we default add (HPTE_R_C | HPTE_R_M ).
>
> Hence the final pte WIMG bits will be MIG. I guess that is what you
> wanted ?
>
>
> If that doesn't work, can you point me the current code so that I can
> look at it and suggest correct alternative.
>
> -aneesh
>
>
