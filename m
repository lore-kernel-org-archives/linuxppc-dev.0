Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 4F008DDE0F
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 07:57:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 5 Aug 2007 23:57:32 +0200
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
	<E1IHnhY-0008PO-IZ@jdl.com>
	<Pine.LNX.4.60.0708052336360.4120@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0708052336360.4120@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708052357.32650.arnd@arndb.de>
Cc: Jon Loeliger <jdl@jdl.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> 
> > I supect it will have the same issue in the end, right?
> 
> ...if you choose to use of_serial.c, yes, if you don't use it and just use 
> legacy_serial.c, then you're fine.

But of_serial can be a loadable module, which means you still get into
trouble if you load it, even if the port was originally initialized
by legacy_serial.

Maybe the best solution would be for 824[15] to not claim compatibility
with 8250 at all then. If the device tree contains an entry that matches
what the generic driver looks for, it better be something that can
be handled by that driver.

	Arnd <><
