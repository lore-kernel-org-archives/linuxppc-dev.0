Return-Path: <SRS0=tA1z=TJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A24C04AAF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 05:25:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6853C20850
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 05:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6853C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4501yJ2d3NzDqPy
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 15:25:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=5.180.42.13; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from deadmen.hmeau.com (unknown [5.180.42.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4501ww2GCDzDqFY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2019 15:24:16 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1hObXG-0001CA-LP; Thu, 09 May 2019 13:24:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1hObX6-0001Yk-GZ; Thu, 09 May 2019 13:23:52 +0800
Date: Thu, 9 May 2019 13:23:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia Geanta <horia.geanta@nxp.com>
Subject: Re: [PATCH] crypto: caam/jr - Remove extra memory barrier during job
 ring dequeue
Message-ID: <20190509052352.nje7a4niuc2n6c57@gondor.apana.org.au>
References: <87pnp2aflz.fsf@concordia.ellerman.id.au>
 <VI1PR0402MB34851F6AB9FE68A2322EB09E98340@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB34851F6AB9FE68A2322EB09E98340@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Vakul Garg <vakul.garg@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 02, 2019 at 11:08:55AM +0000, Horia Geanta wrote:
>
> >> +
> >>  static inline void wr_reg32(void __iomem *reg, u32 data)
> >>  {
> >>  	if (caam_little_end)
> > 
> > This crashes on my p5020ds. Did you test on powerpc?
> > 
> > # first bad commit: [bbfcac5ff5f26aafa51935a62eb86b6eacfe8a49] crypto: caam/jr - Remove extra memory barrier during job ring dequeue
> 
> Thanks for the report Michael.
> 
> Any hint what would be the proper approach here - to have relaxed I/O accessors
> that would work both for ARM and PPC, and avoid ifdeffery etc.?

Since no fix has been found I'm reverting the commit in question.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
