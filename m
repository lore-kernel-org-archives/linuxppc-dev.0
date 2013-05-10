Return-Path: <michael.neuling@gmail.com>
Received: from mail-da0-x22d.google.com (mail-da0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C87442C00C7
 for <linuxppc-dev@ozlabs.org>; Fri, 10 May 2013 20:50:58 +1000 (EST)
Received: by mail-da0-f45.google.com with SMTP id w3so2177274dad.4
 for <linuxppc-dev@ozlabs.org>; Fri, 10 May 2013 03:50:56 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <20130510104352.GF31235@dyad.programming.kicks-ass.net>
References: <25394.1367890528@ale.ozlabs.ibm.com>
 <20130508155929.GA8459@dyad.programming.kicks-ass.net>
 <14691.1368052755@ale.ozlabs.ibm.com>
 <20130510104352.GF31235@dyad.programming.kicks-ass.net>
Date: Fri, 10 May 2013 20:50:56 +1000
Message-ID: <CAEjGV6x1=6iFUwQs6=5GY75-J9ZZzs8=CKE=+MGxdwoKycs9jA@mail.gmail.com>
Subject: Re: Invalid perf_branch_entry.to entries question
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 eranian@google.com, Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 10, 2013 at 8:43 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, May 09, 2013 at 08:39:15AM +1000, Michael Neuling wrote:
>> > Just because I'm curious.. however does that happen? Surely the CPU
>> > knows where next to fetch instructions?
>>
>> For computed gotos (ie. branch to a register value), the hardware gives
>> you the from and to address in the branch history buffer.
>>
>> For branches where the branch target address is an immediate encoded in
>> the instruction, the hardware only logs the from address.  It assumes
>> that software (perf irq handler in this case) can read this branch
>> instruction, calculate the corresponding offset and hence the
>> to/target address.
>>
>> It's entirely possible that when the perf IRQ handler happens, the
>> instruction in question is not readable or is no longer a branch (self
>> modifying code).  Hence we aren't able to calculate a valid to address.
>
> Ohh how cute! You've gotta love lazy hardware :-)

The buffer is in the core (not main memory) and hence only has limited
entries.  So skipping entries that can hopefully be determined in
other ways means we can log more branches.

That being said, it's a PITA for the kernel ;-)

Mikey
