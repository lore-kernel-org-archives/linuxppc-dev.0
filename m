Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21944DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 13:28:40 +1100 (EST)
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081022010347.GA7377@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810171324.42650.david-b@pacbell.net>
	<20081017212942.GA1919@oksana.dev.rtsoft.ru>
	<200810200029.58312.david-b@pacbell.net>
	<20081020154835.GA3234@oksana.dev.rtsoft.ru>
	<1224635360.7654.294.camel@pasglop>
	<20081022010347.GA7377@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 13:27:14 +1100
Message-Id: <1224642434.7654.317.camel@pasglop>
Mime-Version: 1.0
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-22 at 05:03 +0400, Anton Vorontsov wrote:
> If say "X" driver loads prior to bus-notifier module (where we fill
> the platform data), then X.0 device will try to probe w/o platform
> data and will fail. The only way to re-probe things is to rmmod X &&
> insmod of_pdata_filler_X && insmod X. So things depend on the module
> load order.
> 
> The obvious solution is to link the OF stuff into the module, but
> this also won't work, since modules have only one entry (and exit)
> point. So there is no way* to hook our OF helpers into the module.

Well, right, we need the bus notifier to be registered before any
device gets added ... which mean from the same module_init that
registers the bus itself. A bit annoying ...

> * Well, there is one solution to this problem. We can implement
> arch-specific init_module and cleanup_module entry/exit points,
> where we can load/unload the OF hooks. This is quite easy, but
> may look ugly. I could show the drafts.

Yuck :-)

Cheers,
Ben.
