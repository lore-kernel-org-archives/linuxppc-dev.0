Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C809C001E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jul 2023 09:56:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RC31y53PPz3cW2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jul 2023 19:56:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gondor.apana.org.au (client-ip=167.179.156.38; helo=167-179-156-38.a7b39c.syd.nbn.aussiebb.net; envelope-from=herbert@gondor.apana.org.au; receiver=lists.ozlabs.org)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RC31N5qvdz3c3X
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2023 19:56:07 +1000 (AEST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qPKBs-0011CA-9u; Fri, 28 Jul 2023 17:55:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jul 2023 17:55:20 +0800
Date: Fri, 28 Jul 2023 17:55:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC PATCH 00/21] crypto: consolidate and clean up compression
 APIs
Message-ID: <ZMOQiPadP2jggZ2i@gondor.apana.org.au>
References: <20230718125847.3869700-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718125847.3869700-1-ardb@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Steffen Klassert <steffen.klassert@secunet.com>, Kees Cook <keescook@chromium.org>, qat-linux@intel.com, Sergey Senozhatsky <senozhatsky@chromium.org>, Richard Weinberger <richard@nod.at>, David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, Minchan Kim <minchan@kernel.org>, Nick Terrell <terrelln@fb.com>, linux-block@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 18, 2023 at 02:58:26PM +0200, Ard Biesheuvel wrote:
>
> Patch #2 removes the support for on-the-fly allocation of destination
> buffers and scatterlists from the Intel QAT driver. This is never used,
> and not even implemented by all drivers (the HiSilicon ZIP driver does
> not support it). The diffstat of this patch makes a good case why the
> caller should be in charge of allocating the memory, not the driver.

The implementation in qat may not be optimal, but being able to
allocate memory in the algorithm is a big plus for IPComp at least.

Being able to allocate memory page by page as you decompress
means that:

1. We're not affected by memory fragmentation.
2. We don't waste memory by always allocating for the worst case.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
