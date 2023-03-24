Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D080C6FD20
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Mar 2023 16:34:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pjnqj3cPfz3fW2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Mar 2023 03:34:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pjnq73ldNz2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2023 03:34:26 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C3A113E;
	Fri, 24 Mar 2023 09:34:38 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.56.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17CBD3F6C4;
	Fri, 24 Mar 2023 09:33:52 -0700 (PDT)
Date: Fri, 24 Mar 2023 16:32:52 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg()
 fallbacks
Message-ID: <ZB3QtDYuWdpiD5qk@FVFF77S0Q05N>
References: <20230305205628.27385-1-ubizjak@gmail.com>
 <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
 <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
 <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
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

On Fri, Mar 24, 2023 at 04:14:22PM +0000, Mark Rutland wrote:
> On Fri, Mar 24, 2023 at 04:43:32PM +0100, Uros Bizjak wrote:
> > On Fri, Mar 24, 2023 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > > > Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.
> > >
> > > Can you give an example of where we are passing an incompatible pointer?
> > 
> > An example is patch 10/10 from the series, which will fail without
> > this fix when fallback code is used. We have:
> > 
> > -       } while (local_cmpxchg(&rb->head, offset, head) != offset);
> > +       } while (!local_try_cmpxchg(&rb->head, &offset, head));
> > 
> > where rb->head is defined as:
> > 
> > typedef struct {
> >    atomic_long_t a;
> > } local_t;
> > 
> > while offset is defined as 'unsigned long'.
> 
> Ok, but that's because we're doing the wrong thing to start with.
> 
> Since local_t is defined in terms of atomic_long_t, we should define the
> generic local_try_cmpxchg() in terms of atomic_long_try_cmpxchg(). We'll still
> have a mismatch between 'long *' and 'unsigned long *', but then we can fix
> that in the callsite:
> 
> 	while (!local_try_cmpxchg(&rb->head, &(long *)offset, head))

Sorry, that should be:
	
	while (!local_try_cmpxchg(&rb->head, (long *)&offset, head))

The fundamenalthing I'm trying to say is that the
atomic/atomic64/atomic_long/local/local64 APIs should be type-safe, and for
their try_cmpxchg() implementations, the type signature should be:

	${atomictype}_try_cmpxchg(${atomictype} *ptr, ${inttype} *old, ${inttype} new)

Thanks,
Mark.
