Return-Path: <SRS0=wfc/=E2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF7C56201
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 06:27:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29ED322256
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 06:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Za5GnF8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ED322256
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ccmmt1fpdzDqxL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 17:27:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ccmkl43WvzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 17:25:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Za5GnF8S; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ccmkj1dy1z9sTL;
 Fri, 20 Nov 2020 17:25:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1605853535;
 bh=/UKIi79q6Eu95MhQTC3KHQ2vQz9Gi8asFIpqVebEfbg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Za5GnF8SgpLmYK0mvMRfCH7z8RFRMHJC1OhlUvmo58HebyiQlAnuz3F67jHbT/xTb
 TepHetkIKvT9+mwXnmp2rhN4mCvnR/g61MN3C0S6qayV+zWmxpxSCLtyuS3XfQJ/4G
 hT7A77XscWQh7tSEn2I/5GKOxmQwSML8JNrVibzcX7WVytrpf1Iz6XWupcWiFk9YXg
 xRfmDa4DTn8J4akmJqOoHz0JR9ncSjF5dRPyDgQ5hvrdsLKIyUj67J7cvTzigld1bE
 OmGbri57OjObyQ1wT9XWqzKQCIORzrS2NuTF7LDBdhoukWFNgc855KBTBZ1U3a29m4
 I2hkqH1yDkwvQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Fabio Estevam <festevam@gmail.com>, mchehab@kernel.org
Subject: Re: [PATCH] media: fsl-viu: Use proper check for presence of {out,
 in}_be32()
In-Reply-To: <20201120001509.15155-1-festevam@gmail.com>
References: <20201120001509.15155-1-festevam@gmail.com>
Date: Fri, 20 Nov 2020 17:25:29 +1100
Message-ID: <87ima01r52.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, hverkuil@xs4all.nl, paulus@samba.org,
 geert@linux-m68k.org, Fabio Estevam <festevam@gmail.com>,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fabio Estevam <festevam@gmail.com> writes:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>
> When compile-testing on m68k or microblaze:
>
>     drivers/media/platform/fsl-viu.c:41:1: warning: "out_be32" redefined
>     drivers/media/platform/fsl-viu.c:42:1: warning: "in_be32" redefined
>
> Fix this by replacing the check for PowerPC by checks for the presence
> of {out,in}_be32().
>
> As PowerPC implements the be32 accessors using inline functions instead
> of macros, identity definions are added for all accessors to make the
> above checks work.
>
> Fixes: 29d750686331a1a9 ("media: fsl-viu: allow building it with COMPILE_TEST")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> [fabio: adapt to mainline]
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/powerpc/include/asm/io.h    | 14 ++++++++++++++
>  drivers/media/platform/fsl-viu.c |  5 +++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 58635960403c..fcb250db110d 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -194,6 +194,20 @@ static inline void out_be64(volatile u64 __iomem *addr, u64 val)
>  #endif
>  #endif /* __powerpc64__ */
>  
> +#define in_be16 in_be16
> +#define in_be32 in_be32
> +#define in_be64 in_be64
> +#define in_le16 in_le16
> +#define in_le32 in_le32
> +#define in_le64 in_le64
> +
> +#define out_be16 out_be16
> +#define out_be32 out_be32
> +#define out_be64 out_be64
> +#define out_le16 out_le16
> +#define out_le32 out_le32
> +#define out_le64 out_le64

I'd rather not have to carry this in arch code just for one driver.

> diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
> index 4f2a0f992905..bb6c291ed6dc 100644
> --- a/drivers/media/platform/fsl-viu.c
> +++ b/drivers/media/platform/fsl-viu.c
> @@ -31,9 +31,10 @@
>  #define DRV_NAME		"fsl_viu"
>  #define VIU_VERSION		"0.5.1"
>  
> -/* Allow building this driver with COMPILE_TEST */
> -#if !defined(CONFIG_PPC) && !defined(CONFIG_MICROBLAZE) && !defined(CONFIG_M68K)
> +#ifndef out_be32
>  #define out_be32(v, a)	iowrite32be(a, (void __iomem *)v)
> +#endif
> +#ifndef in_be32
>  #define in_be32(a)	ioread32be((void __iomem *)a)
>  #endif

Can't the driver just use ioread/write32be() on all platforms?

cheers
