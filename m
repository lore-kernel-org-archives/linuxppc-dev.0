Return-Path: <SRS0=nRCD=LC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11ADC47082
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 02:27:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7AA61185
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 02:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7AA61185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FzYzT3pLGz3btd
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jun 2021 12:27:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=JjYtuWG8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JjYtuWG8; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FzYyz6SbKz2xtv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jun 2021 12:26:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FzYyw4vchz9sRK;
 Tue,  8 Jun 2021 12:26:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623119209;
 bh=1ZMCtGsRYb+WTlaPJy8Xif1EF1dRkTA6KPQq2Az4Xm0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JjYtuWG8uPyxyAso3igoDZ43oYu5ua+FqU6qrpMCjU0Dt0AZfOoLd7StCE7rNLPEf
 nZUomKPfvnoBsoCX+4wY+vqeQk64ug23pkSXC2EeZltWptR6FcnqltP72Bspg8KmG0
 2jTIKYQ7J1PXlm4CPTFhOWQeFKF0Ls/zIuMCEPUvq5oFEqi3C0iWQLibVZf8B2+Cvs
 v0MKQ27Rcxw3skIfW/vzawV4tJ3bQr0I2UJFyX0+YO+JQrUvHzKoJeuGaGZL+z7cmR
 V6vsUdM2Rr6oJGYuFAOHz2sdme4qesbZuqrI9zs2okMFN7bzs97GDOxKzagwpI2185
 l9QNnExi2iSmw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] powerpc: Fix duplicate included _clear.h
In-Reply-To: <1623061512-31651-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1623061512-31651-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Date: Tue, 08 Jun 2021 12:26:43 +1000
Message-ID: <874ke9f5wc.fsf@mpe.ellerman.id.au>
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:
> Clean up the following includecheck warning:
>
> ./arch/powerpc/perf/req-gen/perf.h: _clear.h is included more than once.

That's by design.

See the error reported by the kbuild robot.

> No functional change.

Not true.

cheers

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/powerpc/perf/req-gen/perf.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/req-gen/perf.h b/arch/powerpc/perf/req-gen/perf.h
> index fa9bc80..59fa588 100644
> --- a/arch/powerpc/perf/req-gen/perf.h
> +++ b/arch/powerpc/perf/req-gen/perf.h
> @@ -51,7 +51,6 @@ enum CAT2(NAME_LOWER, _requests) {
>   *	r_fields
>   * };
>   */
> -#include "_clear.h"
>  #define STRUCT_NAME__(name_lower, r_name) name_lower ## _ ## r_name
>  #define STRUCT_NAME_(name_lower, r_name) STRUCT_NAME__(name_lower, r_name)
>  #define STRUCT_NAME(r_name) STRUCT_NAME_(NAME_LOWER, r_name)
> -- 
> 1.8.3.1
