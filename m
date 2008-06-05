Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 84FB1DE1BC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 03:27:25 +1000 (EST)
Date: Thu, 5 Jun 2008 21:27:23 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [RFC v3] OF: OpenFirmware bindings for the mmc_spi driver
Message-ID: <20080605172723.GA14514@polina.dev.rtsoft.ru>
References: <20080605161624.GA517@polina.dev.rtsoft.ru>
	<fa686aa40806050945h5e61910flb63a8d00e1d2b0e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40806050945h5e61910flb63a8d00e1d2b0e8@mail.gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 10:45:17AM -0600, Grant Likely wrote:
> On Thu, Jun 5, 2008 at 10:16 AM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > Here is v3. I'm out of ideas if you won't like it. :-)
> >
> > v3:
> > - Now these bindings are using bus notifiers chain, thus we adhere to the
> >  spi bus.
> >
> >  By the way, this scheme (IMO) looks good for I2C devices which needs
> >  platform_data extracted from the device tree too (Cc'ing Jochen).
> >
> > - Plus changed the OF bindings themselves, implemented voltage-range
> >  property. (Pierre, please take a look at vddrange_to_ocrmask(). I
> >  wonder if you would like this in the MMC core instead, with a kernel
> >  doc, of course.)
> >
> > v2:
> > - Bindings were adhered to the MMC_SPI driver. Withdrawn by Pierre Ossman.
> 
> Personally I think your v2 was better, and if I'm interpreting
> Pierre's comments correctly I think his main point is that instead of
> using the 'stock' probe/remove hooks for the spi mmc driver, the
> driver should be mildly reworked to provide a common block of code
> that can be used by both the OF and non-OF versions of the
> probe/remove routines.  I also think that is the way to go.

Well, I mentioned the usb_add_hcd()-alike approach for the mmc_spi
host... The absence of enthusiasm I equaled to "no".

Heh.

p.s.
Btw, you forgot another downside of v2 approach: struct spi_driver
duplication... Not sure if everyone will be happy about it.

Though, v2 is only version where we can make modular OF_MMC_SPI.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
