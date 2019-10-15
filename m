Return-Path: <SRS0=Pmlw=YI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0814C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 07:37:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC0C2086A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 07:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC0C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46snM91r9YzDqfs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 18:37:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46snJZ04WHzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2019 18:35:10 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4C96D68CEE; Tue, 15 Oct 2019 09:35:02 +0200 (CEST)
Date: Tue, 15 Oct 2019 09:35:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
Message-ID: <20191015073501.GA32345@lst.de>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
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
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mdroth@linux.vnet.ibm.com,
 b.zolnierkie@samsung.com, jasowang@redhat.com, aik@linux.ibm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, paul.burton@mips.com, robin.murphy@arm.com,
 m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
> be set by both device and guest driver. However, as a hack, when DMA API
> returns physical addresses, guest driver can use the DMA API; even though
> device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
> addresses.

Sorry, but this is a complete bullshit hack.  Driver must always use
the DMA API if they do DMA, and if virtio devices use physical addresses
that needs to be returned through the platform firmware interfaces for
the dma setup.  If you don't do that yet (which based on previous
informations you don't), you need to fix it, and we can then quirk
old implementations that already are out in the field.

In other words: we finally need to fix that virtio mess and not pile
hacks on top of hacks.
