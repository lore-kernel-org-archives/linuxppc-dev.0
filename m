Return-Path: <david-b@pacbell.net>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by ozlabs.org (Postfix) with SMTP id CA72FDE08D
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 08:24:05 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [RFC] OpenFirmware bindings for the MMC-over-SPI driver
Date: Sat, 24 May 2008 12:56:32 -0700
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
In-Reply-To: <20080523182754.GA26891@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200805241256.32639.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 May 2008, Anton Vorontsov wrote:
> 
> This is second attempt to write the OpenFirmware bindings for the
> MMC-over-SPI (and SPI bindings in general).

Summary:  an OF-specific wrapper around the mmc_spi platform code.

I think a wrapper to encapsulate all the OF-specific knowledge makes
much sense here.

The only thing that looks odd to me about this is that the wrapper
is a spi_device rather than an of_device.  To me it makes more sense
to just have an of_device setting up the right spi_device.  (Though
maybe I missed some discussion about why that can't work.)

Example:  drivers/usb/host/sl811_cs.c does that for PCMCIA card
that just wraps an sl811 chip that's more often used standalone.
The PCMCIA descriptors being analagous to OF device table entries.

- Dave
