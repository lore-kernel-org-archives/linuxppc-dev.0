Date: Mon, 04 Nov 2002 11:25:08 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dc* (Data Cache)  instructions in mem*() and *_page() functions
 not used on 8xx
In-reply-to: <3DC5D6CC.6010905@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLGEJKFHAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I don't follow you here, do you need to do all this for a modern(>=D4) 8xx CPU?
>
> Yes.  On "working" silicon, the dcbz (among others) requires special
> processing.....probably enough to ensure it costs more to use this
> instruction in a general purpose case.

hmm, then I asume that a "working" 8xx is different from any other PPC that
uses the dcbz? All other PPC arches are allowed to use the dcbz instruction.

>
> > I hope not, but something needs to be done since copytofrom_user does not
> > work for me.
>
> What do you mean it doesn't work?  It should work fine if you don't
> try to use the dcbz.  That is, leave the code alone.  The bigger problem
> is the newer glibc library has to be modified to conditionally not use
> this as well.

I mean that if I remove the #ifndef CONFIG_8xx restrictions in __copy_fromto_user(),
linux does not work anymore(init hangs). That was the experiment I did earlier in this thread.

clear_page() and copy_page() work fine if I remove #ifndef CONFIG_8xx.
I removed the #ifndef CONFIG_8xx in cacheble_memcpy() and cacheble_memzero() also but
these seems to unused.

>
> > The same resoning goes for the new option. If you have a new enough(>=D4) CPU,
> > then you can enable this optimization(I think?!).
>
> I don't know.  Linux is the only OS that will cause VM faults on a dcbz,
> maybe it will never work.  Until someone verifies it works on the newer
> silicon we can't assume it will.  This certainly isn't a reason to not use
> the processor or not ship products.......

Right, I quite like the 860 and even more the 862P(100MHz) I just got :-)

 Regards
         Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
