Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F1438DDEBD
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:35:25 +1100 (EST)
Date: Mon, 26 Nov 2007 20:40:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: sys_mpc83xx spi driver not probed
Message-ID: <20071126174023.GA17555@localhost.localdomain>
References: <4747079F.60703@fabiotec.com>
	<20071126163956.GB4408@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071126163956.GB4408@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 26, 2007 at 10:39:56AM -0600, Scott Wood wrote:
> On Fri, Nov 23, 2007 at 07:02:23PM +0200, Joel Rouch wrote:
> > I have a custom 8349 ppc board. I have defined the spi master in the 
> > configuration.
> > While booting my board, I driver is well added and linked to platform 
> > bus, however I don't see that the probe entry point is reached.
> > I don't succeed to understand who is triggering the probe. Can someone 
> > point me to the right link or explain me how to force it ?
> 
> Are you calling of_platform_bus_probe() from your board file?

spi_mpc83xx isn't of_platform_driver, yet. Thus we have to use fsl helper,
fsl_spi_init.

So far, good example of spi_mpc83xx usage is in
arch/powerpc/platforms/83xx/mpc832x_rdb.c


Good luck,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
