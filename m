Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7CAB1A074A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 18:15:08 +1100 (AEDT)
Message-ID: <1426230888.17565.164.camel@kernel.crashing.org>
Subject: Re: [RFC] powerpc: use ticket spin lock for !CONFIG_PPC_SPLPAR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 13 Mar 2015 18:14:48 +1100
In-Reply-To: <1426230541.23806.5.camel@ellerman.id.au>
References: <1426157723-28548-1-git-send-email-haokexin@gmail.com>
 <1426158807.17565.131.camel@kernel.crashing.org>
 <1426230541.23806.5.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-13 at 18:09 +1100, Michael Ellerman wrote:
> On Thu, 2015-03-12 at 22:13 +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2015-03-12 at 18:55 +0800, Kevin Hao wrote:
> > > I know Torsten Duwe has tried to add the ticket spinlock for powerpc
> > > one year ago [1]. But it make no progress due to the conflict between
> > > PPC_SPLPAR and lockref. We still don't find a better way to handle
> > > this. But instead of waiting forever for a perfect solution, can't we
> > > just use the ticket spinlock for the !CONFIG_PPC_SPLPAR?
> > > 
> > > This is a very rough patch based on arm64 codes. I want to make sure
> > > that this is acceptable before going step further. This just passed
> > > build and boot test on a fsl t4240rdb board. I have done a simple
> > > performance benchmark by running the following command ten times before
> > > and after applying this patch:
> > > 	./perf bench sched messaging
> > > 
> > >                                 Before        After
> > >     Averaged total time [sec]:  0.403         0.367
> > > 
> > > So we can see a ~9% performance enhancing. This patch depends on this
> > > one [2].
> > 
> > I would do the ifdef'ing differently, something like
> > 
> > CONFIG_PPC_HAS_LOCK_OWNER
> > 
> > CONFIG_PPC_TICKET_LOCKS depends on !PPC_HAS_LOCK_OWNER
> > 
> > and use these two in the code... with SPLPAR select'ing HAS_LOCK_OWNER
>  
> 
> Sam was doing some work looking at CONFER, and I think so far he hasn't found
> that it is much of a benefit. Hopefully he can chime in with his observations.
> 
> So the question is, should we just drop the directed CONFER and switch
> wholesale to ticket locks?
> 
> We can still do CONFER on SPLPAR, we just tell the hypervisor we don't know who
> to confer to.
> 
> There is still the drawback that we loose the lock owner for debugging, but
> that might be worth it. And I think you can get it back with appropriate debug
> options?

Another possibility would be to change the order of the count and the
lock in lockref and defined it to be packed. That might allow us to have
our lock contain the ticket first and the count next and "fit" ...

> cheers
> 
