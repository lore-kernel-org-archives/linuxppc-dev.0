Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE27C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:00:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DF8222C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D253Chez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DF8222C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zYR15dvkzDqQR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 06:59:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="D253Chez"; dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zYPG49NszDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 06:58:26 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id b20so2964020lfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 11:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/n+2vOYomTB5BLs+7tL7KTaBHH30/oos+ud6/cnVnSI=;
 b=D253Chez2iaEQIcdy2TZNsUlaqMRm9VIwWrpW4fWK//FTDXCKKfklGuD0o642xmL34
 Mp7YirjzpQRotbrv0djWXVT+vJS5/MLsACCfzpkJ9An4MiWd9dVmmIgjhdo9yVZ3/bHH
 9o6+1iNpzzKTb5pLfsCFl4j2YHGc18WAFp/jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/n+2vOYomTB5BLs+7tL7KTaBHH30/oos+ud6/cnVnSI=;
 b=bajs8TPPXTkaf40Pw+TLJblIfAvVf+3uSAl85NuRrchnen2Ggoo2N+NiKqoovx+fx+
 354r6Ll2vH0gBTtU+oI1YKNdkEshImSSnXtoEgE7r1/38hzlr9lK+frrGTsco14LWCaX
 dAfaKywhR0fdrkGsIlm6p30mGNsPPzipoeAuaJnpbkZoOmUOTQGz0H4vqrEElDzbDu35
 f7SZepnO0zFtbM3sphOoEEE1HnNHLNFGpQknBBiNJBV2RjEZJLkf82wv/fbdeb51X+n7
 qgrrUPiNzIr8tvT9TPrfswdH3RViQlKpK0czkuOuQxU7XXaelZ0AVwCJGBC0+/+nDRIX
 db5A==
X-Gm-Message-State: AHQUAuZwNbv1aQ+HbqEbXDP+zqV3LSGtS+PWxlUhMIu5TPwgv7KFLpAE
 2np5Nu8SMXG5peVWtnQ0kcfZE3wZURA=
X-Google-Smtp-Source: AHgI3IagZkZEWtHYNxf6mf2SA+2ASyi7KaojdB3Liuhtl/MZFfvEMDILJ+z3MzoZH8+cpLdOOeKYSw==
X-Received: by 2002:ac2:4297:: with SMTP id m23mr3625143lfh.141.1550001502332; 
 Tue, 12 Feb 2019 11:58:22 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173])
 by smtp.gmail.com with ESMTPSA id d5sm3172640lfi.65.2019.02.12.11.58.19
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 11:58:20 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id r10-v6so3337060ljj.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 11:58:19 -0800 (PST)
X-Received: by 2002:a2e:7316:: with SMTP id
 o22-v6mr1693665ljc.82.1550001499483; 
 Tue, 12 Feb 2019 11:58:19 -0800 (PST)
MIME-Version: 1.0
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
 <1549913486-16799-3-git-send-email-longman@redhat.com>
In-Reply-To: <1549913486-16799-3-git-send-email-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Feb 2019 11:58:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
Message-ID: <CAHk-=wjTmSg6zX=xKFSPZor7FWi3s4D0dy-hz_M=yeF_6478QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
To: Waiman Long <longman@redhat.com>
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
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 11:31 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to make it generate slightly better code
> (smaller and maybe a tiny bit faster).

This looks good, but I would ask you to try one slightly different approach.

Instead of this:

>        long tmp = atomic_long_read(&sem->count);
>
>        while (tmp >= 0) {
>                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
>                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
>                        return 1;
>                }
>        }

try doing this instead:

        long tmp = 0;

        do {
                if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
                                        tmp + RWSEM_ACTIVE_READ_BIAS)) {
                        return 1;
        } while (tmp >= 0);
        return 0;

because especially when it comes to locking, it's usually better to
just *guess* that the lock is unlocked, than it is to actually read
from the line to see what the state is.

Often - but certainly not always - the lock is the first access to the
target cacheline, and assuming the trylock is successful (which I
think is the case we want to optimize for), we're much better off
causing that first access to be a read-for-ownership, rather than a
read-for-sharing.

Because if you first read from the line, and then do a cmpxchg, and if
the line was not in the cache, your cache coherency protocol will
generally go through two states: first shared (for the initial read)
and then exclusive-dirty (for the cmpxchg).

Now, this is obviously very micro-architecture dependent, and in fact
the microarchitecture could even see the "predict fallthrough to a
cmpxchg with the same address" and turn the first read into a
read-for-ownership, but we've done this at some point before, and the
"guess unlocked" was actually the one that performed better.

Of course, the downside is that it might be worse when the guess is
incorrect - either because of a nested read lock or due to an actual
conflict with a write, but on the whole those *should* be the rare
cases, and not the cases where we necessarily optimize for latency of
the operation.

Hmm?

                    Linus
