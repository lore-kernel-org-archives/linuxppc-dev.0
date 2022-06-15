Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDC8C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jun 2022 06:50:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNGCd52jnz3c1b
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jun 2022 16:50:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bt/jIrIt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+cd04db8a85bff7cd13dc+6870+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Bt/jIrIt;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LNGBF13gJz3c7h
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2022 16:49:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ysitRv3xhQ/0opcsLZgBDd+5+oJ6cii7ZXUtzDdN2bs=; b=Bt/jIrItpFGMmhD2t82mbrPCxX
	IYvizaoHsLXTzczLly3E94z0QpHSuhSN9nJXXiGv4NnFadJCcOXo6oT8yXuZx4i0GVNN488ufzbnl
	RSnuj9kd866sXQW8SBJZB6qO5G1O0CcMjGrQgP/kAPUkNOwHnquTo9ZlO+ElhY/XwW3ljhYpFLn7y
	7caUyypCtkQHqBSShdA03uyEAIh2tmnI7EQq0bk2BTGaOXWiXlxENEgbzyNk7yyvLHKX+O46QwNod
	6ShKgrSKHg/GXLV37SfkDT+vHpCyPRlBRXkWncr8PgoZEzeSL38kzShP3kiV21Al/Q6NvDWqYx8lD
	eFsi3wog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Mpy-00CvVU-FB; Wed, 15 Jun 2022 06:49:10 +0000
Date: Tue, 14 Jun 2022 23:49:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wang Wenhu <wenhu.wang@hotmail.com>
Subject: Re: [PATCHv2 1/2] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c
 files
Message-ID: <YqmA5h5wCrrVCqoE@infradead.org>
References: <YqHy1uXwCLlJmftr@kroah.com>
 <20220615055735.53585-1-wenhu.wang@hotmail.com>
 <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB295111ED8F547B9F99DB9FA99FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, mdf@kernel.org, trix@redhat.com, bhelgaas@google.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, yilun.xu@intel.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Did you verify that all architectures actually provide a ioremap_prot
prototype?
The header situation for ioremap* is a mess unfortunately.
