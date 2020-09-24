Return-Path: <SRS0=a6W3=DB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81540C4363D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 13:05:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DD521D91
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 13:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DD521D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BxwJW0wFCzDq9Z
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2020 23:05:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BxvWW13FgzDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2020 22:29:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BxvWV4ttLz9sSC; Thu, 24 Sep 2020 22:29:58 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BxvWV0FCMz9sTN; Thu, 24 Sep 2020 22:29:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200917024509.3253837-1-mpe@ellerman.id.au>
References: <20200917024509.3253837-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/process: Fix uninitialised variable error
Message-Id: <160095058615.31531.17011740631199142404.b4-ty@ellerman.id.au>
Date: Thu, 24 Sep 2020 22:29:57 +1000 (AEST)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 17 Sep 2020 12:45:09 +1000, Michael Ellerman wrote:
> Clang, and GCC with -Wmaybe-uninitialized, can't see that val is
> unused in get_fpexec_mode():
> 
>   arch/powerpc/kernel/process.c:1940:7: error: variable 'val' is used
>   uninitialized whenever 'if' condition is true
> 		  if (cpu_has_feature(CPU_FTR_SPE)) {
> 		      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/process: Fix uninitialised variable error
      https://git.kernel.org/powerpc/c/d208e13c6a2277d9fb71fad6a1394c70bdd7b634

cheers
