From: "Chris Thomson" <cmt@bivio.net>
To: "'Dan Malek'" <dan@embeddededge.com>, <acurtis@onz.com>
Cc: "'Paul Mackerras'" <paulus@samba.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: RE: eieio rule-of-thumb?
Date: Thu, 23 May 2002 10:45:42 -0700
Message-ID: <000001c20281$a98be6b0$9502a8c0@cthomson59>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3CED26BB.2080700@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eieio instructions are needed for CPUs based on the 745x core.
These are the 7445, 7450, 7451 and 7455.

Earlier PPC implementations never reordered guarded, or even
uncached, accesses.  Motorola made a big deal about this in its
embedded sales.  All you had to do was set the WIMG bits right.

Evidently Motorola decided that getting the extra performance
of reordering was needed to keep the Apple account.



-----Original Message-----
From: owner-linuxppc-dev@lists.linuxppc.org
[mailto:owner-linuxppc-dev@lists.linuxppc.org]On Behalf Of Dan Malek
Sent: Thursday, May 23, 2002 10:28 AM
To: acurtis@onz.com
Cc: Paul Mackerras; linuxppc-dev@lists.linuxppc.org
Subject: Re: eieio rule-of-thumb?



Allen Curtis wrote:


> All of these make sense,....

What doesn't make sense is why we use eieio at all......All of the
mapped I/O space is marked uncached 'guarded' in the PTE, which enforces
in-order load/store operations.  This should also prevent store gathering in
bridges since they shouldn't see a burst write from a processor store
operation.

If you want higher peformance programmed I/O access, then you should cache
some of the space, and at that time you must use eieio if there are cached
areas subject to out of order access problems.

On the 8xx and 8260 family, all of the I/O (including the internal memory
space) is mapped uncached and guarded.  I've never used eieio nor seen
any reason it was necessary.

Where you will see problems, especially on 4xx and potentially on 8xx,
is the use of "regular" memory for control structures and special registers
for other control.  You can write to memory, which gets stuck in pipelines,
then whack a DCR (which seems to have some magical fast path update) causing
the peripheral to start up before the pipelined writes have made it to
memory.  I'm wondering if we aren't just lucky with the eieio side effects
when a 'sync' would be the logically correct operator.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
