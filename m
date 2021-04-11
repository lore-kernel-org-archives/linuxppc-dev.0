Return-Path: <SRS0=6Fot=JI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270BAC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 16:01:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D2D61041
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 16:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D2D61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJGp92Dzyz30Gl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 02:01:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ocbV3yCE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=guoren@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ocbV3yCE; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJGng5H51z2yyM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 02:01:27 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25EF9611AD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618156884;
 bh=bxyiUc7lO8RjWeGmFNt0Glxp3nNNC162o0D7XY+vRXg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ocbV3yCEonWttAc1zcbh4sFMlpL/8mLiYxvnPxd4vaNWUoxIUghQq/418Vd/8+OsQ
 uJqpH09JX3FyCKp5XaQYZxmUsBFGWg8DBDqrZUYcGC9eTTDGDZ7Pv1fsnvFz66yY3l
 CqFgPgBK9ODxn1O/DoS0JWKwm1nNfEok9TRCbissXEHtyCsrFX5+LauK+0HULFJudx
 MheQDdG6dqOZZtISRGENS7K5+2Yo60vM8RzSwh/VaorG8/XaeVnWmZ6gy7/XASCyPB
 iuDB+RBHMB+CmVctzSKyVDMGk7JOvcTcXfexy6bCgR4aqAXQUWdHhM9dc/xolI6hq+
 ieCqE55bqcOfw==
Received: by mail-lj1-f182.google.com with SMTP id z8so12272679ljm.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 09:01:24 -0700 (PDT)
X-Gm-Message-State: AOAM531fCO8+6eGKZnaFSlpw0DyUlFMHy+s1dmWOh2Ob6bUa0xktuA7a
 BuzGt0uONG42MlkhiEmvnzVtOpU4Ai+caImrWDI=
X-Google-Smtp-Source: ABdhPJy10CnI96Z9R6HlWIrVpcoYY10s7Y9maxlV3dOVr4CugIJl0sk8MNc8rkDLu53Ak6ongjwa0tUvq8SrIM/7luU=
X-Received: by 2002:a05:651c:3c3:: with SMTP id
 f3mr15178457ljp.105.1618156882398; 
 Sun, 11 Apr 2021 09:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-5-git-send-email-guoren@kernel.org>
In-Reply-To: <1617201040-83905-5-git-send-email-guoren@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 12 Apr 2021 00:01:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT2Pe8o0wm1ohJE-A0HNjteiB6T3HMcH3Fdj7Tm7SSR8Q@mail.gmail.com>
Message-ID: <CAJF2gTT2Pe8o0wm1ohJE-A0HNjteiB6T3HMcH3Fdj7Tm7SSR8Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] csky: locks: Optimize coding convention
To: Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Guo Ren <guoren@linux.alibaba.com>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 31, 2021 at 10:32 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
>  - Using smp_cond_load_acquire in arch_spin_lock by Peter's
>    advice.
>  - Using __smp_acquire_fence in arch_spin_trylock
>  - Using smp_store_release in arch_spin_unlock
>
> All above are just coding conventions and won't affect the
> function.
>
> TODO in smp_cond_load_acquire for architecture:
>  - current csky only has:
>    lr.w val, <p0>
>    sc.w <p0>. val2
>    (Any other stores to p0 will let sc.w failed)
>
>  - But smp_cond_load_acquire need:
>    lr.w val, <p0>
>    wfe
>    (Any stores to p0 will send the event to let wfe retired)
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Link: https://lore.kernel.org/linux-riscv/CAAhSdy1JHLUFwu7RuCaQ+RUWRBks2KsDva7EpRt8--4ZfofSUQ@mail.gmail.com/T/#m13adac285b7f51f4f879a5d6b65753ecb1a7524e
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/asm/spinlock.h | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
> index 69f5aa249c5f..69677167977a 100644
> --- a/arch/csky/include/asm/spinlock.h
> +++ b/arch/csky/include/asm/spinlock.h
> @@ -26,10 +26,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>                 : "r"(p), "r"(ticket_next)
>                 : "cc");
>
> -       while (lockval.tickets.next != lockval.tickets.owner)
> -               lockval.tickets.owner = READ_ONCE(lock->tickets.owner);
> -
> -       smp_mb();
> +       smp_cond_load_acquire(&lock->tickets.owner,
> +                                       VAL == lockval.tickets.next);
It's wrong, we should determine lockval before next read.

Fixup:

diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
index fe98ad8ece51..2be627ceb9df 100644
--- a/arch/csky/include/asm/spinlock.h
+++ b/arch/csky/include/asm/spinlock.h
@@ -27,7 +27,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
                : "r"(p), "r"(ticket_next)
                : "cc");

-       smp_cond_load_acquire(&lock->tickets.owner,
+       if (lockval.owner != lockval.tickets.next)
+               smp_cond_load_acquire(&lock->tickets.owner,
                                        VAL == lockval.tickets.next);

>  }
>
>  static inline int arch_spin_trylock(arch_spinlock_t *lock)
> @@ -55,15 +53,14 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
>         } while (!res);
>
>         if (!contended)
> -               smp_mb();
> +               __smp_acquire_fence();
>
>         return !contended;
>  }
>
>  static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
> -       smp_mb();
> -       WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
> +       smp_store_release(&lock->tickets.owner, lock->tickets.owner + 1);
>  }
>
>  static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
