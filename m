Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF03C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:14:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9ED20844
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9ED20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v8mT0lhqzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 03:14:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v8kT73wRzDqMP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 03:13:04 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 6570368D93; Tue,  5 Feb 2019 17:13:00 +0100 (CET)
Date: Tue, 5 Feb 2019 17:13:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc: fix get_arch_dma_ops() for NTB devices
Message-ID: <20190205161300.GB782@lst.de>
References: <20190128133203.mon4a3nkrzijn43g@alfbook-pro.local>
 <87imy6pain.fsf@concordia.ellerman.id.au> <20190204081752.GA5730@lst.de>
 <87h8dimqgv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8dimqgv.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Alexander Fomichev <fomichev.ru@gmail.com>, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 05, 2019 at 10:20:32PM +1100, Michael Ellerman wrote:
> get_dma_ops() falls into arch-dependant get_arch_dma_ops(), which
> historically returns NULL on PowerPC. Therefore dma_set_mask() fails.
> This affects Switchtec (and probably other) NTB devices, that they fail
> to initialize.
> The proposed patch should fix the issue.

I'm not a fan of this.  powerpc, just like arm64 for example has
required that we set a specific per-device dma ops, which keeps
the assignments clear.  Where do the NTB devices come from?

Might be worth adding the NTB maintainers to the CC list and maybe
linux-iommu.
