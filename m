From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15597.29697.76853.964147@argo.ozlabs.ibm.com>
Date: Fri, 24 May 2002 08:58:09 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: benh@kernel.crashing.org, acurtis@onz.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: eieio rule-of-thumb?
In-Reply-To: <3CED2ECD.4090405@embeddededge.com>
References: <3CED26BB.2080700@embeddededge.com>
	<20020523184426.19045@mailhost.mipsys.com>
	<3CED2ECD.4090405@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Oh right....You get guarded to prevent out of order loads, and I just
> get lucky that the uncached store doesn't cross the load.

Careful... "out of order" is a somewhat ambiguous term.  The obvious
meaning (at least to me) is "done in a different order from that
specified in the program", i.e. reordered.  But that isn't what the
term means in the CPU users' manuals and the PEM.  There it means
"done before you know that the program requires it to be done",
i.e. speculative.  The guarded bit prevents "out of order" loads and
stores in the second sense, that is, the processor can't perform a
load or a store to a guarded page until it has resolved all previous
branches and made sure that there are no pending exceptions from
previous instructions.

The original PowerPC architecture didn't put any constraints on which
order the loads and stores done by a program are seen by memory or an
I/O device.  However, none of the implementations so far reorder
stores to noncacheable, guarded space, and IBM has decided that future
64-bit PowerPCs will preserve this behaviour.  I don't recall what
Book E specifies in this area though.

It would be legal for two loads to get reordered, and I can imagine a
situation where this might happen:

	lis	r9,variable@ha
	lwz	r3,variable@l(r9)
	lwzx	r4,r3,r10
	lwz	r5,0(r10)

Imagine that r10 points to a noncacheable guarded page, and that the
first load misses in the cache (or is from a noncacheable page).  The
subsequent loads can't be performed until we know that the first load
isn't going to generate an exception, but that only takes a TLB
lookup.  The third load could well go ahead while the second load is
waiting for the value of the first load.

Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
