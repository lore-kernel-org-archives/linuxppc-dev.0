Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 44625DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 00:09:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] 82xx: SBCPQ2 board platform support
Date: Tue, 17 Jul 2007 15:17:00 +0200
References: <469B3401.9030602@windriver.com> <200707171419.05061.arnd@arndb.de>
	<1184679661.18501.41.camel@mark>
In-Reply-To: <1184679661.18501.41.camel@mark>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707171517.00649.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 17 July 2007, Mark Zhan wrote:
> 
> Since the rtc m48t59 driver has already gone into the -mm source tree,
> and I think, it is an ugly way to make the irq handler a global
> function:-)
> 
> If the driver is not built-in, and I still get the mach check exception,
> it will turn out that other factors are causing mach check exception,
> then just like my original codes, the kernel will not survive this
> machine check, right?

Ok, I missed the point that you also have real machine check events
to care about.

One issue remains though: you still need to have a virtual irq number,
not just make up a IRQ, as there is nothing that guarantees this to work.

Since you already create your own irq_host, you can probably just
give the fake irq the number '1' here, which is local to that host.
Then you call irq_create_mapping() to create the virtual interrupt
number that you pass to the platform_device.

	Arnd <><
