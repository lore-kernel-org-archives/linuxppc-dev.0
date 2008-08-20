Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id AEB88DE122
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 01:27:49 +1000 (EST)
Date: Wed, 20 Aug 2008 11:27:47 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Eran Liberty <liberty@extricom.com>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <48AC23F4.80900@extricom.com>
Message-ID: <alpine.DEB.1.10.0808201014190.23571@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
	<1219114600.8062.15.camel@pasglop>
	<alpine.DEB.1.10.0808182304300.13401@gandalf.stny.rr.com>
	<1219119431.8062.35.camel@pasglop>
	<1219216705.21386.46.camel@pasglop>
	<alpine.DEB.1.10.0808200913070.13132@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0808200916090.13132@gandalf.stny.rr.com>
	<48AC1DD8.9080702@extricom.com>
	<alpine.DEB.1.10.0808200941560.13132@gandalf.stny.rr.com>
	<48AC23F4.80900@extricom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Alan Modra <amodra@au1.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 20 Aug 2008, Eran Liberty wrote:
> > 
> >   
> > > c00bb670:       41 9e 00 50     beq-    cr7,c00bb6c0 <__d_lookup+0x13c>
> > > c00bb674:       83 de 00 00     lwz     r30,0(r30)
> > > c00bb678:       2f 9e 00 00     cmpwi   cr7,r30,0
> > > c00bb67c:       40 9e ff 98     bne+    cr7,c00bb614 <__d_lookup+0x90>
> > > c00bb680:       38 60 00 00     li      r3,0
> > > c00bb684:       81 61 00 00     lwz     r11,0(r1)
> > > c00bb688:       80 0b 00 04     lwz     r0,4(r11)
> > > c00bb68c:       7d 61 5b 78     mr      r1,r11
> > >     
> > 
> > [ BUG HERE IF INTERRUPT HAPPENS ]
> > 
> >   
> > > c00bb690:       bb 0b ff e0     lmw     r24,-32(r11)
> > > c00bb694:       7c 08 03 a6     mtlr    r0
> > > c00bb698:       4e 80 00 20     blr
> > >     
> > 
> > Yep, you have the same bug in your compiler.
> > 
> > -- Steve
> >   
> Hmm... so whats now?

Try anothe gcc version ;-)

> 
> Is there a way to prove this scenario is indeed the one that caused the opps?

I'm not convinced that this is the bug you were seeing. Do you still get 
the crash if you disable dynamic ftrace but leave ftrace on?

-- Steve
