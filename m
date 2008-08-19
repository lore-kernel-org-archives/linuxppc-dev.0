Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 2CA82DE01A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 13:32:10 +1000 (EST)
Date: Mon, 18 Aug 2008 23:32:08 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <20080819024707.GA22659@Krystal>
Message-ID: <alpine.DEB.1.10.0808182329220.13401@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
	<alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>
	<20080819024707.GA22659@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Scott Wood <scottwood@freescale.com>,
	Eran Liberty <liberty@extricom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 18 Aug 2008, Mathieu Desnoyers wrote:

> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > 
> > On Tue, 19 Aug 2008, Benjamin Herrenschmidt wrote:
> > 
> > > 
> > > > Hmm, this was originally copied from x86, where we did a cmpxchg, but that 
> > > > is probably not needed since all of this is done in kstop_machine. Also, 
> > > > only the "get" is needed. If we don't fault there, we wont fault on the 
> > > > put (unless we have permissions wrong, and that would be a bug).
> > > 
> > > Would it ? How do we make sure the kernel text is mapped writeable ?
> > 
> > We map it writeable if FTRACE is enabled.
> > 
> 
> Argh. See text_poke(). It's there exactly for this purpose on x86.

Ouch, I just did. text_poke is quite heavy. It would be interesting to see 
that performed on 20,000 locations at one time. I could play with it, but 
I'm a bit nervous.

-- Steve
