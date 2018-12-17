Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915F0C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 17:38:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E73920675
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 17:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8UdykSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E73920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JT0B6mcbzDqVD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 04:38:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="S8UdykSu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+f285e7ccc7f72256db92+5594+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JSxP2DGkzDqXM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 04:36:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JmBmThrp855oOtumKAAjqsJEcOKvJL8IthTlNgmmRsI=; b=S8UdykSusuB8NWUm7zK4FEJth
 600mTxEKqdPjkgY5cL4D8Uiy7xJGksiMZHXnEHfLFnEkzb6RHGlWqftWKOtjfEfR1oLDGXjM57p6O
 b0H0oyvg3Pj4gBCkB8+RJuwoiS3X5DlGaA4UjZG0Ar/bUhsblR+uATnN3r9Quxge/HD4mQ083TJqF
 wltiJA//ueGWYT6xPFIv8JdGp+mPKtKBy9WJh/MExxs10iL3pOMaDAOgb0LVd+LFr6HsB5SuwNrw3
 FsSDN7zK4cmXLG0+bwJ2Qw1krVvB72FY2QW2Q9Rm1DfQrcHX632Rrti4V2gMwukJ5cE7qYZorWmqU
 kbyIB8ong==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gYwny-0002XH-AC; Mon, 17 Dec 2018 17:35:46 +0000
Date: Mon, 17 Dec 2018 09:35:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390/pci: handle function enumeration after sriov
 enablement
Message-ID: <20181217173546.GA4106@infradead.org>
References: <20181212215453.GJ99796@google.com>
 <20181213175428.87520-2-sebott@linux.ibm.com>
 <20181214131245.GB2606@infradead.org>
 <20181214131802.GA13950@infradead.org>
 <alpine.LFD.2.21.1812171806330.28490@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812171806330.28490@schleppi>
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

On Mon, Dec 17, 2018 at 06:30:18PM +0100, Sebastian Ott wrote:
> Something like this:
> https://lore.kernel.org/linux-pci/20181212215453.GJ99796@google.com/T/#m649d86ea3c65f669c74d048f89afbaf473876ac3

No, I literally meant a flag to skip the work.  Think about it: there
is a standard way to probe VFs, which comes from what is defined in the
PCIe spec itself.  It just turns out s390 for some weird reason decides
to already let the VFs show up basically like PFs.  There really should
be no reason to branch out into per-arch code here as there really
isn't much to do on a per-arch level.  More just a quirk for the
firmware is buggy and already reports the VFs to us, so skip the
probing.
