Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 5D3E2DE0F0
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 00:52:41 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1018225ywt.39
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 07:52:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A0D1FF1-302-2D5C780A@nukeman.tgi-sci.com>
References: <4A0D1FF1-302-2D5C780A@nukeman.tgi-sci.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 15 May 2009 08:52:19 -0600
Message-ID: <fa686aa40905150752o722a7e3ej7a65114130b8eb9e@mail.gmail.com>
Subject: Re: FEC & SDMA (bestcomm) interaction on the 5200
To: Dimiter Popoff <dp@tgi-sci.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 15, 2009 at 2:36 AM, Dimiter Popoff <dp@tgi-sci.com> wrote:
> Hi people,
>
> I am porting my (not linux) OS to the 5200. I went all the
> way understanding how the SDMA works and programming what
> I needed for it so things are now pretty stable in terms
> of disk I/O and system memory -> PCI (offscreen window
> buffers -> PCI display framebuffer).
>
> =A0And I wanted to make use of the Ethernet ("FEC", as they have
> it), hoping it would take me a few days (not my first one).
>
> =A0I am out of luck - it is practically undocumented. There is some
> talk of receive buffers which the FEC should see empty etc.,
> how on earth is that supposed to happen when it has no bus
> master capability at all? It relies on the SDMA for its bus
> activity - but in what format does it expect to get these
> buffer related data?
> =A0Or (more likely, at least hopefully so) this talk in the
> MPC5200BUM (and MPC5200UM, for that) is just nonsense and
> the FEC simply puts in the FIFO incoming packets, writing as
> a last .l the receive frame status word? If so, I could
> easily handle that with the SDMA.
> =A0Same question about transmitting. I can only hope/assume
> that the FEC will just send what it is handed through the
> FIFO by the SDMA, the very first .l being the frame control
> word, and ending when the TFD from the data drd1a or whatever
> makes it through?

It's been a long time since I've been in the bowels of the FEC driver,
but I believe you are correct.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
