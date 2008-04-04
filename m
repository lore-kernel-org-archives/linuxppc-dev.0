Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E4917DDE21
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 04:53:42 +1100 (EST)
Date: Fri, 4 Apr 2008 13:03:33 -0500
From: Olof Johansson <olof@lixom.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: MPIC ack interrupts at mpic_teardown_this_cpu()
Message-ID: <20080404180333.GB26693@lixom.net>
References: <20080403190943.GA16446@ru.mvista.com>
	<1207259436.10388.337.camel@pasglop>
	<20080404052955.GC11799@lixom.net>
	<9d19fecb0ef172995b7ce3a317ee3c0d@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d19fecb0ef172995b7ce3a317ee3c0d@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2008 at 07:38:27PM +0200, Segher Boessenkool wrote:
>>>> We really need to ack interrupts at mpic_teardown, since
>>>> not all platforms reset mpic at kernel start-up. For example,
>>>> kexec'ed kernel hangs on P.A. Semi if mpic_eoi() isn't called.
>>>>
>>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>>>> ---
>>>
>>> Would be interesting to find out why it hangs tho... it shouldn't .
>>
>> I haven't reproduced the problem and looked at hardware state yet, but  
>> I
>> would expect it to be because the openpic won't send another interrupt
>> until the previous is EOI'd, and the IPI is never EOI'd as far as I
>> can tell.
>>
>> The XICS code does it explicitly already. I'm surprised it doesn't  
>> break
>> on the 970-based platforms actually...
>
> platforms/maple/setup.c and platforms/powermac/pic.c use  
> MPIC_WANTS_RESET.
> Is there a reason why we don't do that on every MPIC?  If there is such
> a reason, the default should be to reset, only pseries and chrp and cell
> and now pasemi do not use it.  It's the only sane way to get an MPIC  
> into
> a sane known state starting from <whatever> state.

I used to have the reset there on pasemi but due to some other issues I
ended up taking it out.

It's not like doing a final EOI is a big deal, I really don't see why
there's hassle about this patch.


-Olof
