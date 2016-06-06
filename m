Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNGSK0KDGzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 10:54:41 +1000 (AEST)
Message-ID: <1465174480.12265.2.camel@ellerman.id.au>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Christian Zigotzky
 <chzigotzky@xenosoft.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  linuxppc-dev@lists.ozlabs.org,
 darren@stevens-zone.net, Michael Ellerman <michaele@au1.ibm.com>, Julian
 Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat
 Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,  "contact@a-eon.com"
 <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>, luigi burdo
 <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
Date: Mon, 06 Jun 2016 10:54:40 +1000
In-Reply-To: <871t4dui4g.fsf@skywalker.in.ibm.com>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
 <871t4dui4g.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-06-04 at 20:16 +0530, Aneesh Kumar K.V wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
> 
> > Hi All,
> > 
> > I compiled the latest git version of kernel 4.7 with all PowerPC 
> > commits. Maybe the latest commit powerpc-4.7-2 solved the boot issues. 
> > Our latest Nemo patch 4.7-1 works without any problems with the latest 
> > git version.
> 
> 
> instead of using powerpc-4.7-2 can you use the upstream SHA1 commit id
> ?. I am not sure how to map 4.7-2 to a kernel version.

That's my tag:

  https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/tag/?h=powerpc-4.7-2

> > I got the following error message:
> > 
> > arch/powerpc/kernel/pci-common.c: In function 
> > ‘pci_process_bridge_OF_ranges’:
> > arch/powerpc/kernel/pci-common.c:732:59: error: ‘_PAGE_GUARDED’ 
> > undeclared (first use in this function)
> >                                  range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);
> >                                                             ^
> > arch/powerpc/kernel/pci-common.c:732:59: note: each undeclared 
> > identifier is reported only once for each function it appears in
> > make[1]: *** [arch/powerpc/kernel/pci-common.o] Error 1
> > make: *** [arch/powerpc/kernel] Error 2
> 
> Which kernel is that ? For upstream I have at that line
> 
>  729                         hose->pci_io_size = range.pci_addr + range.size;
>  730                         hose->io_base_phys = range.cpu_addr - range.pci_addr;
>  731 
>  732                         /* Build resource */
>  733                         res = &hose->io_resource;
>  734                         range.cpu_addr = range.pci_addr;
>  735                         break;
>  736                 case IORESOURCE_MEM:

Christian is running an out-of-tree patch for the nemo board. He did post it to
the list at some point.

cheers
