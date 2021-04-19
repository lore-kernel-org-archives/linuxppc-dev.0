Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBF0C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 12:24:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175BF61284
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 12:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175BF61284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FP5bf2sRBz30Gv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 22:24:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=N3IAifGb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=N3IAifGb; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FP5bC6ShTz2xYl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 22:24:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FP5b973w3z9vDc;
 Mon, 19 Apr 2021 22:24:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1618835046;
 bh=zZp3+Qorw8JfU+RWCL9IvATK734P2yLMhkBuOspAZko=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=N3IAifGbYvjmxWVnc+5jTzFCtLjePsZZsa2jU/3dphqyToVZZHRVt/9cb85BA0tyv
 vCTMMiCZ+yM3sIJeh8zTfQ+xoxngupIRQGbMkWrqHSCVxD4lj1XfSddVpM9OV3FmDZ
 BFnN6tS/34V+ZJ8uYgWEUnJSk1vNtxgRceEnFhGrPFOf6Mphu5w5hT7NK/MJVAzy0T
 XvZL2M2eehoxjGyWcN6t0QshjxY8QluZlQF7Zf9AuRLUrfDDTYCH4DYW0QH5LRvF4g
 noTOhcg4SsKYZrJWB3nRmWe0zwLVXjfClTMm1x5EuHgf4iogJumNZqBNpSocWCu8r1
 +81UwWbXXj1Tw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Xiongwei Song <sxwjean@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the powerpc tree
In-Reply-To: <CAEVVKH905HJoJ_WVVZadXiy3LG5y+XDpMBVVtUNOwF2MtYTv8Q@mail.gmail.com>
References: <20210419191425.281dc58a@canb.auug.org.au>
 <CAEVVKH905HJoJ_WVVZadXiy3LG5y+XDpMBVVtUNOwF2MtYTv8Q@mail.gmail.com>
Date: Mon, 19 Apr 2021 22:24:05 +1000
Message-ID: <874kg2ea3e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Xiongwei Song <sxwjean@gmail.com> writes:
> Thank you so much Stephen. Sorry for my negligence.

My fault. I forgot to run allyesconfig.

> Should I fix this myself on powerpc tree?

I'll fix it up.

cheers
