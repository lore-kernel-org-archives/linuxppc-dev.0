Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 245D6DDFC4
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 04:38:35 +1100 (EST)
In-Reply-To: <20080404052955.GC11799@lixom.net>
References: <20080403190943.GA16446@ru.mvista.com>
	<1207259436.10388.337.camel@pasglop>
	<20080404052955.GC11799@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9d19fecb0ef172995b7ce3a317ee3c0d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: MPIC ack interrupts at mpic_teardown_this_cpu()
Date: Fri, 4 Apr 2008 19:38:27 +0200
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> We really need to ack interrupts at mpic_teardown, since
>>> not all platforms reset mpic at kernel start-up. For example,
>>> kexec'ed kernel hangs on P.A. Semi if mpic_eoi() isn't called.
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>>> ---
>>
>> Would be interesting to find out why it hangs tho... it shouldn't .
>
> I haven't reproduced the problem and looked at hardware state yet, but 
> I
> would expect it to be because the openpic won't send another interrupt
> until the previous is EOI'd, and the IPI is never EOI'd as far as I
> can tell.
>
> The XICS code does it explicitly already. I'm surprised it doesn't 
> break
> on the 970-based platforms actually...

platforms/maple/setup.c and platforms/powermac/pic.c use 
MPIC_WANTS_RESET.
Is there a reason why we don't do that on every MPIC?  If there is such
a reason, the default should be to reset, only pseries and chrp and cell
and now pasemi do not use it.  It's the only sane way to get an MPIC 
into
a sane known state starting from <whatever> state.


Segher
