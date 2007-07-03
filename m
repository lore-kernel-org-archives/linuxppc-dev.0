Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E30B3DDEFD
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 22:34:10 +1000 (EST)
In-Reply-To: <1183423369.10386.49.camel@localhost.localdomain>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<1183423369.10386.49.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4ebbe79e6b5cda8080707d60e1fe65e8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Tue, 3 Jul 2007 14:33:34 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		addr = of_get_property(node, "reg", &len);
>>> +		if (!addr || len < sizeof(int) || *addr > 0xffff)
>>> +			continue;
>>
>> Addresses aren't 16 bit AFAIK?
>
> Some i2c busses support 10 bits addressing...

All I2C busses.  All I2C devices, too, it's just that
not all of them can decode 10-bit addresses (but they
are fine with seeing those on the bus, they'll just
never be addressed by it themselves).

Anyway, my point was that 10 isn't the same as 16.


Segher
