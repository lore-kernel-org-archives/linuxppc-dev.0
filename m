Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56486C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:38:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B134420657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOIoo3ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B134420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fDyN4hWgzDqN7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 02:38:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+5981012d7a5c887cceec+5623+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fDwV1V9qzDqPc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 02:36:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=QOIoo3aegLc0rwJmcNn8m1995
 TAOokrue9dySY2H93GVMe/zs5nZwbbHFBVTEfCUMBBZRLhBrbkykKoG+AJBKT7kSjtJExAkCFC6yl
 UGgKPvcRiZC8DAyXJZkDCOl2pUJxr8GWnhklyrFNsaK2l638x3H5nrGMFJS8KikS8+3e6OIQezhgk
 7JZg0hWVw++HNjACg/wI/V6t1I39+9/qlcapjpgab6n0YUNo/s1AZ3EMtSxwsg66QwmDp8YL1obuw
 p4hp/Grd4KiiFWidHwZFde3Vs9SerAqu4X/erdRM9DSG5Fc7lU/PKz/CH6iFR60pqQpGGoXWTjSQR
 lMvz+6G4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gjQlo-0003e3-6w; Tue, 15 Jan 2019 15:36:52 +0000
Date: Tue, 15 Jan 2019 07:36:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 4/9] riscv/vdso: don't clear PG_reserved
Message-ID: <20190115153652.GD26443@infradead.org>
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114125903.24845-5-david@redhat.com>
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
Cc: linux-s390@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Tobias Klauser <tklauser@distanz.ch>, Palmer Dabbelt <palmer@sifive.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
