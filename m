Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA08C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:42:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FAA2339F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 12:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FAA2339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DG6XC4KvFzDrT2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 23:42:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DG6Qw2kM4zDr2F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 23:37:28 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id B5B9868AFE; Wed, 13 Jan 2021 13:37:21 +0100 (CET)
Date: Wed, 13 Jan 2021 13:37:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Message-ID: <20210113123721.GA1098@lst.de>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-3-tientzu@chromium.org> <X/VrqxcaAMi65CF0@kroah.com>
 <20210113115126.GB29376@lst.de> <X/7nkb/YDpKlakRO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/7nkb/YDpKlakRO@kroah.com>
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
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org, grant.likely@arm.com,
 paulus@samba.org, frowand.list@gmail.com, mingo@kernel.org,
 m.szyprowski@samsung.com, sstabellini@kernel.org, saravanak@google.com,
 xypron.glpk@gmx.de, joro@8bytes.org, rafael.j.wysocki@intel.com,
 Christoph Hellwig <hch@lst.de>, bgolaszewski@baylibre.com,
 xen-devel@lists.xenproject.org, treding@nvidia.com, devicetree@vger.kernel.org,
 will@kernel.org, konrad.wilk@oracle.com, dan.j.williams@intel.com,
 robh+dt@kernel.org, Claire Chang <tientzu@chromium.org>,
 boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, jgross@suse.com,
 drinkcat@chromium.org, linuxppc-dev@lists.ozlabs.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 13, 2021 at 01:29:05PM +0100, Greg KH wrote:
> > > Why does this have to be added here?  Shouldn't the platform-specific
> > > code handle it instead?
> > 
> > The whole code added here is pretty generic.  What we need to eventually
> > do, though is to add a separate dma_device instead of adding more and more
> > bloat to struct device.
> 
> I have no objections for that happening!

I'm pretty sure you agreed to it before in fact.  Now someone just needs
to find the time to do this heavy lifting, where "someone" probably means
me.
