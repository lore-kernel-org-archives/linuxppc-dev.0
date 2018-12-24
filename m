Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C4CC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 02:13:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82E52176F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 02:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82E52176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43NN7g6mMjzDqfM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 13:13:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43NN5W0my3zDqWx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 13:11:42 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gbFgH-0005DR-9u; Sun, 23 Dec 2018 20:09:26 -0600
Message-ID: <aacb88f67d1c2bdacff760341291588ac3f2c0f0.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Sun, 23 Dec 2018 20:09:19 -0600
In-Reply-To: <877eg0idwv.fsf@concordia.ellerman.id.au>
References: <20181222044250.GA7651@home.buserror.net>
 <877eg0idwv.fsf@concordia.ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 galak@kernel.crashing.org, hch@lst.de
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: Pull request: scottwood/linux.git next
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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

On Mon, 2018-12-24 at 00:13 +1100, Michael Ellerman wrote:
> Hi Scott,
> 
> Scott Wood <oss@buserror.net> writes:
> > Highlights include elimination of legacy clock bindings use from dts
> > files, an 83xx watchdog handler, fixes to old dts interrupt errors, and
> > some minor cleanup.
> > 
> > The following changes since commit
> > 8c6c942d33f2a79439e86f8f406afae40a5bc767:
> > 
> >   powerpc/eeh: Fix debugfs_simple_attr.cocci warnings (2018-12-20 22:59:03
> > +1100)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> > 
> > for you to fetch changes up to 5f470b3638a4ed03df79b993ece819cac2f4ca7e:
> > 
> >   powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL (2018-12-21 22:07:54
> > -0600)
> > 
> > ----------------------------------------------------------------
> > Alexandre Belloni (1):
> >       powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"
> > 
> > Christoph Hellwig (1):
> >       powerpc/fsl_pci: simplify fsl_pci_dma_set_mask
> 
> This one breaks networking on my p5020ds.
> 
> dmesg is just full of:
> 
>   e1000e 2000:01:00.0: Tx DMA map failed
> 
> Haven't had time to dig any further.

OK, I'll revert.  My t4240rdb doesn't have PCI devices, so I wasn't able to
test it.

-Scott


