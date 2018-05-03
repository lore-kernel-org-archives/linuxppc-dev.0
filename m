Return-Path: <npiggin@gmail.com>
Date: Thu, 3 May 2018 20:15:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Subject: Re: [Skiboot] [PATCH 1/2] SLW: Remove stop1_lite and stop0 stop states
Message-ID: <20180503201559.0aac84ca@roar.ozlabs.ibm.com>
In-Reply-To: <87lgd13vjo.fsf@linux.vnet.ibm.com>
References: <1525079529-2284-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20180501134723.5d00ddf0@roar.ozlabs.ibm.com>
 <20180503090647.xsfw3p7mq2pwd2rw@aksadiga.ibm>
 <20180503192852.13a42712@roar.ozlabs.ibm.com>
 <87lgd13vjo.fsf@linux.vnet.ibm.com>
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

On Thu, 03 May 2018 20:03:55 +1000
Stewart Smith <stewart@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > On Thu, 3 May 2018 14:36:47 +0530
> > Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> >  
> >> On Tue, May 01, 2018 at 01:47:23PM +1000, Nicholas Piggin wrote:  
> >> > On Mon, 30 Apr 2018 14:42:08 +0530
> >> > Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:
> >> >     
> >> > > Powersaving for stop0_lite and stop1_lite is observed to be quite similar
> >> > > and both states resume without state loss. Using context_switch test [1]
> >> > > we observe that stop0_lite has slightly lower latency, hence removing
> >> > > stop1_lite.
> >> > > 
> >> > > [1] linux/tools/testing/selftests/powerpc/benchmarks/context_switch.c
> >> > > 
> >> > > Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>    
> >> > 
> >> > I'm okay for removing stop1_lite and stop2_lite -- SMT switching
> >> > is very latency critical. If we decide to actually start saving
> >> > real power then SMT should already have been switched.
> >> > 
> >> > So I would put stop1_lite and stop2_lite removal in the same patch.    
> >> 
> >> I can do this.
> >>   
> >> > 
> >> > Then what do we have? stop0_lite, stop0, stop1 for our fast idle
> >> > states.    
> >> 
> >> Currently we were looking at  stop0_lite , stop1 as the fast idle states
> >> because stop0 and stop1 have similar latency and powersaving.
> >> Having so many low latency states does not make sense.
> >>   
> >> > 
> >> > I would be against removing stop0 if that is our fastest way to
> >> > release SMT resources, even if there is only a small advantage. Why
> >> > not remove stop1 instead?
> >> >    
> >> SMT-folding comes into picture only when we have at least one thread
> >> running in the core. stop0 and stop1 has exactly same power-saving and
> >> both will release SMT resources if at least one thread in the core is
> >> running.  
> >
> > Right, but you don't know that other threads are running or will remain
> > running when you enter stop. If not, then latency is higher for stop1,
> > no? So we need to be using stop0.
> >  
> >> 
> >> As soon as all threads are idle core enters stop0/stop1, where stop1
> >> does a bit more powersaving than stop0.
> >>   
> >> > We also need to better evaluate stop0_lite. How much advantage does
> >> > that have over snooze?    
> >> 
> >> I evaluated snooze and stop0_lite, there is an additional ipi latency of
> >> a few microseconds in case of stop0_lite. So snooze cannot still be
> >> replaced by stop0_lite.  
> >
> > I meant the other way around. Replace stop0_lite with snooze.
> >
> > So we would have snooze, stop0, stop2, and stop4 and/or 5.  
> 
> Slightly stupid question: should we be disabling these here or should
> Linux be better and deciding what states to use?

Yeah not a bad question, I don't have a good answer. I don't know how
smart Linux is at deciding what to use and when.

I am pretty sure the way we set our _lite states wrong -- we don't
want to go into stop2_lite as a deeper sleep state than stop0 for
example, because that then prevents SMT folding.

> 
> I'm inclined to say this is a Linux problem as it should make the
> decision of what hardware feature to used based on the ones OPAL says
> *can* be used.
> 
> I'm also open to be being convinced otherwise though...
> 

I would say we should manually decide what states we want, and then
work backwards and try to make the dt metadata reach that result
without fudging it too much. If we can't do that, then we should try
to improve the kernel so it can be made to work.

At some we may decide to trim the states by hand in skiboot just
so existing kernels work without so much fuss, and aim to do a bit
better with later devices.

Thanks,
Nick
