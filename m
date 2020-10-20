Return-Path: <SRS0=mlYb=D3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2580DC4363A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 18:37:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024F121481
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 18:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="eDpMzgLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024F121481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CG2Rk08WnzDqbY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2020 05:37:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cmpxchg.org (client-ip=2607:f8b0:4864:20::744;
 helo=mail-qk1-x744.google.com; envelope-from=hannes@cmpxchg.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=cmpxchg-org.20150623.gappssmtp.com
 header.i=@cmpxchg-org.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=eDpMzgLF; dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CG2PY6dDvzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2020 05:35:40 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id z6so2532620qkz.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2020 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3bEaFKRFPS/Sh2t/CI7BcAkihd22K7XwWCcLf9zY4qI=;
 b=eDpMzgLFh+ac8jAdLmXWxs6dOFK/N7u2zhExMvQXU8gLIswGz9dNocWqqJLN/Xmuyt
 rBZ11B5sKUn96yasph0hl8x+8p+BefVuTBQ57aVaVezZHGTE+dm7xTQUyZgeXJkWn5W+
 oERWzaHuOUxRgFPRQORIMQtYcxgIHrWVgfWZux9HU6I7iOtcWighiB11uEEK5eshXa4E
 /Kbn72MSSNUyOKG4Q+P0k7AMskR5VssEg83c6RQlKEjv4LmdJawNB7uv3SRRo07tmzSY
 81pzjCbWB2Jcp/mOXq+/LutPBIhoueU67Qr4WAOrQCbjpgCIbW+OKz5ZPM9mgII8Cjd2
 5CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3bEaFKRFPS/Sh2t/CI7BcAkihd22K7XwWCcLf9zY4qI=;
 b=gZSgenUG0sveAoSs443k9YuCtimrFvCpFu8Do06snCKoOLyzOQjJ1cWhOlknC/iyyz
 QMwJtLJhmh1jW5O3vTrxLnPQqy3ZDvhpLIvxr1CLz1QAM9iBE85dL5d7XZUGSkFg/9EG
 FgeiAKTkdMReqF23iDTRRa06d/QuPTev0rh8WpyanNeInrqjVOVUbXOY0MlsAW1kEv3g
 pwDvv2OKJb0L6fxO1g7qKJqPdDE+KzN7SgURCY1l5Z/0StOS67pEbEoKwHv4O91mGHzH
 vEoUU3Ezfx0IcEbi7xtEnMGHZjg8ITD5qutBlpN8DIARvVDGX+VZVTos+nCOTosQgjoR
 pK/Q==
X-Gm-Message-State: AOAM530t1jJo4nBQsS08+MmQ11j11zuDvjPITLHIoPN4y7tcJlq6lUsI
 aAFYGjWStZICDs/VaW0hzT4kpg==
X-Google-Smtp-Source: ABdhPJx8oRW/tNaZSiG9aS3bionlit1W0IoCBu7VK3t7uOuxJeysus0w6e9BOQuYqJS0NUhYqBefDg==
X-Received: by 2002:a37:a5cd:: with SMTP id o196mr3952603qke.374.1603218933224; 
 Tue, 20 Oct 2020 11:35:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:c52c])
 by smtp.gmail.com with ESMTPSA id o2sm1151174qkm.96.2020.10.20.11.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 11:35:32 -0700 (PDT)
Date: Tue, 20 Oct 2020 14:33:55 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: mm: Question about the use of 'accessed' flags and pte_young()
 helper
Message-ID: <20201020183355.GB397401@cmpxchg.org>
References: <31ef1305-1fd4-8159-a2ca-e9968a568ff0@csgroup.eu>
 <ed3d1e19-b18b-d10e-2c86-0fb7ce3a431d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3d1e19-b18b-d10e-2c86-0fb7ce3a431d@suse.cz>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm <linux-mm@kvack.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 20, 2020 at 05:52:07PM +0200, Vlastimil Babka wrote:
> On 10/8/20 11:49 AM, Christophe Leroy wrote:
> > In a 10 years old commit
> > (https://github.com/linuxppc/linux/commit/d069cb4373fe0d451357c4d3769623a7564dfa9f), powerpc 8xx has
> > made the handling of PTE accessed bit conditional to CONFIG_SWAP.
> > Since then, this has been extended to some other powerpc variants.
> > 
> > That commit means that when CONFIG_SWAP is not selected, the accessed bit is not set by SW TLB miss
> > handlers, leading to pte_young() returning garbage, or should I say possibly returning false
> > allthough a page has been accessed since its access flag was reset.
> > 
> > Looking at various mm/ places, pte_young() is used independent of CONFIG_SWAP
> > 
> > Is it still valid the not manage accessed flags when CONFIG_SWAP is not selected ?
> 
> AFAIK it's wrong, reclaim needs it to detect accessed pages on inactive
> list, via page_referenced(), including file pages (page cache) where
> CONFIG_SWAP plays no role. Maybe it was different 10 years ago.

Yes, we require this bit for properly aging mmapped file pages. The
underlying assumption in the referenced commit is incorrect.

> > If yes, should pte_young() always return true in that case ?
> 
> It should best work as intended. If not possible, true is maybe better, as
> false will lead to inactive file list thrashing.

An unconditional true will cause mmapped file pages to be permanently
mlocked / unevictable.

Either way will break some workloads. The only good answer is the
truth :-)
