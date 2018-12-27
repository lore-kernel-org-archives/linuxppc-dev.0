Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B78C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 13:12:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BE521479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 13:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BE521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43QVd40D5ZzDqGT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 00:12:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QVZW5qf1zDqGP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 00:10:42 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id F145168AFE; Thu, 27 Dec 2018 14:10:38 +0100 (CET)
Date: Thu, 27 Dec 2018 14:10:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Scott Wood <oss@buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
Message-ID: <20181227131038.GB22967@lst.de>
References: <20181222044250.GA7651@home.buserror.net>
 <877eg0idwv.fsf@concordia.ellerman.id.au>
 <aacb88f67d1c2bdacff760341291588ac3f2c0f0.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacb88f67d1c2bdacff760341291588ac3f2c0f0.camel@buserror.net>
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
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 23, 2018 at 08:09:19PM -0600, Scott Wood wrote:
> > > Christoph Hellwig (1):
> > >       powerpc/fsl_pci: simplify fsl_pci_dma_set_mask
> > 
> > This one breaks networking on my p5020ds.
> > 
> > dmesg is just full of:
> > 
> >   e1000e 2000:01:00.0: Tx DMA map failed
> > 
> > Haven't had time to dig any further.
> 
> OK, I'll revert.  My t4240rdb doesn't have PCI devices, so I wasn't able to
> test it.

How did this patch end up in your tree?  I don't think it has a chance
to work Without the rest of the series.
