Date: Sun, 17 Sep 2000 00:32:08 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: Cort Dougan <cort@fsmlabs.com>, Paul Mackerras <paulus@linuxcare.com.au>,
        Takashi Oe <toe@unlserve.unl.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: success 2.4.0-test8 with latest bk
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000914012752.12786A-100000@ofey.earthlink.net>
Message-ID: <Pine.LNX.4.21.0009170029140.20663-100000@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got curious, and I tracked down the commented out
__clear_user(Hash, hash_size)

to version 1.10 of init.c

arch/ppc/mm/init.c
  1.10 00/02/04 13:20:23 cort@medea.fsmlabs.com +15 -2
  Changes to fix PPC64 MM (short term fix) and protect the system
  map memory from being written over.

Cort, any chance you happen to recall why that was needed

>
> On Thu, 14 Sep 2000, Paul Mackerras wrote:
>
> > Takashi Oe writes:
> >
> > > Could you try the following change for arch/ppc/mm/init.c?
> > [snip]
> > > 		Hash = mem_pieces_find(Hash_size, Hash_size);
> > > 		clear_hash_table();
> >
> > Huh?  There is a __clear_user(Hash, Hash_size) call in there but it's
> > commented out, which I don't understand at all.  Certainly the hash
> > table needs to be cleared.
>
> Yeah, that's what I thought when I first saw the code a few months ago.
>
> >                             Using cacheable_memzero would probably be
> > the fastest way to do it.
>
> __clear_user() works but I can't use cacheable_memzero() since frame
> buffer memory resides on the same memory block.
>
>
> Takashi Oe
>
>
>
>

--
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
