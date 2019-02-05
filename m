Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8327AC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:16:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E3120844
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E3120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v8pB0SLQzDqPH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 03:16:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=mst@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v8lP516JzDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 03:13:53 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 257B0804E9;
 Tue,  5 Feb 2019 16:13:51 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.sin2.redhat.com [10.67.116.138])
 by smtp.corp.redhat.com (Postfix) with SMTP id CFDB560BF1;
 Tue,  5 Feb 2019 16:13:41 +0000 (UTC)
Date: Tue, 5 Feb 2019 11:13:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190205111128-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
 <20190129213137-mutt-send-email-mst@kernel.org>
 <20190130074427.GA29516@lst.de>
 <875ztzxvw2.fsf@morokweng.localdomain>
 <20190204152416-mutt-send-email-mst@kernel.org>
 <20190205072407.GA4311@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205072407.GA4311@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 05 Feb 2019 16:13:51 +0000 (UTC)
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
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 05, 2019 at 08:24:07AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 04, 2019 at 04:38:21PM -0500, Michael S. Tsirkin wrote:
> > It was designed to make, when set, as many guests as we can work
> > correctly, and it seems to be successful in doing exactly that.
> > 
> > Unfortunately there could be legacy guests that do work correctly but
> > become slow. Whether trying to somehow work around that
> > can paint us into a corner where things again don't
> > work for some people is a question worth discussing.
> 
> The other problem is that some qemu machines just throw passthrough
> devices and virtio devices on the same virtual PCI(e) bus, and have a
> common IOMMU setup for the whole bus / root port / domain.  I think
> this is completely bogus, but unfortunately it is out in the field.
> 
> Given that power is one of these examples I suspect that is what
> Thiago referes to.  But in this case the answer can't be that we
> pile on hack ontop of another, but instead introduce a new qemu
> machine that separates these clearly, and make that mandatory for
> the secure guest support.

That could we one approach, assuming one exists that guests
already support.

-- 
MST
