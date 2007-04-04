Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 1D259DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:21:26 +1000 (EST)
Date: Tue, 03 Apr 2007 18:21:25 -0700 (PDT)
Message-Id: <20070403.182125.77058566.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070404021924.71e87580@the-village.bc.nu>
References: <17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<20070403.165518.55726194.davem@davemloft.net>
	<20070404021924.71e87580@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: dwmw2@infradead.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 4 Apr 2007 02:19:24 +0100

> > I totally agree with Paul, the onboard serial device should get
> > ttyS0 regardless of what hardare is used to drive it.
> 
> Thats between you and udev.

That might be true when udev exists, but it doesn't for the console
specification on the kernel command line.

I don't care about ordering, but the name matters just like "eth%d"
is the default name for all ethernet devices.

Using different majors for different instances of the exact same kind
of device is really not smart.  It's a serial port, and if you try
to dress it up to be something else you run into all kinds of problems.

Not the least of which is the user has to scratch his head figuring
out what kind of chip drives his serial console, he just wants the
first serial port and he should have a way to say just that even
on the kernel command line.
