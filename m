Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 13F3CDDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:54:33 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3967955pyi
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:54:31 -0700 (PDT)
Message-ID: <fa686aa40710151254p78178e40td3e1aebb6146241e@mail.gmail.com>
Date: Mon, 15 Oct 2007 13:54:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v2] Device tree bindings for Xilinx devices
In-Reply-To: <200710152121.54977.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
	<200710152121.54977.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 15 October 2007, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Here's my second version of xilinx device tree bindings.  Please review
> > and comment.  I'd like to push these out to Paulus in the next couple
> > of days.
>
> There are a few more properties that I can imagine you might need.
> Not sure if it makes sense specifying them now, but here are my thoughts:
>
> >     More devices will be defined as this spec matures.
> >
> > +   l) Xilinx ML300 Framebuffer
> > +
> > +   Simple framebuffer device from the ML300 reference design (also on the
> > +   ML403 reference design as well as others).
> > +
> > +   Required properties:
> > +    - compatible : Must include "xilinx,ml300-fb"
> > +    - reg : offset and length of the framebuffer register set
> > +
> > +   Optional properties:
> > +    - resolution : <xres yres> pixel resolution of framebuffer.  Some
> > +                   implementations use a different resolution.  Default
> > +                   is <d#640 d#480>
> > +    - virt-resolution : <xvirt yvirt> Size of framebuffer in memory.
> > +                        Default is <d#1024 d#480>.
> > +    - rotate-display (empty) : rotate display 180 degrees.
>
> rotate-display could be defined as something that allows 0/90/180/270
> degrees, as well as mirroring, not just 180 degree rotation.

Yeah, I'm not sure what to do here.  The current xilinxfb device is
quite simple; but being that it's implemented in an FPGA, it's
conceivable that HW designers could build in any number of added
features in variant designs.  rotate-display reflects the currently
implemented behavior.  I'd like to future-proof it, but I'm not sure
how far down that path to go.  (suggestions welcome!)

>
> > +   o) Xilinx Uartlite
> > +
> > +   Xilinx uartlite devices are simple fixed speed serial ports.  Uartlite
> > +   ports should be described in a node with the following properties.
> > +
> > +   Requred properties:
> > +    - compatible : Must include "xilinx,uartlite"
> > +    - reg : offset and length of uartlite register set
> > +
> > +    Recommended properties:
> > +    - interrupt-parent, interrupts : Connection of device irq signal.
> > +
>
> typically, serial ports include properties for current-speed and
> clock-frequency. I guess it would be good to include at least one
> of the two here.

Is 'current-speed' the current baud rate?  clock-frequency is unneeded
here because the uartlite is a fixed speed serial device.  :-)

Thanks for the feedback,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
