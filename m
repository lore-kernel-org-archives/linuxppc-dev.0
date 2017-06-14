Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnZVJ6J2bzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:11:20 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5E5AOEX002776
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 01:11:18 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2stx9ydf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 01:11:18 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 14 Jun 2017 15:11:14 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5E5BB7R57868384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:11:11 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5E5BAgw017370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:11:11 +1000
Date: Wed, 14 Jun 2017 10:41:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "Shriya R . Kulkarni" <shriykul@in.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH] powerpc64/hw_breakpoints: Handle data breakpoints in
 radix mode
References: <20170613184200.22541-1-naveen.n.rao@linux.vnet.ibm.com>
 <87r2yn1d1g.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2yn1d1g.fsf@skywalker.in.ibm.com>
Message-Id: <20170614051109.GB16085@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On 2017/06/14 08:38AM, Aneesh Kumar K.V wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > On P9, trying to use data breakpoints throws the splat shown below (*).
> > This is because the check for a data breakpoint in DSISR is in
> > do_hash_page(). Move this check to handle_page_fault() so as to catch
> > data breakpoints in both hash and radix MMU modes.
> >
> > While at it, also remove the label '11' that was made redundant by
> > commit a546498f3bf9aa ("powerpc: Call do_page_fault() with interrupts
> > off")
> >
> > (*)
> >     Unable to handle kernel paging request for data at address 0xc000000000e19218
> >     Faulting instruction address: 0xc0000000001155e8
> >     cpu 0x0: Vector: 300 (Data Access) at [c0000000ef1e7b20]
> >     pc: c0000000001155e8: find_pid_ns+0x48/0xe0
> >     lr: c000000000116ac4: find_task_by_vpid+0x44/0x90
> >     sp: c0000000ef1e7da0
> >     msr: 9000000000009033
> >     dar: c000000000e19218
> >     dsisr: 400000
> >     current = 0xc0000000f1f59700
> >     paca    = 0xc00000000fd40000 softe: 0 irq_happened: 0x01
> >     pid   = 1192, comm = sh
> >     Linux version 4.12.0-rc3-nnr (root@ea605ec2993c) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) ) #74 SMP Tue Jun 13 16:52:49 UTC 2017
> >     enter ? for help
> >     [c0000000ef1e7dc0] c000000000116ac4 find_task_by_vpid+0x44/0x90
> >     [c0000000ef1e7de0] c000000000108800 SyS_setpgid+0x80/0x220
> >     [c0000000ef1e7e30] c00000000000ba6c system_call+0x38/0xfc
> >     --- Exception: c01 (System Call) at 00007fff94480890
> >     SP (7fffd91e7260) is in userspace
> >
> > Fixes: caca285e5ab4a ("powerpc/mm/radix: Use STD_MMU_64 to properly
> > isolate hash related code")
> > Reported-by: Shriya R. Kulkarni <shriykul@in.ibm.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index ae418b85c17c..17ee701b8336 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -1411,10 +1411,8 @@ USE_TEXT_SECTION()
> >  	.balign	IFETCH_ALIGN_BYTES
> >  do_hash_page:
> >  #ifdef CONFIG_PPC_STD_MMU_64
> > -	andis.	r0,r4,0xa410		/* weird error? */
> > +	andis.	r0,r4,0xa450		/* weird error? */
> 
> Can we convert that to a #define value. Ram did try to do that here.
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-June/158607.html

Hmm... I feel it will be good to do that as part of Ram's series since 
he has already coded it up :)

Ram's patches will anyway require a rebase and the change I do here for 
detecting DAWR already has a #define, so it should be a simple matter of 
including DSISR_DABRMATCH in DSISR_PAGE_FAULT_MASK.

But, if you really feel that I should make that change here, please do 
let me know and I will re-spin with those changes.


Thanks for the review!
- Naveen
