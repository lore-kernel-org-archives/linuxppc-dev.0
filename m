Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 363FF67B9A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 01:31:30 +1000 (EST)
In-Reply-To: <20060921133707.GA29137@gate.crashing.org>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
	<20060921133707.GA29137@gate.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Date: Thu, 21 Sep 2006 17:31:18 +0200
To: Matt Porter <mporter@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On PPC44x (and other PowerPC processors) the number of address cells
> to represent a virtual address and a physical address differ due the
> 36-bits of physical address space.

The number of virtual address cells is always 1.  A cell isn't always
32-bits though.  Want more confusion?  Lots of properties are called
"<something>-cells" etc., but those names are historical; the proper
name for the things encoded in properties is "32-bit integers".

> Regardless of the name of the
> new property, it should be defined to allow a different number of
> address cells to represent an address in virtual address space.

How about you check whether the "64-bit" property exists in the CPU
nodes?

>> (*)  This isn't strictly correct, but OF doesn't describe the size of
>> virtual addresses anywhere.  In practice, it's the same as the size
>> of physical addresses always.  Oh, and the name "virtual" isn't  
>> correct
>> in PowerPC-speak anyway, heh.
>
> Actually, in practice, it's not always the same size as a physical
> address. We have 36-bit physical addressing systems in the real world.

Darn, and you have #address-cells = 2 in the root node?  It's allowed,
sure.

> FWIW, I'd be happy with this property name or fw,address. When we
> discussed this on IRC the thought was to conform to what already
> existed for this purpose in the OF spec. Since the address prop sounds
> like it will confuse some people I think it makes sense to add a
> new property (might as well just throw out the spec :P).

But if you do make something new, you'll have to make it better
than what you're replacing, or what's the point :-)


Segher
