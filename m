Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id A54D8DDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 18:57:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: leoli@freescale.com
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Date: Fri, 29 Aug 2008 10:57:20 +0200
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<200808281704.20999.arnd@arndb.de>
	<1220000265.30607.10.camel@Gundam>
In-Reply-To: <1220000265.30607.10.camel@Gundam>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808291057.20612.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net,
	greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 August 2008, Li Yang wrote:
>=20
> > Not a problem, but an observation: Most new code uses work queues inste=
ad
> > of tasklets these days, which gives you more predictable real time
> > latencies.
> > If you don't have a specific reason to prefer a tasklet, just use
> > a workqueue here.
>=20
> Is this truly a trend? =A0Work queue is more flexible but it has higher
> latency. =A0Why are work queues preferred?

Most drivers don't need the low irq to bottom half latency. As I said,
not a problem at all, just my observation. In 2.6.27, we have around
three times more new workqueue usages than new tasklet usages. My
feeling from doing reviews was that it would be closer to a factor
of ten, but I guess I was wrong in that.

	Arnd <><
