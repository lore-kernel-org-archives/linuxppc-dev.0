From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15877.25339.355590.772957@argo.ozlabs.ibm.com>
Date: Sun, 22 Dec 2002 18:00:11 +1100
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: New invalidate/clean/flush_dcache functions
In-Reply-To: <IGEFJKJNHJDCBKALBJLLCEABFJAA.joakim.tjernlund@lumentis.se>
References: <3E034380.1080404@tataelxsi.co.in>
	<IGEFJKJNHJDCBKALBJLLCEABFJAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund writes:

> How about adding new xxx_dcache_range() functions functions to PPC.
> Below is my suggestion which is more logical and more efficient:

Why do you say it's more efficient?  Because it's inline?  Inlining
isn't necessarily a win, you know; by inlining something you can
reduce the number of instructions executed in a particular code path,
but usually you increase the size of the kernel, and together with
that, the icache footprint, which is important because you can execute
quite a lot of instructions in the time taken for one cache miss.

I'm not saying that your functions aren't more efficient, I'm saying
that you haven't established that they are more efficient.  Simply
inlining things doesn't necessarily increase efficiency.  What you
need to do is to show a measurable increase in efficiency, in the
context of the kernel, which is sufficient to justify the increased
size of the kernel.

The other thing is that you haven't included the synchronization
instructions that are required by the PPC architecture spec.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
