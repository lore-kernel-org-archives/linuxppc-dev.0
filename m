Return-Path: <SRS0=Rflt=F2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:24:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B9A229C5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Dec 2020 13:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B9A229C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D0cWS5mq9zDqRm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Dec 2020 00:24:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D0cDJ13flzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2020 00:11:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4D0cDH2XMhz9sWn; Wed, 23 Dec 2020 00:11:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4D0cDG6KdVz9sWg; Wed, 23 Dec 2020 00:11:26 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20201218111619.1206391-1-mpe@ellerman.id.au>
References: <20201218111619.1206391-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/vdso: Block R_PPC_REL24 relocations
Message-Id: <160864266222.1929899.7346084583133036951.b4-ty@ellerman.id.au>
Date: Wed, 23 Dec 2020 00:11:26 +1100 (AEDT)
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
Cc: skirmisher@protonmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 18 Dec 2020 22:16:17 +1100, Michael Ellerman wrote:
> Add R_PPC_REL24 relocations to the list of relocations we do NOT
> support in the VDSO.
> 
> These are generated in some cases and we do not support relocating
> them at runtime, so if they appear then the VDSO will not work at
> runtime, therefore it's preferable to break the build if we see them.

Applied to powerpc/fixes.

[1/3] powerpc/vdso: Block R_PPC_REL24 relocations
      https://git.kernel.org/powerpc/c/42ed6d56ade21f367f27aa5915cc397510cfdef5
[2/3] powerpc/vdso: Don't pass 64-bit ABI cflags to 32-bit VDSO
      https://git.kernel.org/powerpc/c/107521e8039688f7a9548f17919dfde670b911c1
[3/3] powerpc/vdso: Fix DOTSYM for 32-bit LE VDSO
      https://git.kernel.org/powerpc/c/2eda7f11000646909a10298951c9defb2321b240

cheers
