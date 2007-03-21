Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8B3ADDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 08:58:27 +1100 (EST)
In-Reply-To: <20070321202211.GA9682@lixom.net>
References: <20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
	<c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
	<46018A00.9080703@freescale.com>
	<7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
	<46018F7B.40107@freescale.com> <20070321202211.GA9682@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <514337d3f817cc0c8b14c01d08dc76a1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Date: Wed, 21 Mar 2007 22:58:21 +0100
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Are you saying that Linux should not acknowledge the existence of the 
>> mac-address
>> property, even though it's part of the OF spec?
>
> Why? It's a property of the device -- the mac address it was assigned 
> by
> the vendor.

No it's not.  That info is in the "local-mac-address"
property, instead.

"mac-address" contains the address OF used for the device;
it should only be there _if_ the firmware used the device,
and it can only be different (if it is present at all) from
the "local-mac-address" if you are on ancient hardware.

Don't use "mac-address" in flat device trees.  Use
"local-mac-address" instead.


Segher
