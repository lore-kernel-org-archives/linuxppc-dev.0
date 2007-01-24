Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0676EDE213
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 09:18:56 +1100 (EST)
Message-ID: <45B7DB47.4070400@freescale.com>
Date: Wed, 24 Jan 2007 16:18:47 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 03/18] Set -msoft-float and assembler target options in
	the bootwrapper.
References: <20070124210704.GC10527@ld0162-tx32.am.freescale.net>
	<52B7EC8B-85EB-408C-97B7-806F8822B7A3@kernel.crashing.org>
In-Reply-To: <52B7EC8B-85EB-408C-97B7-806F8822B7A3@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> Without -msoft-float, floating point state saving code can be executed
>> (at least with certain buggy versions of GCC, which don't clear bit  6 of
>> CR before calling a varargs function with no varargs parameters).
> 
> 
> I have a hard time understanding what this means.  Can you
> elaborate please?

The PowerPC ABI uses bit 6 of CR to indicate to a varargs function 
whether one (or more) of the varargs parameters is floating point.  This 
is used (among other things) by the varargs function to determine 
whether to save a floating point context.  Normally, GCC will clear the 
bit when calling a vararg function with integer-only parameters, but at 
least some versions (I saw it on 3.4.3) will not touch the bit at all 
when the varargs list is empty.

Since the functions in string.S use cr1 (which contains bit 6), this 
caused a fault on e500 (which doesn't have a normal floating point unit) 
when I called strcmp() followed by printf() of a bare string with no 
other arguments.

>>  AFLAGS += $(cpu-as-y)
>>  CFLAGS += $(cpu-as-y)
>> +export cpu-as-y
> 
> 
> Maybe it would be better to export CFLAGS instead (on the
> other hand, you might have to cut out some options from it
> for 32-bit compiles, dunno).

That'd also bring in the normal Linux headers, which the bootwrapper 
appears to be trying to avoid.

-Scott
