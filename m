Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3260DE038
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:42:45 +1000 (EST)
In-Reply-To: <20070803063532.GB14456@localhost.localdomain>
References: <20070627065335.GD11191@localhost.localdomain>
	<20070627071008.GA30648@localhost.localdomain>
	<b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
	<20070628100020.GA24215@iram.es>
	<20070803063532.GB14456@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4d4b2d7064b052024d37a11a580e51a6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Date: Mon, 6 Aug 2007 21:42:34 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +			PIC8259: interrupt-controller {
>>> +				device_type = "i8259";
>>>
>>> device_type = "interrupt-controller".
>
> Is that really right?  The MPIC binding, at least, has device_type =
> "open-pic" rather than "interrupt-controller".

I got confused.  "open-pic" as device_type is nonsense, because
it doesn't define anything an OF can work with itself.  However,
since some older interrupt controller bindings (pre-imap) define
a device_type, the interrupt mapping recommended practice had to
work around this, so it specified an empty "interrupt-controller"
property for all interrupt controller nodes.

I don't know what the specified device_type for 8259s is; it
seems to me you don't need it in a flat device tree at all.

>>> +		MPIC: interrupt-controller@d {
>>> +			device_type = "open-pic";
>>>
>>> device_type = "interrupt-controller".
>
> Not according to the binding in booting-without-of.txt

Yeah, mea culpa.  Again, you can just leave it out I think.


Segher
