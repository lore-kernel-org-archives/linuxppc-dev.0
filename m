Return-Path: <SRS0=ugCm=VQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79189C76188
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 06:49:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E690120873
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 06:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPaurXaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E690120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qhS04XG3zDqr5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 16:49:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+0127b854950d050a2cef+5808+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qhPL5WW4zDqpg;
 Fri, 19 Jul 2019 16:46:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dFnx5TzMMcoSpuOVSBkt3bk6kgdNjnFBeNAo17jg5Wk=; b=YPaurXaTajlIneAubMagzsXcC
 s7lRHW6bMmRz5vJoILwjx09X/rG2EhotoYUCEBkPgAPRvep7T9EL8rE9YqZx+lJqfB8dIDW6sgb/f
 5ekxC+GX1RAI38SYBVesXcaEU28iwSanRRpEj/Mj05pSBUI/SgcGybCGhG5k0jsC+sqHbDva5YziK
 mxIe/MvYIGBGZ1jnh1UCzMiQK0WxQFTvo5gFiJu5VkmN0vpIF61rDTSu940GxT4YvZ0Ag8KdzjBt9
 fHnRvSoZHZKlymeW/sRI+JzKkOFfxcda4Fh/aTFGeFCY27ywJsi/kGHel8I3FcBNjtHaD6m2WGCGJ
 +rqfCRqZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hoMfB-0007eC-Mp; Fri, 19 Jul 2019 06:46:41 +0000
Date: Thu, 18 Jul 2019 23:46:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v5 1/7] kvmppc: HMM backend driver to manage pages of
 secure guest
Message-ID: <20190719064641.GA29238@infradead.org>
References: <20190709102545.9187-1-bharata@linux.ibm.com>
 <20190709102545.9187-2-bharata@linux.ibm.com>
 <29e536f225036d2a93e653c56a961fcb@linux.vnet.ibm.com>
 <20190710134734.GB2873@ziepe.ca>
 <20190711050848.GB12321@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711050848.GB12321@in.ibm.com>
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linuxram@us.ibm.com, cclaudio@linux.ibm.com,
 kvm-ppc@vger.kernel.org,
 Linuxppc-dev <linuxppc-dev-bounces+janani=linux.ibm.com@lists.ozlabs.org>,
 linux-mm@kvack.org, jglisse@redhat.com, janani <janani@linux.ibm.com>,
 aneesh.kumar@linux.vnet.ibm.com, paulus@au1.ibm.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 11, 2019 at 10:38:48AM +0530, Bharata B Rao wrote:
> Hmmm... I still find it in upstream, guess it will be removed soon?
> 
> I find the below commit in mmotm.

Please take a look at the latest hmm code in mainline, there have
also been other significant changes as well.
