From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Date: Thu, 23 Aug 2001 09:41:00 +0200
Message-Id: <20010823074100.31846@smtp.wanadoo.fr>
In-Reply-To: <20010823104023.I28430@zax>
References: <20010823104023.I28430@zax>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>I'm working on this at the moment too.  The first problem I found was
>that the ELF loader would refuse to exec() init, which turned out to
>be because bytes 16-32 (and possibly later ones too, I forget) of
>binprm->buf were junk.  The data was correct in the page cache.  I
>found this was fixed by removing the dcbz from copy_tofrom_user(),
>although I don't see why yet since the cache line size appears to be
>ok.

Ok, I didn't have this one as I removed all the cache tricks from
copy_tofrom_user & copy_page in my version, at least until I get
it working.
I had copy_tofrom_user failing earlier causing ipconfig to fail,
that's why I took this drastic workaround ;)

>I'm now able to run a very simple binary as init - basically "Hello,
>world!" implemented with one write() syscall, and none of the libc
>initialisation junk present.  A one write hello world with the normal
>crt0 (statically linked) fails.

Ok. So this would mean the problem is with the libc junk ? Hrm.
I didn't trace that far yet, but I suspect the libc I've been
using (the "normal" 6xx one) lacks some cache stuffs. I'm
pretty convinced that we must inval the entire instructions cache
each time we used to do icbi's (either that or handle the cache
aliasing issues specific to the 405GP weird icache design).

I'll do more experiments later today.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
