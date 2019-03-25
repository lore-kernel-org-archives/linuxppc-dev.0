Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C200AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 10:49:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E282085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 10:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E282085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SWHD4zf7zDqC9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 21:49:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SWF866gnzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 21:47:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44SWF75kn8z9sSq;
 Mon, 25 Mar 2019 21:47:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peng Hao <peng.hao2@zte.com.cn>, vitb@kernel.crashing.org,
 benh@kernel.crashing.org, paulus@samba.org, christophe.leroy@c-s.fr
Subject: Re: [PATCH v2] powerpc/8xx: fix possible object reference leak
In-Reply-To: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
References: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
Date: Mon, 25 Mar 2019 21:47:53 +1100
Message-ID: <87d0mfp6w6.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Wen Yang <wen.yang99@zte.com.cn>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Peng Hao <peng.hao2@zte.com.cn> writes:

> From: Wen Yang <wen.yang99@zte.com.cn>
>
> The call to of_find_compatible_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> irq_domain_add_linear also calls of_node_get to increase refcount,
> so irq_domain will not be affected when it is released.
>
> Detected by coccinelle with the following warnings:
> ./arch/powerpc/platforms/8xx/pic.c:158:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 136, but without a corresponding object release within this function.
>
> Fixes: a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with
> revmap-specific initializers")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
> Cc: Vitaly Bordug <vitb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/powerpc/platforms/8xx/pic.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index 8d5a25d..4453df6 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -153,9 +153,7 @@ int mpc8xx_pic_init(void)
>  	if (mpc8xx_pic_host == NULL) {
>  		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>  		ret = -ENOMEM;
> -		goto out;
>  	}
> -	return 0;

It's fragile to rely on ret being equal to zero here. If the code
further up is changed it's easy enough to miss that ret is expected to
be zero.

Better to set it to zero here explicitly, this is the success path after
all, eg:

	ret = 0;

>  out:
>  	of_node_put(np);


cheers
