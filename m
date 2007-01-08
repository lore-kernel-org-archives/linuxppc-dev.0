Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F016DDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 08:19:39 +1100 (EST)
Subject: Re: 2.6.20-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20070108203258.751aa353@gondolin.boeblingen.de.ibm.com>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701051723.08112.m.kozlowski@tuxland.pl>
	<1168030536.22458.28.camel@localhost.localdomain>
	<20070105131516.bd9d8f45.akpm@osdl.org>
	<1168032284.22458.33.camel@localhost.localdomain>
	<20070108203258.751aa353@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 08:19:18 +1100
Message-Id: <1168291158.22458.224.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The idea behind this is to have a probing thread for each device that
> does the actual work (call probe for the matching drivers) so that
> multiple devices can be probed in parallel. The decision to do this can
> only be made at the bus level.
> 
> Previously, the code made it possible to have a probing thread for each
> matching driver for the same device in parallel. I didn't see any
> benefit in that, but maybe I'm just dense...

Hrm... I see. Well, I was using it from the driver because I have a
driver that needs to wait in it's probe() routing for another driver to
show up for another device (they are linked in some ways, but that is
not expressed via bus bindings).

I suppose I'll just have probe() fire off a kthread instead.

Cheers,
Ben.
