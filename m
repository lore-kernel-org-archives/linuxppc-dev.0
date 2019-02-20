Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 06:33:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3965F2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 06:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3965F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44478R69QZzDqFB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:33:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44476b2ZDTzDqBb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 17:31:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44476b1N0dz8t4q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 17:31:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44476b0rsQz9s71; Wed, 20 Feb 2019 17:31:35 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44476Z3YZPz9s70;
 Wed, 20 Feb 2019 17:31:33 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gwLNf-0004Nm-1O; Wed, 20 Feb 2019 00:29:19 -0600
Message-ID: <5e552f3d0c69890d5beb88475c8f9ba7a76bf64b.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Date: Wed, 20 Feb 2019 00:29:17 -0600
In-Reply-To: <87h8czc1by.fsf@concordia.ellerman.id.au>
References: <20190208123416.1051-1-mpe@ellerman.id.au>
 <2fc1837d-af23-751c-d9af-0d0888b26ab4@c-s.fr>
 <87h8czc1by.fsf@concordia.ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, christophe.leroy@c-s.fr,
 linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc: Make PPC_64K_PAGES depend on only 44x or
 PPC_BOOK3S_64
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
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-20 at 01:14 +1100, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
> > On 02/08/2019 12:34 PM, Michael Ellerman wrote:
> > > In commit 7820856a4fcd ("powerpc/mm/book3e/64: Remove unsupported
> > > 64Kpage size from 64bit booke") we dropped the 64K page size support
> > > from the 64-bit nohash (Book3E) code.
> > > 
> > > But we didn't update the dependencies of the PPC_64K_PAGES option,
> > > meaning a randconfig can still trigger this code and cause a build
> > > breakage, eg:
> > >    arch/powerpc/include/asm/nohash/64/pgtable.h:14:2: error: #error
> > > "Page size not supported"
> > >    arch/powerpc/include/asm/nohash/mmu-book3e.h:275:2: error: #error
> > > Unsupported page size
> > > 
> > > So remove PPC_BOOK3E_64 from the dependencies. This also means we
> > > don't need to worry about PPC_FSL_BOOK3E, because that was just trying
> > > to prevent the PPC_BOOK3E_64=y && PPC_FSL_BOOK3E=y case.
> > 
> > Does it means some cleanup could be done, for instance:
> > 
> > arch/powerpc/include/asm/nohash/64/pgalloc.h:#ifndef CONFIG_PPC_64K_PAGES
> > arch/powerpc/include/asm/nohash/64/pgalloc.h:#endif /* 
> > CONFIG_PPC_64K_PAGES */
> > arch/powerpc/include/asm/nohash/64/pgtable.h:#ifdef CONFIG_PPC_64K_PAGES
> > arch/powerpc/include/asm/nohash/64/slice.h:#ifdef CONFIG_PPC_64K_PAGES
> > arch/powerpc/include/asm/nohash/64/slice.h:#else /* CONFIG_PPC_64K_PAGES
> > */
> > arch/powerpc/include/asm/nohash/64/slice.h:#endif /* 
> > !CONFIG_PPC_64K_PAGES */
> > arch/powerpc/include/asm/nohash/pte-book3e.h:#ifdef CONFIG_PPC_64K_PAGES
> > 
> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> > arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> > arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> > arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
> 
> Probably.
> 
> Some of the FSL chips do support 64K pages at least according to some
> datasheets. I don't know what would be required to get it working, or if
> it even works in practice.
> 
> So it would be nice to get 64K working on those chips, but probably no
> one has time or motivation to do it. In which case yeah all that code
> should be removed.

The primary TLB (TLB0) on these chips only supports 4K pages.  TLB1 supports
many different sizes but is much smaller, hardware tablewalk only loads into
TLB0, etc.

-Scott


