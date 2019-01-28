Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C39C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 14:17:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E03214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="abkTnfAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E03214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pBXw3NdjzDqKV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 01:17:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+6bbf09bfe8aea74a20fb+5636+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pBW12YnfzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 01:15:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J4RjtSiWSKweAZ3oYKdvzFuzQdIE8J3c1zqykMrcCSY=; b=abkTnfAqvvWKNyHE1Ctv3NZuD
 QcYdhd4VR9lyDAebzCjJExyPWdVMaodQgmix+rL1iz4Y9+HTq0s+Sfoy1wF4yqcopW6J8/YjOJ7Y4
 QOgj6q5AIcw9QmcNGGRGkKLjhH6b/SYc1IL93Rq5023sXZNj1CxJdALl45dVbkQnc5bTVo+QByN+Z
 XWPB4rNkqXxnipCbk9tYUfjiLwReuFn+75FClhNF5mtM9oTsXlycDcGTkFhUfmMRVrVT2qvQQ2CL2
 iW/Knif1WAqu8GqrFqqYE5pNTvtUD3lxoPi2nQpu+DHFCVQP3WDFm4I0AJ7AQ74CLmq2pwNgGWLjC
 lBhJsKNxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1go7hD-0002ex-MI; Mon, 28 Jan 2019 14:15:31 +0000
Date: Mon, 28 Jan 2019 06:15:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 00/11] Refactor exception entry on 40x/6xx/8xx
Message-ID: <20190128141531.GA664@infradead.org>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 28, 2019 at 11:11:10AM +0000, Christophe Leroy wrote:
> This serie refactors exception entry macros for 40x, 6xx and 8xx
> 
> This serie will benefit to the implementation of CONFIG_VMAP, and also
> to Ben's serie on MSR_EE.

We don't have a CONFIG_VMAP.  Do you mean CONFIG_VMAP_STACK ?
