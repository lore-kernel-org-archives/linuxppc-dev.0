Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMP196dtXzDq80
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2016 00:46:37 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 4 Jun 2016 08:46:35 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, darren@stevens-zone.net,
 Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>,
 Adrian Cox <adrian@humboldt.co.uk>, "R.T.Dickinson" <rtd@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@mac.com>,
 Pat Wall <pjwall@me.com>, "contact@a-eon.com" <contact@a-eon.com>,
 Matthew Leaman <matthew@a-eon.biz>, luigi burdo <intermediadc@hotmail.com>,
 Christian Zigotzky <info@xenosoft.de>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
In-Reply-To: <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <fa666396-4b81-f317-18e2-48078233bb57@xenosoft.de>
Date: Sat, 04 Jun 2016 20:16:23 +0530
Message-ID: <871t4dui4g.fsf@skywalker.in.ibm.com>
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

> Hi All,
>
> I compiled the latest git version of kernel 4.7 with all PowerPC=20
> commits. Maybe the latest commit powerpc-4.7-2 solved the boot issues.=20
> Our latest Nemo patch 4.7-1 works without any problems with the latest=20
> git version.


instead of using powerpc-4.7-2 can you use the upstream SHA1 commit id
?. I am not sure how to map 4.7-2 to a kernel version.

>
> I got the following error message:
>
> arch/powerpc/kernel/pci-common.c: In function=20
> =E2=80=98pci_process_bridge_OF_ranges=E2=80=99:
> arch/powerpc/kernel/pci-common.c:732:59: error: =E2=80=98_PAGE_GUARDED=E2=
=80=99=20
> undeclared (first use in this function)
>                                  range.size, _PAGE_NO_CACHE|_PAGE_GUARDED=
);
>                                                             ^
> arch/powerpc/kernel/pci-common.c:732:59: note: each undeclared=20
> identifier is reported only once for each function it appears in
> make[1]: *** [arch/powerpc/kernel/pci-common.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2



Which kernel is that ? For upstream I have at that line

 729                         hose->pci_io_size =3D range.pci_addr + range.s=
ize;
 730                         hose->io_base_phys =3D range.cpu_addr - range.=
pci_addr;
 731=20
 732                         /* Build resource */
 733                         res =3D &hose->io_resource;
 734                         range.cpu_addr =3D range.pci_addr;
 735                         break;
 736                 case IORESOURCE_MEM:


-aneesh
