Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B6C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 19:38:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B01613CF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 19:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B01613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFHrp173gz30Gc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Apr 2021 05:38:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IsmWkyrF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HWY1A4/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=IsmWkyrF; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HWY1A4/X; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFHrJ6Fw7z2xxg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Apr 2021 05:38:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617737892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJhQUKqEV20liVnsgwrQmVyuB9gKm/Ks+xvFCx56LWo=;
 b=IsmWkyrFdqgIp635jhPURHVjUnh67zM4d2jBkwDQKrwS3vN310A1RCSQ8SQIzeag0AYngB
 /QBJQaEuzzwNTLIVhNLbiFABgRV+mfnw4U/MgtVWLsjcOmAm7cPK+4Lvj770wvI/ax7ifS
 bC9WpmW/rBBqBUafmQvvOcBek0aPMy0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617737893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mJhQUKqEV20liVnsgwrQmVyuB9gKm/Ks+xvFCx56LWo=;
 b=HWY1A4/X0JK5BRdqmspWnNwtGxzyqsktsUq1cwUkkyrjfrE0BVUYQ87kHeQIC5Sgzjbtes
 e0W3pOTBPjgz46kuKtXMuB8g2OgmUath0djjt0fL7Ul3FwLE9dFkktS+Ba7ABYaGRDldRS
 hgCdt9IFh3h9oko8GyNoNwzOcWRCh50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-y4Zh0538PROB9k8ijir18w-1; Tue, 06 Apr 2021 15:38:10 -0400
X-MC-Unique: y4Zh0538PROB9k8ijir18w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 466FC108BD06;
 Tue,  6 Apr 2021 19:38:08 +0000 (UTC)
Received: from omen (ovpn-112-85.phx2.redhat.com [10.3.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD7A19D61;
 Tue,  6 Apr 2021 19:38:06 +0000 (UTC)
Date: Tue, 6 Apr 2021 13:38:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] vfio/pci: remove vfio_pci_nvlink2
Message-ID: <20210406133805.715120bd@omen>
In-Reply-To: <20210326061311.1497642-2-hch@lst.de>
References: <20210326061311.1497642-1-hch@lst.de>
 <20210326061311.1497642-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 Mar 2021 07:13:10 +0100
Christoph Hellwig <hch@lst.de> wrote:

> This driver never had any open userspace (which for VFIO would include
> VM kernel drivers) that use it, and thus should never have been added
> by our normal userspace ABI rules.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/vfio/pci/Kconfig            |   6 -
>  drivers/vfio/pci/Makefile           |   1 -
>  drivers/vfio/pci/vfio_pci.c         |  18 -
>  drivers/vfio/pci/vfio_pci_nvlink2.c | 490 ----------------------------
>  drivers/vfio/pci/vfio_pci_private.h |  14 -
>  include/uapi/linux/vfio.h           |  38 +--
>  6 files changed, 4 insertions(+), 563 deletions(-)
>  delete mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c

Hearing no objections, applied to vfio next branch for v5.13.  Thanks,

Alex

