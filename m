Return-Path: <SRS0=79up=TR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED5FC04AB4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 05:09:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FAD2083E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 05:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FAD2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 454xCt0CPKzDqRq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 15:09:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=128.1.224.119; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
X-Greylist: delayed 1555 seconds by postgrey-1.36 at bilbo;
 Fri, 17 May 2019 15:08:02 AEST
Received: from deadmen.hmeau.com (unknown [128.1.224.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 454xBV36jszDqRC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2019 15:08:02 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1hRUgn-0007Sr-JW; Fri, 17 May 2019 12:41:49 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1hRUgd-0006YT-Cg; Fri, 17 May 2019 12:41:39 +0800
Date: Fri, 17 May 2019 12:41:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] crypto: vmx - ghash: do nosimd fallback manually
Message-ID: <20190517044139.vx4wxzflmjpcjw6f@gondor.apana.org.au>
References: <20190516154002.26246-1-dja@axtens.net>
 <87bm02hsl4.fsf@concordia.ellerman.id.au>
 <87tvdtzzsj.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvdtzzsj.fsf@dja-thinkpad.axtens.net>
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
Cc: leo.barbosa@canonical.com, Stephan Mueller <smueller@chronox.de>,
 nayna@linux.ibm.com, omosnacek@gmail.com, ebiggers@kernel.org,
 leitao@debian.org, pfsmorigo@gmail.com, linux-crypto@vger.kernel.org,
 marcelo.cerri@canonical.com, gcwilson@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 17, 2019 at 10:32:12AM +1000, Daniel Axtens wrote:
>
> Yes, I think that's the right fixes tag. Not quite sure how I managed to
> miss that! Herbert, I assume this will go via your tree: do you want me
> to send a v2 with the tag or are you OK to just add that in when you
> merge it?

I can add this when applying the patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
