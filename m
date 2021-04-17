Return-Path: <SRS0=JxsT=JO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063DC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 21:29:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9601161210
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 21:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9601161210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FN5nd2Pm4z3bVb
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Apr 2021 07:29:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=kjCBnWRn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=kjCBnWRn; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FN5n75pJBz2yxk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Apr 2021 07:29:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tdMd9G9wD3dHdDB049z0mEp3bwlE87mJ0J7o89xl/iU=; b=kjCBnWRnNfJ4jh1gNX/lQqFZaV
 PIt6sDdbkDGzgmh71GE65C7gRjevycey4DoCtbejN9tL9oy21OFCEaAalEL1tJX2o90jMIunwvzlT
 aw6WnoUC4xKa/S6Fo+ZMatucihabyUEWmzgS2fQA3KuKU2AamMDSAvwzszyCc5I4TnWdPWLrwWCKi
 rVT5becyLy4eWu5C3CPFKJcjpScabeN83QGn+BwxjvQCu6su18nAbnPuTOLaKIYZFme9zSXfjcKXe
 HVFpVtf65QAh/PF06VB9QUA3eZMEV6/SGt6UIGiIg++xfTnOleyRsiTg4gP470cAho43TKpegokfh
 QjMDTCHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lXsUd-00BiOm-RD; Sat, 17 Apr 2021 21:28:45 +0000
Date: Sat, 17 Apr 2021 22:28:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 2/2] mm: Indicate pfmemalloc pages in compound_head
Message-ID: <20210417212843.GT2531743@casper.infradead.org>
References: <20210416230724.2519198-1-willy@infradead.org>
 <20210416230724.2519198-3-willy@infradead.org>
 <2a531a42f23e4046833e0feb8faef0b5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a531a42f23e4046833e0feb8faef0b5@AcuMS.aculab.com>
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
Cc: "arnd@kernel.org" <arnd@kernel.org>,
 "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "mhocko@kernel.org" <mhocko@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "mgorman@suse.de" <mgorman@suse.de>,
 "brouer@redhat.com" <brouer@redhat.com>,
 "mcroce@linux.microsoft.com" <mcroce@linux.microsoft.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 17, 2021 at 09:13:45PM +0000, David Laight wrote:
> >  		struct {	/* page_pool used by netstack */
> > -			/**
> > -			 * @dma_addr: might require a 64-bit value on
> > -			 * 32-bit architectures.
> > -			 */
> > +			unsigned long pp_magic;
> > +			unsigned long xmi;
> > +			unsigned long _pp_mapping_pad;
> >  			unsigned long dma_addr[2];
> >  		};
> 
> You've deleted the comment.

Yes.  It no longer added any value.  You can see dma_addr now occupies
two words.

> I also think there should be a comment that dma_addr[0]
> must be aliased to ->index.

That's not a requirement.  Moving the pfmemalloc indicator is a
requirement so that we _can_ use index, but there's no requirement about
how index is used.
