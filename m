Return-Path: <dp@tgi-sci.com>
Received: from server318.com (server318.com [216.35.196.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0FBEDDFB7
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 01:01:03 +1000 (EST)
Message-id: <4A117823-3B-3CBB2B73@nukeman.tgi-sci.com>
To: <linuxppc-dev@ozlabs.org>
From: Dimiter Popoff <dp@tgi-sci.com>
Subject: Re: FEC & SDMA (bestcomm) interaction on the 5200
Date: Mon, 18 May 2009 17:59:47 +0200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Fri, 15 May 2009 08:52:19 -0600
> Subject: Re: FEC & SDMA (bestcomm) interaction on the 5200
> To: Dimiter Popoff <dp@tgi-sci.com>
> Cc: linuxppc-dev@ozlabs.org
> 
> On Fri, May 15, 2009 at 2:36 AM, Dimiter Popoff <dp@tgi-sci.com> wrote:
> > Hi people,
> >
> > I am porting my (not linux) OS to the 5200. I went all the
> > way understanding how the SDMA works and programming what
> > I needed for it so things are now pretty stable in terms
> > of disk I/O and system memory -> PCI (offscreen window
> > buffers -> PCI display framebuffer).
> >
> > =A0And I wanted to make use of the Ethernet ("FEC", as they have
> > it), hoping it would take me a few days (not my first one).
> >
> > =A0I am out of luck - it is practically undocumented. There is some
> > talk of receive buffers which the FEC should see empty etc.,
> > how on earth is that supposed to happen when it has no bus
> > master capability at all? It relies on the SDMA for its bus
> > activity - but in what format does it expect to get these
> > buffer related data?
> > =A0Or (more likely, at least hopefully so) this talk in the
> > MPC5200BUM (and MPC5200UM, for that) is just nonsense and
> > the FEC simply puts in the FIFO incoming packets, writing as
> > a last .l the receive frame status word? If so, I could
> > easily handle that with the SDMA.
> > =A0Same question about transmitting. I can only hope/assume
> > that the FEC will just send what it is handed through the
> > FIFO by the SDMA, the very first .l being the frame control
> > word, and ending when the TFD from the data drd1a or whatever
> > makes it through?
> 
> It's been a long time since I've been in the bowels of the FEC driver,
> but I believe you are correct.
> 
> g.
> 
> -- =
> 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

Thanks for the input, Grant. It matches the memories of a guy
at Frrecale who has had to deal with it ass well, so I guess
I am on the right path - It won't be without trying this or
that out but I am well enough positioned to start.

Dimiter

------------------------------------------------------
Dimiter Popoff               Transgalactic Instruments

http://www.tgi-sci.com
------------------------------------------------------
http://www.flickr.com/photos/didi_tgi/sets/72157600228621276/
