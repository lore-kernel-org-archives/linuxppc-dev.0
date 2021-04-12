Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B8EC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 14:23:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BD761287
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 14:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BD761287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJrZV4w4Pz3c1N
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Apr 2021 00:23:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wrzpc5AV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wrzpc5AV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Wrzpc5AV; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wrzpc5AV; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJrZ232djz2xZP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Apr 2021 00:23:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618237397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrF4YEmMpBSr4tpcoU2zsLDVhSyzm4Z4HeHxtyh0vvU=;
 b=Wrzpc5AVq5jGyuzokVFFNTzCHjxkb5yrBwZQ3dIOqKKdK1gvknDr/poDCncyRlkSg71zgN
 CAkOqb3C+GDglwQxraJPVOfa5GdTyG8ORtXxrL/s2a3PR8sGHu5EQ/ZpJYEvB9AFFPFgDo
 pXRc3i7sfKXVW+gOlupS3A7hH0hMziw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618237397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrF4YEmMpBSr4tpcoU2zsLDVhSyzm4Z4HeHxtyh0vvU=;
 b=Wrzpc5AVq5jGyuzokVFFNTzCHjxkb5yrBwZQ3dIOqKKdK1gvknDr/poDCncyRlkSg71zgN
 CAkOqb3C+GDglwQxraJPVOfa5GdTyG8ORtXxrL/s2a3PR8sGHu5EQ/ZpJYEvB9AFFPFgDo
 pXRc3i7sfKXVW+gOlupS3A7hH0hMziw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-OL_3aR56Mdyv0DeVj_LUSg-1; Mon, 12 Apr 2021 10:23:12 -0400
X-MC-Unique: OL_3aR56Mdyv0DeVj_LUSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52AFC10054F6;
 Mon, 12 Apr 2021 14:23:08 +0000 (UTC)
Received: from omen (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E97905D9DE;
 Mon, 12 Apr 2021 14:23:04 +0000 (UTC)
Date: Mon, 12 Apr 2021 08:23:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] vfio/pci: remove vfio_pci_nvlink2
Message-ID: <20210412082304.5e7c0a80@omen>
In-Reply-To: <87y2dndelm.fsf@mpe.ellerman.id.au>
References: <20210326061311.1497642-1-hch@lst.de>
 <20210326061311.1497642-2-hch@lst.de>
 <20210406133805.715120bd@omen> <87y2dndelm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 12 Apr 2021 19:41:41 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Alex Williamson <alex.williamson@redhat.com> writes:
> > On Fri, 26 Mar 2021 07:13:10 +0100
> > Christoph Hellwig <hch@lst.de> wrote:
> >  
> >> This driver never had any open userspace (which for VFIO would include
> >> VM kernel drivers) that use it, and thus should never have been added
> >> by our normal userspace ABI rules.
> >> 
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >>  drivers/vfio/pci/Kconfig            |   6 -
> >>  drivers/vfio/pci/Makefile           |   1 -
> >>  drivers/vfio/pci/vfio_pci.c         |  18 -
> >>  drivers/vfio/pci/vfio_pci_nvlink2.c | 490 ----------------------------
> >>  drivers/vfio/pci/vfio_pci_private.h |  14 -
> >>  include/uapi/linux/vfio.h           |  38 +--
> >>  6 files changed, 4 insertions(+), 563 deletions(-)
> >>  delete mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c  
> >
> > Hearing no objections, applied to vfio next branch for v5.13.  Thanks,  
> 
> Looks like you only took patch 1?
> 
> I can't take patch 2 on its own, that would break the build.
> 
> Do you want to take both patches? There's currently no conflicts against
> my tree. It's possible one could appear before the v5.13 merge window,
> though it would probably just be something minor.
> 
> Or I could apply both patches to my tree, which means patch 1 would
> appear as two commits in the git history, but that's not a big deal.

I've already got a conflict in my next branch with patch 1, so it's
best to go through my tree.  Seems like a shared branch would be
easiest to allow you to merge and manage potential conflicts against
patch 2, I've pushed a branch here:

https://github.com/awilliam/linux-vfio.git v5.13/vfio/nvlink

Thanks,
Alex

