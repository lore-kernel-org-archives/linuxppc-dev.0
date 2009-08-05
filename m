Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E031CB7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 11:13:03 +1000 (EST)
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id ABA3DDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 11:13:02 +1000 (EST)
Date: Wed, 5 Aug 2009 05:06:20 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/7] spi: Add support for device table matching
Message-ID: <20090805010620.GB14451@oksana.dev.rtsoft.ru>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
	<20090729170457.GA4803@oksana.dev.rtsoft.ru>
	<20090729214446.GB1728@fluff.org.uk>
	<200908031921.23126.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200908031921.23126.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 03, 2009 at 07:21:22PM -0700, David Brownell wrote:
> On Wednesday 29 July 2009, Ben Dooks wrote:
> > >  struct spi_driver {
> > > +     const struct spi_device_id *id_table;
> > > +     int                     (*probe_id)(struct spi_device *spi,
> > > +                                         const struct spi_device_id *id);
> > 
> > how about leaving it at just probe and have either a call or a field
> > in the device that you can look at to see if this was a new style of
> > call?
> > 
> > >       int                     (*probe)(struct spi_device *spi);
> 
> For the record, if this is going to happen I think the
> appropriate long-term solution is to have probe() take
> the device_id just as it does with other busses.

Just curious. Why you prefer another argument in the probe()
instead of calling some helper function? Most drivers don't
need the "id" argument, so why spend memory and cpu cycles
for it?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
