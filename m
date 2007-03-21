Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 470EADDF19
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 06:07:28 +1100 (EST)
In-Reply-To: <46014BF5.6060509@freescale.com>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <995355b28eecaafe955a5628ee939340@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Date: Wed, 21 Mar 2007 20:07:21 +0100
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > It's a layering violation anyway, a device
>> driver has no business peering at "mac-address", that's info
>> for a way higher layer ;-)
>
> Eh, I don't think I agree with that.  mac-address is supposed to be 
> used if it exists, because it represents the "most recent MAC 
> address".

That's policy and belongs in user land, not in the kernel,
and certainly not in a device driver.

> I don't see this code changing ever, because we're always going to 
> need to support older device trees

No you don't.  People who need to stick with an older dev
tree can stick with an older bootwrapper and kernel too.

Or if you *have* to support broken device trees, you should
fix them up in the bootwrapper so the kernel doesn't have to
be aware of them.


Segher
