Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A368C43334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jun 2022 06:44:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LNG4v4Ytkz3cg8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jun 2022 16:44:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=upfrVsj4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+cd04db8a85bff7cd13dc+6870+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=upfrVsj4;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LNG4B1zhwz3bpb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2022 16:44:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X1rEC5ALaIx0d2HCn0F/BRl3rZtH5sm1gZYoEirDhT0=; b=upfrVsj4EyeIaKq5NLpH7XMypo
	j2NNMqh6rsu23p/22yhoKdcZgeY+leAu8Zgq5JVbY/t+9dA5Yeb+V3udY6zfXdDsA7Rq4iRAvr9ZT
	DsK05XBhDP2pNCIjf/ha16rNdqcEASlC73NiN4LJ4GCTXTkLd4KztPoYUHMHiM7U+bc06qfOPxSbb
	iOPB2V+QEhQunT9QYsLblws9sHf+AUDud35DkLIXL0DKscaLxrU8fg7sxd6zJHikYMjX3ik/g7JV6
	yFqVpbk52teNqSXZ8as9qQUE6KHr42FoCv9CiEpoalrhCNDd7vCG/yrn9/HrD9UrGi+gjK6LhVJkt
	mNGOmPIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Mkh-00Ctus-OR; Wed, 15 Jun 2022 06:43:43 +0000
Date: Tue, 14 Jun 2022 23:43:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wang Wenhu <wenhu.wang@hotmail.com>
Subject: Re: [PATCHv2 2/2] uio:powerpc:mpc85xx: l2-cache-sram uio driver
 implementation
Message-ID: <Yql/n+RuVttucWVf@infradead.org>
References: <YqHy1uXwCLlJmftr@kroah.com>
 <20220615055735.53585-1-wenhu.wang@hotmail.com>
 <SG2PR01MB29513533A1EA32DCB00D10309FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB29513533A1EA32DCB00D10309FAD9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
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

As pointed out last time:  uio is the wrong interface to expose sram,
and any kind of ioremap is the wrong way to map it.
