Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A792ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:43:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3202087A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 07:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3202087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42byb35RGDzF3bZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:43:43 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bxgR6756zF3Tp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 18:02:27 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 9C19C68C76; Fri, 19 Oct 2018 09:02:24 +0200 (CEST)
Date: Fri, 19 Oct 2018 09:02:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/8] PCI: consolidate PCI config entry in drivers/pci
Message-ID: <20181019070224.GB30556@lst.de>
References: <20181017080201.10866-1-hch@lst.de>
 <20181017080201.10866-5-hch@lst.de>
 <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASJaRrut2neRa92CudohW4A-2=GHMzgEpOzT97VdGuhng@mail.gmail.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 19, 2018 at 02:07:04PM +0900, Masahiro Yamada wrote:
> We could add 'depends on HAVE_PCI' or something
> to guard it to avoid changing the logic.

I guess that makes sense.

> config PCI_ENDPOINT
>         bool "PCI Endpoint Support"
>         depends on HAVE_PCI     # Is this correct ??
>         depends on HAS_DMA
> 
> 
> or better to have 'depends on PCI' ?

It does not depend on the normal PCI support, so I don't think this
is the right thing to do.
