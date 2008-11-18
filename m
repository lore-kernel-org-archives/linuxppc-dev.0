Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp119.mail.mud.yahoo.com (smtp119.mail.mud.yahoo.com
	[209.191.84.76]) by ozlabs.org (Postfix) with SMTP id BDF98DDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 21:14:02 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
Date: Tue, 18 Nov 2008 21:07:12 +1100
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
	<18721.62958.479215.822513@cargo.ozlabs.ibm.com>
In-Reply-To: <18721.62958.479215.822513@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811182107.12747.nickpiggin@yahoo.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 18 November 2008 09:53, Paul Mackerras wrote:

> I'd love to be able to use a 4k base page size if I could still get
> the reduction in page faults and the expanded TLB reach that we get
> now with 64k pages.  If we could allocate the page cache for large
> files with order-4 allocations wherever possible that would be a good
> start.

That can still have nasty side-effects like fragmentation and 64k
granular reclaim. It also adds complexity to mapping the pages to
userspace.

Christoph's patchset IIRC also only did page cache, wheras I suppose
your kernbench workload is gaining mainly from anonymous page faults.
