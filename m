Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2060AC43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 23:13:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA652170E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 23:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9aJejna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA652170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LrGD1fbDzF39C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 09:13:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="V9aJejna";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+52436e8290dcef712379+5513+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="V9aJejna"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LrCZ1SZGzF37q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 09:11:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AYZEMS42FWgWX/fZd9uNWJ95ae3u3tpBODoaU0A9Amg=; b=V9aJejnaDNDprBrqfXpd1FI+0
 8CYuQz71rO2ew/P/VWh1j4gq0TTLZpqIU2Sdm735ttG0HNxP7CrHKYJhxqIdrUGwnISP6EAnd/cYE
 ZKB6nPvEMTRBTEfyw74BMiSZi9mi/Xlf9KKQT3UBUb+YIlKhjDtwJQAobZJSZ28JDvgJ9lR56Ptg7
 Gsy9P72I493S5tt3mJZRELn8uJdCxp/UdsSEsoGdyHwYiki1D8j55lGfz9gsKt+JJY18cvil2f+u9
 V6KgicuXt/Xr/jl3uuSDSYb+5ii7VzhYyEHuIO+KAyzBYPXss2VRlyyQGiVXu+331moWx7MWcu2pb
 WtDa/kmKw==;
Received: from [199.255.44.5] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5esr-0002jp-Sv; Thu, 27 Sep 2018 22:36:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: dma mask related fixups (including full bus_dma_mask support) v2
Date: Thu, 27 Sep 2018 15:35:34 -0700
Message-Id: <20180927223539.28449-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

the dma_get_required_mask dma API implementation has always been a little
odd, in that we by default don't wire it up struct dma_map_ops, but
instead hard code a default implementation.  powerpc and ia64 override
this default and either call a method or otherwise duplicate the default.

This series always enabled the method and just falls back to the previous
default implementation when it is not available, as well as fixing up
a few bits in the default implementations.  This already allows removing
the ia64 override of the implementation, and will also allow to remove
the powerpc one together with a few additional cleanups in the powerpc
code, but those will be sent separately with other powerpc DMA API
patches.  Last but not least the method will allow us to return a more
sensible value for typical iommu dma_ops eventually, but that is left
to another series as well.

Additionally the dma-direct code has been a bit sloppy in when it was
using phys_to_dma in a few places, so this gets fixed up as well as
actually respecting the bus_dma_mask everywhere instead of just
rejecting dma mask that don't fit into it.

Alltogether this should be all core dma-direct changes required to
move powerpc over to the generic code.

Changes since v2:
 - clean up a mask check
 - add various acks
