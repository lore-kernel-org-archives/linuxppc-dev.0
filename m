Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 011B1DDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 02:51:27 +1100 (EST)
Date: Mon, 17 Nov 2008 10:51:25 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/7] ftrace, PPC: use probe_kernel API to modify code
In-Reply-To: <18720.63178.864933.911090@drongo.ozlabs.ibm.com>
Message-ID: <alpine.DEB.1.10.0811171047520.2919@gandalf.stny.rr.com>
References: <20081116212428.938752312@goodmis.org>
	<20081116212515.728019601@goodmis.org>
	<18720.63178.864933.911090@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 17 Nov 2008, Paul Mackerras wrote:

> Steven Rostedt writes:
> 
> > Impact: use cleaner probe_kernel API over assembly
> > 
> > Using probe_kernel_read/write interface is a much cleaner approach
> > than the current assembly version.
> 
> Possibly naive question: how is it possible for the accesses to the
> instructions to fault, given that we are called through kstop_machine
> (according to the comment) and nothing else should be happening?

Actually, only start up and shutdown of the tracer goes through 
kstop_machine. With the new code, it can happen before SMP starts (in 
init/main.c) or on the module itself, before the module loads. But that's 
not why we do the probe_kernel_* calls.

The reason for probe_kernel_ is because ftrace is very intrusive. Ingo and 
I have been making ftrace very paranoid about anything it does. It does 
not trust itself to be correct. If anything were to fail, it will warn and 
shut itself down peacefully.  So far, I have not seen these warnings, but 
this is part of the robustness features that have been added since 2.6.27.

-- Steve
