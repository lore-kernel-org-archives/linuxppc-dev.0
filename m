Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 969ADDDEE1
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:12:37 +1000 (EST)
In-Reply-To: <20070906084109.315544ea@zod.rchland.ibm.com>
References: <20070905181703.GA30904@ru.mvista.com>
	<20070905160008.201a243a@vader.jdub.homelinux.org>
	<b9fb2fad5d6b04a07996416842df7f72@kernel.crashing.org>
	<20070906081732.079bc45d@zod.rchland.ibm.com>
	<46E000E0.4080203@ru.mvista.com>
	<20070906084109.315544ea@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f6be8e61e378a9358eb60f2fb0042592@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF NDFC
Date: Thu, 6 Sep 2007 16:06:20 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> AFAIK, NAND flash is autodetected by reading it's ID at runtime, so
>> there should be no need for flash bindings.
>
> Well, I'm not really sure.  CFI and JEDEC can both be probed as well,
> and we're working on a binding there.

JEDEC cannot be reliably probed.  CFI can be _almost_ probed,
you need to know the interleaving though, to handle some edge
cases.  Oh, and you need to know it _is_ CFI, of course.

> But if you think you can come up
> with a driver for NDFC that doesn't require some kind of device tree
> description of the devices it controls, then by all means go for it.

I don't know whether NAND can be reliably probed; most "standard"
NAND devices can be, but I don't know what standards are involved
here, if any.  We'll need some MTD people help here.

OTOH, it definitely is better to describe only the NAND controller
and not the devices, than to put nothing at all in the device tree.
We had this same situation with NOR flash before, already...


Segher
