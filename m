Date: Wed, 11 Dec 2002 09:57:33 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Regarding consistent_alloc
In-reply-to: <NCBBIINEHIPFGJPLBEIFMEOMDPAA.acurtis@directvinternet.com>
To: acurtis@directvinternet.com,
	Tom Rini <trini@kernel.crashing.org>,
	Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@au1.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAELIFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
> > > 2. I have a requirement to have my drivers loaded as modules.
> > > m8xx_cpm_hostalloc has a very simplistic implementation, which
> > > makes it unsuitable for something like that. I have some patches
> > > that fix both m8xx_cpm_hostalloc and 8xx_cpm_dpalloc by implementing
> > > a proper heap, with free space management and coalescing.
> > > What is the proper way to push them, and to whom?

It would be great if the new fucntions could work with micropatch.c as well.
If the microcode is loaded, then those microcode area should be reserved and
not used by 8xx_cpm_dpalloc.

> >
> > <buck passing mode=on>Dan Malek still knows the most about the
> > 8xx-specific portions of the kernel, so he should really speak up here
> > when he gets a moment</buck passing>
>
> m8xx_cpm_hostalloc(), if it is anything like the 8260 version, enables you
> to allocation memory from dual-port RAM. (which could be handy and/or
> required for certain CPM related operations) _va() and _pa() only work for
> main memory addresses. For all other address ranges the iopa() function must
> be used. (I hope this is helpful)

_va() and _pa() used to work for m8xx_cpm_hostalloc() and I like that better. _pa()
is much cheaper than iopa() and there is no iova()(I think).

Why was m8xx_cpm_hostalloc() changed to use consistent_alloc()? alloc_bootmem_pages()
should still work(I am guessing)

BTW, m8xx_setup_arch() still calls alloc_bootmem_pages() and
the new m8xx_cpm_reset() does not take a ptr argument, but m8xx_setup_arch()
still calls m8xx_cpm_reset() with cpm_page as argument.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
