Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F9C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:28:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC3220811
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Gb0MkZXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC3220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SdTJ65vQzDqJX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 02:28:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Gb0MkZXr"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SdPT3W0XzDqH5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 02:25:30 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44SdPD2xnBz9v0lr;
 Mon, 25 Mar 2019 16:25:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Gb0MkZXr; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CrK4rxgSxrO3; Mon, 25 Mar 2019 16:25:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44SdPD1fbZz9tyDn;
 Mon, 25 Mar 2019 16:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553527520; bh=JrL7MExoxenGmOAA8+6zfD5VS8gV08AijePqq6+rivY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Gb0MkZXr4cfDzR19n8lna6H+IPA5AH3vZL1jNvOtCev91KCVbckg3/MYHKcjqkio5
 h3ZxOQHblb9nHvTSJ7+rGRyQcDlyWn4FJ8MQkFBX2AdS6cvQu/8kr1/7uriihL47lA
 Q8KeTVo/1kkW9DTDs2sH3feGWWW85xlVR3ifVPe8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 464268B8AB;
 Mon, 25 Mar 2019 16:25:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PjtKP9S86Vzq; Mon, 25 Mar 2019 16:25:25 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DA4758B74F;
 Mon, 25 Mar 2019 16:25:24 +0100 (CET)
Subject: Re: [PATCH v5 3/3] locking/rwsem: Optimize down_read_trylock()
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-4-longman@redhat.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <014279a5-8998-8e03-adb3-c3d611dff171@c-s.fr>
Date: Mon, 25 Mar 2019 16:25:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mips@vger.kernel.org,
 linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Could you share the microbenchmark you are using ?

I'd like to test the series on powerpc.

Thanks
Christophe

Le 22/03/2019 à 15:30, Waiman Long a écrit :
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.
> 
> Before this patch, down_read_trylock:
> 
>     0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
>     0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
>     0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
>     0x000000000000000b <+11>:    mov    %rdx,%rax
>     0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
>     0x0000000000000013 <+19>:    cmp    %rax,%rdx
>     0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
>     0x0000000000000018 <+24>:    mov    (%rdi),%rdx
>     0x000000000000001b <+27>:    test   %rdx,%rdx
>     0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
>     0x0000000000000020 <+32>:    xor    %eax,%eax
>     0x0000000000000022 <+34>:    retq
>     0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
>     0x000000000000002c <+44>:    or     $0x3,%rax
>     0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
>     0x0000000000000034 <+52>:    mov    $0x1,%eax
>     0x0000000000000039 <+57>:    retq
> 
> After patch, down_read_trylock:
> 
>     0x0000000000000000 <+0>:	callq  0x5 <down_read_trylock+5>
>     0x0000000000000005 <+5>:	xor    %eax,%eax
>     0x0000000000000007 <+7>:	lea    0x1(%rax),%rdx
>     0x000000000000000b <+11>:	lock cmpxchg %rdx,(%rdi)
>     0x0000000000000010 <+16>:	jne    0x29 <down_read_trylock+41>
>     0x0000000000000012 <+18>:	mov    %gs:0x0,%rax
>     0x000000000000001b <+27>:	or     $0x3,%rax
>     0x000000000000001f <+31>:	mov    %rax,0x20(%rdi)
>     0x0000000000000023 <+35>:	mov    $0x1,%eax
>     0x0000000000000028 <+40>:	retq
>     0x0000000000000029 <+41>:	test   %rax,%rax
>     0x000000000000002c <+44>:	jns    0x7 <down_read_trylock+7>
>     0x000000000000002e <+46>:	xor    %eax,%eax
>     0x0000000000000030 <+48>:	retq
> 
> By using a rwsem microbenchmark, the down_read_trylock() rate (with a
> load of 10 to lengthen the lock critical section) on a x86-64 system
> before and after the patch were:
> 
>                   Before Patch    After Patch
>     # of Threads     rlock           rlock
>     ------------     -----           -----
>          1           14,496          14,716
>          2            8,644           8,453
> 	4            6,799           6,983
> 	8            5,664           7,190
> 
> On a ARM64 system, the performance results were:
> 
>                   Before Patch    After Patch
>     # of Threads     rlock           rlock
>     ------------     -----           -----
>          1           23,676          24,488
>          2            7,697           9,502
>          4            4,945           3,440
>          8            2,641           1,603
> 
> For the uncontended case (1 thread), the new down_read_trylock() is a
> little bit faster. For the contended cases, the new down_read_trylock()
> perform pretty well in x86-64, but performance degrades at high
> contention level on ARM64.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.h | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> index 45ee00236e03..1f5775aa6a1d 100644
> --- a/kernel/locking/rwsem.h
> +++ b/kernel/locking/rwsem.h
> @@ -174,14 +174,17 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
>   
>   static inline int __down_read_trylock(struct rw_semaphore *sem)
>   {
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
>   			return 1;
>   		}
> -	}
> +	} while (tmp >= 0);
>   	return 0;
>   }
>   
> 
