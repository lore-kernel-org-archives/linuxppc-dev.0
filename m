Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21DDDDDEF9
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 15:48:16 +1100 (EST)
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
In-Reply-To: <200810221404.52798.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081022104606.GA510@oksana.dev.rtsoft.ru>
	<20081022183218.GA19025@oksana.dev.rtsoft.ru>
	<200810221404.52798.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 15:45:45 +1100
Message-Id: <1224737145.7654.387.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-22 at 14:04 -0700, David Brownell wrote:
> > So if we register the board infos after 
> > the controller registered, then nobody will probe the board infos.
> 
> See above.  If you're doing it right, there's no problem.
> That is, scan the OF tables early.  Just like PNP tables
> get scanned early, for example.

It's still pretty yucky in that case to scan the device-tree to convert
it into some kind of fugly board info ... I'd rather have the end
drivers that actually use those GPIOs scan the device-tree directly.

But then, I'm not a believer in generic drivers for things like GPIOs,
i2c devices, etc.. :-)

Ben.
