Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB7C28EB4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 11:45:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8B1206E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 11:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8B1206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KP3k3M6XzDqWy
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 21:45:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KP2708HgzDqW7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2019 21:43:56 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id C2C8268B20; Thu,  6 Jun 2019 13:43:26 +0200 (CEST)
Date: Thu, 6 Jun 2019 13:43:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
Message-ID: <20190606114325.GA7497@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org>
 <20190606093149.GA11598@darkstar.musicnaut.iki.fi>
 <d87ac9a7faac0d5522cb496d74afc586410fed9c.camel@kernel.crashing.org>
 <f8df19ffe5b75537045119037459ae9ad4a1de39.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8df19ffe5b75537045119037459ae9ad4a1de39.camel@kernel.crashing.org>
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Larry Finger <Larry.Finger@lwfinger.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 06, 2019 at 08:57:49PM +1000, Benjamin Herrenschmidt wrote:
> > Wow... that's an odd amount. One thing we could possibly do is add code
> > to limit the amount of RAM when we detect that device....
> 
> Sent too quickly... I mean that *or* force swiotlb at 30-bits on those systems based
> on detecting the presence of that device in the device-tree.

swiotlb doesn't really help you, as these days swiotlb on matters for
the dma_map* case.  What would help is a ZONE_DMA that covers these
devices.  No need to do the 24-bit x86 does, but 30-bit would do it.

WIP patch for testing below:

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index b8286a2013b4..7a367ce87c41 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -319,6 +319,10 @@ struct vm_area_struct;
 #endif /* __ASSEMBLY__ */
 #include <asm/slice.h>
 
+#if 1 /* XXX: pmac?  dynamic discovery? */
+#define ARCH_ZONE_DMA_BITS 30
+#else
 #define ARCH_ZONE_DMA_BITS 31
+#endif
 
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index cba29131bccc..2540d3b2588c 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -248,7 +248,8 @@ void __init paging_init(void)
 	       (long int)((top_of_ram - total_ram) >> 20));
 
 #ifdef CONFIG_ZONE_DMA
-	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
+	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
+			((1UL << ARCH_ZONE_DMA_BITS) - 1) >> PAGE_SHIFT);
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
