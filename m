Date: Thu, 13 Jun 2002 14:03:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: get_pteptr()
Message-ID: <20020613040345.GD4228@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


get_pteptr() is used in exactly three places:
	- in arch/ppc/8xx_io/commproc.c in the #else side of a #if 1,
i.e. not really used at all.
	- in do_page_fault() [arch/ppc/mm/fault.c] for the handling of
page execute faults on 40x.  It's use here is arguably incorrect if
large page pmds are introduced, although we won't ever get execute
faults on large pages, so it doesn't really matter.
	- in iopa() [arch/ppc/mm/pgtable.c].  The sanest way [*] I can
see of extending this to support large page pmds, without horrible
ifdefs can't be done without either extending get_pteptr(), or
removing it and walking the page tables manually.

I could extend get_pteptr() to handle large page pmds.  Something
like:
	- if the address has no valid translation, return 0 and leave
*ptep unchanged (as now).
	- if the address is translated by a normal PTE return
PAGE_MASK and set ptep to point to the PTE
	- if the address is translated by a large page PMD return a
mask for the size of the large page and set ptep to point to the PMD.

That makes iopa() easy and works for the other callers.

But given that iopa() is pretty much the only user of this function
(do_page_fault() should be done slightly differently, I think), there
doesn't seem a lot of point.  Why not just eliminate get_pteptr() and
walk the page tables explicitly in iopa().

[*] Well, apart from removing iopa() entirely, but that's another
flamewar^Wdiscussion.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
