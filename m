Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6040C4320A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 04:58:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E4D60E76
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 04:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13E4D60E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gw9bS3WKBz2ywM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 14:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=L5kddt7Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=L5kddt7Q; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gw9Zj4zL6z2xXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2021 14:57:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gw9Zb2cq8z9sXM;
 Thu, 26 Aug 2021 14:57:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629953863;
 bh=Wc8gisJFzR+NRbBpxFzMI1jqsCul17TIuMj9lRWpS9M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=L5kddt7Q9EwoKdr7oDa9NIdSnMu6IfoKHyMvMlyv2Zt3z7ORaQZZlDD1PoeRpxEgJ
 qbYoSwg8tvBE5itxezRxDO19sV467M3aK4khMrEeqvbHSFmqR0dzgvy5P+zoMX67uV
 T4SQakC6x0/TG6zk6C7VMibohBD8ZyQxj4emEWK/CbhKA46kMfTZZnIuPZvX78zcef
 cmQ2330nS0tSNCZuacnhT3ChHxMh02k3xPxI8CwLq98BJP6ViJC8eKoFrQh1UKPzUA
 uS7hotZyB3/u5Mn4lxmqjS5s/+llsjfUD6nShhyHd7g73CCGoEiornanDS3jktue7t
 3aoXDwpzqs1Xw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Redefine HMT_xxx macros as empty on PPC32
In-Reply-To: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
References: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
Date: Thu, 26 Aug 2021 14:57:42 +1000
Message-ID: <878s0oby61.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> HMT_xxx macros are macros for adjusting thread priority
> (hardware multi-threading) are macros inherited from PPC64
> via commit 5f7c690728ac ("[PATCH] powerpc: Merged ppc_asm.h")
>
> Those instructions are pointless on PPC32, but some common
> fonctions like arch_cpu_idle() use them.
>
> So make them empty on PPC32 to avoid those instructions.

I guess we're pretty sure no 32-bit CPUs do anything with those.

e6500 can run in 32-bit mode, and is 2-way threaded AIUI, so it's
*possible* it could use them.

But I can't find any mention of those special nops in the e6500 core
manual. And actually it does have documentation about thread priority
registers, PPR32, TPRI0/1, but it says they're not used in e6500.

So I guess this seems safe, I'll pick it up.

cheers

> diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include/asm/vdso/processor.h
> index e072577bc7c0..8d79f994b4aa 100644
> --- a/arch/powerpc/include/asm/vdso/processor.h
> +++ b/arch/powerpc/include/asm/vdso/processor.h
> @@ -5,12 +5,21 @@
>  #ifndef __ASSEMBLY__
>  
>  /* Macros for adjusting thread priority (hardware multi-threading) */
> +#ifdef CONFIG_PPC64
>  #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")
>  #define HMT_low()		asm volatile("or 1, 1, 1	# low priority")
>  #define HMT_medium_low()	asm volatile("or 6, 6, 6	# medium low priority")
>  #define HMT_medium()		asm volatile("or 2, 2, 2	# medium priority")
>  #define HMT_medium_high()	asm volatile("or 5, 5, 5	# medium high priority")
>  #define HMT_high()		asm volatile("or 3, 3, 3	# high priority")
> +#else
> +#define HMT_very_low()
> +#define HMT_low()
> +#define HMT_medium_low()
> +#define HMT_medium()
> +#define HMT_medium_high()
> +#define HMT_high()
> +#endif
>  
>  #ifdef CONFIG_PPC64
>  #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
> -- 
> 2.25.0
