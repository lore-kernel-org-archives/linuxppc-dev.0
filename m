Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id D9F38DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 20:25:01 +1100 (EST)
Date: Sat, 23 Feb 2008 10:24:58 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
Message-ID: <20080223092458.GA6873@10.1.86.20>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
	<08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 22, 2008 at 12:33:19PM -0600, Andy Fleming wrote:
>
> On Feb 22, 2008, at 03:50, Philippe De Muyter wrote:
>
>> Dear list,
>>
>> I have just compiled linux-2.6.24 for a MPC8540 target using a MPC8540
>> specific gcc.
>>
>> I then got tan infinity of "SPE used in kernel" messages.  Looking at the
>> sources I ifdeffed out the printk call in KernelSPE, and I now have a
>> silent kernel, that seems to work fine.
>>
>> Is there something wrong in my setting and should I look further to
>> debug this problem or is this perfectly normal ?
>>
>> I wonder why a kernel configured for E500 and compiled by a E500-specific 
>> gcc
>> triggers this message.  Is it invalid to use SPE instructions in the 
>> kernel
>> or do I misunderstand the message ?
>
>
> We don't currently support using SPE in the kernel.  Are you using SPE in 
> the kernel for some reason?  Do you think that the compiler is 
> automatically generating SPE code in the kernel?  I've never seen that 
> before.
>
> Andy

I have bought a modified CLFS installation targetting by default a MPC8540.
By default my powerpc compiler thus generates also SPE instructions.
And I built linux using that compiler.

My first trial used ARCH=ppc and caused this infinity of "SPE used in kernel"
messages, but I then recompiled linux with ARCH=powerpc.  With the message
not ifdef'ed out, this second kernel does not emit "SPE used in kernel"
messages, but I noticed problems with processes dying unexpectedly
(like in the first one, but after my first mail to the list).

Do you by chance know which MPC8540 registers are not saved by the kernel ?

Philippe
