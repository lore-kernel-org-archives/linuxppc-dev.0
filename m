Return-Path: <SRS0=QKeg=YJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1517C4360C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 06:07:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501F02067D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 06:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+y+HbY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501F02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46tMKF0pCGzDqvy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 17:07:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+8addb06ce43a55e758ee+5897+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46tMHK07fJzDqNP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2019 17:06:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tJFiarsuWBHNqpnLytXxWUC0DYU5NvHm76+f4n5h+Gk=; b=j+y+HbY7UYO+xDRqWixdDXfqd
 EAVLPJ+DeUYg0JF7OpZKKoEpWAD1B/85+VYqZjcwaUgLmg8upwTz51rS5FoDPbxAUF5L+zy3mjoyb
 MRjDLs+n1D31/6LmBfRu4ItJeeznQP2iWDKxNYWMr/kprtbfm84vNLIzyGsigHfDNcOEFig8GlI8V
 CJHtOYeQGXD05JBRi9Icj2rfGG9YRUGdATOSh4b8/Z/Bc1TXM+/5Ud/Ro1J7yI222w9aDP/nO+i6H
 K+dxwzYau3fetrujY/iCrBDlLxZ8Bmdku6mM/IBGPdK6rDeOit9sBNJ61jV29w5xS9mrkXF6rqCsE
 5ndjzRibg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iKcRY-0003Pa-Iq; Wed, 16 Oct 2019 06:05:56 +0000
Date: Tue, 15 Oct 2019 23:05:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm/book3s64/hash: Update 4k PAGE_SIZE kernel
 mapping
Message-ID: <20191016060556.GA7279@infradead.org>
References: <20191016055130.10533-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016055130.10533-1-aneesh.kumar@linux.ibm.com>
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
Cc: Cameron Berkenpas <cam@neo-zeon.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 16, 2019 at 11:21:30AM +0530, Aneesh Kumar K.V wrote:
> With commit: 0034d395f89d ("powerpc/mm/hash64: Map all the kernel
> regions in the same 0xc range"), kernel now split the 64TB address range
> into 4 contexts each of 16TB. That implies we can do only 16TB linear
> mapping. This results in boot failure on some P9 systems.
> 
> Fix this by redoing the hash 4k mapping as below.
> 
>  vmalloc start     = 0xd000000000000000
>  IO start          = 0xd000380000000000
>  vmemmap start     = 0xf000000000000000
> 
> Vmalloc area is now 56TB in size and IO remap 8TB.

Btw, is there any good reason to keep the vmalloc and ioremap ranges
separate on powerpc?  Most architectures just use the low-level vmap
code to implement both and share a range.
