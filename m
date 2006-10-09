Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F2C767B56
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 00:21:56 +1000 (EST)
In-Reply-To: <20061009002945.GA2259@localhost.localdomain>
References: <20061004033753.GB20636@localhost.localdomain>
	<3711678A-7AA9-493F-B046-2F459604C028@kernel.crashing.org>
	<20061009002945.GA2259@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <811124BA-A99B-46B9-9A16-4111D937468E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc: Fix make rules for dtc
Date: Mon, 9 Oct 2006 16:21:31 +0200
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

>>>  clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
>>> -		$(obj)/empty.c
>>> +		$(obj)/empty.c *.dtb
>>
>> If this wildcard works at all, it will still do the wrong thing:
>> deleting all .dtb files (even the ones that the Makefile cannot
>> create again, e.g., the user put them in the tree manually) is
>> at best not very polite.
>
> It certainly works at all

My problem with it is the := which might be expanded at the wrong
time.  Or maybe that won't glob the *.dtb yet, who knows.  It's
not obviously "working" either way.

> (the preceding $(obj)/empty.c, however, is
> wrong, I've sent a separate patch for that).  One could say the same
> thing for *.o in clean targets,

Yes, and that's a very well-known problem.

> though I guess adding .dtb files is
> rather more likely.  However, I can't seen an obvious way of
> generating a list of the re-creatable dtbs, without an explicit
> listing of every file in arch/powerpc/boot/dts which sounds like a bit
> of a pain.  Suggestions?

You shouldn't clean _all_ dtb's that you could build, only the dtb's
that you _did_ build.  You already have a rule for what dtb's to
build I assume; just copy the logic from there.


Segher
