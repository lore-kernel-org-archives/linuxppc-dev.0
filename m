Message-ID: <4124C965.1020907@nortelnetworks.com>
Date: Thu, 19 Aug 2004 11:38:13 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.linuxppc.org
Subject: pagetable changes for ppc between 2.6.5 and 2.6.7?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm seeing some strange behaviour, and before I dove into it I thought I'd
double-check with you guys to see if it was something obvious.

We're running on a dual G5 with a 1.5GB of memory.

We needed a way to track when particular application pages (which would be
mlock'd) were being modified.

We added a bit (_PAGE_MEMMON=0x800) to the PTE flags, and expanded
_PAGE_CHG_MASK to include that bit as well.  The new bit signified whether the
page was to be monitored or not.

The app could then (through a driver) mark each page that it wanted to monitor,
and later it could trigger the driver to walk all its page tables, and if the
page was being monitored and was dirty, it would add the page to a list and mark
it as clean.  Since the memory was locked, the kernel (we assumed, and it seemed
to work) would never mark the page as clean itself.

Somewhere between 2.6.5 and 2.6.7 the results for identical application runs
changed, and we are now getting far fewer dirty pages.  Our assumption is that
something in the kernel is marking pages as clean before we get around to
scanning them.  Does anyone know of the top of their heads what would be doing this?

The next step for me is to try running with no swap, just to see if that changes
things.  After that, I guess I'll start playing binary search with patches...

Chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
