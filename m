Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA54C63777
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 13:12:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6397421D46
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 13:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HkGfyJk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6397421D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChdTQ51ThzDq6k
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 00:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=merlin.20170209 header.b=HkGfyJk1; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChdG02R6BzDrBm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2020 00:02:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=hLIHvPXWJN2+QMWWENMIdOYVjlW+boeIBinzicswIpY=; b=HkGfyJk1ztoJSLeBDC3iOhNo3N
 Sx5j5ga/YCWb+wo++NMG/gnhL8S2WoKL/BA8uMnAuRL6+dGgEPsPmFaB1YkumjBwT+RDRlmVqZUHy
 RrN2ZEOhU1S9r4u59aZNXKHMJQfwAW/EyK9+ZKrekfqn5zmI4zD5HBdsgoTCvfeh13ksse0O1j2+H
 qWwdpILV07vgJNJZRnMBCJqLkt/baSIDzvSERP32q4SxBNxOQR1NKSujVynxGfsd78xtlRS64oEZl
 lkALVz+fg1yw7AmFKOVjH/jjOV6RImvn9mbICf1Vnd+Q5qqdr2W/tCYxTDF9n6OcUeRuCB44hnOKs
 VgfZEgPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiGuS-0007ck-Am; Thu, 26 Nov 2020 13:02:04 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D49C9305CC3;
 Thu, 26 Nov 2020 14:02:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id BDD89201E6BBD; Thu, 26 Nov 2020 14:02:02 +0100 (CET)
Date: Thu, 26 Nov 2020 14:02:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/6] mm/gup: Provide gup_get_pte() more generic
Message-ID: <20201126130202.GH2414@hirez.programming.kicks-ass.net>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.036370527@infradead.org>
 <20201126124300.GP4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126124300.GP4327@casper.infradead.org>
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
Cc: mark.rutland@arm.com, aneesh.kumar@linux.ibm.com,
 linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 alexander.shishkin@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, linux-kernel@vger.kernel.org, acme@kernel.org,
 davem@davemloft.net, dave.hansen@intel.com, ak@linux.intel.com,
 eranian@google.com, sparclinux@vger.kernel.org, jolsa@redhat.com,
 mingo@kernel.org, kirill.shutemov@linux.intel.com, kan.liang@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 26, 2020 at 12:43:00PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 01:01:15PM +0100, Peter Zijlstra wrote:
> > +#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
> > +/*
> > + * WARNING: only to be used in the get_user_pages_fast() implementation.
> > + * With get_user_pages_fast(), we walk down the pagetables without taking any
> > + * locks.  For this we would like to load the pointers atomically, but sometimes
> > + * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
> > + * we do have is the guarantee that a PTE will only either go from not present
> > + * to present, or present to not present or both -- it will not switch to a
> > + * completely different present page without a TLB flush in between; something
> > + * that we are blocking by holding interrupts off.
> 
> I feel like this comment needs some love.  How about:
> 
>  * For walking the pagetables without holding any locks.  Some architectures
>  * (eg x86-32 PAE) cannot load the entries atomically without using
>  * expensive instructions.  We are guaranteed that a PTE will only either go
>  * from not present to present, or present to not present -- it will not
>  * switch to a completely different present page without a TLB flush
>  * inbetween; which we are blocking by holding interrupts off.
> 
> And it would be nice to have an assertion that interrupts are disabled
> in the code.  Because comments are nice, but nobody reads them.

Quite agreed, I'll stick a separate patch on with the updated comment
and a lockdep_assert_irqs_disabled() in. I'm afraid that latter will make
for header soup though :/

We'll see, let the robots have it.
