Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37195C169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:37:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABA6D2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA6D2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43q6wW6WKnzDqRf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 13:37:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=mst@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43q6tj2MG8zDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 13:36:13 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 217CEC070154;
 Wed, 30 Jan 2019 02:36:11 +0000 (UTC)
Received: from redhat.com (ovpn-123-79.rdu2.redhat.com [10.10.123.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4060153;
 Wed, 30 Jan 2019 02:36:09 +0000 (UTC)
Date: Tue, 29 Jan 2019 21:36:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190129213137-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 30 Jan 2019 02:36:11 +0000 (UTC)
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
 Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 30, 2019 at 10:24:01AM +0800, Jason Wang wrote:
> 
> On 2019/1/30 上午3:02, Michael S. Tsirkin wrote:
> > On Tue, Jan 29, 2019 at 03:42:44PM -0200, Thiago Jung Bauermann wrote:
> > > Fixing address of powerpc mailing list.
> > > 
> > > Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> > > 
> > > > Hello,
> > > > 
> > > > With Christoph's rework of the DMA API that recently landed, the patch
> > > > below is the only change needed in virtio to make it work in a POWER
> > > > secure guest under the ultravisor.
> > > > 
> > > > The other change we need (making sure the device's dma_map_ops is NULL
> > > > so that the dma-direct/swiotlb code is used) can be made in
> > > > powerpc-specific code.
> > > > 
> > > > Of course, I also have patches (soon to be posted as RFC) which hook up
> > > > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> > > > 
> > > > What do you think?
> > > > 
> > > >  From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > > > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > > > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> > > > 
> > > > The host can't access the guest memory when it's encrypted, so using
> > > > regular memory pages for the ring isn't an option. Go through the DMA API.
> > > > 
> > > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > Well I think this will come back to bite us (witness xen which is now
> > reworking precisely this path - but at least they aren't to blame, xen
> > came before ACCESS_PLATFORM).
> > 
> > I also still think the right thing would have been to set
> > ACCESS_PLATFORM for all systems where device can't access all memory.
> > 
> > But I also think I don't have the energy to argue about power secure
> > guest anymore.  So be it for power secure guest since the involved
> > engineers disagree with me.  Hey I've been wrong in the past ;).
> > 
> > But the name "sev_active" makes me scared because at least AMD guys who
> > were doing the sensible thing and setting ACCESS_PLATFORM (unless I'm
> > wrong? I reemember distinctly that's so) will likely be affected too.
> > We don't want that.
> > 
> > So let's find a way to make sure it's just power secure guest for now
> > pls.
> > 
> > I also think we should add a dma_api near features under virtio_device
> > such that these hacks can move off data path.
> 
> 
> Anyway the current Xen code is conflict with spec which said:
> 
> "If this feature bit is set to 0, then the device has same access to memory
> addresses supplied to it as the driver has. In particular, the device will
> always use physical addresses matching addresses used by the driver
> (typically meaning physical addresses used by the CPU) and not translated
> further, and can access any address supplied to it by the driver. When
> clear, this overrides any platform-specific description of whether device
> access is limited or translated in any way, e.g. whether an IOMMU may be
> present. "
> 
> I wonder how much value that the above description can give us. It's kind of
> odd that the behavior of "when the feature is not negotiated" is described
> in the spec.

Hmm what's odd about it? We need to describe the behaviour is all cases.

> Personally I think we can remove the above and then we can
> switch to use DMA API unconditionally in guest driver. It may have single
> digit regression probably, we can try to overcome it.
> 
> Thanks

This has been discussed ad nauseum. virtio is all about compatibility.
Losing a couple of lines of code isn't worth breaking working setups.
People that want "just use DMA API no tricks" now have the option.
Setting a flag in a feature bit map is literally a single line
of code in the hypervisor. So stop pushing for breaking working
legacy setups and just fix it in the right place.

> 
> > 
> > By the way could you please respond about virtio-iommu and
> > why there's no support for ACCESS_PLATFORM on power?
> > 
> > I have Cc'd you on these discussions.
> > 
> > 
> > Thanks!
> > 
> > 
> > > > ---
> > > >   drivers/virtio/virtio_ring.c | 5 ++++-
> > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index cd7e755484e3..321a27075380 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > > >   	 * not work without an even larger kludge.  Instead, enable
> > > >   	 * the DMA API if we're a Xen guest, which at least allows
> > > >   	 * all of the sensible Xen configurations to work correctly.
> > > > +	 *
> > > > +	 * Also, if guest memory is encrypted the host can't access
> > > > +	 * it directly. In this case, we'll need to use the DMA API.
> > > >   	 */
> > > > -	if (xen_domain())
> > > > +	if (xen_domain() || sev_active())
> > > >   		return true;
> > > > 
> > > >   	return false;
> > > 
> > > -- 
> > > Thiago Jung Bauermann
> > > IBM Linux Technology Center
