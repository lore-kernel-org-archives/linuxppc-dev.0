Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id DDD26B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 23:12:07 +1100 (EST)
Date: Thu, 26 Nov 2009 15:12:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Message-ID: <20091126121204.GA3558@oksana.dev.rtsoft.ru>
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
	<200911252141.59549.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
Cc: Torsten Fleischer <to-fleischer@t-online.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 25, 2009 at 03:11:57PM -0700, Grant Likely wrote:
> On Wed, Nov 25, 2009 at 1:41 PM, Torsten Fleischer
> <to-fleischer@t-online.de> wrote:
> > On Wen, Nov 25, 2009 at 01:33:57 Grant Likely wrote:
> >> Thanks.  However, there needs to be a proper description of what this
> >> patch does to go in the commit header.  Can you please write one?
> >>
> >> Thanks,
> >> g.
> >>
> > [...]
> >
> > The initialization of the chip selects is removed from the probe() function of
> > the spi_mpc8xxx driver, because the driver doesn't know the polarity of the
> > chip selects of the SPI devices at the time of its initialization.
> >
> > For this reason the initialization of the several chip selects is postponed
> > to the point of time when the very first SPI transfer to the associated device
> > occurs.
> >
> >
> > Signed-off-by: Torsten Fleischer <to-fleischer@t-online.de>
> 
> Ah.  I understand what you're doing now.   Hmmm.  This approach
> concerns me because it relies on firmware or platform code to get CS
> gpios set up properly before the driver is probed.

Yes, that was said at the very beginning of this thread.

>  Firmware doesn't
> always get it right, and I prefer to avoid platform specific setups as
> much as possible.  Why can't the CS polarity be encoded into the
> device tree so the driver *does* have the polarity data at probe time?

We have the spi-cs-high property, but it duplicates compatible
property. 'compatible' is enough to tell whether some device has
cs-high or cs-low (device's driver knows that already).

The problem is that SPI bus master doesn't know all the devices,
so it can't extract that information from the compatible string.
To workaround that we can use 'spi-cs-high', but that's ugly
workaround.

SPI modes (0,1,2,3) is another matter, some devices can work in
several modes, so 'spi-cpol' and 'spi-cpha' are actually useful.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
