Message-ID: <001301c2c26b$2a06e7a0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Shen Rong" <rshen@udtech.com.cn>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLGEIOFJAA.joakim.tjernlund@lumentis.se> <3E2F1920.9070702@embeddededge.com>
Subject: Re: wrong definition in cpm_8260.h?
Date: Thu, 23 Jan 2003 00:08:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


From: "Dan Malek" <dan@embeddededge.com>
> Joakim Tjernlund wrote:
>
> > Yes, the CPM will set these flags, but will it also clear them if the
> > buffer is not first/last in a frame? I think not.
>
> It doesn't matter.  The flags are always going to be set.  Why bother
> clearing them when you always set them?
>
> > I know that the driver is designed to always set them so in practise it
> > won't be problem. However this could change some day.
>
> Well, when it changes we can change the code to set/clear the flags
> according to the buffer management algorithm.
>
>
> > yes I know, but I still think those flags should be included in the RX_STATS macro.
>
> Why?  Like I said in the previous message, they aren't part of any network
> status.  They are buffer control flags and need to properly indicate how the
> buffers are managed, not cleared as part of network status.

Suppose there is a bug in the driver(or someone introduces a bug or flaky HW) that will
generate a buffer that is not the first(or last) in this frame every now and then.
Since previously received frames did not clear these bits when they were done with
the RX BD, these bits will still be set and the driver won't detect the "bad" frames.

         Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
