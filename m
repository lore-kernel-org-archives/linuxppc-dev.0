Return-Path: <SRS0=Nfv6=VJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864DC742CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 15:33:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9393A208E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jul 2019 15:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ns5vEMek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9393A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45lcPn2qJhzDqwn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Jul 2019 01:33:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+957344792e76119913ac+5801+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Ns5vEMek"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45lcFX2BSZzDqwF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2019 01:25:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSFwUfQ+/H50jlv9nC2NcDEpesXFjoOMJCpOF9y1rU8=; b=Ns5vEMekqvqVASg++S1r7oq4J
 7/rOrIoU7hOUTkq0bAywv3EwyHUOVa/BcnhdBkvxMncCbhtSMRJLyEh+0Nq2/0M1j17sCDvBKVKgK
 zXTVHoS0lwQ3aK9YV5QgljfYUQTLWukfG62npYmDUIjpwfOVGyW8ozVT/Wz9z1vTTS83sRhtVovxz
 mHkiieslliO1/4hMVrCuL+F4SeoZ4WEgzvJjtbwunmLaUMrDMbIhM988im1q8JEsl0RSZR56DxUAB
 0y6rmBDYfYJu4CjPhklOmfvajjknk5WqIPnZOXJ8sKJoPZ3LZg3RGynwaf6QXN0jGrhak/rbBe9i3
 HVyQWq0vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hlxQj-000423-J9; Fri, 12 Jul 2019 15:25:49 +0000
Date: Fri, 12 Jul 2019 08:25:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 4/4] powerpc/powernv/ioda2: Create bigger
 default window with 64k IOMMU pages
Message-ID: <20190712152549.GB3061@infradead.org>
References: <20190712094509.56695-1-aik@ozlabs.ru>
 <20190712094509.56695-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712094509.56695-5-aik@ozlabs.ru>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Alistair Popple <alistair@popple.id.au>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> -extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
> -					    int nid);
> +extern struct iommu_table *iommu_init_table_res(struct iommu_table *tbl,
> +		int nid, unsigned long res_start, unsigned long res_end);
> +#define iommu_init_table(tbl, nid) iommu_init_table_res((tbl), (nid), 0, 0)

I'd just pass the two additional paramters to iommu_init_table, there
are only 10 callers of it.

> +	 * the max order of allocation possible. The TCE tableis likely to

Missing whitespace between tabke and is.

> +	 * end up being multilevel and with on-demand allocation in place,
> +	 * the initial use is not going to be huge as the default window aims
> +	 * to support cripplied devices (i.e. not fully 64bit DMAble) only.

s/cripplied/crippled/
