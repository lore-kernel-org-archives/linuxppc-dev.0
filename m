Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts22-srv.bellnexxia.net (tomts22.bellnexxia.net
	[209.226.175.184]) by ozlabs.org (Postfix) with ESMTP id 8A466DEA63
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 03:34:56 +1000 (EST)
Received: from toip5.srvr.bell.ca ([209.226.175.88])
	by tomts22-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20080819173454.KIRV1527.tomts22-srv.bellnexxia.net@toip5.srvr.bell.ca>
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 13:34:54 -0400
Date: Tue, 19 Aug 2008 13:34:53 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
Message-ID: <20080819173453.GA28239@Krystal>
References: <48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
	<alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>
	<20080819024707.GA22659@Krystal>
	<alpine.DEB.1.10.0808191247001.28232@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0808191247001.28232@gandalf.stny.rr.com>
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
> 
> On Mon, 18 Aug 2008, Mathieu Desnoyers wrote:
> 
> > * Steven Rostedt (rostedt@goodmis.org) wrote:
> > > 
> > > On Tue, 19 Aug 2008, Benjamin Herrenschmidt wrote:
> > > 
> > > > 
> > > > > Hmm, this was originally copied from x86, where we did a cmpxchg, but that 
> > > > > is probably not needed since all of this is done in kstop_machine. Also, 
> > > > > only the "get" is needed. If we don't fault there, we wont fault on the 
> > > > > put (unless we have permissions wrong, and that would be a bug).
> > > > 
> > > > Would it ? How do we make sure the kernel text is mapped writeable ?
> > > 
> > > We map it writeable if FTRACE is enabled.
> > > 
> > 
> > Argh. See text_poke(). It's there exactly for this purpose on x86.
> > 
> 
> OK, I just tried text_poke and it unfortunately fails. The problem is that 
> it requires that the text you are changing is aligned and fits on one 
> page. We have no control over that.
> 
> -- Steve
> 

Ok, there are two cases where it's ok :

1 - in stop_machine, considering we are not touching code executed in
NMI handlers.
2 - when using my replace_instruction_safe() which uses a temporary
breakpoint when doing the instruction replacement.

In those cases you could use text_poke_early().

See
http://git.kernel.org/?p=linux/kernel/git/compudj/linux-2.6-lttng.git;a=blob;f=arch/x86/kernel/immediate.c;h=7789e2c75bf03e645f15759d5dff0c1698493f92;hb=HEAD

For a use example. Basically it looks like :


360                 pages[0] = virt_to_page((void *)bypass_eip);
361                 vaddr = vmap(pages, 1, VM_MAP, PAGE_KERNEL);
362                 BUG_ON(!vaddr);
363                 text_poke_early(&vaddr[bypass_eip & ~PAGE_MASK],
364                         (void *)addr, size);
365                 /*
366                  * Fill the rest with nops.
367                  */
368                 len = NR_NOPS - size;
369                 add_nops((void *)
370                         &vaddr[(bypass_eip & ~PAGE_MASK) + size],
371                         len);
372                 print_dbg_bytes("inserted nops",
373                         &vaddr[(bypass_eip & ~PAGE_MASK) + size], len);
374                 vunmap(vaddr);

Mathieu


-- 
Mathieu Desnoyers
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
