Date: Tue, 18 Sep 2001 14:33:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 4xx icache and tlb flushing
Message-ID: <20010918143359.B817@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Several questions here.

First on icache flushing.  I noticed that flush_icache_page() has been
changed to a no-op, wheras it used to flush the whole icache on 4xx.
It appears this doesn't break things, but I'm not clear on why some
sort of special icache flush isn't necessary here, given the 4xx's
icache aliasing problem.  Also, although flush_instruction_cache()
uses an iccci on 4xx, flush_icache_range(), flush_dcache_icache()
etc. just use icbi and therefore could miss flushing a virtual alias.
In my tree I've tried using iccci here (overkill, I know) and this
seems to reduce the frequency of process lockups, but I don't have any
hard data on that.

Now two questions on tlb flushing.  First, 4xx uses a __tlbia() macro
in local_flush_tlb_*().  Is there a reason we don't use the _tlbia()
function already included in misc.S?  Second, according to the 405gp
manual, tlb manipulation instructions such as tlbia should be followed
by a context synchronisation instruction (i.e. isync) but we don't
seem to do this.  Is this a bug, or am I missing something?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
