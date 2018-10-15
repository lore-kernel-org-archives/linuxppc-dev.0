Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688BAC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 08:59:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1384D20644
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 08:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1384D20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YXSR0RK5zF3LF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 19:59:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YXQG1dl7zF3Dc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:57:41 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id EA52268C8E; Mon, 15 Oct 2018 10:57:37 +0200 (CEST)
Date: Mon, 15 Oct 2018 10:57:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/8] pci: consolidate PCI config entry in drivers/pci
Message-ID: <20181015085737.GC27159@lst.de>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-5-hch@lst.de>
 <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQy_NTu5=8R6C3Xc2VLrJo7tKOz-u1=3JfGtBa3Z+ZD9g@mail.gmail.com>
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
 Dominik Brodowski <linux@dominikbrodowski.net>, alex.bou9@gmail.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 03:37:05PM +0900, Masahiro Yamada wrote:
> I think HAVE_ is a preferred prefix in this case according to this doc:
> https://github.com/masahir0y/linux/blob/v4.19-rc4/Documentation/kbuild/kconfig-language.txt#L448

Ok, I'll switch everything to HAVE_*

> If you do this for entire powerpc,
> the other 'select HAS_PCI' addtions to
> arch/powerpc/platforms/*/Kconfig look redundant.

I'll drop them.

> > -config PCI
> > -       bool "PCI support"
> > -       select PCI_MSI
> 
> 
> I think this 'select PCI_MSI' for riscv was lost.

Indeed, fixed.

> >  menu "Bus options (PCI etc.)"
> >
> > -config PCI
> > -       bool "PCI support"
> > -       default y
> 
> 
> The default is y for x86 (and xtensa as well).
> 
> With this patch, the default will be flipped.
> 
> I think most of people want to use PCI for x86,
> and this change will make people upset.
> 
> Will you update arch/{x86,xtensa}/configs/*_defconfig?

Yes.  Alternatively we could add a new ARCH_PCI_DEFAULT symbol,
that architectures could select if they want PCI by default.  Does
anyone thing this is a good idea?
