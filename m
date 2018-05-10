Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hRxk2yDLzF2TH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 18:59:54 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4A8xjOR070482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 04:59:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hvh8cvnr2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 04:59:51 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 10 May 2018 09:59:49 +0100
Date: Thu, 10 May 2018 14:29:44 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [Skiboot] [PATCH 1/2] SLW: Remove stop1_lite and stop0 stop states
References: <1525079529-2284-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20180501134723.5d00ddf0@roar.ozlabs.ibm.com>
 <20180503090647.xsfw3p7mq2pwd2rw@aksadiga.ibm>
 <20180503192852.13a42712@roar.ozlabs.ibm.com>
 <87lgd13vjo.fsf@linux.vnet.ibm.com>
 <20180503201559.0aac84ca@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503201559.0aac84ca@roar.ozlabs.ibm.com>
Message-Id: <20180510085944.nllmwgeegifgh4kb@aksadiga.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2018 at 08:15:59PM +1000, Nicholas Piggin wrote:
> On Thu, 03 May 2018 20:03:55 +1000
> Stewart Smith <stewart@linux.vnet.ibm.com> wrote:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > > On Thu, 3 May 2018 14:36:47 +0530
> > > Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> > >  
> > >> On Tue, May 01, 2018 at 01:47:23PM +1000, Nicholas Piggin wrote:  
> > >> > On Mon, 30 Apr 2018 14:42:08 +0530
> > >> > Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> > >> >     
> > >> > > Powersaving for stop0_lite and stop1_lite is observed to be quite similar
> > >> > > and both states resume without state loss. Using context_switch test [1]
> > >> > > we observe that stop0_lite has slightly lower latency, hence removing
> > >> > > stop1_lite.
> > >> > > 
> > >> > > [1] linux/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> > >> > > 
> > >> > > Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>    
> > >> > 
> > >> > I'm okay for removing stop1_lite and stop2_lite -- SMT switching
> > >> > is very latency critical. If we decide to actually start saving
> > >> > real power then SMT should already have been switched.
> > >> > 
> > >> > So I would put stop1_lite and stop2_lite removal in the same patch.    
> > >> 
> > >> I can do this.
> > >>   
> > >> > 
> > >> > Then what do we have? stop0_lite, stop0, stop1 for our fast idle
> > >> > states.    
> > >> 
> > >> Currently we were looking at  stop0_lite , stop1 as the fast idle states
> > >> because stop0 and stop1 have similar latency and powersaving.
> > >> Having so many low latency states does not make sense.
> > >>   
> > >> > 
> > >> > I would be against removing stop0 if that is our fastest way to
> > >> > release SMT resources, even if there is only a small advantage. Why
> > >> > not remove stop1 instead?
> > >> >    
> > >> SMT-folding comes into picture only when we have at least one thread
> > >> running in the core. stop0 and stop1 has exactly same power-saving and
> > >> both will release SMT resources if at least one thread in the core is
> > >> running.  
> > >
> > > Right, but you don't know that other threads are running or will remain
> > > running when you enter stop. If not, then latency is higher for stop1,
> > > no? So we need to be using stop0.
> > >  
> > >> 
> > >> As soon as all threads are idle core enters stop0/stop1, where stop1
> > >> does a bit more powersaving than stop0.
> > >>   
> > >> > We also need to better evaluate stop0_lite. How much advantage does
> > >> > that have over snooze?    
> > >> 
> > >> I evaluated snooze and stop0_lite, there is an additional ipi latency of
> > >> a few microseconds in case of stop0_lite. So snooze cannot still be
> > >> replaced by stop0_lite.  
> > >
> > > I meant the other way around. Replace stop0_lite with snooze.
> > >
> > > So we would have snooze, stop0, stop2, and stop4 and/or 5.  
> > 
> > Slightly stupid question: should we be disabling these here or should
> > Linux be better and deciding what states to use?
> 
> Yeah not a bad question, I don't have a good answer. I don't know how
> smart Linux is at deciding what to use and when.
> 
> I am pretty sure the way we set our _lite states wrong -- we don't
> want to go into stop2_lite as a deeper sleep state than stop0 for
> example, because that then prevents SMT folding.

I think we should keep both stop0 and stop1, i was not able to get
a good enough reason to remove stop0.

I a diffrent patch we need to tweak residencies so that we can bias
to more useful stop states.
