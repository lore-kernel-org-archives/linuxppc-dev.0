Message-ID: <01ff01c2c34f$20baa210$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLGEIOFJAA.joakim.tjernlund@lumentis.se> <3E2F1920.9070702@embeddededge.com> <001301c2c26b$2a06e7a0$020120b0@jockeXP> <013f01c2c283$d2511a30$e600a8c0@udtech.net> <3E300E28.4010804@embeddededge.com>
Subject: Re: wrong definition in cpm_8260.h?
Date: Fri, 24 Jan 2003 10:20:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I don't understand.  The current driver will get exactly one
> interrupt per frame (or maybe less if frames are coming in fast
> and they are queued), regardless of the frame size.

Sorry, I didn't figure it out clearly. As you know the I bit in BDs is just
to let the cpm interrupt the cpu when a buffer not a frame is received.
(yes, in init_fcc_param(), set the rx BDs to
bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
or
bdp->cbd_sc = BD_ENET_RX_EMPTY;
has the same result in the current driver. That's to say we will receive an
interrupt when a "frame" is received. The cpm will issue RXF interrupt
wheneven a frame is received if it's not masked whether you set the I bit or not)

If I want to use the I bit control the interrupt, I can only mask the RXF interrupt,
and unmask the RXB interrupt. When a buffer is full filled with the I bit set in the BD,
a RXB interrupt will occur. But there is a problem, if the buffer is lager enough
to hold an frame (that's the case of the current driver:
 ep->fen_genfcc.fcc_mrblr = PKT_MAXBLR_SIZE; /* 1536 */)
no RXB interrupt is issued since the RXF will be isssed though it is masked by me.
My solution is set the mrblr to a small value(64), and the interrupts will be issued
whenever an buffer is used up by the cpm. The trick is not to set the I bit in all BDs,
but set it one by one or one by more. With this way the interrupt number will be
controled by the I bits in the BDs. Yes, it still has problems, if the last buffer of a
frame has the I bit set in the BD, no RXB interrupt will be issued for the above reason.
The worst case is the I bits are all set only in the last buffers of receiving frames, no
interrupts are issued.

I hope I have explained all now, but maybe my poor Englist won't let me do so:)

>
> The purpose for using first/last is so you can split a frame across multiple
> BDs, making the use of memory a little more efficient.  Using this method,
> you can't dma directly into sk buffers, you will have to check for the
> buffer sequences and copy the data into the sk buffers.  This method also

I do can use dma into small buffers, and then copy to a sk buffer.Since the
current driver copys data to sk buffer too, it won't cost much more time,
though it does incur more bus accesses to the BDs(both the cpu & cpm).


Shenrong

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
