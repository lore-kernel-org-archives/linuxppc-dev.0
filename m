Message-ID: <3D08276D.3080502@embeddededge.com>
Date: Thu, 13 Jun 2002 01:02:37 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: get_pteptr()
References: <20020613040345.GD4228@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> get_pteptr() is used in exactly three places:
> 	- in arch/ppc/8xx_io/commproc.c in the #else side of a #if 1,
> i.e. not really used at all.

That was one of my earliest cache management hacks, that predated iopa()
and consistent_alloc().  You can get rid of it.

> 	- in do_page_fault() [arch/ppc/mm/fault.c] for the handling of
> page execute faults on 40x.  It's use here is arguably incorrect if
> large page pmds are introduced, although we won't ever get execute
> faults on large pages, so it doesn't really matter.

Hmmmm.....I was always hoping we could use "standard" VM functions to
find and update PTEs, but I guess that isn't happening.  I would suggest
just placing a comment around this about the large pages and leave it.


> But given that iopa() is pretty much the only user of this function
> (do_page_fault() should be done slightly differently, I think), there
> doesn't seem a lot of point.  Why not just eliminate get_pteptr() and
> walk the page tables explicitly in iopa().

I sometimes use get_pteptr() for debug.  Make sure xmon doesn't use it
for printing page table information.

> [*] Well, apart from removing iopa() entirely, but that's another
> flamewar^Wdiscussion.

Just remove it for 4xx, or put an #ifdef in iopa() to do the arithmetic
conversion.  It's only used on 4xx and 8xx, and I would like to ensure
the 8xx still works correctly before we nuke everything.  I would just
be a little careful to ensure you have run enough PCI cards to verify
everything is OK.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
