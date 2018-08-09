Return-Path: <srs0=nndc=ky=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mM3X52rGzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 18:33:44 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41mM3X4Plhz8t8b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 18:33:44 +1000 (AEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41mM3W4FX6z9s4Z
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2018 18:33:42 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id a26-v6so2506585pfo.4
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Aug 2018 01:33:42 -0700 (PDT)
Date: Thu, 9 Aug 2018 18:33:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michal Suchanek
 <msuchanek@suse.com>, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
Message-ID: <20180809183333.6097d5ec@roar.ozlabs.ibm.com>
In-Reply-To: <20180809080945.5wgxevm5oq7otbpe@in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
 <87o9ecaovz.fsf@concordia.ellerman.id.au>
 <d08a7794-e5c2-2b05-c21a-ae5a7baa7d88@linux.ibm.com>
 <87d0us9hgg.fsf@concordia.ellerman.id.au>
 <20180809180253.5665ddf5@roar.ozlabs.ibm.com>
 <20180809080945.5wgxevm5oq7otbpe@in.ibm.com>
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

On Thu, 9 Aug 2018 13:39:45 +0530
Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com> wrote:

> On Thu, Aug 09, 2018 at 06:02:53PM +1000, Nicholas Piggin wrote:
> > On Thu, 09 Aug 2018 16:34:07 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> >   
> > > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:  
> > > > On 08/08/2018 08:26 PM, Michael Ellerman wrote:    
> > > >> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:    
> > > >>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > > >>>
> > > >>> Introduce recovery action for recovered memory errors (MCEs). There are
> > > >>> soft memory errors like SLB Multihit, which can be a result of a bad
> > > >>> hardware OR software BUG. Kernel can easily recover from these soft errors
> > > >>> by flushing SLB contents. After the recovery kernel can still continue to
> > > >>> function without any issue. But in some scenario's we may keep getting
> > > >>> these soft errors until the root cause is fixed. To be able to analyze and
> > > >>> find the root cause, best way is to gather enough data and system state at
> > > >>> the time of MCE. Hence this patch introduces a sysctl knob where user can
> > > >>> decide either to continue after recovery or panic the kernel to capture the
> > > >>> dump.    
> > > >> 
> > > >> I'm not convinced we want this.
> > > >> 
> > > >> As we've discovered it's often not possible to reconstruct what happened
> > > >> based on a dump anyway.
> > > >> 
> > > >> The key thing you need is the content of the SLB and that's not included
> > > >> in a dump.
> > > >> 
> > > >> So I think we should dump the SLB content when we get the MCE (which
> > > >> this series does) and any other useful info, and then if we can recover
> > > >> we should.    
> > > >
> > > > The reasoning there is what if we got multi-hit due to some corruption 
> > > > in slb_cache_ptr. ie. some part of kernel is wrongly updating the paca 
> > > > data structure due to wrong pointer. Now that is far fetched, but then 
> > > > possible right?. Hence the idea that, if we don't have much insight into 
> > > > why a slb multi-hit occur from the dmesg which include slb content, 
> > > > slb_cache contents etc, there should be an easy way to force a dump that 
> > > > might assist in further debug.    
> > > 
> > > If you're debugging something complex that you can't determine from the
> > > SLB dump then you should be running a debug kernel anyway. And if
> > > anything you want to drop into xmon and sit there, preserving the most
> > > state, rather than taking a dump.  
> > 
> > I'm not saying for a dump specifically, just some form of crash. And we
> > really should have an option to xmon on panic, but that's another story.  
> 
> That's fine during development or in a lab, not something we could
> enforce in a customer environment, could we?

xmon on panic? Not something to enforce but IMO (without thinking about
it too much but having encountered it several times) it should probably
be tied xmon on BUG option.

> 
> > I think HA/failover kind of environments use options like this too. If
> > anything starts going bad they don't want to try limping along but stop
> > ASAP.  
> 
> Right. And in this particular case, can we guarantee no corruption
> (leading to or post the multihit recovery) when running a customer workload,
> is the question...

I think that's an element of it. If SLB corruption is caused by
software then we could already have memory corruption. If it's hardware
then presumably we're supposed to have some guarantee of error rates.
But still you would say a machine that has taken no MCEs is less likely
to have a problem than one that has taken some MCEs!

It's not just corruption either, I've run into bugs where we get huge
streams of HMIs for example which all get recovered properly but
performance would have been in the toilet.

Anyway, being policy maybe we could drop this patch out of the SLB MCE
series and introduce it afterwards if we think it's necessary. For
SLB multi hit caused by software bug in slb handling, I'd say Michael's
pretty right about just needing the MCE output with SLB contents.

Thanks,
Nick
