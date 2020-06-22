Return-Path: <SRS0=kptR=AD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22692C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 13:36:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DAA20716
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 13:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DAA20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49r9RG1DlpzDqY0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 23:36:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=fornost.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from fornost.hmeau.com (unknown [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49r9NV4tXVzDqVN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 23:33:41 +1000 (AEST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
 by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
 id 1jnMZg-0000Iu-Gy; Mon, 22 Jun 2020 23:33:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation);
 Mon, 22 Jun 2020 23:33:24 +1000
Date: Mon, 22 Jun 2020 23:33:24 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: Re: [next-20200621] LTP tests af_alg02/05 failure on POWER9 PowerVM
 LPAR
Message-ID: <20200622133324.GA4025@gondor.apana.org.au>
References: <DF21C7B5-3824-4A6E-B59C-78B67E247383@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF21C7B5-3824-4A6E-B59C-78B67E247383@linux.vnet.ibm.com>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 22, 2020 at 05:55:29PM +0530, Sachin Sant wrote:
> With recent next(next-20200621) af_alg02/05 tests fail while running on POWER9
> PowerVM LPAR.
> 
> Results from  5.8.0-rc1-next-20200622
> # ./af_alg02
> tst_test.c:1096: INFO: Timeout per run is 0h 00m 20s
> af_alg02.c:52: BROK: Timed out while reading from request socket.
> #
> 
> 5.8.0-rc1-next-20200618 was good. The test case ran fine.
> 
> Root cause analysis point to following commit:
> 
> commit f3c802a1f30013f8f723b62d7fa49eb9e991da23
>     crypto: algif_aead - Only wake up when ctx->more is zero
> 
> Reverting this commit allows the test to PASS.

Yes that commit does change the behaviour if you don't terminate
your AEAD request by clearing the MSG_MORE flag.  AEAD does not
support chaining so each request must be sent in full before it
can be processed through recvmsg(2).  Setting the MSG_MORE flag
indicates that your request has not been sent in full.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
