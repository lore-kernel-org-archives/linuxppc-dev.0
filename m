Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A733C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 06:35:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBB061104
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 06:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBB061104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNxrY5Q39z3bq6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 16:35:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNxr904rkz2ypn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 16:34:47 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A92C068B05; Mon, 19 Apr 2021 08:34:41 +0200 (CEST)
Date: Mon, 19 Apr 2021 08:34:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/1] mm: Fix struct page layout on 32-bit systems
Message-ID: <20210419063441.GA18787@lst.de>
References: <20210411114307.5087f958@carbon>
 <20210411103318.GC2531743@casper.infradead.org>
 <20210412011532.GG2531743@casper.infradead.org>
 <20210414101044.19da09df@carbon>
 <20210414115052.GS2531743@casper.infradead.org>
 <20210414211322.3799afd4@carbon>
 <20210414213556.GY2531743@casper.infradead.org>
 <a50c3156fe8943ef964db4345344862f@AcuMS.aculab.com>
 <20210415200832.32796445@carbon>
 <20210416152755.GL2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416152755.GL2531743@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Arnd Bergmann <arnd@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 David Laight <David.Laight@aculab.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Matteo Croce <mcroce@linux.microsoft.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 16, 2021 at 04:27:55PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 15, 2021 at 08:08:32PM +0200, Jesper Dangaard Brouer wrote:
> > See below patch.  Where I swap32 the dma address to satisfy
> > page->compound having bit zero cleared. (It is the simplest fix I could
> > come up with).
> 
> I think this is slightly simpler, and as a bonus code that assumes the
> old layout won't compile.

So, why do we even do this crappy overlay of a dma address?  This just
all seems like a giant hack.  Random subsystems should not just steal
a few struct page fields as that just turns into the desasters like the
one we've seen here or probably something worse next time.
