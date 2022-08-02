Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266C3C00140
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 18:17:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ly39R3zfTz304j
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Aug 2022 04:16:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ly3914Bf6z2yjC
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2022 04:16:36 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 272IDHUg002582;
	Tue, 2 Aug 2022 13:13:17 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 272IDFmt002581;
	Tue, 2 Aug 2022 13:13:15 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 2 Aug 2022 13:13:15 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/3] powerpc: Fix eh field when calling lwarx on PPC32
Message-ID: <20220802181315.GI25951@gate.crashing.org>
References: <a1176e19e627dd6a1b8d24c6c457a8ab874b7d12.1659430931.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1176e19e627dd6a1b8d24c6c457a8ab874b7d12.1659430931.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Tue, Aug 02, 2022 at 11:02:36AM +0200, Christophe Leroy wrote:
> Commit 9401f4e46cf6 ("powerpc: Use lwarx/ldarx directly instead of
> PPC_LWARX/LDARX macros") properly handled the eh field of lwarx
> in asm/bitops.h but failed to clear it for PPC32 in
> asm/simple_spinlock.h
> 
> So, do as in arch_atomic_try_cmpxchg_lock(), set it to 1 if PPC64
> but set it to 0 if PPC32. For that use IS_ENABLED(CONFIG_PPC64) which
> returns 1 when CONFIG_PPC64 is set and 0 otherwise.
> 
> Reported-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

> +	unsigned int eh = IS_ENABLED(CONFIG_PPC64);
>  
>  	token = LOCK_TOKEN;
>  	__asm__ __volatile__(
> -"1:	lwarx		%0,0,%2,1\n\
> +"1:	lwarx		%0,0,%2,%3\n\
>  	cmpwi		0,%0,0\n\
>  	bne-		2f\n\
>  	stwcx.		%1,0,%2\n\
> @@ -59,7 +60,7 @@ static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
>  	PPC_ACQUIRE_BARRIER
>  "2:"
>  	: "=&r" (tmp)
> -	: "r" (token), "r" (&lock->slock)
> +	: "r" (token), "r" (&lock->slock), "i" (eh)
>  	: "cr0", "memory");

That should work yes.  But please note that "n" is prefered if a number
is required (like here), not some other constant, as allowed by "i".

Thanks!


Segher
