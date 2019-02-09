Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F665C282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 20:00:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E995E2083B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 20:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E995E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xjbG5KQLzDqSv
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 07:00:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xjYN0nd2zDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 06:59:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43xjYM5kTzz8tXf
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 06:59:03 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43xjYM5DKSz9sMr; Sun, 10 Feb 2019 06:59:03 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
X-Greylist: delayed 2267 seconds by postgrey-1.36 at bilbo;
 Sun, 10 Feb 2019 06:59:02 AEDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43xjYL701Rz9sMp;
 Sun, 10 Feb 2019 06:59:02 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gsY9T-0005w1-AV; Sat, 09 Feb 2019 13:18:59 -0600
Message-ID: <cca1d555eaad9027ef23cc06925575cadf3a09df.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Sat, 09 Feb 2019 13:18:57 -0600
In-Reply-To: <2fc1837d-af23-751c-d9af-0d0888b26ab4@c-s.fr>
References: <20190208123416.1051-1-mpe@ellerman.id.au>
 <2fc1837d-af23-751c-d9af-0d0888b26ab4@c-s.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@c-s.fr, mpe@ellerman.id.au,
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

On Fri, 2019-02-08 at 13:01 +0000, Christophe Leroy wrote:
> 
> On 02/08/2019 12:34 PM, Michael Ellerman wrote:
> > In commit 7820856a4fcd ("powerpc/mm/book3e/64: Remove unsupported
> > 64Kpage size from 64bit booke") we dropped the 64K page size support
> > from the 64-bit nohash (Book3E) code.
> > 
> > But we didn't update the dependencies of the PPC_64K_PAGES option,
> > meaning a randconfig can still trigger this code and cause a build
> > breakage, eg:
> >    arch/powerpc/include/asm/nohash/64/pgtable.h:14:2: error: #error "Page
> > size not supported"
> >    arch/powerpc/include/asm/nohash/mmu-book3e.h:275:2: error: #error
> > Unsupported page size
> > 
> > So remove PPC_BOOK3E_64 from the dependencies. This also means we
> > don't need to worry about PPC_FSL_BOOK3E, because that was just trying
> > to prevent the PPC_BOOK3E_64=y && PPC_FSL_BOOK3E=y case.
> 
> Does it means some cleanup could be done, for instance:
> 
> arch/powerpc/include/asm/nohash/64/pgalloc.h:#ifndef CONFIG_PPC_64K_PAGES
> arch/powerpc/include/asm/nohash/64/pgalloc.h:#endif /* 
> CONFIG_PPC_64K_PAGES */
> arch/powerpc/include/asm/nohash/64/pgtable.h:#ifdef CONFIG_PPC_64K_PAGES
> arch/powerpc/include/asm/nohash/64/slice.h:#ifdef CONFIG_PPC_64K_PAGES
> arch/powerpc/include/asm/nohash/64/slice.h:#else /* CONFIG_PPC_64K_PAGES */
> arch/powerpc/include/asm/nohash/64/slice.h:#endif /* 
> !CONFIG_PPC_64K_PAGES */
> arch/powerpc/include/asm/nohash/pte-book3e.h:#ifdef CONFIG_PPC_64K_PAGES
> 
> arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
> arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
> arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
> arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
> arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
> arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
> arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
> arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES

More generally, if fsl is the only supported book3e platform and that's not
expected to change, everything in tlb_low_64e.S except the bolted and e6500
variants could go away.

-Scott


