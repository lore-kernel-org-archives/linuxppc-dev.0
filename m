Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 87500DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 05:42:14 +1000 (EST)
Message-ID: <464CB071.5050504@ru.mvista.com>
Date: Thu, 17 May 2007 23:43:45 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
In-Reply-To: <f9afbdb49bc1f935153305315770bccd@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de,
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
>> +     * We must write a positive value to the decrementer to clear
>> +     * the interrupt on the IBM 970 CPU series.  In periodic mode,
>> +     * this happens when the decrementer gets reloaded later, but
>> +     * in one-shot mode, we have to do it here since an event handler
>> +     * may skip loading the new value...

> Nothing special about 970 here -- on *every* PowerPC,
> a decrementer exception exists as long as the high
> bit of the decrementer equals 1.  BookE is different
> of course.  Some other CPUs might deviate from the
> architecture as well.

    Quoting "PowerPC Operating Environment Architecture":

The Decrementer counts down. On POWER4, a Decrementer exception occurs when 
DEC0 changes from 0 to 1. On POWER4+, operation is as follows.

The exception effects of the Decrementer are said to be consistent with the 
contents of the Decrementer if one of the following statements is true.

* DEC0=0 and a Decrementer exception does not exist.

* DEC0=1 and a Decrementer exception exists.

If DEC0=0, a context synchronizing instruction or event ensures that the 
exception effects of the Decrementer are consistent with the contents of the 
Decrementer. Otherwise, when the contents of DEC0 change, the exception 
effects of the Decrementer become consistent with the new contents of the 
Decrementer reasonably soon after the change.

> Segher

WBR, Sergei
