Date: Thu, 13 Mar 2003 08:40:54 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: question on howto use invalidate_dcache_range
In-reply-to: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de>
To: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIECAFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi,
>
> in November there was the discussion about Joakims patch to 8xx_io/enet.c.
> (http://lists.linuxppc.org/linuxppc-embedded/200211/msg00122.html)
>
> Since the result of the discussion didn't seam that clear to me I still have a question related to this.
>
> After all is it realy neccessary to use invalidate_dcache range before giving the transmit buffer to the DMA?
>   That's one of Joakims last modifications but what exactly is the reason? It's obvious for the flush command but I
> couldn't figure
> out the reason for invalidate.

Yes, it is neccessary. When you allocate a new skb buffer it you may get a recently used
buffer. The TCP/UPD/IP layer(s) may have modified some of the contents in that buffer before
freeing it. Therefore can the dcache contain dirty(modified) cache lines which belong to the
buffer. When the CPU needs more dcache, it will flush those dirty cache lines to memory which
now belong to the CPM. By invalidating the buffer you tell the CPU to free those cachelines
whithout writeing them to memory.

> Beside the cache line alignment problem (causing nearby data to be flushed or invalidated) are there any other problems
> to be taken
> care of?

There are no cache line alignment problems. There was some concern(expressed by Dan) that
some vital data at the end of the skb buffer could be invalidated due to bad aligment.
See http://lists.linuxppc.org/linuxppc-embedded/200302/msg00135.html
These has been fixed in the skb layer long ago.

The patch has been around for many months now and I have not received any problem
reports.

 Jocke

> Thanks, Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
