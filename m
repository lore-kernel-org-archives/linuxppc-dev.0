Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AC2CAB7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 12:12:53 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 24955DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 12:12:52 +1000 (EST)
Date: Thu, 30 Jul 2009 06:12:50 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 1/7] spi: Add support for device table matching
Message-ID: <20090730021250.GA12001@oksana.dev.rtsoft.ru>
References: <20090729170345.GA26787@oksana.dev.rtsoft.ru>
	<20090729170457.GA4803@oksana.dev.rtsoft.ru>
	<20090729214446.GB1728@fluff.org.uk>
	<20090729223223.GA15280@oksana.dev.rtsoft.ru>
	<20090729224050.GA17902@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090729224050.GA17902@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>,
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

On Thu, Jul 30, 2009 at 02:40:50AM +0400, Anton Vorontsov wrote:
[...]
> - If you don't store "id" in the device struct, you'll have
>   to look up the device table twice (at first during bus->match(),
>   and second time in drivers' probe() hook, i.e.
>   probe(struct bus_dev *dev) {
>   	id = bus_get_devid(dev); /* here */
>   }

Hm... actually, we're doing this anyway, but in spi core.

So, doing something like spi_get_device_id() might be a good
idea.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
