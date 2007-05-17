Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 29AB1DDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 05:59:02 +1000 (EST)
Message-ID: <464CB460.40905@ru.mvista.com>
Date: Fri, 18 May 2007 00:00:32 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
	<464CB071.5050504@ru.mvista.com>
	<9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
In-Reply-To: <9095839480a9686d9c40aa6143edb804@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Segher Boessenkool wrote:
>>>> +     * We must write a positive value to the decrementer to clear
>>>> +     * the interrupt on the IBM 970 CPU series.  In periodic mode,
>>>> +     * this happens when the decrementer gets reloaded later, but
>>>> +     * in one-shot mode, we have to do it here since an event handler
>>>> +     * may skip loading the new value...
>>
>>
>>> Nothing special about 970 here -- on *every* PowerPC,
>>> a decrementer exception exists as long as the high
>>> bit of the decrementer equals 1.  BookE is different
>>> of course.  Some other CPUs might deviate from the
>>> architecture as well.
>>
>>
>>    Quoting "PowerPC Operating Environment Architecture":

> <snip>

>> Otherwise, when the contents of DEC0 change, the exception effects of 
>> the Decrementer become consistent with the new contents of the 
>> Decrementer reasonably soon after the change.

> And that is guaranteed on all PowerPC as far as I can see.
> The main thing is that a decrementer exception won't go
> away until the high bit becomes 0.

On both POWER4 and POWER4+, the Decrementer must be implemented such that 
requirements 1 to 3 below are satisfied. On POWER4, requirements 4 and 5 must 
also be satisfied.

1. The operation of the Time Base and the Decrementer is coherent, i.e., the 
counters are driven by the same fundamental time base.
2. Loading a GPR from the Decrementer shall have no effect on the accuracy of 
the Decrementer.

3. Storing a GPR to the Decrementer shall replace the value in the Decrementer 
with the value in the GPR.

4. Whenever bit 0 of the Decrementer changes from 0 to 1, an interrupt request 
is signaled. If multiple Decrementer interrupt requests are received before 
the first can be reported, only one interrupt is reported. The occurrence of a 
Decrementer interrupt cancels the request.

5. If the Decrementer is altered by software and the contents of bit 0 are 
changed from 0 to 1, an interrupt request is signaled.

    (4) clearly contradicts your point. I don't mind changing #ifdef though 
(so it'll cover all non Book E cases)

> Segher

WBR, Sergei
