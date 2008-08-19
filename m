Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts22-srv.bellnexxia.net (tomts22.bellnexxia.net
	[209.226.175.184]) by ozlabs.org (Postfix) with ESMTP id BA6AEDDFD0
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:52:11 +1000 (EST)
Received: from toip7.srvr.bell.ca ([209.226.175.124])
	by tomts22-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080819025209.FKUD1527.tomts22-srv.bellnexxia.net@toip7.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 22:52:09 -0400
Date: Mon, 18 Aug 2008 22:47:07 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
Message-ID: <20080819024707.GA22659@Krystal>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
	<alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>
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

* Steven Rostedt (rostedt@goodmis.org) wrote:
> 
> On Tue, 19 Aug 2008, Benjamin Herrenschmidt wrote:
> 
> > 
> > > Hmm, this was originally copied from x86, where we did a cmpxchg, but that 
> > > is probably not needed since all of this is done in kstop_machine. Also, 
> > > only the "get" is needed. If we don't fault there, we wont fault on the 
> > > put (unless we have permissions wrong, and that would be a bug).
> > 
> > Would it ? How do we make sure the kernel text is mapped writeable ?
> 
> We map it writeable if FTRACE is enabled.
> 

Argh. See text_poke(). It's there exactly for this purpose on x86.

Mathieu

> > 
> > > So are you recommending something like
> > > 
> > >         int cmd;
> > > 
> > > 	if (__get_user(cmd, ip))
> > > 		goto fault;
> > > 
> > > 	if (cmd != old)
> > > 		goto not_same;
> > > 
> > > 	WARN_ON_ONCE(__put_user(cmd, ip));
> > > 
> > > If we did this, we could probably put this into the generic code:
> > 
> > That would work I suppose, I'll give it a try.
> > 
> > > 	if (copy_from_user(cmd, ip, ARCH_CALL_SIZE))
> > > 		goto fault;
> > > 
> > > 	if (memcmp(cmd, old, ARCH_CALL_SIZE) != 0)
> > > 		goto not_same;
> > > 
> > > 	WARN_ON_ONCE(copy_to_user(cmd, ip, ARCH_CALL_SIZE));
> > 
> > You need the __ variants or the access_ok() checks will bite
> > you bad.
> 
> Ah, good point ;-)
> 
> -- Steve
> 

-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
