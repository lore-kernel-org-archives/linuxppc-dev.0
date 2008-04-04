Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AB56DDF5A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 05:55:09 +1100 (EST)
In-Reply-To: <20080404180333.GB26693@lixom.net>
References: <20080403190943.GA16446@ru.mvista.com>
	<1207259436.10388.337.camel@pasglop>
	<20080404052955.GC11799@lixom.net>
	<9d19fecb0ef172995b7ce3a317ee3c0d@kernel.crashing.org>
	<20080404180333.GB26693@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <63defd942bd57ca87cb17334832b615c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: MPIC ack interrupts at mpic_teardown_this_cpu()
Date: Fri, 4 Apr 2008 20:55:01 +0200
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

>> platforms/maple/setup.c and platforms/powermac/pic.c use
>> MPIC_WANTS_RESET.
>> Is there a reason why we don't do that on every MPIC?  If there is 
>> such
>> a reason, the default should be to reset, only pseries and chrp and 
>> cell
>> and now pasemi do not use it.  It's the only sane way to get an MPIC
>> into
>> a sane known state starting from <whatever> state.
>
> I used to have the reset there on pasemi but due to some other issues I
> ended up taking it out.
>
> It's not like doing a final EOI is a big deal, I really don't see why
> there's hassle about this patch.

The patch is fine, don't get me wrong.  I'm just saying MPIC_WANTS_RESET
should be the default since pretty much everything wants it.  The few
platforms that don't can document why; with the current code, we cannot
see if you just forgot it or not.


Segher
