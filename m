Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C246B67BC1
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 01:07:08 +1000 (EST)
In-Reply-To: <17682.34922.240565.233215@cargo.ozlabs.ibm.com>
References: <20060919193020.GN29167@austin.ibm.com>
	<17682.34922.240565.233215@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CE7D62D7-5700-488F-91F0-5F732B242EC0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc: clarify use of twi/isync in io macros
Date: Thu, 21 Sep 2006 17:06:37 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> + * A data-dependent branch followed by an isync ensures that no
>> + * instructions after the isync in program order will be
>> + * (speculatively) executed, so the load that the twi depends
>> + * on has to complete before anything else is executed; in
>
> While the statement about branches is true, it's not especially
> relevant when it comes to twi.

twi is a data-dependent branch -- all exceptions are branches (well
they do change the execution flow!), and this one is generated
directly by an insn even.  Traps and "normal" branches are neighbours
in the opcode maps, too, FWIW ;-)

> What's happening is that isync has to
> prevent any following instructions from starting execution until all
> previous instructions have completed, meaning that they have got to
> the point of knowing whether they will generate an exception or not.

It also has to know whether the isync will be executed at all, in
the sequential model.

> In general the processor doesn't know whether twi will generate an
> exception until the data it depends on is available, and that's why
> the isync has to wait for the previous load to have returned the
> data.

Yeah, the main point is that the load insn can complete _before_
the data has come back ("the storage access has been performed"),
so an isync without another insn depending on the load result
won't do.

Care to write some better explanatory text than the rubbish I
came up with?  :-)

Btw, you say "in general the CPU doesn't know", but it _can_ know
in this code, as the TO field is 0 (so it can never trap).  Is
there anything preventing/forbidding a CPU from optimising this
case?  I see it spelled out for "conditional branch" insns, but
it would be interesting to know if the arch guarantees no insn
will complete before its input regs are ready.
