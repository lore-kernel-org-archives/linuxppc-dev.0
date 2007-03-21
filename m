Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8521DDF5C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 06:48:40 +1100 (EST)
In-Reply-To: <46018A00.9080703@freescale.com>
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
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
Date: Wed, 21 Mar 2007 20:48:25 +0100
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

>> No, I'm saying that you shouldn't use "mac-address" for
>> something it isn't meant for.
>
> If the property exists in the device tree, then it should be used, no? 
>  Whether or not it exists is not for the driver to decide.

The property doesn't describe anything about the device;
it merely tells you something about what the firmware did
during booting.  How or what you use it for later is a
policy decision -- you could for example reuse the address
instead of doing a new RARP sequence.  Big deal nowadays.

> What I hope to do is remove all traces of mac-address from the device 
> trees.

We share that goal :-)

> If it's not in the DTS, then U-Boot won't add it, bootwrapper won't 
> add it, the kernel won't add it, and therefore it won't exist when the 
> driver loads, so the driver won't use it.
>
>> You aren't supposed to have a "mac-address" property for
>> devices that weren't used during firmware execution / booting
>> _at all_.
>
> I can't tell if we agree or disagree.  Perhaps you should look at the 
> code and tell me what needs to be changed?

Just everything everywhere that mentions "mac-address" should be
completely and utterly eradicated :-)

And sure I understand you have to change one component at a
time -- seems to me uboot is the first step to fix?


Segher
