Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD865C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C4C214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C4C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tLGN61GhzDqGx
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 19:19:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tLDg5gfczDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 19:17:55 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 5850968D93; Mon,  4 Feb 2019 09:17:52 +0100 (CET)
Date: Mon, 4 Feb 2019 09:17:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc: fix get_arch_dma_ops() for NTB devices
Message-ID: <20190204081752.GA5730@lst.de>
References: <20190128133203.mon4a3nkrzijn43g@alfbook-pro.local>
 <87imy6pain.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imy6pain.fsf@concordia.ellerman.id.au>
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

On Wed, Jan 30, 2019 at 11:58:40PM +1100, Michael Ellerman wrote:
> Alexander Fomichev <fomichev.ru@gmail.com> writes:
> 
> > get_dma_ops() falls into arch-dependant get_arch_dma_ops(), which
> > historically returns NULL on PowerPC. Therefore dma_set_mask() fails.
> > This affects Switchtec (and probably other) NTB devices, that they fail
> > to initialize.
> 
> What's an NTB device?
> 
> drivers/ntb I assume?
> 
> So it's a PCI device of some sort, but presumably the device you're
> calling dma_set_mask() on is an NTB device not a PCI device?
> 
> But then it works if you tell it to use the PCI DMA ops?
> 
> At the very least the code should be checking for the NTB bus type and
> only returning the PCI ops in that specific case, not for all devices.

Can you provide the context?  E.g. the patch and the rest of the commit
log.  This all looks rather odd to me.
