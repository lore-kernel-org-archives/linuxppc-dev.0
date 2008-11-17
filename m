Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18721.62958.479215.822513@cargo.ozlabs.ibm.com>
Date: Tue, 18 Nov 2008 09:53:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
In-Reply-To: <alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<alpine.LFD.2.00.0811171300410.18283@nehalem.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds writes:

> The ppc people run databases, and they don't care about sane people 

And HPC apps, and all sorts of other things...

> telling them the big pages suck. It's made worse by the fact that they 
> also have horribly bad TLB fills on their broken CPU's, and years and 

Taking page faults at a 4k granularity also sucks.  A lot of the
performance improvement from using 64k pages comes just from executing
the page fault path (and other paths in the mm code) less frequently.
That's why we see a performance improvement from 64k pages even on
machines that don't support 64k pages in hardware (like the 21%
reduction in system time on a kernel compile that I reported earlier).
That has nothing to do with TLB miss times or anything to do with the
MMU.

I'd love to be able to use a 4k base page size if I could still get
the reduction in page faults and the expanded TLB reach that we get
now with 64k pages.  If we could allocate the page cache for large
files with order-4 allocations wherever possible that would be a good
start.  I think Christoph Lameter had some patches in that direction
but they didn't seem to get very far.

> years of telling people that the MMU on ppc's are sh*t has only been 
> reacted to with "talk to the hand, we know better".

Well, it's been reacted to with "AIX can use small pages where it
makes sense, and large pages where that makes sense, so why can't
Linux?"

> I suspect the PPC people need to figure out some way to handle this in 
> their broken setups (since I don't really expect them to finally admit 
> that they were full of sh*t with their big pages), but since I think it's 
> a ppc bug, I'm not at all interested in a fix that penalizes the _good_ 
> case.

Looks like we should make the stack a bit larger.

Paul.
