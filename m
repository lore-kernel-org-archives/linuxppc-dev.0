Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 427DADDF27
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 09:01:25 +1100 (EST)
In-Reply-To: <24462.1174509282@falcon10.austin.ibm.com>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
	<c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
	<46018A00.9080703@freescale.com>
	<7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
	<24462.1174509282@falcon10.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5d53b11f1325dbf6a15390407d94bc2f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses(). 
Date: Wed, 21 Mar 2007 23:01:19 +0100
To: Doug Maxey <dwm@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Just everything everywhere that mentions "mac-address" should be
>> completely and utterly eradicated :-)
>
> FYI -
> On a recent build of IBM ofw, on a 8844 booted from the ethernet@4,1
>
> find /proc/device-tree/ -path \*ethernet@4,1\*
> primero ~# find /proc/device-tree/ -path \*ethernet@4,*

> /proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/mac-address
> /proc/device-tree/pci@8000000f8000000/pci@2/ethernet@4,1/local-mac- 
> address

That's a real OF so yes it should have the "mac-address"
property if it initialised the device.

However, no consumer (except maybe a second-stage bootloader,
and even then it's dubious on modern systems) should use it;
"local-mac-address" is what you want.  Really.


Segher
