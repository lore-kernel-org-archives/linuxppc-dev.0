Return-Path: <SRS0=1hKA=Z3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E47EC43603
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 08:30:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6401A20707
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 08:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6401A20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47T87M6G8KzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 19:30:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47T84t2Gx6zDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2019 19:28:46 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4D04768C4E; Thu,  5 Dec 2019 09:28:38 +0100 (CET)
Date: Thu, 5 Dec 2019 09:28:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v4 1/2] powerpc/pseries/iommu: Share the per-cpu TCE
 page with the hypervisor.
Message-ID: <20191205082837.GA20298@lst.de>
References: <20191203020850.GA12354@oc0525413822.ibm.com>
 <0b56ce3e-6c32-5f3b-e7cc-0d419a61d71d@ozlabs.ru>
 <20191203040509.GB12354@oc0525413822.ibm.com>
 <a0f19e65-81eb-37bd-928b-7a57a8660e3d@ozlabs.ru>
 <20191203165204.GA5079@oc0525413822.ibm.com>
 <3a17372a-fcee-efbf-0a05-282ffb1adc90@ozlabs.ru>
 <20191204004958.GB5063@oc0525413822.ibm.com>
 <5963ff32-2119-be7c-d1e5-63457888a73b@ozlabs.ru>
 <20191204033618.GA5031@umbus.fritz.box>
 <20191204204232.GE5063@oc0525413822.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204204232.GE5063@oc0525413822.ibm.com>
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
Cc: andmike@us.ibm.com, mst@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 mdroth@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, ram.n.pai@gmail.com,
 cai@lca.pw, tglx@linutronix.de, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 04, 2019 at 12:42:32PM -0800, Ram Pai wrote:
> > The other approach we could use for that - which would still allow
> > H_PUT_TCE_INDIRECT, would be to allocate the TCE buffer page from the
> > same pool that we use for the bounce buffers.  I assume there must
> > already be some sort of allocator for that?
> 
> The allocator for swiotlb is buried deep in the swiotlb code. It is 
> not exposed to the outside-swiotlb world. Will have to do major surgery
> to expose it.

I don't think it would require all that much changes, but I'd really
hate the layering of calling into it directly.  Do we have a struct
device associated with the iommu that doesn't get iommu translations
themselves?  If we do a dma_alloc_coherent on that you'll get the
memory pool for free.
