Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 86F7BDE065
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 07:08:17 +1000 (EST)
Date: Tue, 19 Aug 2008 17:08:15 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
In-Reply-To: <20080819173453.GA28239@Krystal>
Message-ID: <alpine.DEB.1.10.0808191705590.4957@gandalf.stny.rr.com>
References: <48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
	<alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>
	<20080819024707.GA22659@Krystal>
	<alpine.DEB.1.10.0808191247001.28232@gandalf.stny.rr.com>
	<20080819173453.GA28239@Krystal>
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


On Tue, 19 Aug 2008, Mathieu Desnoyers wrote:
> 
> Ok, there are two cases where it's ok :
> 
> 1 - in stop_machine, considering we are not touching code executed in
> NMI handlers.
> 2 - when using my replace_instruction_safe() which uses a temporary
> breakpoint when doing the instruction replacement.
> 
> In those cases you could use text_poke_early().
> 
> See
> http://git.kernel.org/?p=linux/kernel/git/compudj/linux-2.6-lttng.git;a=blob;f=arch/x86/kernel/immediate.c;h=7789e2c75bf03e645f15759d5dff0c1698493f92;hb=HEAD
> 
> For a use example. Basically it looks like :
> 
> 
> 360                 pages[0] = virt_to_page((void *)bypass_eip);
> 361                 vaddr = vmap(pages, 1, VM_MAP, PAGE_KERNEL);
> 362                 BUG_ON(!vaddr);
> 363                 text_poke_early(&vaddr[bypass_eip & ~PAGE_MASK],
> 364                         (void *)addr, size);
> 365                 /*
> 366                  * Fill the rest with nops.
> 367                  */
> 368                 len = NR_NOPS - size;
> 369                 add_nops((void *)
> 370                         &vaddr[(bypass_eip & ~PAGE_MASK) + size],
> 371                         len);
> 372                 print_dbg_bytes("inserted nops",
> 373                         &vaddr[(bypass_eip & ~PAGE_MASK) + size], len);
> 374                 vunmap(vaddr);

vunmap can not be called with interrupts disabled, and this is exactly 
what my code does.

-- Steve
