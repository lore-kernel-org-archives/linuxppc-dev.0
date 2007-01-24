Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93B6BDDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 09:46:11 +1100 (EST)
In-Reply-To: <45B7DB47.4070400@freescale.com>
References: <20070124210704.GC10527@ld0162-tx32.am.freescale.net>
	<52B7EC8B-85EB-408C-97B7-806F8822B7A3@kernel.crashing.org>
	<45B7DB47.4070400@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <74B54E3F-5436-4D9E-85E2-563CA7F22D94@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 03/18] Set -msoft-float and assembler target options in
	the bootwrapper.
Date: Wed, 24 Jan 2007 23:45:46 +0100
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Without -msoft-float, floating point state saving code can be  
>>> executed
>>> (at least with certain buggy versions of GCC, which don't clear  
>>> bit  6 of
>>> CR before calling a varargs function with no varargs parameters).
>> I have a hard time understanding what this means.  Can you
>> elaborate please?
>
> The PowerPC ABI uses bit 6 of CR to indicate to a varargs function  
> whether one (or more) of the varargs parameters is floating point.   
> This is used (among other things) by the varargs function to  
> determine whether to save a floating point context.  Normally, GCC  
> will clear the bit when calling a vararg function with integer-only  
> parameters, but at least some versions (I saw it on 3.4.3) will not  
> touch the bit at all when the varargs list is empty.

Gotcha.  Now, should a varargs function that doesn't get passed
any actual varargs use that bit at all?  If not, the Linux printf()
(or some support function) is broken; if so, is this fixed in later
GCC versions?  If not, please report it (http://gcc.gnu.org/bugzilla).

>>>  AFLAGS += $(cpu-as-y)
>>>  CFLAGS += $(cpu-as-y)
>>> +export cpu-as-y
>> Maybe it would be better to export CFLAGS instead (on the
>> other hand, you might have to cut out some options from it
>> for 32-bit compiles, dunno).
>
> That'd also bring in the normal Linux headers, which the  
> bootwrapper appears to be trying to avoid.

Right.  cpu-as-y is an ugly name to export though, let's use a
better name (that explains what it's for -- PLATFORM-AFLAGS or
something like that).


Segher
