Message-ID: <000d01c24703$476d13c0$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLEELOFFAA.joakim.tjernlund@lumentis.se> <3D5D88C5.9030402@embeddededge.com> <002f01c245e2$de2223e0$0200a8c0@telia.com> <3D5E508E.90504@embeddededge.com> <000f01c245f9$5429e440$0200a8c0@telia.com> <3D5E77A8.4050009@embeddededge.com>
Subject: Re: MPC860 reorder and invalidate dcache
Date: Mon, 19 Aug 2002 00:04:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > ... The other mapping is used for flash commands and to write data to flash.
> > Each time I read I do a invalidate_dcache_range() to pick up updates made from
> > the uncached mapping.
>
> Why don't you do a single invalidate after the write to cover the region
> you just updated?

You read my mind :-). I tried this once before but failed, but that was problably due to
some stupid mistake. Now I am ready to give it another try.

Just to make sure, I only need to invalidate the address space that actually modify
the flash contents?
>
> > I was just hoping that the 'sync' instruction was an "accident", but now I know
> > better.
>
> Those of us that have programmed PowerPC all of these years seldom include
> a 'sync' instruction by accident.  We are more likely to not use them and
> then discover later they are necessary :-)

Amen :-)
But I still think it is a bit strange that you need a sync when you invalidate since all
you want to do is throw away the data in the cache, but what do I know :-)

             Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
