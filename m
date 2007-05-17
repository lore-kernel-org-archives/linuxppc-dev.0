Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27EECDDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 06:54:28 +1000 (EST)
In-Reply-To: <464CB460.40905@ru.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
	<464CB071.5050504@ru.mvista.com>
	<9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
	<464CB460.40905@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <97d47c2261fe9cd3f1a6c864278a6ab6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Thu, 17 May 2007 22:53:49 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Otherwise, when the contents of DEC0 change, the exception effects 
>>> of the Decrementer become consistent with the new contents of the 
>>> Decrementer reasonably soon after the change.
>
>> And that is guaranteed on all PowerPC as far as I can see.
>> The main thing is that a decrementer exception won't go
>> away until the high bit becomes 0.
>
> On both POWER4 and POWER4+, the Decrementer must be implemented such 
> that requirements 1 to 3 below are satisfied. On POWER4, requirements 
> 4 and 5 must also be satisfied.

<snip>

> 4. Whenever bit 0 of the Decrementer changes from 0 to 1, an interrupt 
> request is signaled. If multiple Decrementer interrupt requests are 
> received before the first can be reported, only one interrupt is 
> reported. The occurrence of a Decrementer interrupt cancels the 
> request.
>
> 5. If the Decrementer is altered by software and the contents of bit 0 
> are changed from 0 to 1, an interrupt request is signaled.

 From the POWER ISA 2.03, the latest public version of the
architecture definition:

	When the contents of DEC32 change from 0 to 1, a Decrementer
	exception will come into existence within a reasonable period
	or time. When the contents of DEC32 change from 1 to 0, an
	existing Decrementer exception will cease to exist within a
	reasonable period of time, but not later than the completion
	of the next context synchronizing instruction or event.

>    (4) clearly contradicts your point.

Yes, on some implementations there can be other conditions that
make a decrementer exception go away; there is no contradiction
here (thankfully).  My wording was sloppy.

> I don't mind changing #ifdef though (so it'll cover all non Book E 
> cases)

That was exactly my point; thank you.


Segher
