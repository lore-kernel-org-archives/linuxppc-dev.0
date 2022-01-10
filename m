Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC29C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Jan 2022 08:44:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JXS784nq4z3bZy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Jan 2022 19:44:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WBUR2YcW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+996bc53df2b455107366+6714+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=WBUR2YcW; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JXS6N53WJz2xsN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jan 2022 19:43:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Rz5UQILXn7pea3r9p2TDb1W76FhMtiR//aY0Ef16jhk=; b=WBUR2YcWT9KX0Z20PuMrEkF8vF
 T5vBucLynGXhR0GQDiq77GcEtg+B0FmIkKxqftEX+3cw6E//o8ho1W+ggWyeaP1v7o0lF7dbtOzv2
 jGEKRc8SqoynjAoCYky6VxRDD5hSY1OQuTmFSJ0DhTyLAUhHujf1r3u2jfEitIYqKvtndZ/5wnYtB
 XG7VW9KExHgPkEK8es34c8k0W58QGIUz5PhtkBWbtGt3z4gLaxmyzMGtjbTZKwkklpwQU/OBZHBMr
 wy68ycUlUQKTDwLyUPgHMAkPh0upwyNKSXqP5uE1U+TwKlS1AOFpdoZ6OwEDWDGNZ9dbTHaiPtL8H
 OODZCISQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1n6qHC-009zF7-N6; Mon, 10 Jan 2022 08:43:38 +0000
Date: Mon, 10 Jan 2022 00:43:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 02/16] floppy: Remove usage of the deprecated
 "pci-dma-compat.h" API
Message-ID: <YdvxugKJMGmMShGG@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <3b8dfc91908327b983a44adc18bd6a6f4c4b2d9f.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8dfc91908327b983a44adc18bd6a6f4c4b2d9f.1641500561.git.christophe.jaillet@wanadoo.fr>
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
Cc: arnd@arndb.de, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, paulus@samba.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
