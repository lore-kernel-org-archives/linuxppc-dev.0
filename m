Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 16:55:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B922070D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 16:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B922070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44THM02Vy0zDqDG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 03:55:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.222.195; helo=mail-qk1-f195.google.com;
 envelope-from=mst@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44THKC0jVXzDqKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 03:54:05 +1100 (AEDT)
Received: by mail-qk1-f195.google.com with SMTP id b74so8043358qkg.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 09:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AT7xvjAWIyJCcePl132t7T+n+TzpQQuXNXm3pdI4blo=;
 b=aM1RvcjdwXgub2KNvWAvqd6BtLC/5tE614dAjKjgJFEiZNGNlgc/p0xrzzfmf6VRDE
 P4bGoMGg9IpOiDgTcbyRHxqBQLEMgc7ufFlzNpAXm9hdPOEBEdSfFFmqh7MemB9bUjJS
 me+crf2jAuZvQP1COM3EiFGH19RsECZDwbIDqUIVJd3slwZJz7PK/nzPGWjRC97rGJW9
 GvUqN2pNDIMvbiVLfwIXXCrA4Y3m+PCyI3ot6z1wttNOGMF9ouZoGIvK+ywlZEm8GbBn
 MFB9bUghUd08ilXIyJf2K+sp6Mh+iTbDQ1LAYQ7EXS10Q6TH387FXhhs0sp0DW+6maBT
 NOmA==
X-Gm-Message-State: APjAAAWWUNXQNdDX4RxQ/lbGRvPacfxnZ4xtHra8sKf+2llubVJoGHr8
 ysTTAJklqaS+v36Ls2Crqtqw5A==
X-Google-Smtp-Source: APXvYqx5UHQ8nanghfhzg0pFdZd+8kyMjawRO91F3JXx/Hibg1pKAb4WUAy68WuyCcKrcSt7axztAQ==
X-Received: by 2002:a05:620a:1597:: with SMTP id
 d23mr25900044qkk.226.1553619243524; 
 Tue, 26 Mar 2019 09:54:03 -0700 (PDT)
Received: from redhat.com ([66.187.232.66])
 by smtp.gmail.com with ESMTPSA id o68sm10908092qkc.89.2019.03.26.09.54.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Mar 2019 09:54:02 -0700 (PDT)
Date: Tue, 26 Mar 2019 12:53:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190325084348-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
 <20190129213137-mutt-send-email-mst@kernel.org>
 <20190130074427.GA29516@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130074427.GA29516@lst.de>
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
Cc: kevin.tian@intel.com, Lorenzo.Pieralisi@arm.com,
 tnowicki@caviumnetworks.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 Will.Deacon@arm.com, virtualization@lists.linux-foundation.org,
 eric.auger@redhat.com, iommu@lists.linux-foundation.org, Marc.Zyngier@arm.com,
 Robin.Murphy@arm.com, bharat.bhushan@nxp.com, linuxppc-dev@lists.ozlabs.org,
 joro@8bytes.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 30, 2019 at 08:44:27AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> > This has been discussed ad nauseum. virtio is all about compatibility.
> > Losing a couple of lines of code isn't worth breaking working setups.
> > People that want "just use DMA API no tricks" now have the option.
> > Setting a flag in a feature bit map is literally a single line
> > of code in the hypervisor. So stop pushing for breaking working
> > legacy setups and just fix it in the right place.
> 
> I agree with the legacy aspect.  What I am missing is an extremely
> strong wording that says you SHOULD always set this flag for new
> hosts, including an explanation why.


So as far as power is concerned, IIUC the issue they are struggling with is
that some platforms do not support pass-through mode in the emulated IOMMU.
Disabling PLATFORM_ACCESS is so far a way around that, unfortunately just for
virtio devices.  I would like virtio-iommu to be able to address that need as
well.

-- 
MST
