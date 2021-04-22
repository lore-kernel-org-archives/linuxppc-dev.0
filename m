Return-Path: <SRS0=xMs2=JT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BFCC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 13:50:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F17B6145B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 13:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F17B6145B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQzMD2pSlz30Fc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 23:50:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=opAHDFQP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=opAHDFQP; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQzLj2jJ4z2xZN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2021 23:49:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FQzLS4gwsz9sW5;
 Thu, 22 Apr 2021 23:49:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1619099380;
 bh=PhzqVOhEd/h/0Fbbb3BAwftaycIPw8RDL50QyqE12IM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=opAHDFQP4CkPQG2bXglbuqBieFuhtxeywVbuoUy6F6KRrIYll/aQ4VCFGZ+1SK9ww
 qkC27cYMIYRHgi8TycPRBwvXaDwBGTnXMQvEVQhwKjswSnF0TiXP9XoXJJH8uAMdxR
 lMSsBJYzwnLenDSlSt5RcjvvzILAWNdsjd3NeCn1uh6z9wZ4h29Ve3grGN/tFByXrh
 laZUoPJjgJvzIviuLVCQoLLfZr/DN4nqji6OiiVCjJx3TKVyz53aJyIcQrAkkTTzmJ
 lKYWFa+XMX4Vq2TMF7e9f3rRkMEJ3MQkjQhp4H2W940Tex0j4MPNi8CrUl2AaEhvuK
 7NueaXiSceWgg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] vfio/pci: remove vfio_pci_nvlink2
In-Reply-To: <20210412082304.5e7c0a80@omen>
References: <20210326061311.1497642-1-hch@lst.de>
 <20210326061311.1497642-2-hch@lst.de> <20210406133805.715120bd@omen>
 <87y2dndelm.fsf@mpe.ellerman.id.au> <20210412082304.5e7c0a80@omen>
Date: Thu, 22 Apr 2021 23:49:31 +1000
Message-ID: <87h7jybf9w.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Alex Williamson <alex.williamson@redhat.com> writes:
> On Mon, 12 Apr 2021 19:41:41 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Alex Williamson <alex.williamson@redhat.com> writes:
>> > On Fri, 26 Mar 2021 07:13:10 +0100
>> > Christoph Hellwig <hch@lst.de> wrote:
>> >  
>> >> This driver never had any open userspace (which for VFIO would include
>> >> VM kernel drivers) that use it, and thus should never have been added
>> >> by our normal userspace ABI rules.
>> >> 
>> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> >> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >> ---
>> >>  drivers/vfio/pci/Kconfig            |   6 -
>> >>  drivers/vfio/pci/Makefile           |   1 -
>> >>  drivers/vfio/pci/vfio_pci.c         |  18 -
>> >>  drivers/vfio/pci/vfio_pci_nvlink2.c | 490 ----------------------------
>> >>  drivers/vfio/pci/vfio_pci_private.h |  14 -
>> >>  include/uapi/linux/vfio.h           |  38 +--
>> >>  6 files changed, 4 insertions(+), 563 deletions(-)
>> >>  delete mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c  
>> >
>> > Hearing no objections, applied to vfio next branch for v5.13.  Thanks,  
>> 
>> Looks like you only took patch 1?
>> 
>> I can't take patch 2 on its own, that would break the build.
>> 
>> Do you want to take both patches? There's currently no conflicts against
>> my tree. It's possible one could appear before the v5.13 merge window,
>> though it would probably just be something minor.
>> 
>> Or I could apply both patches to my tree, which means patch 1 would
>> appear as two commits in the git history, but that's not a big deal.
>
> I've already got a conflict in my next branch with patch 1, so it's
> best to go through my tree.  Seems like a shared branch would be
> easiest to allow you to merge and manage potential conflicts against
> patch 2, I've pushed a branch here:
>
> https://github.com/awilliam/linux-vfio.git v5.13/vfio/nvlink

Thanks.

My next is based on rc2, so I won't pull that in directly, because I
don't want to pull all of rc6 in with it.

I'll put it in a topic branch and merge it into my next after my first
pull has gone to Linus.

cheers
