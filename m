Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B1C60DE06E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 15:51:24 +1000 (EST)
Date: Tue, 19 May 2009 22:51:18 -0700 (PDT)
Message-Id: <20090519.225118.58497608.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: Musings on PCI busses
From: David Miller <davem@davemloft.net>
In-Reply-To: <1242788490.16901.133.camel@pasglop>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<1242788490.16901.133.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 20 May 2009 13:01:30 +1000

> For example, some of the OF parsing bits may fail to convert memory
> addresses to IO addresses if the PCI host bridges have not been
> discovered yet, potentially causing issues with matching of resources
> between the early serial stuff and the generic serial driver (if you
> use an IO driven UART, the PCI 8250 driver may not properly figure out
> that what it's finding in its IO BARs is actually the same port as
> what it gets from the platform code as the later will end up with
> memory addresses rather than IO ones). That's one example.

FWIW, I never run into this issue on sparc64 exactly because I
fully resolve all resources when I populate the OF device tree
in the kernel.
