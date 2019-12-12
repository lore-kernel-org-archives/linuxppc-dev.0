Return-Path: <SRS0=eY2C=2C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B162C43603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 12:55:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C0C22527
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 12:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uy0br++x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C0C22527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47YYg11kPxzDr3D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 23:55:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=198.137.202.133;
 helo=bombadil.infradead.org;
 envelope-from=batv+27c5b7719eecc710bb1c+5954+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="uy0br++x"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47YYbL5cZPzDqy9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2019 23:51:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oSRXOSEob+GwTZ/RqtmUmQb3EJbz7IDcRAl8Llq9EHU=; b=uy0br++xhd/1zHgbIfpoQhVfN
 dvjpj42ZcEZbpSsh3gFbG8q6icweHNtUE3bQGkGT18YZDay/5awdRJeKmi9BUWVxWFvAkNw+MYqHl
 /k8j2aYyVngKxUYevHE4XUc32qDoraVyXHNL22Db1n+qKsfRciTQDC7IZfe2s/ubAUpvOPlsBFdRh
 u7H/sSbLtINFXQvX0eVB48f66DBqT+hQUi5EDiOljS6TUX3pNiPvUGfrjBENxJx54DhZzZm4YCmgf
 SXS2BVfRz0T9TB01N8Hc5nPmZKKH/0lIDDPiTAEl0m78KprC5vubs8PXI+vtsvLfN1tBK0uG4H9FF
 391G5tlCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ifNw4-0002G9-Bs; Thu, 12 Dec 2019 12:51:16 +0000
Date: Thu, 12 Dec 2019 04:51:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/irq: don't use current_stack_pointer() in do_IRQ()
Message-ID: <20191212125116.GA3381@infradead.org>
References: <1bb34d3ea006c308221706290613e6cc5dc3cb74.1575802064.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb34d3ea006c308221706290613e6cc5dc3cb74.1575802064.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Why can't current_stack_pointer be turned into an inline function using
inline assembly?  That would reduce the overhead for all callers.
