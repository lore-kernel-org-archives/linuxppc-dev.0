Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A93F31007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 06:58:46 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 15 Feb 2012 01:28:43 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1EJvxu34534294
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 01:27:59 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1EJvvuj011633
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 06:57:59 +1100
Message-ID: <4F3ABCC1.5020000@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2012 01:27:53 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arjan van de Ven <arjanvandeven@gmail.com>
Subject: Re: smp: Start up non-boot CPUs asynchronously
References: <20120130205444.22f5e26a@infradead.org>
 <20120131125232.GD4408@elte.hu>	<20120131054155.371e8307@infradead.org>
 <20120131143130.GF13676@elte.hu>	<20120131072216.1ce78e50@infradead.org>
 <20120131161207.GA18357@elte.hu>	<20120131082439.575978c0@infradead.org>
 <4F3A1891.8060001@linux.vnet.ibm.com>	<4F3A2DFB.5000209@linux.vnet.ibm.com>
 <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
In-Reply-To: <CADyApD0o4UYsTkqf2H2yJZ-d05NAyRAEc6z+m1gJEogc=cZLqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mikey@neuling.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, gregkh@linuxfoundation.org,
 Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Arjan van de Ven <arjan@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Small note, it appears as if the last 2 of your replies to this thread
 didn't reach LKML.]

On 02/14/2012 08:01 PM, Arjan van de Ven wrote:

> one coments; will comment more when I get to work
> 
> On Tue, Feb 14, 2012 at 1:48 AM, Srivatsa S. Bhat 
> 
> 7. And whichever code between smp_init() and async_synchronize_full() didn't
> 
>     care about CPU hotplug till today but depended on all cpus being
>     online must
>     suddenly start worrying about CPU Hotplug. They must register a cpu
>     notifier
>     and handle callbacks etc etc.. Or if they are not worth that
>     complexity, they
>     should atleast be redesigned or moved around - like the print
>     statements that
>     tell how many cpus came up, for example.
> 
> 
> frankly, such code HAS to worry about cpus going online and offline even
> today; the firmware, at least on X86, can start taking cores
> offline/online once ACPI is initialized....
> (as controlled by a data center manager from outside the box, usually
> done based on thermal or power conditions on a datacenter level).
> Now, no doubt that we have bugs in this space, since this only happened
> very rarely before.
> 
> Question is what to do from a longer term strategy:
> Either we declare the number of online CPUs invariant during a certain
> phase of the boot (and make ACPI and co honor this as well somehow)
> or
> We decide to go about fixing these (maybe with the help of lockdep?)
> 
> In addition to this, the reality is that the whole "bring cpus up"
> sequence needs to be changed; the current one is very messy and requires
> the hotplug lock for the whole bring up of each individual cpu... which
> is a very unfortunate design; a much better design would be to only take
> the lock for the actual registration of the newly brought up CPU to the
> kernel, while running the physical bringup without the global lock.
> If/when that change gets made, we can do the physical bring up in
> parallel (with each other, but also with the rest of the kernel boot),
> and do the registration en-mass at some convenient time in the boot,
> potentially late.
> 


Sounds like a good idea, but how will we take care of CPU_UP_PREPARE and
CPU_STARTING callbacks then? Because, CPU_UP_PREPARE callbacks are run
before bringing up the cpu and CPU_STARTING is called from the cpu that is
coming up. Also, CPU_UP_PREPARE callbacks can be failed, which can lead
to that particular cpu boot getting aborted. With the "late commissioning
of CPUs" idea you proposed above, retaining such semantics could become
very challenging.

Regards,
Srivatsa S. Bhat
