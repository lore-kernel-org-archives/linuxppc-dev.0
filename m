Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D812DE18C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:00:43 +1000 (EST)
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 11:53:34 +1000
Message-Id: <1219110814.8062.2.camel@pasglop>
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Scott Wood <scottwood@freescale.com>,
	Eran Liberty <liberty@extricom.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-18 at 14:27 -0400, Steven Rostedt wrote:
> 
> On Mon, 18 Aug 2008, Scott Wood wrote:
> 
> > Mathieu Desnoyers wrote:
> > >         asm volatile (
> > >                 "1: lwz         %1, 0(%2)\n"
> > >                 "   cmpw        %1, %5\n"
> > >                 "   bne         2f\n"
> > >                 "   stwu        %3, 0(%2)\n"
> > >                 "2:\n"
> > >                 ".section .fixup, \"ax\"\n"
> > >                 "3:     li %0, 1\n"
> > >                 "       b 2b\n"
> > >                 ".previous\n"
> > >                 ".section __ex_table,\"a\"\n"
> > >                 _ASM_ALIGN "\n"
> > >                 _ASM_PTR "1b, 3b\n"
> > >                 ".previous"
> > >                 : "=r"(faulted), "=r"(replaced)
> > >                 : "r"(ip), "r"(new),
> > >                   "0"(faulted), "r"(old)
> > >                 : "memory");
> > 
> > Some (most likely unrelated) nits in the above inline asm:


Why not use __get_user/__put_user ?

Cheers,
Ben.
