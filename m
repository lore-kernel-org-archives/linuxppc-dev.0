Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31021C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Dec 2021 12:05:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JQP3b2B12z3cCj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Dec 2021 23:05:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=fornost.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
X-Greylist: delayed 1791 seconds by postgrey-1.36 at boromir;
 Fri, 31 Dec 2021 23:05:03 AEDT
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JQP333njFz2xDY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Dec 2021 23:05:03 +1100 (AEDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
 by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
 id 1n3GB5-0004sN-4E; Fri, 31 Dec 2021 22:34:32 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation);
 Fri, 31 Dec 2021 22:34:30 +1100
Date: Fri, 31 Dec 2021 22:34:30 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH 0/5] Remove duplicate context init function for sha
 algorithm
Message-ID: <Yc7qxrxxIMr5kPSj@gondor.apana.org.au>
References: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
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
Cc: linux-s390@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 sparclinux@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 20, 2021 at 05:23:13PM +0800, Tianjia Zhang wrote:
> This series of patches is mainly for repetitive code cleaning. The sha
> algorithm has provided generic context initialization implementation.
> The context initialization code in the optimized implementation of each
> platform is a repetitive code and can be deleted. The sha*_base_init()
> series of functions are used uniformly.
> 
> Tianjia Zhang (5):
>   crypto: sha256 - remove duplicate generic hash init function
>   crypto: mips/sha - remove duplicate hash init function
>   crypto: powerpc/sha - remove duplicate hash init function
>   crypto: sparc/sha - remove duplicate hash init function
>   crypto: s390/sha512 - Use macros instead of direct IV numbers
> 
>  arch/mips/cavium-octeon/crypto/octeon-sha1.c  | 17 +-------
>  .../mips/cavium-octeon/crypto/octeon-sha256.c | 39 ++-----------------
>  .../mips/cavium-octeon/crypto/octeon-sha512.c | 39 ++-----------------
>  arch/powerpc/crypto/sha1-spe-glue.c           | 17 +-------
>  arch/powerpc/crypto/sha1.c                    | 14 +------
>  arch/powerpc/crypto/sha256-spe-glue.c         | 39 ++-----------------
>  arch/s390/crypto/sha512_s390.c                | 32 +++++++--------
>  arch/sparc/crypto/sha1_glue.c                 | 14 +------
>  arch/sparc/crypto/sha256_glue.c               | 37 ++----------------
>  arch/sparc/crypto/sha512_glue.c               | 37 ++----------------
>  crypto/sha256_generic.c                       | 16 +-------
>  11 files changed, 41 insertions(+), 260 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
