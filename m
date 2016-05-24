Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDfgf0sgQzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:38:06 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 25 May 2016 01:38:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8CAD82CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:38:01 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4OFbrJ85439964
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:38:01 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4OFbTat022695
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 01:37:29 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net
Cc: Michael Ellerman <michaele@au1.ibm.com>
Subject: Re: PAGE_GUARDED
In-Reply-To: <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
Date: Tue, 24 May 2016 21:07:10 +0530
Message-ID: <87d1obqxg9.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Zigotzky <chzigotzky@xenosoft.de> writes:

> Ben,
>
> I tried:
>
> /* Workaround for lack of device tree */
>                         if (primary) {
>                                 __ioremap_at(range.cpu_addr, (void=20
> *)ISA_IO_BASE,
>                                 range.size, pgprot_noncached(PAGE_KERNEL)=
);
>                         hose->io_base_virt =3D (void *)_IO_BASE;
>                         printk("Initialised io_base_virt 0x%lx _IO_BASE=20
> 0x%llx\n", (unsigned long)hose->io_base_virt, (unsigned long long)_IO_BAS=
E);
>                      }
>
> Unfortunately I got some error messages:
>
> arch/powerpc/kernel/pci-common.c: In function=20
> =E2=80=98pci_process_bridge_OF_ranges=E2=80=99:
> arch/powerpc/kernel/pci-common.c:731:32: error: incompatible type for=20
> argument 4 of =E2=80=98__ioremap_at=E2=80=99
>                                  __ioremap_at(range.cpu_addr, (void=20
> *)ISA_IO_BASE,
>                                  ^
> In file included from include/linux/io.h:25:0,
>                   from include/linux/pci.h:31,
>                   from arch/powerpc/kernel/pci-common.c:20:
> ./arch/powerpc/include/asm/io.h:746:23: note: expected =E2=80=98long unsi=
gned=20
> int=E2=80=99 but argument is of type =E2=80=98pgprot_t=E2=80=99
>   extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
>

You can look at commit 72176dd0ad36c ("powerpc/mm: Use a helper for
finding pte bits mapping I/O area") to find similar conversion we did.

For ex:
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
		     size, _PAGE_NO_CACHE|_PAGE_GUARDED);

gets replaced by

 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
		     size, pgprot_val(pgprot_noncached(__pgprot(0))));

Now that gets mapped to the below hpte bits

pte bit -> _PAGE_NON_IDEMPOTENT

Which get converted in htab_convert_pte_flags(unsigned long pteflags)
to

	if ((pteflags & _PAGE_CACHE_CTL ) =3D=3D _PAGE_NON_IDEMPOTENT)
		rflags |=3D (HPTE_R_I | HPTE_R_G);

BTW we default add (HPTE_R_C | HPTE_R_M ).

Hence the final pte WIMG bits will be MIG. I guess that is what you
wanted ?


If that doesn't work, can you point me the current code so that I can
look at it and suggest correct alternative.

-aneesh
