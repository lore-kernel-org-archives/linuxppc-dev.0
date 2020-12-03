Return-Path: <SRS0=jgKV=FH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5AC64E7A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 12:35:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9B6206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 12:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9B6206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmwKZ3j2WzDqZL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 23:35:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=kN0UfyVg; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmwFL0Gg2zDrFL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2020 23:31:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2bjAG/22Xb88hJcxvz1EpCKJuf3oMonmSEWRI/Pfre8=; b=kN0UfyVg5AFOJTIput+Nt86Ekc
 Q3LG5weU1QXDniBRaUvnMsL7gDgKEdCY5djySEvEofodaN1oOJzQyhc1Kf2/yO4W0VNfTEksLApbT
 A7Zi3WkZDAXP4ejREwrP3JYM18d0SnEFU/HmbURuGmvuY6Oezfkiz1aIsxY0nHJGzo5KPTCSHarUI
 u3Yj4gaRjHW1Br4I8C/SIXsIstOJ5pyAIpUodg1RBA7oTCEEJdBXkfai7rjojy37PucTs0pEh6BEr
 Z4KFyjpIxNUiC+YtkWgZ9KwSFPTGRMAm4wn2reffMSzX/xrfLSVu656ADBhfEBiUC3U7LtZHRMja2
 3DiMaunw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kknlh-0007Ex-HX; Thu, 03 Dec 2020 12:31:29 +0000
Date: Thu, 3 Dec 2020 12:31:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [MOCKUP] x86/mm: Lightweight lazy mm refcounting
Message-ID: <20201203123129.GH11935@casper.infradead.org>
References: <7c4bcc0a464ca60be1e0aeba805a192be0ee81e5.1606972194.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c4bcc0a464ca60be1e0aeba805a192be0ee81e5.1606972194.git.luto@kernel.org>
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
 Rik van Riel <riel@surriel.com>, Will Deacon <will@kernel.org>,
 X86 ML <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux-MM <linux-mm@kvack.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 02, 2020 at 09:25:51PM -0800, Andy Lutomirski wrote:
> This code compiles, but I haven't even tried to boot it.  The earlier
> part of the series isn't terribly interesting -- it's a handful of
> cleanups that remove all reads of ->active_mm from arch/x86.  I've
> been meaning to do that for a while, and now I did it.  But, with
> that done, I think we can move to a totally different lazy mm refcounting
> model.

I went back and read Documentation/vm/active_mm.rst recently.

I think it's useful to think about how this would have been handled if
we'd had RCU at the time.  Particularly:

Linus wrote:
> To support all that, the "struct mm_struct" now has two counters: a
> "mm_users" counter that is how many "real address space users" there are,
> and a "mm_count" counter that is the number of "lazy" users (ie anonymous
> users) plus one if there are any real users.

And this just makes me think RCU freeing of mm_struct.  I'm sure it's
more complicated than that (then, or now), but if an anonymous process
is borrowing a freed mm, and the mm is freed by RCU then it will not go
away until the task context switches.  When we context switch back to
the anon task, it'll borrow some other task's MM and won't even notice
that the MM it was using has gone away.
