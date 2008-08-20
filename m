Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp115.mail.mud.yahoo.com (smtp115.mail.mud.yahoo.com
	[209.191.84.164]) by ozlabs.org (Postfix) with SMTP id BB7DBDDDE3
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 19:41:02 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
Date: Wed, 20 Aug 2008 19:40:51 +1000
References: <48A9901B.1080900@redhat.com> <20080819173453.GA28239@Krystal>
	<alpine.DEB.1.10.0808191705590.4957@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0808191705590.4957@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808201940.51916.nickpiggin@yahoo.com.au>
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

On Wednesday 20 August 2008 07:08, Steven Rostedt wrote:
> On Tue, 19 Aug 2008, Mathieu Desnoyers wrote:
> > Ok, there are two cases where it's ok :
> >
> > 1 - in stop_machine, considering we are not touching code executed in
> > NMI handlers.
> > 2 - when using my replace_instruction_safe() which uses a temporary
> > breakpoint when doing the instruction replacement.
> >
> > In those cases you could use text_poke_early().
> >
> > See
> > http://git.kernel.org/?p=linux/kernel/git/compudj/linux-2.6-lttng.git;a=b
> >lob;f=arch/x86/kernel/immediate.c;h=7789e2c75bf03e645f15759d5dff0c1698493f
> >92;hb=HEAD
> >
> > For a use example. Basically it looks like :
> >
> >
> > 360                 pages[0] = virt_to_page((void *)bypass_eip);
> > 361                 vaddr = vmap(pages, 1, VM_MAP, PAGE_KERNEL);
> > 362                 BUG_ON(!vaddr);
> > 363                 text_poke_early(&vaddr[bypass_eip & ~PAGE_MASK],
> > 364                         (void *)addr, size);
> > 365                 /*
> > 366                  * Fill the rest with nops.
> > 367                  */
> > 368                 len = NR_NOPS - size;
> > 369                 add_nops((void *)
> > 370                         &vaddr[(bypass_eip & ~PAGE_MASK) + size],
> > 371                         len);
> > 372                 print_dbg_bytes("inserted nops",
> > 373                         &vaddr[(bypass_eip & ~PAGE_MASK) + size],
> > len); 374                 vunmap(vaddr);
>
> vunmap can not be called with interrupts disabled, and this is exactly
> what my code does.

It could be after the vmap rewrite (with a few other small tweaks).
But a) it would be less robust when called from interrupt context
and this code looks broken as it is WRT error handling; and b) it
still costs several thousand cycles to vmap+touch+vunmap...
