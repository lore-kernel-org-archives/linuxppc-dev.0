Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 58B1CDDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 03:30:35 +1100 (EST)
Date: Mon, 20 Oct 2008 12:30:33 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
In-Reply-To: <20081016150106.6ddf7e46@zod.rchland.ibm.com>
Message-ID: <alpine.DEB.1.10.0810201222570.3760@gandalf.stny.rr.com>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161421530.11042@gandalf.stny.rr.com>
	<20081016183529.GB29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
	<20081016150106.6ddf7e46@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 16 Oct 2008, Josh Boyer wrote:
> > 
> > On Thu, 16 Oct 2008, Josh Boyer wrote:
> > > 
> > > Well, that's why I asked.  You sent 2 patches out over a month ago that
> > > don't appear to have shown up in any Linus or PowerPC tree.
> > 
> > Oh, the patches I sent on here, are not to solve this issue. It was 
> > actually solving issues in linux-tip itself.
> 
> Totally confused as to what linux-tip is, but ok.
> 
> > I'm still looking into the cause for ftrace not to boot on PPC.
> 
> There were issues with -pg and some other compile flag on PPC at one
> point.  I think you worked that out with Ben, but I don't recall.
> 
> Anyway, if you want a tester let me know.  It seems 2.6.27.1 should be
> fine since FTRACE was disabled, but for .28-rc1 it would be cool if it
> worked :).

Hi Josh,

I've been looking deeper at the code for PPC. I realized that my PPC64 box 
that I've been testing on did not use modules. While looking at the module 
code it dawned on me the dynamic ftrace needs a bit of work. This is 
because the way modules are handled in PPC (and other architectures as 
well).  The jmps used by mcount is a 24 bit jump. Since the modules are 
loaded farther than 24bits away, a trampoline is needed.

A bit of rework is needed in the ftrace infrastructure to handle the 
trampoline. Too much work to go into 28. I'll start working on code that 
can hopefully be ready and tested for 29. It's not that major of a change, 
but since the merge window for 28 has already been opened, we would like 
to get a bit more testing in before we hand it over to Linus.

-- Steve
