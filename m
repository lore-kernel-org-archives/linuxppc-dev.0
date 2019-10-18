Return-Path: <SRS0=Uveu=YL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1553CA9EA3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AED21D80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AED21D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46vdwW0sdnzDrS5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Oct 2019 19:09:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=fornost.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46vdsJ2L0VzDrDN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2019 19:06:25 +1100 (AEDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
 by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
 id 1iLNH2-0001zp-G3; Fri, 18 Oct 2019 19:06:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation);
 Fri, 18 Oct 2019 19:06:12 +1100
Date: Fri, 18 Oct 2019 19:06:12 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/4] crypto: nx - convert to skcipher API
Message-ID: <20191018080612.GM25128@gondor.apana.org.au>
References: <20191013043918.337113-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013043918.337113-1-ebiggers@kernel.org>
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
Cc: Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Nayna Jain <nayna@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 12, 2019 at 09:39:14PM -0700, Eric Biggers wrote:
> This series converts the PowerPC Nest (NX) implementations of AES modes
> from the deprecated "blkcipher" API to the "skcipher" API.  This is
> needed in order for the blkcipher API to be removed.
> 
> This patchset is compile-tested only, as I don't have this hardware.
> If anyone has this hardware, please test this patchset with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
> 
> Eric Biggers (4):
>   crypto: nx - don't abuse blkcipher_desc to pass iv around
>   crypto: nx - convert AES-ECB to skcipher API
>   crypto: nx - convert AES-CBC to skcipher API
>   crypto: nx - convert AES-CTR to skcipher API
> 
>  drivers/crypto/nx/nx-aes-cbc.c | 81 ++++++++++++++-----------------
>  drivers/crypto/nx/nx-aes-ccm.c | 40 ++++++----------
>  drivers/crypto/nx/nx-aes-ctr.c | 87 +++++++++++++++-------------------
>  drivers/crypto/nx/nx-aes-ecb.c | 76 +++++++++++++----------------
>  drivers/crypto/nx/nx-aes-gcm.c | 24 ++++------
>  drivers/crypto/nx/nx.c         | 64 ++++++++++++++-----------
>  drivers/crypto/nx/nx.h         | 19 ++++----
>  7 files changed, 176 insertions(+), 215 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
