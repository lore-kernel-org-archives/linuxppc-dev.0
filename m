Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBEBF67A5D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 03:11:44 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Date: Mon, 17 Apr 2006 19:10:46 +0200
References: <1145049535.1336.128.camel@localhost.localdomain>
	<Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
	<4441ECE6.5010709@yahoo.com.au>
In-Reply-To: <4441ECE6.5010709@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604171910.48838.ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, benedict.gaster@superh.com, bjornw@axis.com,
	Ingo Molnar <mingo@elte.hu>, grundler@parisc-linux.org,
	Steven Rostedt <rostedt@goodmis.org>, starvik@axis.com,
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

On Sunday 16 April 2006 09:06, Nick Piggin wrote:

> I still don't understand what the justification is for slowing down
> this critical bit of infrastructure for something that is only a
> problem in the -rt patchset, and even then only a problem when tracing
> is enabled.

There are actually problems outside -rt. e.g. the Xen kernel was running
into a near overflow and as more and more code is using per cpu variables
others might too.

I'm confident the problem can be solved without adding more variables
though - e.g. in the way rusty proposed.

-Andi
