Return-Path: <SRS0=g7Ik=KX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4EAC47087
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 07:27:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C633161005
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 07:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C633161005
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Frx8P1KHPz3bsK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 May 2021 17:27:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=deadmen.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Frx7x68ZXz2xxq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 May 2021 17:26:35 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
 id 1lmWsu-0003bo-Sd; Fri, 28 May 2021 15:26:21 +0800
Received: from herbert by gondobar with local (Exim 4.92)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1lmWsj-0001yG-VK; Fri, 28 May 2021 15:26:10 +0800
Date: Fri, 28 May 2021 15:26:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/3] Rid W=1 warnings from Crypto
Message-ID: <20210528072609.GG7392@gondor.apana.org.au>
References: <20210520092733.3434378-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520092733.3434378-1-lee.jones@linaro.org>
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
Cc: John Allen <john.allen@amd.com>,
 Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Gary R Hook <gary.hook@amd.com>,
 linux-kernel@vger.kernel.org, George Cherian <gcherian@marvell.com>,
 Paul Mackerras <paulus@samba.org>, Robert Jennings <rcj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 20, 2021 at 10:27:30AM +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Lee Jones (3):
>   crypto: cavium: Fix a bunch of kernel-doc related issues
>   crypto: nx: nx-aes-gcm: Kernel-doc formatting should not be used for
>     headers
>   crypto: ccp: ccp-dev: Fix a little doc-rot
> 
>  drivers/crypto/cavium/cpt/cptpf_main.c        |  2 +-
>  drivers/crypto/cavium/cpt/cptvf_reqmanager.c  |  4 ++--
>  drivers/crypto/cavium/nitrox/nitrox_main.c    |  4 ++--
>  drivers/crypto/cavium/nitrox/nitrox_mbx.c     |  4 ++--
>  drivers/crypto/cavium/nitrox/nitrox_reqmgr.c  | 12 ++++++----
>  .../crypto/cavium/nitrox/nitrox_skcipher.c    |  2 +-
>  drivers/crypto/ccp/ccp-dev.c                  |  2 +-
>  drivers/crypto/nx/nx-842-pseries.c            | 24 +++++++++----------
>  8 files changed, 27 insertions(+), 27 deletions(-)
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Gary R Hook <gary.hook@amd.com>
> Cc: George Cherian <gcherian@marvell.com>
> Cc: Haren Myneni <haren@us.ibm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: John Allen <john.allen@amd.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
> Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> -- 
> 2.31.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
