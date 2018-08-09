Return-Path: <srs0=n2wi=ky=linux.vnet.ibm.com=ananth@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mLXH0g61zDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 18:10:07 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41mLXG4Gt0z8v0w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 18:10:06 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41mLXF4JnPz9s1x
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2018 18:10:05 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7989CJM099787
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2018 04:10:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2krhe513da-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Aug 2018 04:10:02 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@linux.vnet.ibm.com>;
 Thu, 9 Aug 2018 02:10:01 -0600
Date: Thu, 9 Aug 2018 13:39:45 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
Reply-To: ananth@linux.vnet.ibm.com
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
 <87o9ecaovz.fsf@concordia.ellerman.id.au>
 <d08a7794-e5c2-2b05-c21a-ae5a7baa7d88@linux.ibm.com>
 <87d0us9hgg.fsf@concordia.ellerman.id.au>
 <20180809180253.5665ddf5@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180809180253.5665ddf5@roar.ozlabs.ibm.com>
Message-Id: <20180809080945.5wgxevm5oq7otbpe@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2018 at 06:02:53PM +1000, Nicholas Piggin wrote:
> On Thu, 09 Aug 2018 16:34:07 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> > > On 08/08/2018 08:26 PM, Michael Ellerman wrote:  
> > >> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:  
> > >>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > >>>
> > >>> Introduce recovery action for recovered memory errors (MCEs). There are
> > >>> soft memory errors like SLB Multihit, which can be a result of a bad
> > >>> hardware OR software BUG. Kernel can easily recover from these soft errors
> > >>> by flushing SLB contents. After the recovery kernel can still continue to
> > >>> function without any issue. But in some scenario's we may keep getting
> > >>> these soft errors until the root cause is fixed. To be able to analyze and
> > >>> find the root cause, best way is to gather enough data and system state at
> > >>> the time of MCE. Hence this patch introduces a sysctl knob where user can
> > >>> decide either to continue after recovery or panic the kernel to capture the
> > >>> dump.  
> > >> 
> > >> I'm not convinced we want this.
> > >> 
> > >> As we've discovered it's often not possible to reconstruct what happened
> > >> based on a dump anyway.
> > >> 
> > >> The key thing you need is the content of the SLB and that's not included
> > >> in a dump.
> > >> 
> > >> So I think we should dump the SLB content when we get the MCE (which
> > >> this series does) and any other useful info, and then if we can recover
> > >> we should.  
> > >
> > > The reasoning there is what if we got multi-hit due to some corruption 
> > > in slb_cache_ptr. ie. some part of kernel is wrongly updating the paca 
> > > data structure due to wrong pointer. Now that is far fetched, but then 
> > > possible right?. Hence the idea that, if we don't have much insight into 
> > > why a slb multi-hit occur from the dmesg which include slb content, 
> > > slb_cache contents etc, there should be an easy way to force a dump that 
> > > might assist in further debug.  
> > 
> > If you're debugging something complex that you can't determine from the
> > SLB dump then you should be running a debug kernel anyway. And if
> > anything you want to drop into xmon and sit there, preserving the most
> > state, rather than taking a dump.
> 
> I'm not saying for a dump specifically, just some form of crash. And we
> really should have an option to xmon on panic, but that's another story.

That's fine during development or in a lab, not something we could
enforce in a customer environment, could we?

> I think HA/failover kind of environments use options like this too. If
> anything starts going bad they don't want to try limping along but stop
> ASAP.

Right. And in this particular case, can we guarantee no corruption
(leading to or post the multihit recovery) when running a customer workload,
is the question...

Ananth
