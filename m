Return-Path: <SRS0=USLf=AU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 10:35:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0856206DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 10:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ysIolg+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0856206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B2Xcx0qH0zDqvW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 20:35:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=ysIolg+C; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2XZy52tJzDqqJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2020 20:33:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IvpXUYK9H+QnmAsI+N7Y+NJkZMFkfZkklbiU2ToyVQs=; b=ysIolg+CeRhNjk4NEZhTj9mj5g
 ca828lNtjuaGV9NHITlG2ZDPtxGhXNhk3KrvudsXjUJmb8J4XG/OF1nzUOwI//gHDtqE0EANnpbE+
 bbiBnPXo5VHSiHumhpr2Qu+akcJEqpES74jCyTShVPKFLAmD/sBzeRgZb/ORaBfu5DUyt8R+5OLWf
 GfezKgB7POj5RVO9xyLQJYa4YqvWXnYTcjZguHbo5tiN+wTk/yxkJo9dnoBBMvOLBeJh/GXmNplaB
 k6UuaBO7U4dpxgXLgt+GyuZ9p/eO25EDL03UeJAkSn2ViIUTHUSjhhYACWMO+fCLOzes7hYXYC/zl
 7sbP7/LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtTs4-0007rF-9q; Thu, 09 Jul 2020 10:33:40 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66F76300739;
 Thu,  9 Jul 2020 12:33:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 53455235B3D17; Thu,  9 Jul 2020 12:33:38 +0200 (CEST)
Date: Thu, 9 Jul 2020 12:33:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 4/6] powerpc/64s: implement queued spinlocks and rwlocks
Message-ID: <20200709103338.GQ597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-5-npiggin@gmail.com>
 <877dvdvvkm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dvdvvkm.fsf@mpe.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, kvm-ppc@vger.kernel.org,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 09, 2020 at 08:20:25PM +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> > These have shown significantly improved performance and fairness when
> > spinlock contention is moderate to high on very large systems.
> >
> >  [ Numbers hopefully forthcoming after more testing, but initial
> >    results look good ]
> 
> Would be good to have something here, even if it's preliminary.
> 
> > Thanks to the fast path, single threaded performance is not noticably
> > hurt.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/Kconfig                      | 13 ++++++++++++
> >  arch/powerpc/include/asm/Kbuild           |  2 ++
> >  arch/powerpc/include/asm/qspinlock.h      | 25 +++++++++++++++++++++++
> >  arch/powerpc/include/asm/spinlock.h       |  5 +++++
> >  arch/powerpc/include/asm/spinlock_types.h |  5 +++++
> >  arch/powerpc/lib/Makefile                 |  3 +++
> 
> >  include/asm-generic/qspinlock.h           |  2 ++
> 
> Who's ack do we need for that part?

Mine I suppose would do, as discussed earlier, it probably isn't
required anymore, but I understand the paranoia of not wanting to change
too many things at once :-)


Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
