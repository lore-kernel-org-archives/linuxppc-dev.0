Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Hans Feldt" <Hans.Feldt@uab.ericsson.se>
Cc: <linuxppc-embedded@lists.linuxppc.org>, <scop@digitel.com.br>,
	<thomas@corelatus.com>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 2
Date: Wed, 13 Nov 2002 17:35:36 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLAEPLFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3DD25896.6020603@uab.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On 10/24/02 04:23 PM, Joakim Tjernlund wrote:
> > Hi
> >
> > This is the second version of my patch that removes the expensive memcpy of
> > received
> > ethernet frames in interrupt context.
>
> Isn't it so that this patch works because you have snooping? Without
> snooping the driver would fail because of cache line replacement which
> could trash received data.

I don't have snooping(mpc860).

>
> The buffer invalidate in this case is unneeded. But if you wanna
> optimise you should invalidate the whole buffer before giving it to DMA
> thus getting rid of the flush implied by memory coherence.

In my first version I did invalidate the whole buffer BEFORE I gave it
to the CPM/DMA. I moved it because I thougth it was better to invalidate
after I received it, since the packet len is known at that time
so I don't have to invalidate the whole buffer, just the received number of bytes.

>
> Tried this out in a driver for a processor without snooping, now and
> then received packets got corrupted, cache line wise...

You may be right, perhaps one must invalidate the whole buffer before giving it
to the CPM/DMA. Suppose you reuse a buffer which has been modified before it
was freed and the dcache must write back data to free up space and the buffer,
which now is owned by the CPM, get written to.

I have not seen any corrupted packets and you are the first to report
any problems. What modifications have you done?

What CPU?
Post the driver please.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
