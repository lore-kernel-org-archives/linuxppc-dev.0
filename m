Return-Path: <jwboyer@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id A909648698
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 04:09:45 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id m2so657168uge.14
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 10:09:42 -0700 (PDT)
Date: Mon, 20 Oct 2008 13:08:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
Message-ID: <20081020170808.GB7249@yoda.jdub.homelinux.org>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161421530.11042@gandalf.stny.rr.com>
	<20081016183529.GB29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
	<20081016150106.6ddf7e46@zod.rchland.ibm.com>
	<alpine.DEB.1.10.0810201222570.3760@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.1.10.0810201222570.3760@gandalf.stny.rr.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2008 at 12:30:33PM -0400, Steven Rostedt wrote:
>> Anyway, if you want a tester let me know.  It seems 2.6.27.1 should be
>> fine since FTRACE was disabled, but for .28-rc1 it would be cool if it
>> worked :).
>
>Hi Josh,
>
>I've been looking deeper at the code for PPC. I realized that my PPC64 box 
>that I've been testing on did not use modules. While looking at the module 
>code it dawned on me the dynamic ftrace needs a bit of work. This is 
>because the way modules are handled in PPC (and other architectures as 
>well).  The jmps used by mcount is a 24 bit jump. Since the modules are 
>loaded farther than 24bits away, a trampoline is needed.

Ah, indeed.

>A bit of rework is needed in the ftrace infrastructure to handle the 
>trampoline. Too much work to go into 28. I'll start working on code that 
>can hopefully be ready and tested for 29. It's not that major of a change, 
>but since the merge window for 28 has already been opened, we would like 
>to get a bit more testing in before we hand it over to Linus.

That seems like a good plan.  Should we mark dynamic ftrace as X86 only
in Kconfig for .28 to prevent people from inadvertently setting it?

josh
