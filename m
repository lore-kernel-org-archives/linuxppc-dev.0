Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58DC467B82
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 20:15:37 +1000 (EST)
In-Reply-To: <20060923081836.GA25298@mag.az.mvista.com>
References: <A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
	<20060921133707.GA29137@gate.crashing.org>
	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
	<20060922012408.GA13820@mag.az.mvista.com>
	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
	<20060922185923.GB25738@mag.az.mvista.com>
	<74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>
	<20060923081836.GA25298@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D47FC822-2AB1-459A-B2EC-50A99552DC9A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Date: Sat, 23 Sep 2006 12:15:19 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Paul Mackerras <paulus@samba.org>, Matt Porter <mporter@embeddedalley.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> All I'm try to say is that "fw,address" is just like the "reg"  
> property
> except that it holds the effective addr not the physical addr and the
> size of the address is determined by the existence of "/cpus/64-bit"
> not #address-cells.  That's all.

Sounds good.

>> Yes.  Except a "cell" is not what you think it is.  A "cell" is the
>> size of numbers OF deals with internally; just deal with it.  Of
>> course, there's things like "#address-cells", which really mean
>> "#-32bit-things-per-address".
>
> Okay, well, when I talked about cells I meant "#-32bit-things-per- 
> address".
> Obviously it was silly of me to think that "#address-cells" meant  
> the # of
> address cells...

Some background might clear things up (or not)...  A "cell" is the
unit of data in a Forth system.  When OF was young (and not yet
called OF), all systems were 32-bit, and the 32-bit-thingies in
the properties (which weren't yet called properties) in the device
tree were called cells as well.  When 64-bit came into the picture,
everything fell apart.  The "correct" name for the property thingies
now is "integers as encoded with encode-int".  Maybe we can compromise
on calling it "property cells" or something.

The situation is even worse with "package", let's not go there :-)


Segher
