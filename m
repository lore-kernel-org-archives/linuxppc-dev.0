Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E5FC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 07:16:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DD96102A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 07:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DD96102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNymN5PYYz3brf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 17:16:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eey/l+RH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::633;
 helo=mail-ej1-x633.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=eey/l+RH; dkim-atps=neutral
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNylw2YSRz30FX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 17:16:09 +1000 (AEST)
Received: by mail-ej1-x633.google.com with SMTP id w3so51296639ejc.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NN0SIfMjTxjZbQRx0YAvjqNr/mU2jjCeZfOuWM1TKQg=;
 b=eey/l+RHXKvQeN6pj97BCplXIBEybQcxN3b7FvQmF61jOBhQh1L3SEeQQ75h/2HdsS
 lvYIqu8K+q2WjsDlLAeK9Wnb1NF6cyeqhlkGq0FPAm8DlUPS+AQFo/NJsd07cj0Q3ZlL
 w8WQ5kpSsHEVNjJVZ5gBLqQKoIsyvcX+/cFN8KMQZ3Iv///hFKsd8BwPgREnubNCqPL5
 Dv9i0qdko+0u1NPVIEUTdH9QkepmL8RujKMziiyLsXYQvB3kYOx688e/XZFtgAngxGsq
 QiydkHhZuGPAi067UJ3NLgK8UACRsB/vwxJjcJLrUCb9fFPP+3Jmcp+S2QopZl9iPKxG
 oZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NN0SIfMjTxjZbQRx0YAvjqNr/mU2jjCeZfOuWM1TKQg=;
 b=XAogxVFKjKCp9zzBB0qZiwcO+w2Kw6yI2BHVHbeuWrQ2wOrnPuJl56dvlXzT6THRNF
 20LF0gMX10ikuutEPeHqTgIg+RFKZ0oQpPDlj1PdmJEMbUBJJ4kxolfnI+EUz68z7vBk
 W+29pwaLp/VpKjjbeXWJG6eI0UJ1N9GWdcdqPTqFQ/0O/TSCa5SewCYoqXgjdmwlwU8l
 H640yQdrP09F26EvIvZ8tMjKpznmqO9Z5ekDjGCfx627N3AnuhOKXfL+ceZQxnNz6HSR
 6wD6Ce7MC/2eU/baUTi+1PymXZ5OpDSsb/Jz60fhn9yYmRWiPTuW43F2iw9agL6CZr4+
 gi/A==
X-Gm-Message-State: AOAM531Fiv4hYigGMnWk68uLn9XKinfGkXFAxptTQU2B7cR8jMGUh+YH
 +gpV4mxmggRq0jpcryvV6Nf7FA==
X-Google-Smtp-Source: ABdhPJzED7HcLyGFPWdG5U4GtxJ9nU13WoMu/wsaNmOE8Ia2aHE+xQgk+fFtK5iYslBsmLLlnWZE0A==
X-Received: by 2002:a17:906:d109:: with SMTP id
 b9mr1894772ejz.548.1618816561662; 
 Mon, 19 Apr 2021 00:16:01 -0700 (PDT)
Received: from apalos.home (ppp-94-65-92-88.home.otenet.gr. [94.65.92.88])
 by smtp.gmail.com with ESMTPSA id q10sm8586361eds.26.2021.04.19.00.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Apr 2021 00:16:01 -0700 (PDT)
Date: Mon, 19 Apr 2021 10:15:58 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/1] mm: Fix struct page layout on 32-bit systems
Message-ID: <YH0uLsnzdE9ya6kw@apalos.home>
References: <20210411103318.GC2531743@casper.infradead.org>
 <20210412011532.GG2531743@casper.infradead.org>
 <20210414101044.19da09df@carbon>
 <20210414115052.GS2531743@casper.infradead.org>
 <20210414211322.3799afd4@carbon>
 <20210414213556.GY2531743@casper.infradead.org>
 <a50c3156fe8943ef964db4345344862f@AcuMS.aculab.com>
 <20210415200832.32796445@carbon>
 <20210416152755.GL2531743@casper.infradead.org>
 <20210419063441.GA18787@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419063441.GA18787@lst.de>
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
Cc: Arnd Bergmann <arnd@kernel.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 David Laight <David.Laight@aculab.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Matteo Croce <mcroce@linux.microsoft.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On Mon, Apr 19, 2021 at 08:34:41AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 16, 2021 at 04:27:55PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 15, 2021 at 08:08:32PM +0200, Jesper Dangaard Brouer wrote:
> > > See below patch.  Where I swap32 the dma address to satisfy
> > > page->compound having bit zero cleared. (It is the simplest fix I could
> > > come up with).
> > 
> > I think this is slightly simpler, and as a bonus code that assumes the
> > old layout won't compile.
> 
> So, why do we even do this crappy overlay of a dma address?  This just
> all seems like a giant hack.  Random subsystems should not just steal
> a few struct page fields as that just turns into the desasters like the
> one we've seen here or probably something worse next time.

The page pool API was using page->private in the past to store these kind of
info. That caused a problem to begin with, since it would fail  on 32-bit
systems with 64bit DMA.  We had a similar discussion on the past but decided
struct page is the right place to store that [1].

Another advantage is that we can now use the information from the networking 
subsystem and enable recycling of SKBs and SKB fragments, by using the stored 
metadata of struct page [2].

[1] https://lore.kernel.org/netdev/20190207.132519.1698007650891404763.davem@davemloft.net/
[2] https://lore.kernel.org/netdev/20210409223801.104657-1-mcroce@linux.microsoft.com/

Cheers
/Ilias
