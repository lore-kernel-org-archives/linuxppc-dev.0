Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F07CFDDF45
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:14:35 +1000 (EST)
In-Reply-To: <467176EB.7060404@ru.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Fri, 15 Jun 2007 10:14:24 +0200
To: Vladislav Buzov <vbuzov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Are these errata 7448-only?  If not, I wonder what is
>> done on PowerMacs?
>
> This is a errata for 7448 only. I've looked through errata for other=20=

> 7450 processors (7450, 7457) and they contain the same erratum for L2=20=

> cache: "L2 hardware flush may not flush every line from the L2 cache"=20=

> The workaround for this problem is: "Set the IONLY and DONLY bits in=20=

> the L2CR prior to the L2 hardware flush", and the projected solution=20=

> is: "The workaround has been documented in the MPC7450 RISC=20
> Microprocessor Family User=92s Manual as the correct way to flush the =
L2=20
> cache"

Okay, so it is for all members of the 7450 family.  Good :-)

>> Looks reasonable enough to me...  if it works (on all
>> things considered "7450" by the kernel).
>
> I've double checked this. All processors considered 7450 in the kernel=20=

> are covered by MPC7450 RISC Microprocessor Family Reference Manual=20
> where hardware cache flushing procedure is described.

Nice.  Now all that remains to be done is for the patch to
be tested on actual hardware for at least a few of those
other CPUs.  Any volunteers?

>>>      /* TODO: use HW flush assist when available */
>>
>> You want to get rid of this old comment though -- and
>> perhaps branch over the non-hardware-assisted cache
>> flushing code.
>
> Ok, I agree that the comment is obsolete now. Would you please explain=20=

> why the branch over non-hardware-assisted code should be removed as=20
> well. Technically the cache is flushed and there is no need to use=20
> extra commands to fill and then re-flush the cache.

I said such a branch should be added, not removed -- it
appears from your reply that you are skipping it already
and I just missed it?


Segher
