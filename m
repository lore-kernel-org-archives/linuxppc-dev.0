Message-ID: <3DD4DFEA.7070700@uab.ericsson.se>
Date: Fri, 15 Nov 2002 12:52:10 +0100
From: Hans Feldt <Hans.Feldt@uab.ericsson.se>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@lists.linuxppc.org, scop@digitel.com.br,
	thomas@corelatus.com
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 2
References: <IGEFJKJNHJDCBKALBJLLAEPLFHAA.joakim.tjernlund@lumentis.se> <001c01c28b4b$28665b80$4f158a86@default> <002901c28b5a$55f60820$0200a8c0@telia.com> <3DD2CE30.6090708@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 11/13/02 11:12 PM, Dan Malek wrote:

> This isn't something new that hasn't been tried before.  The problem
> in the past with non-coherent processors, incoming DMA, and skbufs is
> the buffers would share cache lines with other data which would get
> corrupted as the result of the invalidate for the DMA.  Typically,
> data that was corrupted were flags and control information for the IP

The problem I was describing related to this patch was due to the L1
cache replacement algorithm. The L1 cache flushes a line to main memory
when it's full with some LRU algo. Thus if you have no snooping
(860/405), this can interfere with the DMA into the same piece of memory.

Invalidating the whole buffer before giving it to DMA solves this and
the cost of doing it on the whole buffer is not much. You have already
done the big optimisation in removing the memcpy and changing flush to
invalidate.

Cheers,
Hans


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
