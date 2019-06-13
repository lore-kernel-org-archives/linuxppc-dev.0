Return-Path: <SRS0=gIJz=UM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B770DC31E45
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Jun 2019 13:11:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A11E21721
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Jun 2019 13:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A11E21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Pkf94LczzDrN8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Jun 2019 23:11:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=216.24.177.18; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45PkbR5SZVzDrGw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2019 23:09:21 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1hbPTY-0001tF-EP; Thu, 13 Jun 2019 21:09:08 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1hbPTS-0005Yj-KZ; Thu, 13 Jun 2019 21:09:02 +0800
Date: Thu, 13 Jun 2019 21:09:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 4/4] crypto: talitos - drop icv_ool
Message-ID: <20190613130902.bswei465r4ey66gc@gondor.apana.org.au>
References: <cover.1560263641.git.christophe.leroy@c-s.fr>
 <39be46fb40ad77e40ae5c1a979ca6a2ccfab244a.1560263641.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB34852F501B30A09A4E515B4798EF0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <b2db68d5-d89b-2f38-d5b4-7b7eccf68204@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2db68d5-d89b-2f38-d5b4-7b7eccf68204@c-s.fr>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>, Horia Geanta <horia.geanta@nxp.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 13, 2019 at 02:28:51PM +0200, Christophe Leroy wrote:
> 
> 
> Le 13/06/2019 à 14:21, Horia Geanta a écrit :
> > On 6/11/2019 5:39 PM, Christophe Leroy wrote:
> > > icv_ool is not used anymore, drop it.
> > > 
> > > Fixes: 9cc87bc3613b ("crypto: talitos - fix AEAD processing")
> > I can't find this SHA1.
> > 
> > Are you referring to commit e345177ded17 ("crypto: talitos - fix AEAD processing.")?
> > 
> > Horia
> > 
> 
> Oops yes, that's the sha1 it had in my tree before it got merged.
> 
> Do I have to resend it or can Herbert just drop the wrong reference and take
> the following one:

Please resend since you're going to change the other patches too.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
