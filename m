Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5B852C020A
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Nov 2013 01:49:41 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 5 Nov 2013 07:49:36 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 126D119D8036
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Nov 2013 07:49:29 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA5EnQ14064550
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Nov 2013 07:49:28 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA5EppYB029243
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Nov 2013 07:51:53 -0700
Date: Tue, 5 Nov 2013 06:49:00 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC] arch: Introduce new TSO memory barrier smp_tmb()
Message-ID: <20131105144900.GD3947@linux.vnet.ibm.com>
References: <CA+55aFx_kuvR-0dwJtjvnhtha5QBc5XcLZPRH=WKT+hYVAKOrw@mail.gmail.com>
 <20131103200124.GK19466@laptop.lan>
 <20131103224242.GF3947@linux.vnet.ibm.com>
 <CA+55aFyD_kCkAHQwHCUBrumO-pH6LaZikTNvyWDW_tWsHdqk6Q@mail.gmail.com>
 <20131104105059.GL3947@linux.vnet.ibm.com>
 <20131104112254.GK28601@twins.programming.kicks-ass.net>
 <20131104162732.GN3947@linux.vnet.ibm.com>
 <20131104191127.GW16117@laptop.programming.kicks-ass.net>
 <20131104205344.GW3947@linux.vnet.ibm.com>
 <20131105140548.GD26895@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131105140548.GD26895@mudshark.cambridge.arm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Victor Kaplansky <VICTORK@il.ibm.com>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 05, 2013 at 02:05:48PM +0000, Will Deacon wrote:
> On Mon, Nov 04, 2013 at 08:53:44PM +0000, Paul E. McKenney wrote:
> > On Mon, Nov 04, 2013 at 08:11:27PM +0100, Peter Zijlstra wrote:
> > Some comments below.  I believe that opcodes need to be fixed for IA64.
> > I am unsure of the ifdefs and opcodes for arm64, but the ARM folks should
> > be able to tell us.

[ . . . ]

> > > +} while (0)
> > > +
> > > +#define smp_load_acquire(p)                                          \
> > > +do {                                                                 \
> > > +     typeof(p) ___p1;                                                \
> > > +     asm volatile ("ldar %w0, [%1]"                                  \
> > > +                     : "=r" (___p1) : "r" (&p) : "memory");          \
> > > +     return ___p1;                                                   \
> 
> Similar comments here wrt Q constraint.
> 
> Random other question: have you considered how these accessors should behave
> when presented with __iomem pointers?

Should we have something to make sparse yell if not __kernel or some such?

								Thanx, Paul
