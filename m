Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC83C25B75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 11:04:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VrKyb5m3sz3cWN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 21:04:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
X-Greylist: delayed 2598 seconds by postgrey-1.37 at boromir; Fri, 31 May 2024 21:04:31 AEST
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VrKy773n6z30Th
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2024 21:04:31 +1000 (AEST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sCzNQ-004AiX-2n;
	Fri, 31 May 2024 18:20:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 May 2024 18:20:50 +0800
Date: Fri, 31 May 2024 18:20:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Danny Tsen <dtsen@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] crypto: X25519 supports for ppc64le
Message-ID: <Zlmkgisql2NxPcXi@gondor.apana.org.au>
References: <20240516151957.2215-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516151957.2215-1-dtsen@linux.ibm.com>
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
Cc: dtsen@us.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org, appro@cryptogams.org, linux-crypto@vger.kernel.org, ltcgcw@linux.vnet.ibm.com, leitao@debian.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 16, 2024 at 11:19:54AM -0400, Danny Tsen wrote:
> This patch series provide X25519 support for ppc64le with a new module
> curve25519-ppc64le.
> 
> The implementation is based on CRYPTOGAMs perl output from x25519-ppc64.pl.
> (see https://github.com/dot-asm/cryptogams/)
> Modified and added 4 supporting functions.
> 
> This patch has passed the selftest by running modprobe
> curve25519-ppc64le.
> 
> Danny Tsen (3):
>   X25519 low-level primitives for ppc64le.
>   X25519 core functions for ppc64le
>   Update Kconfig and Makefile for ppc64le x25519.
> 
>  arch/powerpc/crypto/Kconfig                   |  11 +
>  arch/powerpc/crypto/Makefile                  |   2 +
>  arch/powerpc/crypto/curve25519-ppc64le-core.c | 299 ++++++++
>  arch/powerpc/crypto/curve25519-ppc64le_asm.S  | 671 ++++++++++++++++++
>  4 files changed, 983 insertions(+)
>  create mode 100644 arch/powerpc/crypto/curve25519-ppc64le-core.c
>  create mode 100644 arch/powerpc/crypto/curve25519-ppc64le_asm.S
> 
> -- 
> 2.31.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
