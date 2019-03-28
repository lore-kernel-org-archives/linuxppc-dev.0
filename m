Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB38C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 06:10:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD4D20700
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 06:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD4D20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VDy13VsXzDqN0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 17:10:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=104.223.48.154; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VDvt1CgZzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 17:08:57 +1100 (AEDT)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1h9OCw-0003s0-RK; Thu, 28 Mar 2019 14:08:10 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1h9OCl-0007nh-9O; Thu, 28 Mar 2019 14:07:59 +0800
Date: Thu, 28 Mar 2019 14:07:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Yue Haibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] crypto: vmx - Make p8_init and p8_exit static
Message-ID: <20190328060759.ibwxcivx3unnpip4@gondor.apana.org.au>
References: <20190321151148.19128-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321151148.19128-1-yuehaibing@huawei.com>
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
Cc: nayna@linux.ibm.com, linux-kernel@vger.kernel.org, pfsmorigo@gmail.com,
 linux-crypto@vger.kernel.org, leitao@debian.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 21, 2019 at 11:11:48PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> drivers/crypto/vmx/vmx.c:44:12: warning:
>  symbol 'p8_init' was not declared. Should it be static?
> drivers/crypto/vmx/vmx.c:70:13: warning:
>  symbol 'p8_exit' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
