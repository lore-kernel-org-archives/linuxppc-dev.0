Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmMNs1rq8zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 15:47:25 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v14so13346814pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 22:47:25 -0700 (PDT)
Date: Mon, 12 Jun 2017 15:47:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, "Shreyas B . Prabhu\"
 <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/14 v2] idle performance improvements
Message-ID: <20170612154707.61380a1e@roar.ozlabs.ibm.com>
In-Reply-To: <1497241524.2897.1.camel@au1.ibm.com>
References: <20170611093102.2025-1-npiggin@gmail.com>
 <1497241524.2897.1.camel@au1.ibm.com>
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

On Mon, 12 Jun 2017 14:25:24 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Sun, 2017-06-11 at 19:30 +1000, Nicholas Piggin wrote:
> > I rebased this on the powerpc next tree.
> > 
> > A couple of things are changed since last post:
> > 
> > - Patch 1 now properly accounts for the fact the powernv idle
> >   wakeups do not re-enable interrupts until the cpuidle driver
> >   enables them. This was not quite right in the previous patch
> >   (and prep_irq_for_idle() is not quite right for that case so
> >   a new primitive has to be introduced).  
> 
> What do you mean ? We shouldn't be going to sleep with the CPU thinking
> it's interrupts are off, otherwise we end up effectively "taking an
> interrupt while off" which is not right and it will cause accounting to
> think we are off for too long.
> 
> Is this a generic cpuidle problem or a powerpc issue ?

cpuidle drivers enter their idle state with local_irq_disable().
powernv cpuidle driver currently does not call trace_hardirqs_on()
before going to sleep (e.g., it does not use prep_irq_for_idle()).

I did a previous patch that uses prep_irq_for_idle directly, but
that assumes when we return from idle that local irqs should be
on. The generic cpuidle does not want that, I haven't dug into
exactly why not. But it seems to work better just to put the SRR1
wakeup reason into the irq_pending bit and let the lazy irq logic
take care of the rest.
 
> I'd rather we don't have to of those "prep_for_idle...". If necessary
> sync the other one.

Okay one can call the other rather than implementing twice.

Thanks,
Nick
