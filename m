Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C09A1A0271
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 15:27:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 24 Mar 2015 14:27:42 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6D34E2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 15:27:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2O4RTD538076524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 15:27:38 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2O4R31a001773
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 15:27:04 +1100
Message-ID: <5510E77F.1020903@linux.vnet.ibm.com>
Date: Tue, 24 Mar 2015 09:56:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/tm: Abort syscalls in active transactions
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
 <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
 <550BE2AB.2050604@linux.vnet.ibm.com>
 <1427162659.28572.3.camel@ellerman.id.au>
In-Reply-To: <1427162659.28572.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Sam Bobroff <sam.bobroff@au1.ibm.com>,
 matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/24/2015 07:34 AM, Michael Ellerman wrote:
> On Fri, 2015-03-20 at 14:34 +0530, Anshuman Khandual wrote:
>> On 03/19/2015 10:13 AM, Sam Bobroff wrote:
>>> This patch changes the syscall handler to doom (tabort) active
>>> transactions when a syscall is made and return immediately without
>>> performing the syscall.
>>>
>>> Currently, the system call instruction automatically suspends an
>>> active transaction which causes side effects to persist when an active
>>> transaction fails.
>>>
>>> This does change the kernel's behaviour, but in a way that was
>>> documented as unsupported. It doesn't reduce functionality because
>>> syscalls will still be performed after tsuspend. It also provides a
>>> consistent interface and makes the behaviour of user code
>>> substantially the same across powerpc and platforms that do not
>>> support suspended transactions (e.g. x86 and s390).
>>>
>>> Performance measurements using
>>> http://ozlabs.org/~anton/junkcode/null_syscall.c
>>> indicate the cost of a system call increases by about 0.5%.
>>
>> Performance test results verified which shows an improvement of
>> around ~0.52% with the patch compared to without it.
>>
>> [With patch]		null_syscall:     757.59 cycles     100.00%
>> [Without patch]]	null_syscall:     753.66 cycles     100.00%
> 
> No that's a performance *decrease* with the patch applied. ?

Micheal, thats true. The cycle counts are more with patch being applied.
Here are some more results on mainline.

Without the patch:

        null_syscall:     754.14 cycles     100.00%
        null_syscall:     754.50 cycles     100.00%
        null_syscall:     754.17 cycles     100.00%
        null_syscall:     754.43 cycles     100.00%
        null_syscall:     754.17 cycles     100.00%
        null_syscall:     754.20 cycles     100.00%
        null_syscall:     754.47 cycles     100.00%
        null_syscall:     754.70 cycles     100.00%
        null_syscall:     754.43 cycles     100.00%
        null_syscall:     753.72 cycles     100.00%

With the patch:

        null_syscall:     756.76 cycles     100.00%
        null_syscall:     756.40 cycles     100.00%
        null_syscall:     756.46 cycles     100.00%
        null_syscall:     756.86 cycles     100.00%
        null_syscall:     756.56 cycles     100.00%
        null_syscall:     756.66 cycles     100.00%
        null_syscall:     756.86 cycles     100.00%
        null_syscall:     756.86 cycles     100.00%
        null_syscall:     757.02 cycles     100.00%
        null_syscall:     756.93 cycles     100.00%
