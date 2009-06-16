Return-Path: <dwh@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F1297B71BD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 05:02:46 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 37EB5DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 05:02:46 +1000 (EST)
Message-ID: <4A37EC4F.7060900@ovro.caltech.edu>
Date: Tue, 16 Jun 2009 12:02:39 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>	
	<4A37C88F.8040701@ovro.caltech.edu>
	<c384c5ea0906160959v1fde484av8cff4916cacb84cc@mail.gmail.com>
In-Reply-To: <c384c5ea0906160959v1fde484av8cff4916cacb84cc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leon,

>>> Most MPC8xxx board designs I have seen suffer from this possible dead
>>> lock:
>>> - NOR Flash is put in erase mode or write mode
>>> - Hardware watchdog triggers
>>> - HRESET# is asserted by the processor, during which the configuration
>>> words are read from NOR Flash.
>>>
>>> Either
>>> HRESET# is not attached to NOR, NOR stays in erase/write mode and
>>> invalid words will be read -> dead lock
>>>
>>> or either:
>>> HRESET# is attached to NOR reset, NOR is reset, but stays in reset as
>>> HRESET# stays asserted.
>>>
>>> We have been looking at several solutions hardware wise that reset the
>>> NOR flash on HRESET# going low, but the processors are stubborn,
>>> read the config words only once, than dead lock.
>>>
>>> I wonder if there are known-working designs for this.
>> What do you do in the case of blank flash on a board?
>>
> The problem is not with blank flash or firmware upgrades, we know how
> to handle that.
> 
> Your solution is (a solution) to a different problem.
> 
> The problem lies in the fact that board dead lock can occur if the
> watchdog triggers, for all reference designs I have seen.
> 
> Thanks for thinking along.  I would like to solve the original problem though.
> BTW, we use CPLD/FPGAs on most of our boards, this one we do not for
> cost reasons.

So we're talking about the sequence where HRESET# asserts as
in say the logic analyzer trace on p34:

http://www.ovro.caltech.edu/~dwh/carma_board/powerpc_mpc8349e.pdf

the LALE pulse where the processor reads the RCWs occurs very
soon after the falling edge of HRESET#.

So the Flash needs to be reset to ensure that it is in
read-array mode, so that the processor doesn't choke.
Since HRESET# is still low, thats no good. A pulse
generator that is based on HRESET# might work, but
the pulse would have to be long enough to meet any
reset requirement of the flash, yet short enough so
that the read of the first RCW would be valid. Since
the local bus is running really slow at this point,
I think that could be done ok.

How about a set-reset flip flop that is set on the
falling edge of HRESET# and cleared on the rising
edge of LALE. That'll produce a decent reset
pulse to the flash, and then there is plenty of
time for the first access to produce valid data
on the bus.

Cheers,
Dave
