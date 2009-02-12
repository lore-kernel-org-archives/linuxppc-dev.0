Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 371CFDDE9E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 13:37:16 +1100 (EST)
Date: Wed, 11 Feb 2009 21:37:14 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 0/7][RFC] function graph tracer port to PowerPC
In-Reply-To: <1234405406.8142.4.camel@localhost>
Message-ID: <alpine.DEB.1.10.0902112131410.13954@gandalf.stny.rr.com>
References: <20090212011051.265346435@goodmis.org>
	<1234405406.8142.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 12 Feb 2009, Michael Ellerman wrote:
> > 
> > 
> > The function graph tracer not only traces the start of a function
> > (uses the function tracer part for that) but also uses the kprobes
> > trick to replace the return address with a hook to trace the exit
> > of the function.
> 
> You use the "kprobes trick", but none of the kprobes code (AFAICS).
> Couldn't there be some common code between the two?

I'm not 100% sure how kprobes work, but I believe they use traps. And then 
they set the return address to take another trap, to fix it. I could be 
totally off here, on how kprobes does this.

But ftrace is about executing the code directly. The return code jumps to 
a another function in asm that will set up the call to do the tracing, and 
then fix the return pointer back. The only thing that is similar between
the two approaches that I can tell, is that we both modify the return 
address of the function. I took a quick peek at the kprobes code and I 
see no easy way to share it.

-- Steve
