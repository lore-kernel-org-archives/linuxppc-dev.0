Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4B2C00140
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 11:15:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LxsqV2hLYz3c6X
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Aug 2022 21:15:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=OKnuybTA;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lxspr1XKZz2xGf
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2022 21:15:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=OKnuybTA;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lxspq5mcDz4x1P;
	Tue,  2 Aug 2022 21:15:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1659438916;
	bh=QUd6PC2Si9JD8mo+JkMA5SafHzZ0731ZhqbEwcSaXJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OKnuybTApefW3m2zs2oGXCdRishriCtmSW4T2xlKbFjRyRvkkXlPz4XQu2L8O0DCn
	 aAMr/nrOZLjsE29c2uHvHC8ohh9YbosZMpduZiwzQrkXSaQqOarrhv+vaHjEv8FU2V
	 R+Y+UETZJBMYDbdAPusbFDS6hQTBrHAr2B2ztUdfd1a+jNIaugE/JLOE6dNaQirsVD
	 P/eaFSzleC+g5qSR+FErP1Gj5mIQZlfEzAnq9DTuJyvesQ9//GGLJ3BaUWqpBAuSmv
	 46gJgdOg4NdKl88iZknrEq8l30I2QPJEzqOb4kDEIwZirLlfq7EbJAiPubwuGNcEse
	 mU0EriPxZC6yg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-edac@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] EDAC/ppc_4xx: Include required of_irq header directly
In-Reply-To: <993f5a7da371458cb819b5f3f569073c78523b01.1659436180.git.christophe.leroy@csgroup.eu>
References: <993f5a7da371458cb819b5f3f569073c78523b01.1659436180.git.christophe.leroy@csgroup.eu>
Date: Tue, 02 Aug 2022 21:15:15 +1000
Message-ID: <87zggmaocc.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit 4d5c5bad5193 ("powerpc: Remove asm/prom.h from asm/mpc52xx.h
> and asm/pci.h") that cleans up powerpc's asm/prom.h leads to build
> errors in ppc4xx_edac.c due to missing header. Include required
> header directly to avoid the build failure.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 4d5c5bad5193 ("powerpc: Remove asm/prom.h from asm/mpc52xx.h and asm/pci.h")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/edac/ppc4xx_edac.c | 1 +
>  1 file changed, 1 insertion(+)

I'll pick this up as I merged the commit that broke it.

cheers

> diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
> index 6793f6d799e7..0bc670778c99 100644
> --- a/drivers/edac/ppc4xx_edac.c
> +++ b/drivers/edac/ppc4xx_edac.c
> @@ -11,6 +11,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/types.h>
>  
> -- 
> 2.36.1
