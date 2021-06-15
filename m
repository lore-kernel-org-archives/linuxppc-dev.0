Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99768C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 05:04:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD176124B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 05:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD176124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3x7h5BKXz3bxS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 15:04:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=deadmen.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3x7G5HG5z3018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 15:04:09 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
 id 1lt1Ec-0006cw-4n; Tue, 15 Jun 2021 13:03:34 +0800
Received: from herbert by gondobar with local (Exim 4.92)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1lt1E3-0001MR-0g; Tue, 15 Jun 2021 13:02:59 +0800
Date: Tue, 15 Jun 2021 13:02:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ira Weiny <ira.weiny@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 09/16] ps3disk: use memcpy_{from,to}_bvec
Message-ID: <20210615050258.GA5208@gondor.apana.org.au>
References: <20210608160603.1535935-1-hch@lst.de>
 <20210608160603.1535935-10-hch@lst.de>
 <20210609014822.GT3697498@iweiny-DESK2.sc.intel.com>
 <20210611065338.GA31210@lst.de>
 <20210612040743.GG1600546@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612040743.GG1600546@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-arch@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-scsi@vger.kernel.org,
 Mike Snitzer <snitzer@redhat.com>, linux-sh@vger.kernel.org,
 Geoff Levand <geoff@infradead.org>, Tero Kristo <t-kristo@ti.com>,
 ceph-devel@vger.kernel.org, linux-mips@vger.kernel.org,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Thomas Gleixner <tglx@linutronix.de>, linux-csky@vger.kernel.org,
 linux-mmc@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 11, 2021 at 09:07:43PM -0700, Ira Weiny wrote:
>
> More recently this was added:
> 
> 7e34e0bbc644 crypto: omap-crypto - fix userspace copied buffer access
> 
> I'm CC'ing Tero and Herbert to see why they added the SLAB check.

Probably because the generic Crypto API has the same check.  This
all goes back to

commit 4f3e797ad07d52d34983354a77b365dfcd48c1b4
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon Feb 9 14:22:14 2009 +1100

    crypto: scatterwalk - Avoid flush_dcache_page on slab pages

    It's illegal to call flush_dcache_page on slab pages on a number
    of architectures.  So this patch avoids doing so if PageSlab is
    true.

    In future we can move the flush_dcache_page call to those page
    cache users that actually need it.

    Reported-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

But I can't find any emails discussing this so let me ask Dave
directly and see if he can tell us what the issue was or might
have been.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
