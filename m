Date: Thu, 23 Aug 2001 10:40:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Message-ID: <20010823104023.I28430@zax>
References: <3B83D895.C5738613@mvista.com> <20010822200404.21295@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010822200404.21295@smtp.wanadoo.fr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 22, 2001 at 10:04:04PM +0200, Benjamin Herrenschmidt wrote:
>
> >
> >Will you please check that in?  I pused the files but couldn't
> >decide which method of initialization was "current" :-).
> >
> >I'm still sorting out the bootloader stuff.
>
> I'll do tomorrow when I'm at work.
>
> Note that I still didn't manage to get userland to work on
> my 405GP. I'm suspecting an issue between Paulus/DaveM new
> cache flush avoidance code and the weird cache design of the
> 405. But it might not...

I'm working on this at the moment too.  The first problem I found was
that the ELF loader would refuse to exec() init, which turned out to
be because bytes 16-32 (and possibly later ones too, I forget) of
binprm->buf were junk.  The data was correct in the page cache.  I
found this was fixed by removing the dcbz from copy_tofrom_user(),
although I don't see why yet since the cache line size appears to be
ok.

I'm now able to run a very simple binary as init - basically "Hello,
world!" implemented with one write() syscall, and none of the libc
initialisation junk present.  A one write hello world with the normal
crt0 (statically linked) fails.

--
David Gibson			| Microsoft: Making the easy things hard
david@gibson.dropbear.id.au	| and the hard things buggy
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
