Message-ID: <013f01c2c283$d2511a30$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>,
	"Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLGEIOFJAA.joakim.tjernlund@lumentis.se> <3E2F1920.9070702@embeddededge.com> <001301c2c26b$2a06e7a0$020120b0@jockeXP>
Subject: Re: wrong definition in cpm_8260.h?
Date: Thu, 23 Jan 2003 10:04:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I write following message just for information:)

I am changing the fcc enet buffer management and interrupt
strategy to reduce the interrupt number when receiving the
small frame(say 64 bytes). I mask the frame received interrupt,
and unmask the buffer completed(i.e. RXB) interrupt, then use
the I bit and Last bit to control the interrupt number, that's to
say not to set all the I bit in BDs. When the cpm uses up several buffers
(maybe not receiving one frame), it will interrupt the cpu. It took me
some minutes to find the First&Last bits have not been included
in the RX_STATS. Well, I personly think there is no need to
change the RX_STATS if there are some comments just like what
Dan has said. But at least the so called final_version in fcc_enet_rx
need to be changed since it's do nothing but eat the cpu.

I still have the problems with the above solution:
1. If all the I bits are set only on the rx frames' last buffer, no interrupts
are trigered, and the cpm will silently use up all the BDs without notifying
the cpu.
2. There are some delay for cpu to know whether the packets are coming
if all the buffers previously received have no I bits set in the BDs.
3. maybe more
If you have any ideas, pls tell me. Thanks.

Shenrong

----- Original Message -----
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Shen Rong" <rshen@udtech.com.cn>; <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, January 23, 2003 7:08 AM
Subject: Re: wrong definition in cpm_8260.h?


> From: "Dan Malek" <dan@embeddededge.com>
> > Joakim Tjernlund wrote:
> >
> > > Yes, the CPM will set these flags, but will it also clear them if the
> > > buffer is not first/last in a frame? I think not.
> >
> > It doesn't matter.  The flags are always going to be set.  Why bother
> > clearing them when you always set them?
> >
> > > I know that the driver is designed to always set them so in practise it
> > > won't be problem. However this could change some day.
> >
> > Well, when it changes we can change the code to set/clear the flags
> > according to the buffer management algorithm.
> >
> >
> > > yes I know, but I still think those flags should be included in the RX_STATS macro.
> >
> > Why?  Like I said in the previous message, they aren't part of any network
> > status.  They are buffer control flags and need to properly indicate how the
> > buffers are managed, not cleared as part of network status.
>
> Suppose there is a bug in the driver(or someone introduces a bug or flaky HW) that will
> generate a buffer that is not the first(or last) in this frame every now and then.
> Since previously received frames did not clear these bits when they were done with
> the RX BD, these bits will still be set and the driver won't detect the "bad" frames.
>
>          Jocke
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
