Return-Path: <SRS0=7wTx=7R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B409C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:19:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EF420663
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 11:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+N79pq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EF420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49d3Fb1tkbzDqnk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 21:19:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=q+N79pq8; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49d3CZ6XSbzDqld
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 21:17:30 +1000 (AEST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EED9C20663;
 Thu,  4 Jun 2020 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591269448;
 bh=TD23lUmHIH4fDCI+FcUMyA2oC82x0Bai1U3IaWCZkEg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q+N79pq8MdT0YLoIZImKz0WOU1Deu3HxicOZmkxWveX1KC5zJCO5lUjeefXxlaNlA
 nvlomYyqjE0JUNTYYDsUoKmE5l0f+d/we/lrFkL+eaux0MSAA9zCr0YPF7jbG2a1Yb
 aMHs/qa37gU+2K/Avj/2JrsRlzZ3m9ESbYbEixdA=
Date: Thu, 4 Jun 2020 12:17:23 +0100
From: Will Deacon <will@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: linux-next: build failure on powerpc 8xx with 16k pages
Message-ID: <20200604111723.GA1267@willie-the-truck>
References: <dc2b16e1-b719-5500-508d-ae97bf50c4a6@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2b16e1-b719-5500-508d-ae97bf50c4a6@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, peterz@infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi, [+Peter]

On Thu, Jun 04, 2020 at 10:48:03AM +0000, Christophe Leroy wrote:
> Using mpc885_ads_defconfig with CONFIG_PPC_16K_PAGES instead of
> CONFIG_PPC_4K_PAGES, getting the following build failure:
> 
>   CC      mm/gup.o
> In file included from ./include/linux/kernel.h:11:0,
>                  from mm/gup.c:2:
> In function 'gup_hugepte.constprop',
>     inlined from 'gup_huge_pd.isra.78' at mm/gup.c:2465:8:
> ./include/linux/compiler.h:392:38: error: call to '__compiletime_assert_257'
> declared with attribute error: Unsupported access size for
> {READ,WRITE}_ONCE().
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ./include/linux/compiler.h:373:4: note: in definition of macro
> '__compiletime_assert'
>     prefix ## suffix();    \
>     ^
> ./include/linux/compiler.h:392:2: note: in expansion of macro
> '_compiletime_assert'
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^
> ./include/linux/compiler.h:405:2: note: in expansion of macro
> 'compiletime_assert'
>   compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
>   ^
> ./include/linux/compiler.h:291:2: note: in expansion of macro
> 'compiletime_assert_rwonce_type'
>   compiletime_assert_rwonce_type(x);    \
>   ^
> mm/gup.c:2428:8: note: in expansion of macro 'READ_ONCE'
>   pte = READ_ONCE(*ptep);
>         ^
> In function 'gup_get_pte',
>     inlined from 'gup_pte_range' at mm/gup.c:2228:9,
>     inlined from 'gup_pmd_range' at mm/gup.c:2613:15,
>     inlined from 'gup_pud_range' at mm/gup.c:2641:15,
>     inlined from 'gup_p4d_range' at mm/gup.c:2666:15,
>     inlined from 'gup_pgd_range' at mm/gup.c:2694:15,
>     inlined from 'internal_get_user_pages_fast' at mm/gup.c:2785:3:

At first glance, this looks like a real bug in the 16k page code -- you're
loading the pte non-atomically on the fast GUP path and so you're prone to
tearing, which probably isn't what you want. For a short-term hack, I'd
suggest having CONFIG_HAVE_FAST_GUP depend on !CONFIG_PPC_16K_PAGES, but if
you want to support this them you'll need to rework your pte_t so that it
can be loaded atomically.

Will
