Return-Path: <srs0=8rgx=kx=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lxDF4R7yzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 02:09:49 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lxDF3F2Tz8vJD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 02:09:49 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lxDD5bglz9s4V
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2018 02:09:48 +1000 (AEST)
Date: Wed, 8 Aug 2018 18:09:43 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, Michal Suchanek
 <msuchanek@suse.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ananth Narayan <ananth@in.ibm.com>
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
Message-ID: <20180808180943.7e8ca319@kitsune.suse.cz>
In-Reply-To: <d08a7794-e5c2-2b05-c21a-ae5a7baa7d88@linux.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
 <87o9ecaovz.fsf@concordia.ellerman.id.au>
 <d08a7794-e5c2-2b05-c21a-ae5a7baa7d88@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Aug 2018 21:07:11 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> On 08/08/2018 08:26 PM, Michael Ellerman wrote:
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:  
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> Introduce recovery action for recovered memory errors (MCEs).
> >> There are soft memory errors like SLB Multihit, which can be a
> >> result of a bad hardware OR software BUG. Kernel can easily
> >> recover from these soft errors by flushing SLB contents. After the
> >> recovery kernel can still continue to function without any issue.
> >> But in some scenario's we may keep getting these soft errors until
> >> the root cause is fixed. To be able to analyze and find the root
> >> cause, best way is to gather enough data and system state at the
> >> time of MCE. Hence this patch introduces a sysctl knob where user
> >> can decide either to continue after recovery or panic the kernel
> >> to capture the dump.  
> > 
> > I'm not convinced we want this.
> > 
> > As we've discovered it's often not possible to reconstruct what
> > happened based on a dump anyway.
> > 
> > The key thing you need is the content of the SLB and that's not
> > included in a dump.
> > 
> > So I think we should dump the SLB content when we get the MCE (which
> > this series does) and any other useful info, and then if we can
> > recover we should.
> >   
> 
> The reasoning there is what if we got multi-hit due to some
> corruption in slb_cache_ptr. ie. some part of kernel is wrongly
> updating the paca data structure due to wrong pointer. Now that is
> far fetched, but then possible right?. Hence the idea that, if we
> don't have much insight into why a slb multi-hit occur from the dmesg
> which include slb content, slb_cache contents etc, there should be an
> easy way to force a dump that might assist in further debug.

Nonetheless this turns all MCEs into crashes. Are there any MCEs that
could happen during normal operation and should be handled by default?

Thanks

Michal
