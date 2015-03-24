Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 019941A0171
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 13:04:20 +1100 (AEDT)
Message-ID: <1427162659.28572.3.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/tm: Abort syscalls in active transactions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 24 Mar 2015 13:04:19 +1100
In-Reply-To: <550BE2AB.2050604@linux.vnet.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
 <6ebcb9f982f7cb100aef954cd7dc6a6081cd9134.1426740212.git.sam.bobroff@au1.ibm.com>
 <550BE2AB.2050604@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, matt@ozlabs.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-20 at 14:34 +0530, Anshuman Khandual wrote:
> On 03/19/2015 10:13 AM, Sam Bobroff wrote:
> > This patch changes the syscall handler to doom (tabort) active
> > transactions when a syscall is made and return immediately without
> > performing the syscall.
> > 
> > Currently, the system call instruction automatically suspends an
> > active transaction which causes side effects to persist when an active
> > transaction fails.
> > 
> > This does change the kernel's behaviour, but in a way that was
> > documented as unsupported. It doesn't reduce functionality because
> > syscalls will still be performed after tsuspend. It also provides a
> > consistent interface and makes the behaviour of user code
> > substantially the same across powerpc and platforms that do not
> > support suspended transactions (e.g. x86 and s390).
> > 
> > Performance measurements using
> > http://ozlabs.org/~anton/junkcode/null_syscall.c
> > indicate the cost of a system call increases by about 0.5%.
> 
> Performance test results verified which shows an improvement of
> around ~0.52% with the patch compared to without it.
> 
> [With patch]		null_syscall:     757.59 cycles     100.00%
> [Without patch]]	null_syscall:     753.66 cycles     100.00%

No that's a performance *decrease* with the patch applied. ?

cheers
