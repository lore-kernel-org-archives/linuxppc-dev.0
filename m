Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 14616DDE39
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 10:13:29 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 3 Jun 2007 02:13:23 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070603001323.GA25653@iram.es>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<1180828253.14025.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180828253.14025.22.camel@localhost.localdomain>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 09:50:53AM +1000, Benjamin Herrenschmidt wrote:
> Minor nits (in addition to needing a "reg" property)
> 
> > +
> > +						i8259: i8259@4d0 {
> 
> Name should probably be "interrupt-controller" as well to follow the
> recommended naming practice.
> 
> > +							clock-frequency = <0>;
> > +							interrupt-controller;
> > +							device_type = "interrupt-controller";
> > +							#address-cells = <0>;
> > +							#interrupt-cells = <2>;
> > +							built-in;
> > +							compatible = "chrp,iic";
> > +							big-endian;
> 
> big-endian ? On a 8259 ? 

Yes, I spotted that too. Funny on a device which is only ever 
accessed through inb/outb! 

Maybe the 0x4d0/4d1 ports can be accessed with 16 bit 
instructions, I don't know. What I know for sure is that
accessing port 0x20 with an inl/outl on some boards
locks immediately the system up (perhaps through infinite
retries).

	Gabriel
