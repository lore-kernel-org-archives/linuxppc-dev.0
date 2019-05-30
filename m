Return-Path: <SRS0=Y6lA=T6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B97FC28CC0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 13:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E96259FB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 13:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E96259FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45F8Jc5LMbzDqWm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 23:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=216.24.177.18; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F7zv5XJLzDqV9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 23:42:19 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1hWLJq-0005bs-ME; Thu, 30 May 2019 21:42:10 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1hWLJo-0003f3-NQ; Thu, 30 May 2019 21:42:08 +0800
Date: Thu, 30 May 2019 21:42:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v1 00/15] Fixing selftests failure on Talitos driver
Message-ID: <20190530134208.frpozzmqtafw35hy@gondor.apana.org.au>
References: <cover.1558445259.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558445259.git.christophe.leroy@c-s.fr>
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
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com,
 linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 21, 2019 at 01:34:06PM +0000, Christophe Leroy wrote:
> Several test failures have popped up following recent changes to crypto
> selftests.
> 
> This series fixes (most of) them.
> 
> The last three patches are trivial cleanups.
> 
> Christophe Leroy (15):
>   crypto: talitos - fix skcipher failure due to wrong output IV
>   crypto: talitos - rename alternative AEAD algos.
>   crypto: talitos - reduce max key size for SEC1
>   crypto: talitos - check AES key size
>   crypto: talitos - fix CTR alg blocksize
>   crypto: talitos - check data blocksize in ablkcipher.
>   crypto: talitos - fix ECB algs ivsize
>   crypto: talitos - Do not modify req->cryptlen on decryption.
>   crypto: talitos - HMAC SNOOP NO AFEU mode requires SW icv checking.
>   crypto: talitos - properly handle split ICV.
>   crypto: talitos - Align SEC1 accesses to 32 bits boundaries.
>   crypto: talitos - fix AEAD processing.
>   Revert "crypto: talitos - export the talitos_submit function"
>   crypto: talitos - use IS_ENABLED() in has_ftr_sec1()
>   crypto: talitos - use SPDX-License-Identifier
> 
>  drivers/crypto/talitos.c | 281 ++++++++++++++++++++++-------------------------
>  drivers/crypto/talitos.h |  45 ++------
>  2 files changed, 139 insertions(+), 187 deletions(-)

Patch 1 was already applied.

2-15 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
