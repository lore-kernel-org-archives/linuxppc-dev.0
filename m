Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E795DDF8C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 00:39:23 +1100 (EST)
In-Reply-To: <20070318115656.GA12765@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4efa309babf03924b549b5c84436e33b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Date: Wed, 21 Mar 2007 14:38:16 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Well, first, details shmetails.  It's the interface and approach I
> thin is better.  Second, I don't think the zImage should be setting
> mac-address anyway.  In OF that property is based on what the
> interface has been used for during booting, which the zImage doesn't
> know.  The kernel doesn't need mac-address if local-mac-address is
> present, so we should just leave it out.

Exactly.  "mac-address" is mostly historical anyway, from the
time that people used RARP and such.  Nowadays, almost any network
interface on any board has a statically assigned MAC address and
so should use "local-mac-address".

It would be a good idea to remove any mention of "mac-address"
from the kernel :-)

>> Also, in the future, we hope to eliminate *all* MAC
>> address entries from the DTS files, and the boot loader and/or
>> bootwrapper will add one.

There *are* use cases for setting it statically in the DTS
(bring up activities, ...) -- so please don't make it
impossible to do so.

But yes, no "shipping" DTS should have it, preferably.


Segher
