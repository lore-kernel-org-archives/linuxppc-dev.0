Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E55C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 19:04:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA6520869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 19:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA6520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pwsN0zH5zDq6W
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:04:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=mst@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pwqR1XrnzDqQg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 06:02:43 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0177CA0484;
 Tue, 29 Jan 2019 19:02:41 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
 by smtp.corp.redhat.com (Postfix) with SMTP id DA0CC5C893;
 Tue, 29 Jan 2019 19:02:37 +0000 (UTC)
Date: Tue, 29 Jan 2019 14:02:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190129134750-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87womn8inf.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 29 Jan 2019 19:02:41 +0000 (UTC)
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
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
> 
> Fixing address of powerpc mailing list.
> 
> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> 
> > Hello,
> >
> > With Christoph's rework of the DMA API that recently landed, the patch
> > below is the only change needed in virtio to make it work in a POWER
> > secure guest under the ultravisor.
> >
> > The other change we need (making sure the device's dma_map_ops is NULL
> > so that the dma-direct/swiotlb code is used) can be made in
> > powerpc-specific code.
> >
> > Of course, I also have patches (soon to be posted as RFC) which hook up
> > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> >
> > What do you think?
> >
> > From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> >
> > The host can't access the guest memory when it's encrypted, so using
> > regular memory pages for the ring isn't an option. Go through the DMA API.
> >
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Well I think this will come back to bite us (witness xen which is now
reworking precisely this path - but at least they aren't to blame, xen
came before ACCESS_PLATFORM).

I also still think the right thing would have been to set
ACCESS_PLATFORM for all systems where device can't access all memory.

But I also think I don't have the energy to argue about power secure
guest anymore.  So be it for power secure guest since the involved
engineers disagree with me.  Hey I've been wrong in the past ;).

But the name "sev_active" makes me scared because at least AMD guys who
were doing the sensible thing and setting ACCESS_PLATFORM (unless I'm
wrong? I reemember distinctly that's so) will likely be affected too.
We don't want that.

So let's find a way to make sure it's just power secure guest for now
pls.

I also think we should add a dma_api near features under virtio_device
such that these hacks can move off data path.

By the way could you please respond about virtio-iommu and
why there's no support for ACCESS_PLATFORM on power?

I have Cc'd you on these discussions.


Thanks!


> > ---
> >  drivers/virtio/virtio_ring.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd7e755484e3..321a27075380 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * not work without an even larger kludge.  Instead, enable
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> > +	 *
> > +	 * Also, if guest memory is encrypted the host can't access
> > +	 * it directly. In this case, we'll need to use the DMA API.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() || sev_active())
> >  		return true;
> >
> >  	return false;
> 
> 
> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center
