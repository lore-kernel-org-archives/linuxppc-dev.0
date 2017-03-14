Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhzNk2nDszDqYc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 13:35:17 +1100 (AEDT)
Message-ID: <1489458878.2174.23.camel@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] reworking cause_ipi and adding global doorbell
 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 14 Mar 2017 13:34:38 +1100
In-Reply-To: <20170314114950.6d197c80@roar.ozlabs.ibm.com>
References: <20170312171327.21088-1-npiggin@gmail.com>
 <1489447868.2174.16.camel@kernel.crashing.org>
 <20170314114950.6d197c80@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-14 at 11:49 +1000, Nicholas Piggin wrote:
> On Tue, 14 Mar 2017 10:31:08 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Mon, 2017-03-13 at 03:13 +1000, Nicholas Piggin wrote:
> > > Hi,
> > > 
> > > Just after the previous two fixes, I would like to propose changing
> > > the way we do doorbell vs interrupt controller IPIs, and add support
> > > for global doorbells supported by POWER9 in HV mode.
> > > 
> > > After this, the platform code knows about doorbells and interrupt
> > > controller IPIs, rather than they know about each other.  
> > 
> > A few things come to mind:
> > 
> >  - We don't want to use doorbells under KVM. They are going to turn
> > into traps and be emulated, slower than using H_IPI, at least on P9.
> > Even for core only doorbells. I'm not sure how to convey that to the
> > guest.
> 
> msgsndp will be okay, won't it? Guest just chooses that based on
> HVMODE (which pseries platform knows is core only).

No. It will suck. Because KVM can run each guest thread on a different core,
the HW won't work, so we have to disable it and trap the instructions & emulate
them. We really don't want P9 guests to use it under KVM (it's fine under pHyp).

> >  - On PP9 DD1 we need a CI load instead of msgsync (a DARN instruction
> > would do too if it works)
> 
> Yes, Paul pointed this out too. I'll add an alt patch for it. Apparently
> also msgsync needs lwsync afterwards for DD2.

Odd. Ok.

> >  - Can we get rid of the atomic ops for manipulating the IPI mux ? What
> > about a cache line per message and just set/clear ? If we clear in the
> > doorbell handler before we call the respective targets, we shouldn't
> > "lose" messages no ? As long as the actual handlers "loop" as necessary
> > of course.
> 
> Yes I think that would work. Good idea. A single cacheline with messages
> being independently stored bytes within it might work better, so the
> receiver CPU does not have to go through and load multiple cachelines
> to check for messages. It could load up to 8 message types with one load.

Ok. But we need to make sure we use multiple stores to not lose messages.

Ie.

 - Load all
 - For each byte if set
    - clear byte
    - then call handler

Cheers,
Ben.
