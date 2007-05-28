Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8DB58DDF61
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 21:06:40 +1000 (EST)
In-Reply-To: <20070527233031.GB23768@localhost.localdomain>
References: <20070524041625.GD20078@localhost.localdomain>
	<BB9A8C3A-0BC5-4DF0-9201-2742124A4AF5@kernel.crashing.org>
	<1180014260.3360.14.camel@zod.rchland.ibm.com>
	<20070525042359.GE13575@localhost.localdomain>
	<20070525043728.GG13575@localhost.localdomain>
	<20070525043852.GH13575@localhost.localdomain>
	<25433b8fc06678e73ee055ed4f44f7a3@kernel.crashing.org>
	<20070527233031.GB23768@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3b1087a7734a3836346e181eef4b606a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
Date: Mon, 28 May 2007 13:06:11 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> 	- Second, the PHYs give only "bcm54xx" as a compatible
>>> property.  This is unfortunate, because there are many bcm54xx PHY
>>> models, and they have differences which can matter.  We add a more
>>> precise compatible string, giving the precise PHY model (bcm5461A in
>>> this case).
>>
>> You completely removed the "compatible" properties instead.
>> Bad idea.
>
> Um... weren't you the one that was just saying compatible properties
> aren't necessary if you can distinguish the hardware in other ways?

The OS device driver doesn't need "compatible" if it
can probe the device some other way; it doesn't need
the device node at all, even.  You still should have
a "compatible" property (or, old style, a specific
"name" property) if you want the OS to be able to use
the device node to recognise the device (i.e., if a
device node for the device exists at all: always).


Segher
