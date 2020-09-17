Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E5AC43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 11:43:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9F4206BE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 11:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9F4206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsZqX11nJzDqD0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 21:43:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsZSS1LxRzDqWn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 21:27:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BsZSR0Sg2z9sTQ; Thu, 17 Sep 2020 21:27:18 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <8ae4554357da4882612644a74387ae05525b2aaa.1599800716.git.christophe.leroy@csgroup.eu>
References: <8ae4554357da4882612644a74387ae05525b2aaa.1599800716.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kasan: Fix CONFIG_KASAN_VMALLOC for 8xx
Message-Id: <160034201660.3339803.1270264630243029470.b4-ty@ellerman.id.au>
Date: Thu, 17 Sep 2020 21:27:18 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 11 Sep 2020 05:05:38 +0000 (UTC), Christophe Leroy wrote:
> Before the commit identified below, pages tables allocation was
> performed after the allocation of final shadow area for linear memory.
> But that commit switched the order, leading to page tables being
> already allocated at the time 8xx kasan_init_shadow_8M() is called.
> Due to this, kasan_init_shadow_8M() doesn't map the needed
> shadow entries because there are already page tables.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kasan: Fix CONFIG_KASAN_VMALLOC for 8xx
      https://git.kernel.org/powerpc/c/4c42dc5c69a8f24c467a6c997909d2f1d4efdc7f

cheers
