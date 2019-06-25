Return-Path: <SRS0=GBvC=UY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED2C4646B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jun 2019 01:23:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698E0206DD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jun 2019 01:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698E0206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45XpLz5FlNzDqSw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Jun 2019 11:23:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=216.24.177.18; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45XpK45RgvzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2019 11:21:25 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1hfa8x-0004UA-5l; Tue, 25 Jun 2019 09:21:07 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1hfa8p-0005ra-Sk; Tue, 25 Jun 2019 09:20:59 +0800
Date: Tue, 25 Jun 2019 09:20:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH v4 1/4] lib/scatterlist: Fix mapping iterator when
 sg->offset is greater than PAGE_SIZE
Message-ID: <20190625012059.albyfaca73uoaoxr@gondor.apana.org.au>
References: <cover.1560805614.git.christophe.leroy@c-s.fr>
 <f28c6b0e2f9510f42ca934f19c4315084e668c21.1560805614.git.christophe.leroy@c-s.fr>
 <20190620060221.q4pbsqzsza3pxs42@gondor.apana.org.au>
 <20190624173533.GA809@ideak-desk.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624173533.GA809@ideak-desk.fi.intel.com>
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
Cc: horia.geanta@nxp.com, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 24, 2019 at 08:35:33PM +0300, Imre Deak wrote:
> Hi,
> 
> On Thu, Jun 20, 2019 at 02:02:21PM +0800, Herbert Xu wrote:
> > On Mon, Jun 17, 2019 at 09:15:02PM +0000, Christophe Leroy wrote:
> > > All mapping iterator logic is based on the assumption that sg->offset
> > > is always lower than PAGE_SIZE.
> > > 
> > > But there are situations where sg->offset is such that the SG item
> > > is on the second page.
> 
> could you explain how sg->offset becomes >= PAGE_SIZE?

The network stack can produce SG list elements that are longer
than PAGE_SIZE.  If you the iterate over it one page at a time
then the offset can exceed PAGE_SIZE.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
