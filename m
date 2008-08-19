Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 1FFA9DE4A2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:41:02 +1000 (EST)
Date: Mon, 18 Aug 2008 22:41:00 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <1219113549.8062.13.camel@pasglop>
Message-ID: <alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
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


On Tue, 19 Aug 2008, Benjamin Herrenschmidt wrote:

> 
> > Hmm, this was originally copied from x86, where we did a cmpxchg, but that 
> > is probably not needed since all of this is done in kstop_machine. Also, 
> > only the "get" is needed. If we don't fault there, we wont fault on the 
> > put (unless we have permissions wrong, and that would be a bug).
> 
> Would it ? How do we make sure the kernel text is mapped writeable ?

We map it writeable if FTRACE is enabled.

> 
> > So are you recommending something like
> > 
> >         int cmd;
> > 
> > 	if (__get_user(cmd, ip))
> > 		goto fault;
> > 
> > 	if (cmd != old)
> > 		goto not_same;
> > 
> > 	WARN_ON_ONCE(__put_user(cmd, ip));
> > 
> > If we did this, we could probably put this into the generic code:
> 
> That would work I suppose, I'll give it a try.
> 
> > 	if (copy_from_user(cmd, ip, ARCH_CALL_SIZE))
> > 		goto fault;
> > 
> > 	if (memcmp(cmd, old, ARCH_CALL_SIZE) != 0)
> > 		goto not_same;
> > 
> > 	WARN_ON_ONCE(copy_to_user(cmd, ip, ARCH_CALL_SIZE));
> 
> You need the __ variants or the access_ok() checks will bite
> you bad.

Ah, good point ;-)

-- Steve
