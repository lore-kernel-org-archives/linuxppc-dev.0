Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65E931A2A85
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 20:05:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 19:05:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C30F62BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 20:05:42 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K95Ymt28573764
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 20:05:42 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K958UQ023732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 20:05:09 +1100
Message-ID: <550BE2AB.2050604@linux.vnet.ibm.com>
Date: Fri, 20 Mar 2015 14:34:43 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Subject: Re: [PATCH 1/3] powerpc/tm: Abort syscalls in active transactions
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
 <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/19/2015 10:13 AM, Sam Bobroff wrote:
> This patch changes the syscall handler to doom (tabort) active
> transactions when a syscall is made and return immediately without
> performing the syscall.
> 
> Currently, the system call instruction automatically suspends an
> active transaction which causes side effects to persist when an active
> transaction fails.
> 
> This does change the kernel's behaviour, but in a way that was
> documented as unsupported. It doesn't reduce functionality because
> syscalls will still be performed after tsuspend. It also provides a
> consistent interface and makes the behaviour of user code
> substantially the same across powerpc and platforms that do not
> support suspended transactions (e.g. x86 and s390).
> 
> Performance measurements using
> http://ozlabs.org/~anton/junkcode/null_syscall.c
> indicate the cost of a system call increases by about 0.5%.

Performance test results verified which shows an improvement of
around ~0.52% with the patch compared to without it.

[With patch]		null_syscall:     757.59 cycles     100.00%
[Without patch]]	null_syscall:     753.66 cycles     100.00%

> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Tested-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
