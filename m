Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDc8F5TpGzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 23:44:12 +1000 (AEST)
Subject: PAGE_GUARDED
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <michaele@au1.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
Date: Tue, 24 May 2016 15:37:58 +0200
MIME-Version: 1.0
In-Reply-To: <1464088614.3078.79.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

I tried:

/* Workaround for lack of device tree */
                        if (primary) {
                                __ioremap_at(range.cpu_addr, (void 
*)ISA_IO_BASE,
                                range.size, pgprot_noncached(PAGE_KERNEL));
                        hose->io_base_virt = (void *)_IO_BASE;
                        printk("Initialised io_base_virt 0x%lx _IO_BASE 
0x%llx\n", (unsigned long)hose->io_base_virt, (unsigned long long)_IO_BASE);
                     }

Unfortunately I got some error messages:

arch/powerpc/kernel/pci-common.c: In function 
‘pci_process_bridge_OF_ranges’:
arch/powerpc/kernel/pci-common.c:731:32: error: incompatible type for 
argument 4 of ‘__ioremap_at’
                                 __ioremap_at(range.cpu_addr, (void 
*)ISA_IO_BASE,
                                 ^
In file included from include/linux/io.h:25:0,
                  from include/linux/pci.h:31,
                  from arch/powerpc/kernel/pci-common.c:20:
./arch/powerpc/include/asm/io.h:746:23: note: expected ‘long unsigned 
int’ but argument is of type ‘pgprot_t’
  extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,

Cheers,

Christian


On 24 May 2016 at 1:16 PM, Benjamin Herrenschmidt wrote:
> Actually, can you try pgprot_noncached(PAGE_KERNEL) ? If that works,
> then I wonder what that's going on in pci_64.c ...
>
> Cheers,
> Ben.
