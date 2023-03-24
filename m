Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DB9C6FD1C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Mar 2023 16:15:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PjnPQ4nBqz3fX8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Mar 2023 03:15:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PjnNq1Trlz3bT1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2023 03:15:03 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85CBC113E;
	Fri, 24 Mar 2023 09:15:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.55.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2B83F6C4;
	Fri, 24 Mar 2023 09:14:28 -0700 (PDT)
Date: Fri, 24 Mar 2023 16:14:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg()
 fallbacks
Message-ID: <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
References: <20230305205628.27385-1-ubizjak@gmail.com>
 <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
 <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 24, 2023 at 04:43:32PM +0100, Uros Bizjak wrote:
> On Fri, Mar 24, 2023 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > > Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.
> >
> > Can you give an example of where we are passing an incompatible pointer?
> 
> An example is patch 10/10 from the series, which will fail without
> this fix when fallback code is used. We have:
> 
> -       } while (local_cmpxchg(&rb->head, offset, head) != offset);
> +       } while (!local_try_cmpxchg(&rb->head, &offset, head));
> 
> where rb->head is defined as:
> 
> typedef struct {
>    atomic_long_t a;
> } local_t;
> 
> while offset is defined as 'unsigned long'.

Ok, but that's because we're doing the wrong thing to start with.

Since local_t is defined in terms of atomic_long_t, we should define the
generic local_try_cmpxchg() in terms of atomic_long_try_cmpxchg(). We'll still
have a mismatch between 'long *' and 'unsigned long *', but then we can fix
that in the callsite:

	while (!local_try_cmpxchg(&rb->head, &(long *)offset, head))

... which then won't silently mask issues elsewhere, and will be consistent
with all the other atomic APIs.

Thanks,
Mark.

> 
> The assignment in existing try_cmpxchg template:
> 
> typeof(*(_ptr)) *___op = (_oldp)
> 
> will trigger an initialization from an incompatible pointer type error.
> 
> Please note that x86 avoids this issue by a cast in its
> target-dependent definition:
> 
> #define __raw_try_cmpxchg(_ptr, _pold, _new, size, lock)                \
> ({                                                                      \
>        bool success;                                                   \
>        __typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);              \
>        __typeof__(*(_ptr)) __old = *_old;                              \
>        __typeof__(*(_ptr)) __new = (_new);                             \
> 
> so, the warning/error will trigger only in the fallback code.
> 
> > That sounds indicative of a bug in the caller, but maybe I'm missing some
> > reason this is necessary due to some indirection.
> >
> > > Fixes: 29f006fdefe6 ("asm-generic/atomic: Add try_cmpxchg() fallbacks")
> >
> > I'm not sure that this needs a fixes tag. Does anything go wrong today, or only
> > later in this series?
> 
> The patch at [1] triggered a build error in posix_acl.c/__get.acl due
> to the same problem. The compilation for x86 target was OK, because
> x86 defines target-specific arch_try_cmpxchg, but the compilation
> broke for targets that revert to generic support. Please note that
> this specific problem was recently fixed in a different way [2], but
> the issue with the fallback remains.
> 
> [1] https://lore.kernel.org/lkml/20220714173819.13312-1-ubizjak@gmail.com/
> [2] https://lore.kernel.org/lkml/20221201160103.76012-1-ubizjak@gmail.com/
> 
> Uros.
