Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D36C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:43:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056A364E31
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 13:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056A364E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbLYQ5jnPzDsbK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 00:42:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKY95VWWzDsbM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:33 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKY71QGrz9sCD; Wed, 10 Feb 2021 23:57:29 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, "Christopher M. Riedl" <cmr@codefail.de>
In-Reply-To: <20210206072342.5067-1-cmr@codefail.de>
References: <20210206072342.5067-1-cmr@codefail.de>
Subject: Re: [PATCH v2] powerpc64/idle: Fix SP offsets when saving GPRs
Message-Id: <161296172518.3178259.1308070818778001883.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:29 +1100 (AEDT)
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

On Sat, 6 Feb 2021 01:23:42 -0600, Christopher M. Riedl wrote:
> The idle entry/exit code saves/restores GPRs in the stack "red zone"
> (Protected Zone according to PowerPC64 ELF ABI v2). However, the offset
> used for the first GPR is incorrect and overwrites the back chain - the
> Protected Zone actually starts below the current SP. In practice this is
> probably not an issue, but it's still incorrect so fix it.
> 
> Also expand the comments to explain why using the stack "red zone"
> instead of creating a new stackframe is appropriate here.

Applied to powerpc/next.

[1/1] powerpc64/idle: Fix SP offsets when saving GPRs
      https://git.kernel.org/powerpc/c/73287caa9210ded6066833195f4335f7f688a46b

cheers
