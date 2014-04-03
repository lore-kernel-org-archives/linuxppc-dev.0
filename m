Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC7E01400F7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 10:12:37 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 3 Apr 2014 19:12:35 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6171E38C8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 19:12:32 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s33NCWJ55898716
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Apr 2014 23:12:32 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s33NCVKi004685
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Apr 2014 19:12:32 -0400
Date: Thu, 3 Apr 2014 16:12:25 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] hugetlb: ensure hugepage access is denied if
 hugepages are not supported
Message-ID: <20140403231225.GA17412@linux.vnet.ibm.com>
References: <20140324230256.GA18778@linux.vnet.ibm.com>
 <20140326155815.GB15234@linux.vnet.ibm.com>
 <87ioqqo065.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ioqqo065.fsf@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 nyc@holomorphy.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.04.2014 [21:49:46 +0530], Aneesh Kumar K.V wrote:
> Nishanth Aravamudan <nacc@linux.vnet.ibm.com> writes:
> 
> > On 24.03.2014 [16:02:56 -0700], Nishanth Aravamudan wrote:
> >> In KVM guests on Power, if the guest is not backed by hugepages, we see
> >> the following in the guest:
> >> 
> >> AnonHugePages:         0 kB
> >> HugePages_Total:       0
> >> HugePages_Free:        0
> >> HugePages_Rsvd:        0
> >> HugePages_Surp:        0
> >> Hugepagesize:         64 kB
> >> 
> >> This seems like a configuration issue -- why is a hstate of 64k being
> >> registered?
> >> 
> >> I did some debugging and found that the following does trigger,
> >> mm/hugetlb.c::hugetlb_init():
> >> 
> >>         /* Some platform decide whether they support huge pages at boot
> >>          * time. On these, such as powerpc, HPAGE_SHIFT is set to 0 when
> >>          * there is no such support
> >>          */
> >>         if (HPAGE_SHIFT == 0)
> >>                 return 0;
> >> 
> >> That check is only during init-time. So we don't support hugepages, but
> >> none of the hugetlb APIs actually check this condition (HPAGE_SHIFT ==
> >> 0), so /proc/meminfo above falsely indicates there is a valid hstate (at
> >> least one). But note that there is no /sys/kernel/mm/hugepages meaning
> >> no hstate was actually registered.
> >> 
> >> Further, it turns out that huge_page_order(default_hstate) is 0, so
> >> hugetlb_report_meminfo is doing:
> >> 
> >> 1UL << (huge_page_order(h) + PAGE_SHIFT - 10)
> >> 
> >> which ends up just doing 1 << (PAGE_SHIFT - 10) and since the base page
> >> size is 64k, we report a hugepage size of 64k... And allow the user to
> >> allocate hugepages via the sysctl, etc.
> >> 
> >> What's the right thing to do here?
> >> 
> >> 1) Should we add checks for HPAGE_SHIFT == 0 to all the hugetlb APIs? It
> >> seems like HPAGE_SHIFT == 0 should be the equivalent, functionally, of
> >> the config options being off. This seems like a lot of overhead, though,
> >> to put everywhere, so maybe I can do it in an arch-specific macro, that
> >> in asm-generic defaults to 0 (and so will hopefully be compiled out?).
> >> 
> >> 2) What should hugetlbfs do when HPAGE_SHIFT == 0? Should it be
> >> mountable? Obviously if it's mountable, we can't great files there
> >> (since the fs will report insufficient space). [1]
> >
> > Here is my solution to this. Comments appreciated!
> >
> > In KVM guests on Power, in a guest not backed by hugepages, we see the
> > following:
> >
> > AnonHugePages:         0 kB
> > HugePages_Total:       0
> > HugePages_Free:        0
> > HugePages_Rsvd:        0
> > HugePages_Surp:        0
> > Hugepagesize:         64 kB
> >
> > HPAGE_SHIFT == 0 in this configuration, which indicates that hugepages
> > are not supported at boot-time, but this is only checked in
> > hugetlb_init(). Extract the check to a helper function, and use it in a
> > few relevant places.
> >
> > This does make hugetlbfs not supported in this environment. I believe
> > this is fine, as there are no valid hugepages and that won't change at
> > runtime.
> >
> > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> 
> Looks good. Can you resubmit it as a proper patch ?

Will Cc you on that.


> You may also want to capture in commit message saying hugetlbfs file
> system also will not be registered. 

I did that already:

> > This does make hugetlbfs not supported in this environment. I
> > believe this is fine, as there are no valid hugepages and that won't
> > change at runtime.

Thanks,
Nish
