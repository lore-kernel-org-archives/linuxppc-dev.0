Return-Path: <david-b@pacbell.net>
Received: from smtp123.sbc.mail.sp1.yahoo.com (smtp123.sbc.mail.sp1.yahoo.com
	[69.147.64.96]) by ozlabs.org (Postfix) with SMTP id 40DA5DE04A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 13:37:23 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Thu, 22 May 2008 19:26:23 -0700
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<716a0f1b6c9a544b480c06a329072483@kernel.crashing.org>
	<fa686aa40805211233h72a258bpf8c945b9f662d6ee@mail.gmail.com>
In-Reply-To: <fa686aa40805211233h72a258bpf8c945b9f662d6ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805221926.24112.david-b@pacbell.net>
Cc: fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 May 2008, Grant Likely wrote:
> > spi-controller {
> >        #address-cells = 2;
> >        #size-cells = 0;
> >        some-device@0,f000 { reg = < 0 f000 >; } // CS 0, SPI address f000
> >        some-device@1,f000 { reg = < 1 f000 >; } // CS 1, SPI address f000
> >        some-device@1,ff00 { reg = < 1 ff00 >; } // CS 1, SPI address ff00
> > }
> 
> For SPI the CS # *is* the address.  :-)
> 
> Unlike I2C, SPI doesn't impose any protocol on the data.  It is all
> anonymous data out, anonymous data in, a clock and a chip select.

Very true ... but then there are SPI chips which embed addressing.

I have in mind the mcp23s08 (and mcp23s17) GPIO expanders, which
support up to four chips wired in parallel on a given chipselect.
The devices are distinguished by how two address pins are wired;
and two bits in the command byte must match them.  (I think they
just recycled an I2C design into the SPI world.)

- Dave
