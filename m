Message-ID: <3B85E0D2.21BC306E@mvista.com>
Date: Fri, 24 Aug 2001 01:06:26 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
References: <20010823074100.31846@smtp.wanadoo.fr> <20010823110818.2847@smtp.adsl.oleane.com> <20010824114153.A790@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
to break.
>
> Ah yes, I ran into that one when I started converting the ppc405_enet
> driver to use ioremap() and in_beXX() instead of the godawful mess of
> direct access and explicit eieio()s it uses now.

Umm....what are you doing?  Those registers are already mapped via
ioremap(), so that isn't necessary.  What you consider a "godawful mess"
is a personal preference, and I prefer the programming style that
currently exists.  I don't have any love for the driver, but it
certainly isn't a patch I would check in.......

The only modification that _should_ be done is moving the generic
on-board I/O mapping done during board initialization to be a specific
ioremap() in the driver, and actually looking at the eieio() to ensure
they are really necessary.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
