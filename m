Date: Thu, 21 Jun 2001 18:16:24 -0400 (EDT)
Message-Id: <200106212216.f5LMGOT428496@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: ghurwitz@dyndns.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using a customg Interrupt Controller
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The problem could be (and I fear it is but hope it isn't) with atomic
> functions. I don't know if you've followed the travails of this board, but
> due to problems in the memory bridge controller, we don't have working
> lwarx/stwcx. calls, which means that we do not have atomic functions; I
> have replaced all of the atomic functions with non-atomic versions that
> should return the same, and as of yet there are no other busmasters on the
> board, so this should not yet prove a problem.

You need eieio.
If in doubt, sprinkle it everywhere.
Make stuff volatile.
Make stuff uncachable, or disable the cache for now.
To be really forceful, use sync instead of eieio.
Flush and/or invalidate cache lines as needed.

Look up sync and eieio in a PowerPC book.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
