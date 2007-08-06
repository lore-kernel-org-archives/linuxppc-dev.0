Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39D4EDDE24
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 03:16:40 +1000 (EST)
In-Reply-To: <46B07F04.8040806@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<46A79DE0.8060405@ru.mvista.com> <46A79F14.9040409@freescale.com>
	<46A7A17C.8090505@ru.mvista.com> <46A7A1D5.7020003@freescale.com>
	<46A7A5E4.4090105@ru.mvista.com>
	<d04530fcd6e879e0bc059049b7951aef@kernel.crashing.org>
	<46B07F04.8040806@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ef909c9835ecc57be4f4fa7fdc405889@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [IDE] Platform IDE driver
Date: Mon, 6 Aug 2007 19:16:27 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> More importantly, "reg-shift" doesn't say what part of
>> the bigger words to access.  A common example is byte-wide
>> registers on a 32-bit-only bus; it's about 50%-50% between
>> connecting the registers to the low byte vs. connecting it
>> to the byte with the lowest address.
>
>    We already have "big-endian" prop used in MPIC nodes, IIRC. Could 
> try to "reuse" it here as well...

Sure.  This would be an okay way to handle legacy devices that
are connected in inventive ways: add "reg-shift" and/or "big-endian"
properties.  We should make sure this is documented in the
appropriate bindings though, don't just assume it will work.

For non-legacy devices, please just use the "compatible"
property to figure out the endianness etc.; it is a bad idea
to make a "blablabla-big-endian" compatible value, but you can
almost often just use a more specific model name instead; and
typically the device has some other quirks anyway ;-)

>> It would be nice to not name similar properties in the
>> device tree dissimilarly.  Kernel code doesn't come into
>> the picture here.
>
>    The "reg-shift" prop is yet unaccepted ad-hockery at this point. ;-)
>    So, I don't see why we have to be consistent with it.

Don't treat your ad-hockery ad hoc, that way leads to insanity :-)

It's quite important to use good names for all new properties
you define, so you naturally end up with similar names for
similar purposes.  Of course it isn't a *requirement*, you're
right about that.


Segher
