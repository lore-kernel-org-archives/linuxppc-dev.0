Return-Path: <chzigotzky@xenosoft.de>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPqbp6DT7zDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 23:51:34 +1000 (AEST)
Subject: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
To: Darren Stevens <darren@stevens-zone.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>,
 Julian Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 luigi burdo <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
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
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <18d21f44-295c-d177-6283-7bebf49382dd@xenosoft.de>
Date: Wed, 8 Jun 2016 15:51:00 +0200
MIME-Version: 1.0
In-Reply-To: <484bd17c3f3.74dd55e@auth.smtp.1and1.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I tried to revert this commit but unfortunately I doesn't work:

git revert d6a9996e84ac4beb7713e9485f4563e100a9b03e

error: could not revert d6a9996... powerpc/mm: vmalloc abstraction in 
preparation for radix
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'


Any hints?

Thanks,

Christian

On 08 June 2016 at 1:33 PM, Darren Stevens wrote:
> Hello Christian
>
> That's not where I ended up with my bisect, this commit is about 10 before the
> one I found to be bad, which is:
>
> commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Fri Apr 29 23:26:21 2016 +1000
>
>      powerpc/mm: vmalloc abstraction in preparation for radix
>      
>      The vmalloc range differs between hash and radix config. Hence make
>      VMALLOC_START and related constants a variable which will be runtime
>      initialized depending on whether hash or radix mode is active.
>      
>      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>      [mpe: Fix missing init of ioremap_bot in pgtable_64.c for ppc64e]
>      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Not sure how we are getting different results though. I have attached my
> bisect log and the suspect commit, whcih is quite large. I'm not sure which
> part of it is at fault. I have some jobs to do now, but hope to get tesing
> this later today.
>
> Regards
> Darren
