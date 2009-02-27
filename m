Return-Path: <opurdila@ixiacom.com>
Received: from ixro-ex1.ixiacom.com (unknown [92.87.192.98])
	by ozlabs.org (Postfix) with ESMTP id EBC92DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 22:57:32 +1100 (EST)
From: Octavian Purdila <opurdila@ixiacom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc: oprofile: enable support for ppc750
	processors
Date: Fri, 27 Feb 2009 13:57:12 +0200
References: <1233724934.16867.290.camel@pasglop>
	<2acbd3e40902261430l77b465cqf1cb6f0f4b737e92@mail.gmail.com>
	<1235690037.7388.38.camel@pasglop>
In-Reply-To: <1235690037.7388.38.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902271357.13023.opurdila@ixiacom.com>
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@gmail.com>,
	John J Miller <millerjo@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> On Thu, 2009-02-26 at 16:30 -0600, Andy Fleming wrote:
> > I know this saves you some code, but it seems hacky.  It would be
> > better to modify oprofile to detect the proper cpu type.  Also, this
> > will screw things up if you try to use the different event set that
> > the 750 has.
>
> Agreed. Note that Jack Miller (CC) has some patches for the oprofile
> side.
>

Not sure I understand, but the oprofile userspace  tool sees it as new 
processor (ppc750). I had to patch it to add the events for the new processor.

> > Also, one more concern is the long-standing errata which makes this
> > quite dangerous.  All of the versions of the 750 I'm aware of have a
> > bug where if a Performance Monitor exception occurs within one cycle
> > of the Decrementer exception, the cpu will lose the ability to return
> > from the interrupt (SRR0/SRR1 become corrupted).  It's possible the
> > 750s you have modified to support oprofile don't have this errata.
> > Alternatively, we can decide we don't care, as you have to be root to
> > use oprofile.  But this is why I didn't add support for anything
> > before the 7450.
>

Yes, I understand. We knew about the errata and we used the timer interrupt 
for profiling for some time, but then we run into some issue were we had to use 
advanced counters as L1 cache misses / TLB misses to diagnose some issues and 
we decided to give it a try. And _seems_ to work fine. Although we didn't 
stress it too hard (around 10-20 minutes of continuous run).

So maybe it would be useful for other people in the same situation as ours. 
BTW, this is the out of cat /proc/cpuinfo on our hw:

processor       : 0
cpu             : 750GX
temperature     : 10-12 C (uncalibrated)
revision        : 1.2 (pvr 7002 0102)
bogomips        : 1597.44
vendor          : Ixia
machine         : TCPX [0x6b]

 
> I think we need to advertise it as broken in some way... 

Perhaps set it to use the timer by default, and allow the user to switch to 
the hardware performance counter + printing a message that this mode is 
dangerous?

Thanks,
tavi
