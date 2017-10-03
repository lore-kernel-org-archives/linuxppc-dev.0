Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5tVv33qVzDqm8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 20:08:39 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9395tcO122064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 05:08:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dc6nnkf3b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 05:08:36 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 05:08:35 -0400
Subject: Re: [linux-next] [bisected a4615d11] Memory DLPAR triggers
 WARN_ONCE() in mm/page_vma_mapped.c
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>
Date: Tue, 03 Oct 2017 14:38:30 +0530
In-Reply-To: <08A52087-D1D6-45C9-A660-154EB6BF780B@cs.rutgers.edu>
References: <1505123773.10243.9.camel@abdul>
 <FCEFC0A6-D32A-424C-9858-7C996956F4C0@cs.rutgers.edu>
 <1505281695.9665.5.camel@abdul.in.ibm.com>
 <08A52087-D1D6-45C9-A660-154EB6BF780B@cs.rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1507021710.3792.3.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-29 at 10:07 -0400, Zi Yan wrote:
> Hi Abdul,
> 
> I just want to follow up with this.
> 
> Did you have a chance to test my patch? Does it fix your original problem?

Yes I did test the patch. it fixes the warning.

Reported-and-tested-by:  Abdul Haleem <abdhalee@linux.vnet.ibm.com>

Thanks for the fix.

--
Regard's

Abdul Haleem
IBM Linux Technology Centre

> 
> On 13 Sep 2017, at 1:48, abdul wrote:
> 
> > On Mon, 2017-09-11 at 10:53 -0400, Zi Yan wrote:
> >> Hi Abdul,
> >>
> >> Can you try this patch below? I think I missed that pmd entries
> >> can be zapped, so the WARN_ONCE is unnecessary.
> >>
> >> Thanks.
> >>
> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >> index 6a03946469a9..eb462e7db0a9 100644
> >> --- a/mm/page_vma_mapped.c
> >> +++ b/mm/page_vma_mapped.c
> >> @@ -167,8 +167,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >>                                                 return not_found(pvmw);
> >>                                         return true;
> >>                                 }
> >> -                       } else
> >> -                               WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
> >> +                       }
> >>                         return not_found(pvmw);
> >>                 } else {
> >>                         /* THP pmd was split under us: handle on pte level */
> >>
> >> --
> >> Best Regards
> >> Yan Zi
