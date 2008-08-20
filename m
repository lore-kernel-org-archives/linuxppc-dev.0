Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 927A1DDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 07:51:21 +1000 (EST)
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <alpine.DEB.1.10.0808200913070.13132@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop> <1219114600.8062.15.camel@pasglop>
	<alpine.DEB.1.10.0808182304300.13401@gandalf.stny.rr.com>
	<1219119431.8062.35.camel@pasglop> <1219216705.21386.46.camel@pasglop>
	<alpine.DEB.1.10.0808200913070.13132@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Thu, 21 Aug 2008 07:36:29 +1000
Message-Id: <1219268189.21386.65.camel@pasglop>
Mime-Version: 1.0
Cc: Eran Liberty <liberty@extricom.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Alan Modra <amodra@au1.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > As you can see, it restores r1 -before- it pops r24..r31 off
> > the stack ! I let you imagine what happens if an interrupt happens
> > just in between those two instructions (mr and lmw). We don't do
> > redzones on our ABI, so basically, the registers end up corrupted
> > by the interrupt.
> 
> Ouch!  You've disassembled this without -pg too, and it does not have this 
> bug? What version of gcc do you have?

Oops, should have mentioned it ;-)

4.2.3 (Ubuntu 4.2.3-2ubuntu7)

Ben.
