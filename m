Return-Path: <SRS0=UD/r=UN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812AC31E4B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 19:17:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E2520644
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 19:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E2520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QVjZ4Dm3zDrnN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 05:17:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=neutral (mailfrom) smtp.mailfrom=iki.fi
 (client-ip=62.142.5.107; helo=emh01.mail.saunalahti.fi;
 envelope-from=aaro.koskinen@iki.fi; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=iki.fi
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
 [62.142.5.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45QVgY5w03zDrdn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 05:15:37 +1000 (AEST)
Received: from darkstar.musicnaut.iki.fi (85-76-83-177-nat.elisa-mobile.fi
 [85.76.83.177])
 by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 3F9C720347;
 Fri, 14 Jun 2019 22:15:33 +0300 (EEST)
Date: Fri, 14 Jun 2019 22:15:33 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
Message-ID: <20190614191532.GC27145@darkstar.musicnaut.iki.fi>
References: <20190613082446.18685-1-hch@lst.de>
 <CA+7wUswMtpVCoX0H5eF=GUY8jWDAEWa9Z223tKiKHiL69hhHtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUswMtpVCoX0H5eF=GUY8jWDAEWa9Z223tKiKHiL69hhHtQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>,
 Larry Finger <Larry.Finger@lwfinger.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Fri, Jun 14, 2019 at 09:24:16AM +0200, Mathieu Malaterre wrote:
> On Thu, Jun 13, 2019 at 10:27 AM Christoph Hellwig <hch@lst.de> wrote:
> > With the strict dma mask checking introduced with the switch to
> > the generic DMA direct code common wifi chips on 32-bit powerbooks
> > stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
> > to allow them to reliably allocate dma coherent memory.
> >
> > Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
> > Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/powerpc/include/asm/page.h         | 7 +++++++
> >  arch/powerpc/mm/mem.c                   | 3 ++-
> >  arch/powerpc/platforms/powermac/Kconfig | 1 +
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> > index b8286a2013b4..0d52f57fca04 100644
> > --- a/arch/powerpc/include/asm/page.h
> > +++ b/arch/powerpc/include/asm/page.h
> > @@ -319,6 +319,13 @@ struct vm_area_struct;
> >  #endif /* __ASSEMBLY__ */
> >  #include <asm/slice.h>
> >
> > +/*
> > + * Allow 30-bit DMA for very limited Broadcom wifi chips on many powerbooks.
> 
> nit: would it be possible to mention explicit reference to b43-legacy.
> Using b43 on my macmini g4 never showed those symptoms (using
> 5.2.0-rc2+)

According to Wikipedia Mac mini G4 is limited to 1 GB RAM, so that's
why you don't see the issue.

A.
