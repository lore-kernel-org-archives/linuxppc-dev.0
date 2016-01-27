Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB97F1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 18:01:38 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 27 Jan 2016 17:01:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E73273578055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 18:01:35 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0R71RdG33095720
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 18:01:35 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0R7139A026387
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 18:01:03 +1100
Subject: Re: [PATCH] Fix fall-through from case 30 (rld*) to case 31
To: oliver <oohall@gmail.com>
References: <1453704952-11197-1-git-send-email-oohall@gmail.com>
 <56A814B4.9020802@au1.ibm.com>
 <CAOSf1CEh6GjJZLKGXDviVbycPUuPzb6jL05Zq5d0pzBpeiumNA@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56A86B15.9040803@au1.ibm.com>
Date: Wed, 27 Jan 2016 18:00:37 +1100
MIME-Version: 1.0
In-Reply-To: <CAOSf1CEh6GjJZLKGXDviVbycPUuPzb6jL05Zq5d0pzBpeiumNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/01/16 16:29, oliver wrote:
>>Is there anywhere else in the sstep code that deals well with malformed instructions?
>
> When you break out of the switch the opcode type is marked as unknown
> and when further attempts to parse the instruction fail it returns zero
> to indicate failure. Also, many of the instructions handled by the
> function are only valid in 64bit mode. For 32bit processors these
> instructions would be illegal and the code that handles them is
> #ifdef`ed out when compiling for 32 bit platforms so simply breaking out
> of the switch and letting it propagate should be the right move here.

analyse_instr() returns 0 whenever it analyses but does not execute an 
instruction - it's not a failure as such.

In emulate_step(), if analyse_instr() returns 0 it will test for a bunch 
of instruction classes which require memory operations, and classes 
which can't be single-stepped. UNKNOWN isn't handled specifically, so 
it'll skip all that and return 0 at the end (meaning the step was not 
successfully emulated - as opposed to -1, which is used for instructions 
that are not allowed to be stepped).

This in turn is handled differently depending on whether emulate_step() 
is invoked in the kprobes, uprobes or hw_breakpoint code.

Rather than breaking out and relying on behaviour later in the code, I'd 
suggest either:

  - creating a goto label for bad instructions that clearly sets the 
type to UNKNOWN and returns 0 (and maybe adding some handling for that 
in emulate_step(), raise some kind of nice big warning at the very least)

  - make analyse_instr() return -1 on invalid instructions, which 
emulate_step() will immediately propagate, then make sure that whoever 
calls emulate_step() handles that appropriately


Andrew

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
