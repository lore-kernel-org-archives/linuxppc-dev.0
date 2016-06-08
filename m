Return-Path: <chzigotzky@xenosoft.de>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.218])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPt9z6qWVzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 01:47:51 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Darren Stevens <darren@stevens-zone.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 luigi burdo <intermediadc@hotmail.com>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
 <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
 <1465174304.12265.0.camel@ellerman.id.au>
 <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
 <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
 <87r3c71zs9.fsf@skywalker.in.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <d3753fa2-d88b-2e31-7d0d-d8952c29a12b@xenosoft.de>
Date: Wed, 8 Jun 2016 17:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <87r3c71zs9.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

We use it only in the file "pci-common.c".

Part of the Nemo patch with ISA_IO_BASE:

diff -rupN linux-4.7/arch/powerpc/kernel/pci-common.c 
linux-4.7-nemo/arch/powerpc/kernel/pci-common.c
--- linux-4.7/arch/powerpc/kernel/pci-common.c    2016-05-20 
10:23:06.588299920 +0200
+++ linux-4.7-nemo/arch/powerpc/kernel/pci-common.c    2016-05-20 
10:21:28.652296699 +0200
@@ -723,6 +723,19 @@ void pci_process_bridge_OF_ranges(struct
                  isa_io_base =
                      (unsigned long)hose->io_base_virt;
  #endif /* CONFIG_PPC32 */
+
+
+#ifdef CONFIG_PPC_PASEMI_SB600
+                       /* Workaround for lack of device tree. New for 
kernel 3.17: range.cpu_addr instead of cpu_addr and range.size instead 
of size Ch. Zigotzky */
+                       if (primary) {
+                               __ioremap_at(range.cpu_addr, (void 
*)ISA_IO_BASE,
+                               range.size, 
pgprot_val(pgprot_noncached(__pgprot(0))));
+                       hose->io_base_virt = (void *)_IO_BASE;
+               /* _IO_BASE needs unsigned long long for the kernel 3.17 
Ch. Zigotzky */
+                       printk("Initialised io_base_virt 0x%lx _IO_BASE 
0x%llx\n", (unsigned long)hose->io_base_virt, (unsigned long long)_IO_BASE);
+                    }
+#endif
+

Cheers,

Christian

On 08 June 2016 at 5:11 PM, Aneesh Kumar K.V wrote:
>
> Can you check the value of ISA_IO_BASE where you are
> using it. If you are calling it early, you will find wrong value in
> that. With the latest kernel it is a variable and is initialized in
> hash__early_init_mmu();
>
> -aneesh
>
>
