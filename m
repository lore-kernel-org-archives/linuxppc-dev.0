Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 506BCDDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 05:51:04 +1000 (EST)
In-Reply-To: <464CB071.5050504@ru.mvista.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
	<464CB071.5050504@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Thu, 17 May 2007 21:50:52 +0200
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

>>> +     * We must write a positive value to the decrementer to clear
>>> +     * the interrupt on the IBM 970 CPU series.  In periodic mode,
>>> +     * this happens when the decrementer gets reloaded later, but
>>> +     * in one-shot mode, we have to do it here since an event 
>>> handler
>>> +     * may skip loading the new value...
>
>> Nothing special about 970 here -- on *every* PowerPC,
>> a decrementer exception exists as long as the high
>> bit of the decrementer equals 1.  BookE is different
>> of course.  Some other CPUs might deviate from the
>> architecture as well.
>
>    Quoting "PowerPC Operating Environment Architecture":

<snip>

> Otherwise, when the contents of DEC0 change, the exception effects of 
> the Decrementer become consistent with the new contents of the 
> Decrementer reasonably soon after the change.

And that is guaranteed on all PowerPC as far as I can see.
The main thing is that a decrementer exception won't go
away until the high bit becomes 0.


Segher
