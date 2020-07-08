Return-Path: <SRS0=luaH=AT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 08:35:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F9921974
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 08:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ya9qiXHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F9921974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1t0h15FnzDr6S
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 18:35:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=90.155.50.34; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=Ya9qiXHH; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1syM52CWzDr1c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 18:33:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZJNpnEdpSwAOlQcxfZwII1itlZxmBIrNUFOl9UFQI0s=; b=Ya9qiXHHrdyTWGPp032YRnzFIH
 6MPYm0BEoMc8ncfqqgb17R+Q1Yuv0iN4WdS/fxjtUiznK3bLbXquZDs7sSVGogtzLN++DsaGuBaJ+
 qxeWf0cuxdCtPe/HsGMvplOVk4llp07clkobZcvBYbO9+adWvLV/Hbov12TR7dC+IhsmIB0z9Yw2T
 h9JG4XlquyLth3icw8mMkkAJA+hfeaw90jRoPMbh7DqJSBErC0cwQQ0pwFWtmhCEul0BDB0WstS46
 RzcRgZc2lOT/SzvFOdYKUM8hfD52L0Dsui/qWIIQ1E2spaJ5v3/tsywLBG9gTevjRjwSFW6I+TOuB
 k1AQxs/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jt5VF-0007ob-RZ; Wed, 08 Jul 2020 08:32:32 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF5B6300739;
 Wed,  8 Jul 2020 10:32:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id BB50D2BDFCA5B; Wed,  8 Jul 2020 10:32:10 +0200 (CEST)
Date: Wed, 8 Jul 2020 10:32:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Message-ID: <20200708083210.GD597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 07, 2020 at 11:33:45PM -0400, Waiman Long wrote:
> From 5d7941a498935fb225b2c7a3108cbf590114c3db Mon Sep 17 00:00:00 2001
> From: Waiman Long <longman@redhat.com>
> Date: Tue, 7 Jul 2020 22:29:16 -0400
> Subject: [PATCH 2/9] locking/pvqspinlock: Introduce
>  CONFIG_PARAVIRT_QSPINLOCKS_LITE
> 
> Add a new PARAVIRT_QSPINLOCKS_LITE config option that allows
> architectures to use the PV qspinlock code without the need to use or
> implement a pv_kick() function, thus eliminating the atomic unlock
> overhead. The non-atomic queued_spin_unlock() can be used instead.
> The pv_wait() function will still be needed, but it can be a dummy
> function.
> 
> With that option set, the hybrid PV queued/unfair locking code should
> still be able to make it performant enough in a paravirtualized

How is this supposed to work? If there is no kick, you have no control
over who wakes up and fairness goes out the window entirely.

You don't even begin to explain...
