Date: Fri, 24 Aug 2001 11:41:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@mvista.com>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Message-ID: <20010824114153.A790@zax>
References: <20010823074100.31846@smtp.wanadoo.fr> <20010823110818.2847@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010823110818.2847@smtp.adsl.oleane.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 23, 2001 at 01:08:18PM +0200, Benjamin Herrenschmidt wrote:
>
> >>I'm now able to run a very simple binary as init - basically "Hello,
> >>world!" implemented with one write() syscall, and none of the libc
> >>initialisation junk present.  A one write hello world with the normal
> >>crt0 (statically linked) fails.
> >
> >Ok. So this would mean the problem is with the libc junk ? Hrm.
> >I didn't trace that far yet, but I suspect the libc I've been
> >using (the "normal" 6xx one) lacks some cache stuffs. I'm
> >pretty convinced that we must inval the entire instructions cache
> >each time we used to do icbi's (either that or handle the cache
> >aliasing issues specific to the 405GP weird icache design).
> >
> >I'll do more experiments later today.
>
> I found at least one other problem: The kernel is happily doing
> tlbie's on the 405 (which doesn't support them). Among other places,
> calls to flush_HPTE are turned into _tlbie which is not redefined
> to do a tlbia, causing at least ioremap to break.

Ah yes, I ran into that one when I started converting the ppc405_enet
driver to use ioremap() and in_beXX() instead of the godawful mess of
direct access and explicit eieio()s it uses now.

--
David Gibson			| Microsoft: Making the easy things hard
david@gibson.dropbear.id.au	| and the hard things buggy
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
