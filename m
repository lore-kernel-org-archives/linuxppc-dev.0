Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 331CE1A0130
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 19:27:22 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 28 Nov 2014 18:27:19 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1BCAC2CE8067
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 19:27:15 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAS8RExR29229272
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 19:27:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAS8RETg004940
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 19:27:14 +1100
Message-ID: <547831DC.6000703@linux.vnet.ibm.com>
Date: Fri, 28 Nov 2014 13:57:08 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 0/2] powerpc: CR based local atomic operation
 implementation
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDC8B@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9FDC8B@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 27 November 2014 07:35 PM, David Laight wrote:
> From: Madhavan Srinivasan
>> This patchset create the infrastructure to handle the CR based
>> local_* atomic operations. Local atomic operations are fast
>> and highly reentrant per CPU counters.  Used for percpu
>> variable updates. Local atomic operations only guarantee
>> variable modification atomicity wrt the CPU which owns the
>> data and these needs to be executed in a preemption safe way.
> 
> These are usually called 'restartable atomic sequences (RAS)'.
> 
>> Here is the design of the first patch. Since local_* operations
>> are only need to be atomic to interrupts (IIUC), patch uses
>> one of the Condition Register (CR) fields as a flag variable. When
>> entering the local_*, specific bit in the CR5 field is set
>> and on exit, bit is cleared. CR bit checking is done in the
>> interrupt return path. If CR5[EQ] bit set and if we return
>> to kernel, we reset to start of local_* operation.
> 
> I don't claim to be able to read ppc assembler.
> But I can't see the code that clears CR5[EQ] for the duration
> of the ISR.
I use crclr instruction at the end of the code block to clear the bit.

> Without it a nested interrupt will go through unwanted paths.
> 
> There are also a lot of 'magic' constants in that assembly code.
> 
All these constants are define in asm/ppc-opcode.h

> I also wonder if it is possible to inspect the interrupted
> code to determine the start/end of the RAS block.
> (Easiest if you assume that there is a single 'write' instruction
> as the last entry in the block.)
> 
So each local_* function also have code in the __ex_table section. IIUC,
__ex_table contains two address. So if the return address found in the
first column of the _ex_table, use the corresponding address in the
second column to continue from.

> Also, how expensive is it to disable all interrupts?
> 
In the patch 1/2, posted the numbers for that too.

> 	David
> 

Regards
Maddy
