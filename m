Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85667C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 12:21:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3319C214DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 12:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WzkhUBZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3319C214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wqQC2xqjzDr3G
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:21:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=WzkhUBZp; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wqB64pS9zDqVm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 22:10:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HbahpenxFs2WlSOpyCi+8NS4LjYRGaVKCZV3KQuvnWE=; b=WzkhUBZpY4XeQFrQo4R81bDqrJ
 36m4MCGHB29NFSPoQpBAsq9xDbv1faU4N+Nnbnsy4oyy2aiY4Vg0xEBWtQVmseQj42B+ju7jgLE0h
 3GhHV1Jf7KS1TwLjvCRHHGK0C0dfuiMOtevlOvQKGROGPHvPvfnjTTfrcZ0pzMO/23f3c89uzIqSV
 9bvhUw20a3ENhS+sKjYNuB5Oe+jKg2zO8RMFYhW3WQFcjGoKVf+UixKnZ+IS8GfyU71v4MY/8Rtlp
 NwHKhNvLOMm+eWil7vpQunwQCmD8P1reNXEULuIeYVGXzD6+i3CN2Q+3nc4aP7gBHUvVrhnUhU5Ed
 mzyAXJzA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jLQaG-0002nC-3d; Mon, 06 Apr 2020 12:10:32 +0000
Date: Mon, 6 Apr 2020 05:10:32 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] exec: open code copy_string_kernel
Message-ID: <20200406121032.GX21484@bombadil.infradead.org>
References: <20200406120312.1150405-1-hch@lst.de>
 <20200406120312.1150405-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406120312.1150405-7-hch@lst.de>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 06, 2020 at 02:03:12PM +0200, Christoph Hellwig wrote:
> +	int len = strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating null */;

If you end up doing another version of this, it's a terminating NUL, not null.

I almost wonder if we shouldn't have

#define TERMINATING_NUL		1

in kernel.h.

	int len = strnlen(arg, MAX_ARG_STRLEN) + TERMINATING_NUL;

has a certain appeal.  There's the risk people might misuse it though ...

	str[end] = TERMINATING_NUL;

so probably not a good idea.
