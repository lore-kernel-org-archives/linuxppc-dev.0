Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DE8ADE0C4
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 08:13:29 +1000 (EST)
In-Reply-To: <468FC849.20801@ru.mvista.com>
References: <1183784308.3066.16.camel@shinybook.infradead.org>	<200707071410.14998.arnd@arndb.de>
	<1183827083.3066.64.camel@shinybook.infradead.org>
	<468FC849.20801@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E944F7CC-A222-4C8F-9F8E-A970DD87B43D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
Date: Sun, 8 Jul 2007 00:12:09 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Given the existence of the boards, it looks correct to do this.
>>> However, I wonder if it was correct for the MV64660 to claim
>>> compatibily witn ns16550 if the programming model is not exactly
>>> the same. The official OF serial port bindings don't mention the
>>> reg-shift property, so it maybe would have been better to have
>
>    I'd preferred "reg-stride" or "reg-size" but see below...

It is not the register size.  "Register spacing" is the most
common name I believe, but "register shift" is nicer for
computer programs.

>>> a different value for the "compatible" property, in order not
>>> to confuse existing operating systems that implement the standard.
>
>> Ok, how about 'sparse16550'? Otherwise identical to ns16550, but with
>
>     Erm, wouldn't it be *too* generic approach?  I'd suggest to  
> name the
> device with its own name and make of_serial.c recognize it and  
> register with
> 8250.c as needed.

Yes, name the device by its real name, *please*.

>> the reg-shift property. I'll send a patch shortly, and I'll  
>> reorder the
>> match table -- if something claims compatibility with both 8250 and
>> 16550, shouldn't we drive it as the latter?
>
>     Certainly. BTW, was there really "ns8250" -- 8250 is Intel's chip?

It should be "i8250" yes.  Not that you'd ever find any anymore
of course.  And in many cases, it should be "pnpPNP,xxx" anyway.


Segher
