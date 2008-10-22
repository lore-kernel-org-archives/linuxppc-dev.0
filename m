Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE3B7DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 13:30:39 +1100 (EST)
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081022014243.GA19362@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810171324.42650.david-b@pacbell.net>
	<20081017212942.GA1919@oksana.dev.rtsoft.ru>
	<200810200029.58312.david-b@pacbell.net>
	<20081020154835.GA3234@oksana.dev.rtsoft.ru>
	<1224635360.7654.294.camel@pasglop>
	<20081022010347.GA7377@oksana.dev.rtsoft.ru>
	<20081022014243.GA19362@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 13:28:17 +1100
Message-Id: <1224642497.7654.319.camel@pasglop>
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

On Wed, 2008-10-22 at 05:42 +0400, Anton Vorontsov wrote:
> 
> Thinking about it more, I started recalling other issues. The bus
> notifier chain doesn't replay previous events, so we also have to
> register the notifier before the _devices_ are registered. And this
> ruins the whole approach. :-/ Yeah, that's why I abandoned the bus
> notifier idea.

The notifier can be registered before the devices, though it's a little
bit fishy and fragile.

Easier I suppose to just have OF specific hooks in the bus code.

Ben.
