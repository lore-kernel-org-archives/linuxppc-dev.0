Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B062C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 09:38:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974802146F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 09:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vGAmDYQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974802146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yghH36bbzDqPf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 20:38:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ygfG0Jt8zDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 20:36:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wODyZCRCI3EBE6BNkz8TloMb63efXEvZVOwD3gxLjZc=; b=vGAmDYQ8fbCnQPxEZ5PZLAY17
 YAGIose1sw2xBapvAs4EnPbsPVqlDoGtJBt0ukxKOqzfvo/MM5yCEhOOAXWIJ51oMPZy9CPwDa3vA
 QOQBaWOfRBeWEyUqjrZM7a1hc24RtPe7m5pLTILXp9gLyBo/219eV2onnJqcpKbSub6DOA5vZBsu7
 Kh9jamjiaqTSpvcrpLv7dwqbIkdva56GfgTHpgGzwrayEJsj9m+LVPDVy9us6qNAW3K8a4XO9Icsx
 UXqcAMqwXvc/NXMid1uOA81688J8PCysk8982+e+Pi1Sqa8vZFwZPh2OTRuNXFQv/TtXahK9HYdm/
 yS1IoJltw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt80T-0006Mc-Hd; Mon, 11 Feb 2019 09:36:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 99FA520D0BED0; Mon, 11 Feb 2019 10:36:01 +0100 (CET)
Date: Mon, 11 Feb 2019 10:36:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211093601.GT32511@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549850450-10171-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:
> diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> index bad2bca..067e265 100644
> --- a/kernel/locking/rwsem.h
> +++ b/kernel/locking/rwsem.h
> @@ -32,6 +32,26 @@
>  # define DEBUG_RWSEMS_WARN_ON(c)
>  #endif
>  
> +/*
> + * R/W semaphores originally for PPC using the stuff in lib/rwsem.c.
> + * Adapted largely from include/asm-i386/rwsem.h
> + * by Paul Mackerras <paulus@samba.org>.
> + */
> +
> +/*
> + * the semaphore definition
> + */
> +#ifdef CONFIG_64BIT
> +# define RWSEM_ACTIVE_MASK		0xffffffffL
> +#else
> +# define RWSEM_ACTIVE_MASK		0x0000ffffL
> +#endif
> +
> +#define RWSEM_ACTIVE_BIAS		0x00000001L
> +#define RWSEM_WAITING_BIAS		(-RWSEM_ACTIVE_MASK-1)
> +#define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
> +#define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
> +
>  #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>  /*
>   * All writes to owner are protected by WRITE_ONCE() to make sure that
> @@ -132,3 +152,113 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
>  {
>  }
>  #endif
> +
> +#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
> +/*
> + * lock for reading
> + */
> +static inline void __down_read(struct rw_semaphore *sem)
> +{
> +	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
> +		rwsem_down_read_failed(sem);
> +}
> +
> +static inline int __down_read_killable(struct rw_semaphore *sem)
> +{
> +	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
> +		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
> +			return -EINTR;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +			return 1;

That really wants to be:

		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
						    tmp + RWSEM_ACTIVE_READ_BIAS))

> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * lock for writing
> + */
> +static inline void __down_write(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
> +					     &sem->count);
> +	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
> +		rwsem_down_write_failed(sem);
> +}
> +
> +static inline int __down_write_killable(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
> +					     &sem->count);
> +	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
> +		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
> +			return -EINTR;
> +	return 0;
> +}
> +
> +static inline int __down_write_trylock(struct rw_semaphore *sem)
> +{
> +	long tmp;

	tmp = RWSEM_UNLOCKED_VALUE;

> +
> +	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
> +		      RWSEM_ACTIVE_WRITE_BIAS);
> +	return tmp == RWSEM_UNLOCKED_VALUE;

	return atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
					       RWSEM_ACTIVE_WRITE_BIAS);

> +}
> +
> +/*
> + * unlock after reading
> + */
> +static inline void __up_read(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	tmp = atomic_long_dec_return_release(&sem->count);
> +	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
> +		rwsem_wake(sem);
> +}
> +
> +/*
> + * unlock after writing
> + */
> +static inline void __up_write(struct rw_semaphore *sem)
> +{
> +	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
> +						    &sem->count) < 0))
> +		rwsem_wake(sem);
> +}
> +
> +/*
> + * downgrade write lock to read lock
> + */
> +static inline void __downgrade_write(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	/*
> +	 * When downgrading from exclusive to shared ownership,
> +	 * anything inside the write-locked region cannot leak
> +	 * into the read side. In contrast, anything in the
> +	 * read-locked region is ok to be re-ordered into the
> +	 * write side. As such, rely on RELEASE semantics.
> +	 */
> +	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
> +	if (tmp < 0)
> +		rwsem_downgrade_wake(sem);
> +}
> +
> +#endif /* CONFIG_RWSEM_XCHGADD_ALGORITHM */
