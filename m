Return-Path: <SRS0=CZBu=FE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE9C5519F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 09:29:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B7D20809
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 09:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPDAemu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B7D20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cl0Lh0W2YzDqcL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 20:29:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=gPDAemu8; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cl0H61TN2zDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 20:26:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=aCfkGM0vlzXViK81UTEMgfauupgXmRJw3cav7RA9s0E=; b=gPDAemu81O47vOcuWY7I29THXg
 nt+YeRVZDtqqPty2L/qNFCh1BXnXk3Dv7qDJwyEEgVb4dK0GxUXPgcAl8NI/6mp9emA9xbKp47l9S
 Z7Ta23ItKhhlkoOviUnMz2mSEMonmx4Oqc4mal+jvAyXLWU0+aVTvGDOmelPJgvI+OD1anH7/HsfL
 DJWmoiB7pzkyBM45X1RNHYTOPY0QzuSQ2cnM37FR83FpEC9FGwdnNBjiK+sYJ2YlUd9Y5wulyKbiZ
 tXMZ4bNYyY91+m9jhDQwd8fysDaCrorLLb/VGndWhaXGf6ND5jk9XmBHpvJkAGSbmr7ow1twPDl/m
 ypseg8Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjfS3-00085i-54; Mon, 30 Nov 2020 09:26:31 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78D48301179;
 Mon, 30 Nov 2020 10:26:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5AE9B2B2690EC; Mon, 30 Nov 2020 10:26:28 +0100 (CET)
Date: Mon, 30 Nov 2020 10:26:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
Message-ID: <20201130092628.GL2414@hirez.programming.kicks-ass.net>
References: <20201128160141.1003903-1-npiggin@gmail.com>
 <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Linux-MM <linux-mm@kvack.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 28, 2020 at 07:54:57PM -0800, Andy Lutomirski wrote:
> Version (b) seems fairly straightforward to implement -- add RCU
> protection and a atomic_t special_ref_cleared (initially 0) to struct
> mm_struct itself.  After anyone clears a bit to mm_cpumask (which is
> already a barrier),

No it isn't. clear_bit() implies no barrier what so ever. That's x86
you're thinking about.

> they read mm_users.  If it's zero, then they scan
> mm_cpumask and see if it's empty.  If it is, they atomically swap
> special_ref_cleared to 1.  If it was zero before the swap, they do
> mmdrop().  I can imagine some tweaks that could make this a big
> faster, at least in the limit of a huge number of CPUs.
