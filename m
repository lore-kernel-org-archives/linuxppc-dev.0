Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id CA081DE465
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:22:11 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] Device tree bindings for Xilinx devices
Date: Mon, 15 Oct 2007 21:21:53 +0200
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710152121.54977.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 15 October 2007, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Here's my second version of xilinx device tree bindings.  Please review
> and comment.  I'd like to push these out to Paulus in the next couple
> of days.

There are a few more properties that I can imagine you might need.
Not sure if it makes sense specifying them now, but here are my thoughts:
 
>     More devices will be defined as this spec matures.
>  
> +   l) Xilinx ML300 Framebuffer
> +
> +   Simple framebuffer device from the ML300 reference design (also on the
> +   ML403 reference design as well as others).
> +
> +   Required properties:
> +    - compatible : Must include "xilinx,ml300-fb"
> +    - reg : offset and length of the framebuffer register set
> +
> +   Optional properties:
> +    - resolution : <xres yres> pixel resolution of framebuffer.  Some
> +                   implementations use a different resolution.  Default
> +                   is <d#640 d#480>
> +    - virt-resolution : <xvirt yvirt> Size of framebuffer in memory.
> +                        Default is <d#1024 d#480>.
> +    - rotate-display (empty) : rotate display 180 degrees.

rotate-display could be defined as something that allows 0/90/180/270
degrees, as well as mirroring, not just 180 degree rotation.

> +   o) Xilinx Uartlite
> +
> +   Xilinx uartlite devices are simple fixed speed serial ports.  Uartlite
> +   ports should be described in a node with the following properties.
> +
> +   Requred properties:
> +    - compatible : Must include "xilinx,uartlite"
> +    - reg : offset and length of uartlite register set
> +
> +    Recommended properties:
> +    - interrupt-parent, interrupts : Connection of device irq signal.
> +

typically, serial ports include properties for current-speed and
clock-frequency. I guess it would be good to include at least one
of the two here.

	Arnd <><
