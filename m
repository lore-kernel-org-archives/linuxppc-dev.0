Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D08CC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:16:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9722070B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9722070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444xNY4X6hzDqRP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 01:16:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 444xLH5gFzzDq83
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 01:14:30 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9B1815AB;
 Thu, 21 Feb 2019 06:14:28 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752693F575;
 Thu, 21 Feb 2019 06:14:23 -0800 (PST)
Date: Thu, 21 Feb 2019 14:14:20 +0000
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 3/3] locking/rwsem: Optimize down_read_trylock()
Message-ID: <20190221141420.GC12696@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <1550095217-12047-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550095217-12047-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linux-mips@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 13, 2019 at 05:00:17PM -0500, Waiman Long wrote:
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.
> 
> Before this patch, down_read_trylock:
> 
>    0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
>    0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
>    0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
>    0x000000000000000b <+11>:    mov    %rdx,%rax
>    0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
>    0x0000000000000013 <+19>:    cmp    %rax,%rdx
>    0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
>    0x0000000000000018 <+24>:    mov    (%rdi),%rdx
>    0x000000000000001b <+27>:    test   %rdx,%rdx
>    0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
>    0x0000000000000020 <+32>:    xor    %eax,%eax
>    0x0000000000000022 <+34>:    retq
>    0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
>    0x000000000000002c <+44>:    or     $0x3,%rax
>    0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
>    0x0000000000000034 <+52>:    mov    $0x1,%eax
>    0x0000000000000039 <+57>:    retq
> 
> After patch, down_read_trylock:
> 
>    0x0000000000000000 <+0>:	callq  0x5 <down_read_trylock+5>
>    0x0000000000000005 <+5>:	xor    %eax,%eax
>    0x0000000000000007 <+7>:	lea    0x1(%rax),%rdx
>    0x000000000000000b <+11>:	lock cmpxchg %rdx,(%rdi)
>    0x0000000000000010 <+16>:	jne    0x29 <down_read_trylock+41>
>    0x0000000000000012 <+18>:	mov    %gs:0x0,%rax
>    0x000000000000001b <+27>:	or     $0x3,%rax
>    0x000000000000001f <+31>:	mov    %rax,0x20(%rdi)
>    0x0000000000000023 <+35>:	mov    $0x1,%eax
>    0x0000000000000028 <+40>:	retq
>    0x0000000000000029 <+41>:	test   %rax,%rax
>    0x000000000000002c <+44>:	jns    0x7 <down_read_trylock+7>
>    0x000000000000002e <+46>:	xor    %eax,%eax
>    0x0000000000000030 <+48>:	retq
> 
> By using a rwsem microbenchmark, the down_read_trylock() rate (with a
> load of 10 to lengthen the lock critical section) on a x86-64 system
> before and after the patch were:
> 
>                  Before Patch    After Patch
>    # of Threads     rlock           rlock
>    ------------     -----           -----
>         1           14,496          14,716
>         2            8,644           8,453
> 	4            6,799           6,983
> 	8            5,664           7,190
> 
> On a ARM64 system, the performance results were:
> 
>                  Before Patch    After Patch
>    # of Threads     rlock           rlock
>    ------------     -----           -----
>         1           23,676          24,488
>         2            7,697           9,502
>         4            4,945           3,440
>         8            2,641           1,603
> 
> For the uncontended case (1 thread), the new down_read_trylock() is a
> little bit faster. For the contended cases, the new down_read_trylock()
> perform pretty well in x86-64, but performance degrades at high
> contention level on ARM64.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> index 45ee002..1f5775a 100644
> --- a/kernel/locking/rwsem.h
> +++ b/kernel/locking/rwsem.h
> @@ -174,14 +174,17 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
>  
>  static inline int __down_read_trylock(struct rw_semaphore *sem)
>  {
> -	long tmp;
> +	/*
> +	 * Optimize for the case when the rwsem is not locked at all.
> +	 */
> +	long tmp = RWSEM_UNLOCKED_VALUE;
>  
> -	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> -		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> -				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +	do {
> +		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> +					tmp + RWSEM_ACTIVE_READ_BIAS)) {
>  			return 1;
>  		}
> -	}
> +	} while (tmp >= 0);

Nit: but I guess that should be RWSEM_UNLOCKED_VALUE instead of 0.

Will
