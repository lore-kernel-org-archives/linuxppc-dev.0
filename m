Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC16EDDFAB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 16:31:45 +1000 (EST)
In-Reply-To: <1243540232.3305.0@antares>
References: <OF508468F5.9BFFC168-ONC12575C4.005846FD-C12575C4.00592585@transmode.se>	(from
	joakim.tjernlund@transmode.se on Thu May 28 18:13:43 2009)
	<1243540232.3305.0@antares>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Message-ID: <OFC4733C3C.0E94C44D-ONC12575C5.00215A32-C12575C5.0023DB18@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 29 May 2009 08:31:39 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Am 28.05.09 18:13 schrieb(en) Joakim Tjernlund:
> > hmm, these do look a bit unoptimal anyway. Any reason not to write
> > them something like below(written by me for uClibc long time ago).
> > You will have to add eieio()/sync
>
> No (and I wasn't aware of the PPC pre-inc vs. post-inc stuff) - I just

I think this is true for most RISC based CPU's. It is a pity as
post ops are a lot more common. The do {} while(--chunks) is also
better. Basically the "while(--chunks)" is free(but only if you don't use
chunks inside the loop).

> stumbled over this while fixing mtd accesses to the MPC5200's Local Bus
> in 16-bit mode which doesn't allow byte accesses.  And I didn't want to
> go too deep into this as the real fix for me is actually somewhat
> different...

OK.
>
> > /* PPC can do pre increment and load/store, but not post increment
> > and load/store.
> >    Therefore use *++ptr instead of *ptr++. */
> [snip]
> >  copy_chunks:
> >    do {
> >       /* make gcc to load all data, then store it */
> >       tmp1 = *(unsigned long *)(tmp_from+4);
> >       tmp_from += 8;
> >       tmp2 = *(unsigned long *)tmp_from;
> >       *(unsigned long *)(tmp_to+4) = tmp1;
> >       tmp_to += 8;
> >       *(unsigned long *)tmp_to = tmp2;
> >    } while (--chunks);
>
> Is this the same for all PPC cores, i.e. do they all benefit from
> loading/storing 8 instead of 4 bytes?

As I recall there is an extra cycle between load and store,
so you will benefit from doing all your loads first and then
stores. The kernel memcpy has loads 16 bytes before storing. I selected
8 as uClibc should also be small.
Since there has to be eieio between ops I am not sure it will
matter here. Perhaps it is better to do 4 bytes in the main loop, making
the whole function smaller. There are memset and memmove functions in
uClibc too.

 Jocke
