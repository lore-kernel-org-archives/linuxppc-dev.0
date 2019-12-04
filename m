Return-Path: <SRS0=KnCP=Z2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B3C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 14:02:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BE9205F4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BE9205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47SgXJ3Lq1zDqX8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 01:02:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47SgPf6K5xzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2019 00:56:37 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 95DA468BFE; Wed,  4 Dec 2019 14:56:32 +0100 (CET)
Date: Wed, 4 Dec 2019 14:56:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from
 low memory
Message-ID: <20191204135632.GA31262@lst.de>
References: <20191204123524.22919-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Robin Murphy <robin.murphy@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 04, 2019 at 02:35:24PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
> system has more physical memory than this limit, the swiotlb buffer is not
> addressable because it is allocated from memblock using top-down mode.
> 
> Force memblock to bottom-up mode before calling swiotlb_init() to ensure
> that the swiotlb buffer is DMA-able.
> 
> Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
