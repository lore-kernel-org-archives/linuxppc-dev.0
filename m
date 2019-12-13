Return-Path: <SRS0=Sd9m=2D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A92C43603
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 10:49:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0241A206B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 10:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2toVqK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0241A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Z6q40XTlzDq6K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 21:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::343;
 helo=mail-wm1-x343.google.com; envelope-from=luc.vanoostenryck@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2toVqK3"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Z6mz3Js7zDrCT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 21:47:13 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so5814331wmj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 02:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aaItiTBk+e/R7wwZriBm1tDINaCLpM0u6e3njFKqqz8=;
 b=k2toVqK3xMpoQjPSunK5wQX2k/4FJdeWG6RMkZAOfcidd8oWAypdSfZVmj7VqJPARt
 D9jsVNfdnktzLM9kafptKzLf/MBDUHACylS71VvxJt7joO/PueWSlwl2tfrDfs/OB3A5
 9nCBlOpxsQ7z9OaxavDF50HpmkILhzxJAg+/RavBVin1voVF96sfcYcSpKx9j8YSDsMK
 wtD9Q3zk7/sQHPjUfcqEUXsoym55yhSOs0arrNE7BUzb5IeSai+o9nINSC8MklBR2Xeo
 ArjWDcuB4XqhR8P1+e5GcvXGXXYJj2Xlvr5AGErgkBbdrVFbwWjMdHUGWWmahvHJnBx1
 5wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aaItiTBk+e/R7wwZriBm1tDINaCLpM0u6e3njFKqqz8=;
 b=c4DSsGL+gSZgbz+n2h8edyY0JJSvwEEgzPnwBX95vBPy6Jo1EfzhmPkDEa8H9/MVzK
 t8HyaHp1WWknn4I/eRHkZDe04Zsq8YTFKXYAjHjJQQFjt6mGtu3pM88N66pPpeNjLEyi
 ywu66J9oDU1U6oJiE1LTOZqNUz2NWS+j5L+Kc/bWhAoufeD6kE0XJZrDmx19bszKnwrz
 jTzPXFwrURlXkzRUI8GFvZ6mIaN7gjH93Wyf6IUM+MMaob3Bb4BjcorbXm1rsY+3ncge
 l1fh3N80PoF7be3xgTxUPJE4G2WPUzxM8UqL08QeKWKsP6GCyZMnNKmTdoc36lDzT3vi
 SyQw==
X-Gm-Message-State: APjAAAXLC2+BCAXguNVFAZHEvb6wOUaVC30UTapCy/4P2W4vCDOIuUz1
 eBKGKQtXbWmDiYtUP2aWUUs=
X-Google-Smtp-Source: APXvYqyfTI8+XVU3RlrvIfXGdBG0oWSlgTPqBGikvSD/heK932h0ralSPKkMiJh26I6zh+Fs+wYfXg==
X-Received: by 2002:a1c:e90e:: with SMTP id q14mr12593233wmc.108.1576234029069; 
 Fri, 13 Dec 2019 02:47:09 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40f6:4600:c498:c79c:5e:9634])
 by smtp.gmail.com with ESMTPSA id x17sm8764911wrt.74.2019.12.13.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 02:47:08 -0800 (PST)
Date: Fri, 13 Dec 2019 11:47:06 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191213104706.xnpqaehmtean3mkd@ltop.local>
References: <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
 <20191212205338.GB11802@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212205338.GB11802@worktop.programming.kicks-ass.net>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Mark Rutland <mark.rutland@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 12, 2019 at 09:53:38PM +0100, Peter Zijlstra wrote:
> Now, looking at the current GCC source:
> 
>   https://github.com/gcc-mirror/gcc/blob/97d7270f894395e513667a031a0c309d1819d05e/gcc/c/c-parser.c#L3707
> 
> it seems that __typeof__() is supposed to strip all qualifiers from
> _Atomic types. That lead me to try:
> 
> 	typeof(_Atomic typeof(p)) __p = (p);
> 
> But alas, I still get the same junk you got for ool_store_release() :/

I was checking this to see if Sparse was ready to support this.
I was a bit surprised because at first sigth GCC was doing as
it claims (typeof striping const & volatile on _Atomic types)
but your exampe wasn't working. But it's working if an
intermediate var is used:
	_Atomic typeof(p) tmp;
	typeof(tmp) __p = (p);
or, uglier but probably more practical:
	typeof(({_Atomic typeof(p) tmp; })) __p = (p);

Go figure!

OTOH, at least on GCC 8.3, it seems to always do the same with
volatiles than it does with consts.

-- Luc Van Oostenryck
