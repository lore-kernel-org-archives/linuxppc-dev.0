Date: Thu, 30 May 2002 18:04:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Do we need tlbsx at finish_tlb_load?
Message-ID: <20020530080434.GY16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A question to Dan and Tom in particular:

At the moment on 4xx, just after finish_tlb_load, which is called by
both the TLB miss handlers, we do a tlbsx to see if an entry for this
virtual address already exists.

Since this code is only called from the TLB miss handler, I can't see
how there could ever be a valid TLB entry present at this point.
There is a comment claiming that this path can be hit under some
circumstances, but it doesn't make sense to me.

Is there any situation where we can reach this point with a valid TLB
entry existing for the faulting address?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
