Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPsN843R3zDqn2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 01:11:36 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 11:11:30 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>,
 Adrian Cox <adrian@humboldt.co.uk>, "R.T.Dickinson" <rtd@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@mac.com>,
 Pat Wall <pjwall@me.com>, "contact@a-eon.com" <contact@a-eon.com>,
 Matthew Leaman <matthew@a-eon.biz>, luigi burdo <intermediadc@hotmail.com>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
In-Reply-To: <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
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
Date: Wed, 08 Jun 2016 20:41:18 +0530
Message-ID: <87r3c71zs9.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Darren Stevens <darren@stevens-zone.net> writes:

> Hello Christian

> That's not where I ended up with my bisect, this commit is about 10 before the
> one I found to be bad, which is:
>
> commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Fri Apr 29 23:26:21 2016 +1000
>
>     powerpc/mm: vmalloc abstraction in preparation for radix
>     
>     The vmalloc range differs between hash and radix config. Hence make
>     VMALLOC_START and related constants a variable which will be runtime
>     initialized depending on whether hash or radix mode is active.
>     
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>     [mpe: Fix missing init of ioremap_bot in pgtable_64.c for ppc64e]
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>

Can you check the value of ISA_IO_BASE where you are
using it. If you are calling it early, you will find wrong value in
that. With the latest kernel it is a variable and is initialized in
hash__early_init_mmu();

-aneesh
