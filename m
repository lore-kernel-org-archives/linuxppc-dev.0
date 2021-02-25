Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE07C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 11:16:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C3264EF1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 11:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C3264EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmVbS0xslz3cZG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 22:16:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=l8g3SqNm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=l8g3SqNm; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmVb019wgz30N1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 22:15:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DmVZr71ldz9sBy;
 Thu, 25 Feb 2021 22:15:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1614251751;
 bh=Vca/imfcO2yn/YdTghwR8DqtTxd3FAFwqDWZTbVefq4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=l8g3SqNmOf5alYyLAsWGsuOdqzrJtVJj4EJ6aKNBYE4wELIlH1+ejvW9kSQyaxuqX
 /JME0W7NjR4gvc5TZ8X+Pmu0aJ3RI+WvleS4b40NwCo+3OBwh5EpP+pJ8q2+LggIjZ
 V8ycZ2v23ZkcE6LEQpJT0knqp9OG2YMPwaSlBmpvzYPx1bo8OEOg8b1YlzvDkfQC8q
 PdeABa2WJRDW12/Mq3gQmB1vjzY6/bkq1y20EOd/X+Kl45PjgOIu+rmLa16Lxqcwnz
 Si9rFvNiSTJgGxcYsbALHAvSuneDoY2ed/VXVLP2kx0c/+cUvN1uhLfYD4+JrHdumW
 QZgzAwZOuMSGw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yang Li <yang.lee@linux.alibaba.com>, herbert@gondor.apana.org.au
Subject: Re: [PATCH] crypto/nx: add missing call to of_node_put()
In-Reply-To: <1614243417-48556-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614243417-48556-1-git-send-email-yang.lee@linux.alibaba.com>
Date: Thu, 25 Feb 2021 22:15:45 +1100
Message-ID: <87v9ags8im.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-crypto@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Yang Li <yang.lee@linux.alibaba.com> writes:
> In one of the error paths of the for_each_child_of_node() loop,
> add missing call to of_node_put().
>
> Fix the following coccicheck warning:
> ./drivers/crypto/nx/nx-common-powernv.c:927:1-23: WARNING: Function
> "for_each_child_of_node" should have of_node_put() before return around
> line 936.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/crypto/nx/nx-common-powernv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
> index 13c65de..b43c457 100644
> --- a/drivers/crypto/nx/nx-common-powernv.c
> +++ b/drivers/crypto/nx/nx-common-powernv.c
> @@ -933,6 +933,7 @@ static int __init nx_powernv_probe_vas(struct device_node *pn)
>  				NX_CT_GZIP, "ibm,p9-nx-gzip", &ct_gzip);
>  
>  		if (ret)
> +			of_node_put(dn);
>  			return ret;

Sorry this is wrong, the if needs braces.

cheers
