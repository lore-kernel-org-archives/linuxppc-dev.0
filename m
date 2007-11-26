Return-Path: <cbou@mail.ru>
Received: from mx3.mail.ru (mx3.mail.ru [194.67.23.149])
	by ozlabs.org (Postfix) with ESMTP id 2E686DDF00
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 11:41:32 +1100 (EST)
Date: Mon, 26 Nov 2007 03:34:56 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce pata node, make
	use pata_of_platform driver
Message-ID: <20071126003456.GA20130@zarina>
References: <20071123175229.GA27143@localhost.localdomain>
	<20071123175356.GC27338@localhost.localdomain>
	<200711242157.47303.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200711242157.47303.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Reply-To: cbou@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 24, 2007 at 09:57:46PM +0100, Arnd Bergmann wrote:
> On Friday 23 November 2007, Anton Vorontsov wrote:
> > 
> > +static struct of_device_id mpc834x_ids[] = {
> > +       { .compatible = "pata-platform", },
> > +       {},
> > +};
> > +
> > +static int __init mpc834x_declare_of_platform_devices(void)
> > +{
> > +       if (!machine_is(mpc834x_itx))
> > +               return 0;
> > +
> > +       of_platform_bus_probe(NULL, mpc834x_ids, NULL);
> > +
> > +       return 0;
> > +}
> > +device_initcall(mpc834x_declare_of_platform_devices);
> 
> This is not really how of_platform_bus_probe was meant to be used.
> Instead of listing the device you want to probe, you should list
> all buses that potentially contain a device that you are probing.

Yup, I sort of knew it. For mpc8349emitx, pata node should be in
the localbus node. But there is no localbus node yet... I'll fix
that issue in the next round of these patches.


Much thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
