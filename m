Return-Path: <SRS0=fR6Q=BJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA153C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:31:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C1920809
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 01:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Jmc6e8k7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C1920809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHCY95sc2zDqtR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2020 11:31:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHCVL5J3jzDqdf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 11:28:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Jmc6e8k7; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHCVL0ZHZz9sRN;
 Thu, 30 Jul 2020 11:28:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596072522;
 bh=CBXQEncx5ICdSQp2iEa2IBvBCwHWDKYPRESmYradVyQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Jmc6e8k7CX0FVJeMzy9n7A0qudqL+MWV/ykUBtaYD3TnFW9axvLLnjlCbcK+U2GA/
 UwiO/+Trw1tQuZ2LwdXFXR/ZOgkI8xBpJnSw4p7M5y9olADT0z2C1AbGYOrgyFc/pc
 OVroqo8DO25h3Bi3tPFoPtkvlj+E6SC5Sckbly6IHnOlUnVU82+QPZH0MCW0HOapnA
 g9qjIU7i6xkGQmMOtm8Icu31QiCs5UmIsFu1geEZ+tUvBPMu68eQWTvfFaqwcvfhLJ
 DqLvDQYN8N27W6Y4Zx9aakeLgfDoVwtMybaXGXXZjwuL2+HLM9jDlvOtuwPlPxPIuI
 kpCTZ392OLEFQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/vio: drop bus_type from parent device
In-Reply-To: <20200406155748.6761-1-cascardo@canonical.com>
References: <20200406155748.6761-1-cascardo@canonical.com>
Date: Thu, 30 Jul 2020 11:28:38 +1000
Message-ID: <87ime56bax.fsf@mpe.ellerman.id.au>
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
Cc: cascardo@canonical.com, Peter Rajnoha <prajnoha@redhat.com>,
 gregkh@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[ Added Peter & Greg to Cc ]

Thadeu Lima de Souza Cascardo <cascardo@canonical.com> writes:
> Commit df44b479654f62b478c18ee4d8bc4e9f897a9844 ("kobject: return error
> code if writing /sys/.../uevent fails") started returning failure when
> writing to /sys/devices/vio/uevent.
>
> This causes an early udevadm trigger to fail. On some installer versions of
> Ubuntu, this will cause init to exit, thus panicing the system very early
> during boot.
>
> Removing the bus_type from the parent device will remove some of the extra
> empty files from /sys/devices/vio/, but will keep the rest of the layout
> for vio devices, keeping them under /sys/devices/vio/.

What exactly does it change?

I'm finding it hard to evaluate if this change is going to cause a
regression somehow.

I'm also not clear on why removing the bus type is correct, apart from
whether it fixes the bug you're seeing.

> It has been tested that uevents for vio devices don't change after this
> fix, they still contain MODALIAS.
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Fixes: df44b479654f ("kobject: return error code if writing /sys/.../uevent fails")

AFAICS there haven't been any other fixes for that commit. Do we know
why it is only vio that was affected? (possibly because it's a fake bus
to begin with?)

cheers

> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index 37f1f25ba804..a94dab3972a0 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -36,7 +36,6 @@ static struct vio_dev vio_bus_device  = { /* fake "parent" device */
>  	.name = "vio",
>  	.type = "",
>  	.dev.init_name = "vio",
> -	.dev.bus = &vio_bus_type,
>  };
>  
>  #ifdef CONFIG_PPC_SMLPAR
> -- 
> 2.20.1
