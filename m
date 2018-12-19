Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F49DC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 07:55:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA6B204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 07:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kj0xTO4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA6B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KRyJ4FJjzDqhb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 18:55:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="kj0xTO4o";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+660da67c63f4a722ad6d+5596+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="kj0xTO4o"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KRvT2gWnzDqD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 18:52:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=alsjOs5Is9hevKk0pOwCMLW0cPl6n+3yxxg+/hycS7E=; b=kj0xTO4oHe+M8g2pa81krF3IJ
 VOJZGn2zDwWBNMuwioIPFSY/rRcn6tXExr6oSPHoOsQTc7KnL4dVpc0nAqldp/mo7K9vUEQbPXw3+
 foxWlQRRpZT/WJYgSBpDAEBymRnstHKE1Jri1iz+EjA9VzRo0ASOotshu7oyyVgBbfTSsNTHAnl39
 T6No29B+SpGGYVQox7uZK1aYnz+iqLmXiR2QoDt7NZHLY6Fzq7n+Wg3TtyFIW63wAoAFqWqGzFVw1
 eHqXKWTDKPyYqNCzNOAyTpZE9h6QdFjUHU3jfABvlL2aTEBJ+txzgVV/CshUeG31yuyjsgaiAySIj
 R3dxnhJiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gZWei-0000TN-LY; Wed, 19 Dec 2018 07:52:36 +0000
Date: Tue, 18 Dec 2018 23:52:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 1/2] PCI/IOV: provide flag to skip VF scanning
Message-ID: <20181219075236.GA1684@infradead.org>
References: <20181217173546.GA4106@infradead.org>
 <20181218101650.23089-1-sebott@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218101650.23089-1-sebott@linux.ibm.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 18, 2018 at 11:16:49AM +0100, Sebastian Ott wrote:
> Provide a flag to skip scanning for new VFs after SRIOV enablement.
> This can be set by implementations for which the VFs are already
> reported by other means.
> 
> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
