Return-Path: <SRS0=J6Sm=EF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386BC56201
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 06:50:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D099522202
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 06:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D099522202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CMtHM6zQqzDqnn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 17:50:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=fornost.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CMtDx6QWTzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 17:48:31 +1100 (AEDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
 by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
 id 1kYOCw-0004on-FN; Fri, 30 Oct 2020 17:48:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation);
 Fri, 30 Oct 2020 17:48:18 +1100
Date: Fri, 30 Oct 2020 17:48:18 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] crypto: talitos - Endianess in current_desc_hdr()
Message-ID: <20201030064818.GB25453@gondor.apana.org.au>
References: <facca5935decb8ddefa4c4898b2aeedc7ec4f860.1602149660.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facca5935decb8ddefa4c4898b2aeedc7ec4f860.1602149660.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 08, 2020 at 09:34:55AM +0000, Christophe Leroy wrote:
> current_desc_hdr() compares the value of the current descriptor
> with the next_desc member of the talitos_desc struct.
> 
> While the current descriptor is obtained from in_be32() which
> return CPU ordered bytes, next_desc member is in big endian order.
> 
> Convert the current descriptor into big endian before comparing it
> with next_desc.
> 
> This fixes a sparse warning.
> 
> Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash on SEC1")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/crypto/talitos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
