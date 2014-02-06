Return-Path: <tommusta@gmail.com>
Received: from mail-qc0-x22a.google.com (mail-qc0-x22a.google.com
 [IPv6:2607:f8b0:400d:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99CBE2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 06:28:43 +1100 (EST)
Received: by mail-qc0-f170.google.com with SMTP id e9so4095676qcy.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Feb 2014 11:28:40 -0800 (PST)
Message-ID: <52F3E255.5050906@gmail.com>
Date: Thu, 06 Feb 2014 13:28:21 -0600
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
 <20140206180826.GI5002@laptop.programming.kicks-ass.net>
In-Reply-To: <20140206180826.GI5002@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/6/2014 12:08 PM, Peter Zijlstra wrote:
>>> Can you pair lwarx with sthcx ? I couldn't immediately find the answer
>>> > > in the PowerISA doc. If so I think you can do better by being able to
>>> > > atomically load both tickets but only storing the head without affecting
>>> > > the tail.
>> > 
>> > V2.06b, Book II, Chapter 3, "sthcx" says:
>> > | If a reservation exists and the length associated [...] is not 2 bytes,
>> > | it is undefined whether (RS)_48:63 are stored [...]
>> > 
>> > That doesn't make me feel comfortable :(
> That's on page 692, right? The way I read that is of the lharx/sthcx
> don't have the exact same address, storage is undefined. But I can't
> find mention of non-matching load and store size, although I can imagine
> it being the same undefined.

My read is consistent with Torsten's ... this looks like a bad idea.

Look at the RTL for sthcx. on page 692 (Power ISA V2.06) and you will see this:

if RESERVE then
  if RESERVE_LENGTH = 2 then
     ...
  else
     undefined_case <- 1
else
  ...

A legal implementation might never perform the store.
