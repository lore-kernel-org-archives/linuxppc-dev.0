Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5407DDDFE
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 20:07:08 +1100 (EST)
In-Reply-To: <1168928704.4803.59.camel@localhost.localdomain>
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<45AA098C.70101@246tNt.com>
	<6189b01379f62aa4516484872f4ef86f@kernel.crashing.org>
	<1168810790.4803.11.camel@localhost.localdomain>
	<ccc8fbc935d8f8d3e30870d43959f6c7@kernel.crashing.org>
	<1168817449.4803.28.camel@localhost.localdomain>
	<ef64a4198a02929a00c28abb5f0934b5@kernel.crashing.org>
	<1168818533.4803.37.camel@localhost.localdomain>
	<a1af25147ea7308c394d243511b96f69@kernel.crashing.org>
	<45ABA20E.30008@genesi-usa.com>
	<528646bc0701150906o253c898dobe3b55ffb91add70@mail.gmail.com>
	<1168928704.4803.59.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <452f9e180ad06db4260fe95a765fd73f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Discussion on SOC device tree bindings
Date: Tue, 16 Jan 2007 10:07:40 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The thread started with discussion about the 5200 device tree binding
>> conventions, but has moved to a specific issue.  Now we are talking
>> about how to deal with shared registers.  ie. There are 2 I2C
>> controllers on the 5200, but they share one register.  How is that
>> best represented in the device tree?
>
>   .../i2c-core/i2c-bus@0
>               /i2c-bus@1

This describes two i2c buses under one i2c controller;
that's not the same thing.  OTOH, I suspect that's
closer to the real situation.  Grant?

> Or something like that. Make one device that encloses them all.

It's the only way to do it, the shared register can be
in the "reg" property for one device node only.


Segher
