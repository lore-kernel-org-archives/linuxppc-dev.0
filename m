Return-Path: <SRS0=zfR2=G3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7693AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jan 2021 11:37:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D3522C9D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jan 2021 11:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D3522C9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DNrb03FvJzDr0f
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jan 2021 22:37:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=90.155.50.34;
 helo=casper.infradead.org;
 envelope-from=batv+340bc88fe697da228867+6363+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=qk0PisdW; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DNrTQ1BxTzDqx0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jan 2021 22:32:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Mqa32asZZp18V8r6vs5C2A7h2wwBEtaIVqomz3yUGRQ=; b=qk0PisdW5PxD45qYqKoEnTKmPp
 WGAn2tGrYEtYqZX8q3ah10/j0LWTe7sSPmfEdXvB3YKoYQ0vxAe7okj1TOJRunIoR+6fUu2WF28MC
 0bL9lqlRSvq0StcMloP9NdW/uEOT3Jp0xT9dKU7nQucG42BYoSJz9VhYEZFwmZ3aTNPMBkr2yrd0A
 qxU9gyj6ymumpsfwl4hKJeqOR7IYpzWiqfTGj1GL/PMQyhGKgdRMscNKersh3RXZa4v4Dtuh1ZuDJ
 Jegr4m4bq4urBmJht4IP+XpPMAVwgO8whUdwl8n3wRPWOoBQGcjdJET4eWP/p4IHpsuXCBst5RQLm
 nWNb4tCA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l3dcN-002udt-CX; Sun, 24 Jan 2021 11:31:46 +0000
Date: Sun, 24 Jan 2021 11:31:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 01/12] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
Message-ID: <20210124113143.GA694255@infradead.org>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210124082230.2118861-2-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, Ding Tianhong <dingtianhong@huawei.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, Zefan Li <lizefan@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jan 24, 2021 at 06:22:19PM +1000, Nicholas Piggin wrote:
> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
> Whether or not a vmap is huge depends on the architecture details,
> alignments, boot options, etc., which the caller can not be expected
> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
> 
> This change teaches vmalloc_to_page about larger pages, and returns
> the struct page that corresponds to the offset within the large page.
> This makes the API agnostic to mapping implementation details.

Maybe enable instead of fix would be better in the subject line?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
