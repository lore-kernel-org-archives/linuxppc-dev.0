Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BB4C282CC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 21:40:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652F120823
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 21:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652F120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43th2B0rSpzDqM1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 08:40:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=mst@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43th0W4CfVzDqH5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 08:38:34 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 143A2A0902;
 Mon,  4 Feb 2019 21:38:32 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.sin2.redhat.com [10.67.116.138])
 by smtp.corp.redhat.com (Postfix) with SMTP id 3FAD81048103;
 Mon,  4 Feb 2019 21:38:23 +0000 (UTC)
Date: Mon, 4 Feb 2019 16:38:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190204152416-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
 <20190129213137-mutt-send-email-mst@kernel.org>
 <20190130074427.GA29516@lst.de>
 <875ztzxvw2.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ztzxvw2.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 04 Feb 2019 21:38:32 +0000 (UTC)
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

On Mon, Feb 04, 2019 at 04:15:41PM -0200, Thiago Jung Bauermann wrote:
> 
> Christoph Hellwig <hch@lst.de> writes:
> 
> > On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> >> This has been discussed ad nauseum. virtio is all about compatibility.
> >> Losing a couple of lines of code isn't worth breaking working setups.
> >> People that want "just use DMA API no tricks" now have the option.
> >> Setting a flag in a feature bit map is literally a single line
> >> of code in the hypervisor. So stop pushing for breaking working
> >> legacy setups and just fix it in the right place.
> >
> > I agree with the legacy aspect.  What I am missing is an extremely
> > strong wording that says you SHOULD always set this flag for new
> > hosts, including an explanation why.
> 
> My understanding of ACCESS_PLATFORM is that it means "this device will
> behave in all aspects like a regular device attached to this bus".


Not really. Look it up in the spec:

VIRTIO_F_ACCESS_PLATFORM(33) This feature indicates that the device can be used on a platform
	where device access to data in memory is limited and/or translated. E.g. this is the case if the device
	can be located behind an IOMMU that translates bus addresses from the device into physical addresses
	in memory, if the device can be limited to only access certain memory addresses or if special commands
	such as a cache flush can be needed to synchronise data in memory with the device. Whether accesses
	are actually limited or translated is described by platform-specific means. If this feature bit is set to 0,
	then the device has same access to memory addresses supplied to it as the driver has. In particular, the
	device will always use physical addresses matching addresses used by the driver (typically meaning
	physical addresses used by the CPU) and not translated further, and can access any address supplied
	to it by the driver. When clear, this overrides any platform-specific description of whether device access
	is limited or translated in any way, e.g. whether an IOMMU may be present.



> Is
> that it? Therefore it should be set because it's the sane thing to do?

It's the sane thing to do unless you want the very specific thing that
having it clear means, which is just have it be another CPU.

It was designed to make, when set, as many guests as we can work
correctly, and it seems to be successful in doing exactly that.

Unfortunately there could be legacy guests that do work correctly but
become slow. Whether trying to somehow work around that
can paint us into a corner where things again don't
work for some people is a question worth discussing.


> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
