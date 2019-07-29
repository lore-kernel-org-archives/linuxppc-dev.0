Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D548C7618B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 15:31:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AB4206E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 15:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nXtEMeP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AB4206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45y3Yr4WVszDqC9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 01:31:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+767bd1556e0605a17a22+5818+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="nXtEMeP3"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45y2Fh2BjJzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 00:32:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LQVvrxHhNozlLrCeoa/r+A8a1Nth6EeS0mzOOGaTr78=; b=nXtEMeP3eXdw0s5WVf3Dx0y+L
 4ZsAitEjAUHYUWry1q9onLEND2XAwrHbDYKRNGr8TWIFA0wrFrLwSmnowIGSxI1DqSfqPONkLhb73
 A+8gZx3qMyyFH0f09dKY/0epJqv7+H8jZDiDg5AxYuZcdQf395uliYZFmldMl7Fmvj3zRR9u73DlQ
 J8IFNkhmCrUOUfUcPtAscivnTfeiOSHPo3y2xDD8UkSW19mGq+ZYnzoSYs4DdoN5diyyFd5CFSrhJ
 GAlG8sA05FpHaTRzs8iyQQkVH02LrPi1xvcBBhskH7fgi8LPtDac8u4FkMu/oMZCDCSANW2GkPrNK
 XqtY66wsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hs6gu-0008Ad-Eg; Mon, 29 Jul 2019 14:31:56 +0000
Date: Mon, 29 Jul 2019 07:31:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Yan <yanaijie@huawei.com>
Subject: Re: [RFC PATCH 02/10] powerpc: move memstart_addr and kernstart_addr
 to init-common.c
Message-ID: <20190729143155.GA11737@infradead.org>
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <20190717080621.40424-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717080621.40424-3-yanaijie@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: wangkefeng.wang@huawei.com, keescook@chromium.org,
 kernel-hardening@lists.openwall.com, thunder.leizhen@huawei.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, jingxiangfeng@huawei.com,
 diana.craciun@nxp.com, paulus@samba.org, fanchengyang@huawei.com,
 linuxppc-dev@lists.ozlabs.org, yebin10@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I think you need to keep the more restrictive EXPORT_SYMBOL_GPL from
the 64-bit code to keep the intention of all authors intact.
