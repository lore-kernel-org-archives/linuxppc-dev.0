Return-Path: <sam@ravnborg.org>
Received: from pqueuea.post.tele.dk (pqueuea.post.tele.dk [193.162.153.9])
	by ozlabs.org (Postfix) with ESMTP id 867C767A64
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 00:31:41 +1000 (EST)
Received: from pasmtp.tele.dk (pasmtp.tele.dk [193.162.159.95])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 2CEF5375F05
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Apr 2006 16:04:49 +0200 (CEST)
Date: Sun, 16 Apr 2006 16:03:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-ID: <20060416140359.GA15091@mars.ravnborg.org>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	<4441B02D.4000405@yahoo.com.au>
	<Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
	<17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	<1145194804.27407.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1145194804.27407.103.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	rusty@rustcorp.com.au, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 16, 2006 at 09:40:04AM -0400, Steven Rostedt wrote:
 
> The per_cpu variables are defined with the macro 
>     DEFINE_PER_CPU(type, var)
> 
> This macro just places the variable into the section .data.percpu and
> prepends the prefix "per_cpu__" to the variable.
> 
> To use this variable in another .c file the declaration is used by the
> macro
>     DECLARE_PER_CPU(type, var)
> 
> This macro is simply the extern declaration of the variable with the
> prefix added.
Suprisingly this macro shows up in ~19 .c files. Only valid usage is
forward declaration of a later static definition with DEFINE_PER_CPU.
arch/m32r/kernel/smp.c + arch/m32r/kernel/smpboot.c is jsut one example.

Just a random comment not related to Steven's patches.

	Sam
