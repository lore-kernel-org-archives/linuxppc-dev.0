Return-Path: <SRS0=LqqS=B4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B846DC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 14:17:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78649207D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2020 14:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78649207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWCfY6ztfzDqZm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 00:17:25 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWCDW5zQ7zDqVb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2020 23:58:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BWCDW3NB1z9sTS; Tue, 18 Aug 2020 23:58:19 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <6eddca2d5611fd57312a88eae31278c87a8fc99d.1596641224.git.christophe.leroy@csgroup.eu>
References: <6eddca2d5611fd57312a88eae31278c87a8fc99d.1596641224.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kasan: Fix KASAN_SHADOW_START on BOOK3S_32
Message-Id: <159775907943.1766076.16539291819681115078.b4-ty@ellerman.id.au>
Date: Tue, 18 Aug 2020 23:58:19 +1000 (AEST)
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

On Wed, 5 Aug 2020 15:27:29 +0000 (UTC), Christophe Leroy wrote:
> On BOOK3S_32, when we have modules and strict kernel RWX, modules
> are not in vmalloc space but in a dedicated segment that is
> below PAGE_OFFSET.
> 
> So KASAN_SHADOW_START must take it into account.
> 
> MODULES_VADDR can't be used because it is not defined yet
> in kasan.h

Applied to powerpc/fixes.

[1/1] powerpc/kasan: Fix KASAN_SHADOW_START on BOOK3S_32
      https://git.kernel.org/powerpc/c/48d2f0407be7a36e8f20be37ec9121e021ef3964

cheers
