Date: Thu, 14 Sep 2000 01:50:04 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: success 2.4.0-test8 with latest bk
In-Reply-To: <14784.18464.5736.911672@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000914012752.12786A-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 14 Sep 2000, Paul Mackerras wrote:

> Takashi Oe writes:
>
> > Could you try the following change for arch/ppc/mm/init.c?
> [snip]
> > 		Hash = mem_pieces_find(Hash_size, Hash_size);
> > 		clear_hash_table();
>
> Huh?  There is a __clear_user(Hash, Hash_size) call in there but it's
> commented out, which I don't understand at all.  Certainly the hash
> table needs to be cleared.

Yeah, that's what I thought when I first saw the code a few months ago.

>                             Using cacheable_memzero would probably be
> the fastest way to do it.

__clear_user() works but I can't use cacheable_memzero() since frame
buffer memory resides on the same memory block.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
