Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id AC5CFDDE9E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 09:55:26 +1000 (EST)
Date: Tue, 03 Apr 2007 16:55:18 -0700 (PDT)
Message-Id: <20070403.165518.55726194.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <17938.57292.870224.132415@cargo.ozlabs.ibm.com>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 4 Apr 2007 09:14:20 +1000

> David Woodhouse writes:
> 
> > There are proper device numbers registered for pmac_zilog now. Use them.
> 
> Sigh.  I guess this is inevitable, but IMNSHO this exposes a weakness
> in our serial subsystem.
> 
> The problem is that this means that a user has to know "oh, the serial
> port on my computer is implemented with a Z85C30 chip, therefore it's
> /dev/ttyPZ0 not /dev/ttyS0, like it would be if the designers had used
> a 16C550".
...
> Why should a user know or care about that?  It really should be "it's
> the built-in serial port on my computer therefore it's /dev/ttyS0".

I totally agree with Paul, the onboard serial device should get
ttyS0 regardless of what hardare is used to drive it.

We dish out the minors sequentially on sparc in order to handle
the case of multiple onboard serial controllers of different
types which can happen on sparc.

Generalizing this minor number allocation for ttyS? might be the
best way to handle this.
