Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12AEADDEEA
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 06:20:00 +1000 (EST)
In-Reply-To: <463CC0A4.5040407@ru.mvista.com>
References: <20070501051804.GB3881@localhost.localdomain>
	<4639CBD8.6010205@ru.mvista.com>
	<20070503123055.GE26659@localhost.localdomain>
	<4639DDE1.40904@ru.mvista.com>
	<71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
	<463A1941.3090608@ru.mvista.com> <463A2192.6020308@ru.mvista.com>
	<e21cca984c076474a6e89018a198d93a@kernel.crashing.org>
	<20070503235620.GB28599@localhost.localdomain>
	<463CC0A4.5040407@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0146e2d237b2024968c17c021efb1174@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Date: Sat, 5 May 2007 22:19:51 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> But if the flash really is on an external bus controlled by a bus
>> controller on the SoC, it sounds like it should go under that bus
>> bridge.  In which case the SoC would need another range in its ranges
>> property.
>
>    Erm, how multiple memory ranges are supposed to work? Aren't the 
> addresses in the "reg" property of subnodes relative to the "ranges" 
> property?

If the address space of a child bus is a subset (perhaps
after some mapping) of the address space of the parent bus,
the "ranges" property in the parent node describes that
subset (and mapping).  If the address spaces are identical,
this is expressed by an empty "ranges" property.  If there
is no such mapping (indirect register access, for example),
this is expressed by the absence of a "ranges" property.

There can be multiple ranges in a "ranges" property, that's
why it's called "ranges" and not "range".  A common example
is the "ranges" property in PCI bus nodes (if those have
both a memory and legacy I/O range; for host bridges, this
means that both those ranges are direct mapped).

I hope this answered your question, it was a bit vague.


Segher
