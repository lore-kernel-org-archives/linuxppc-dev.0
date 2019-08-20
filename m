Return-Path: <SRS0=bLNb=WQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E87C3A589
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 22:31:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D1122DA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 22:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D1122DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ClrB69w8zDrG2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 08:31:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ClnG1KMQzDqMB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2019 08:28:34 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id BEB5868B20; Wed, 21 Aug 2019 00:28:28 +0200 (CEST)
Date: Wed, 21 Aug 2019 00:28:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 05/12] powerpc/mm: rework io-workaround invocation.
Message-ID: <20190820222828.GC18433@lst.de>
References: <cover.1566309262.git.christophe.leroy@c-s.fr>
 <5fa3ef069fbd0f152512afaae19e7a60161454cf.1566309262.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa3ef069fbd0f152512afaae19e7a60161454cf.1566309262.git.christophe.leroy@c-s.fr>
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
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 20, 2019 at 02:07:13PM +0000, Christophe Leroy wrote:
> ppc_md.ioremap() is only used for I/O workaround on CELL platform,
> so indirect function call can be avoided.
> 
> This patch reworks the io-workaround and ioremap() functions to
> use the global 'io_workaround_inited' flag for the activation
> of io-workaround.
> 
> When CONFIG_PPC_IO_WORKAROUNDS or CONFIG_PPC_INDIRECT_MMIO are not
> selected, the I/O workaround ioremap() voids and the global flag is
> not used.

Note that CONFIG_PPC_IO_WORKAROUNDS is only selected by a specific cell
config,  and CONFIG_PPC_INDIRECT_MMIO is always selected by cell, so
I think we can make CONFIG_PPC_IO_WORKAROUNDS depend on
CONFIG_PPC_INDIRECT_MMIO

>  #define _IO_WORKAROUNDS_H
>  
> +#ifdef CONFIG_PPC_IO_WORKAROUNDS
>  #include <linux/io.h>
>  #include <asm/pci-bridge.h>
>  
> @@ -32,4 +33,23 @@ extern int spiderpci_iowa_init(struct iowa_bus *, void *);
>  #define SPIDER_PCI_DUMMY_READ		0x0810
>  #define SPIDER_PCI_DUMMY_READ_BASE	0x0814
>  
> +#endif
> +
> +#if defined(CONFIG_PPC_IO_WORKAROUNDS) && defined(CONFIG_PPC_INDIRECT_MMIO)

and simplify the ifdefs here a bit.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
