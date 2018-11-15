Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC62C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 19:41:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014EB2133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 19:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014EB2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wsDR5DKhzF3hJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 06:41:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.103; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0103.hostedemail.com
 [216.40.44.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wrt35K6KzF3hl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 06:25:14 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id CD391180790B5;
 Thu, 15 Nov 2018 19:25:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: train79_844655162681d
X-Filterd-Recvd-Size: 3595
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf14.hostedemail.com (Postfix) with ESMTPA;
 Thu, 15 Nov 2018 19:25:08 +0000 (UTC)
Message-ID: <7a3922bc5089dfe0978e07a809606360c74c940c.camel@perches.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
From: Joe Perches <joe@perches.com>
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, darren@stevens-zone.net, 
 christophe.leroy@c-s.fr, geoff@infradead.org
Date: Thu, 15 Nov 2018 11:25:07 -0800
In-Reply-To: <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
 <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, Souptick Joarder <jrdr.linux@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-11-15 at 23:29 +0530, Sabyasachi Gupta wrote:
> On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> > 
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> 
> Any comment on this patch?

It's obviously correct.

You might realign the arguments on the next lines
to the open parenthesis.

Perhaps there should be new function calls
added for symmetry to the other alloc functions
for multiplication overflow protection.

Perhaps:

void *dma_alloc_array_coherent()
void *dma_calloc_coherent()

Something like
---
 include/linux/dma-mapping.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 15bd41447025..95bebf8883b1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -565,6 +565,25 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline void *dma_alloc_array_coherent(struct device *dev,
+					     size_t n, size_t size,
+					     dma_addr_t *dma_handle, gfp_t gfp)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+	return dma_alloc_coherent(dev, bytes, dma_handle, gfp);
+}
+
+static inline void *dma_calloc_coherent(struct device *dev,
+					size_t n, size_t size,
+					dma_addr_t *dma_handle, gfp_t gfp)
+{
+	return dma_alloc_array_coherent(dev, n, size, dma_handle,
+					gfp | __GFP_ZERO);
+}
+
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {

---
> > diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
[]
> > @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
> > 
> >         chan->ring_size = ring_size;
> > 
> > -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
> > +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
> >                                              ring_size * sizeof(u64),
> >                                              &chan->ring_dma, GFP_KERNEL);
> >  en
> >         if (!chan->ring_virt)
> >                 return -ENOMEM;
> > 
> > -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
> > -
> >         return 0;
> >  }
> >  EXPORT_SYMBOL(pasemi_dma_alloc_ring);


