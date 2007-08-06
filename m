Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E950DDE43
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:30:35 +1000 (EST)
In-Reply-To: <200708052357.32650.arnd@arndb.de>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
	<E1IHnhY-0008PO-IZ@jdl.com>
	<Pine.LNX.4.60.0708052336360.4120@poirot.grange>
	<200708052357.32650.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1288ff079974aa806119584018bab973@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Mon, 6 Aug 2007 21:29:55 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Maybe the best solution would be for 824[15] to not claim compatibility
> with 8250 at all then.

Or at least it should have a more specific entry for this
"special" 16x50 UART, and that one should be probed first.

> If the device tree contains an entry that matches
> what the generic driver looks for, it better be something that can
> be handled by that driver.

Pretty much; you can't make this rule too strict though,
if a device mostly works with the generic driver, you can
claim compatibility with it -- keep in mind that that can
come back to bite you though, like in this case.  The
advantages do outweigh the disadvantages sometimes, it's
all a tradeoff; avoid it if possible.


Segher
