Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A7ACB70BC
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Sep 2011 03:35:10 +1000 (EST)
Received: from /spool/local by us.ibm.com with XMail ESMTP
	for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 9 Sep 2011 13:35:07 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p89HZ4RV273804
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Sep 2011 13:35:04 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p89HYuGw003842
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Sep 2011 13:35:01 -0400
Date: Fri, 9 Sep 2011 10:34:55 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH tip/core/rcu 48/55] powerpc: strengthen
	value-returning-atomics memory barriers
Message-ID: <20110909173455.GH2435@linux.vnet.ibm.com>
References: <20110906180015.GA2560@linux.vnet.ibm.com>
	<1315332049-2604-48-git-send-email-paulmck@linux.vnet.ibm.com>
	<CAOesGMi--W6TCUMZzF07-Zep9Ta3tBJWZcG+5imEK_Hza0y9Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAOesGMi--W6TCUMZzF07-Zep9Ta3tBJWZcG+5imEK_Hza0y9Jg@mail.gmail.com>
Cc: mathieu.desnoyers@polymtl.ca, laijs@cn.fujitsu.com, eric.dumazet@gmail.com,
	patches@linaro.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	josh@joshtriplett.org, dhowells@redhat.com, darren@dvhart.com,
	niv@us.ibm.com, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	anton@samba.org, Valdis.Kletnieks@vt.edu, mingo@elte.hu,
	akpm@linux-foundation.org, paulus@samba.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 09, 2011 at 10:23:33AM -0700, Olof Johansson wrote:
> [+linuxppc-dev]
> 
> On Tue, Sep 6, 2011 at 11:00 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > The trailing isync/lwsync in PowerPC value-returning atomics needs
> > to be a sync in order to provide the required ordering properties.
> > The leading lwsync/eieio can remain, as the remainder of the required
> > ordering guarantees are provided by the atomic instructions: Any
> > reordering will cause the stwcx to fail, which will result in a retry.
> 
> Admittedly, my powerpc barrier memory is starting to fade, but isn't
> isync sufficient here? It will make sure all instructions before it
> have retired, and will restart any speculative/issued instructions
> beyond it.
> 
> lwsync not being sufficient makes sense since a load can overtake it.

As I understand it, although isync waits for the prior stwcx to execute,
it does not guarantee that the corresponding store is visible to all
processors before any following loads.

> > diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
> > index d7cab44..4d97fbe 100644
> > --- a/arch/powerpc/include/asm/synch.h
> > +++ b/arch/powerpc/include/asm/synch.h
> > @@ -37,11 +37,7 @@ static inline void isync(void)
> >  #endif
> >
> >  #ifdef CONFIG_SMP
> > -#define __PPC_ACQUIRE_BARRIER                          \
> > -       START_LWSYNC_SECTION(97);                       \
> > -       isync;                                          \
> > -       MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
> > -#define PPC_ACQUIRE_BARRIER    "\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
> > +#define PPC_ACQUIRE_BARRIER    "\n" stringify_in_c(sync;)
> 
> This can just be done as "\n\tsync\n" instead of the stringify stuff.

That does sound a bit more straightforward, now that you mention it.  ;-)

							Thanx, Paul
