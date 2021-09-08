Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B5C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 05:18:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AC960F43
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 05:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01AC960F43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H49Py54Dcz2ymy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Sep 2021 15:17:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Xjl17dz0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Xjl17dz0; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H49PH3rS8z2xvG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Sep 2021 15:17:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1631078236;
 bh=KcC2lb3PGi0RwsLmBTlN9VvtZWNUnC9jZmSIHmkB7kQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Xjl17dz0ilkr86mL8VsYq+Mjx8sdHD7/GpSoSyxpqtHXzFJXgjGsXRYScjA0b+/qz
 LVeFS+bTimjXP4dy8FcutRuSZETV3fFkkW/TAT9UrDcadwOSX5ody5RJz0gsq0g4Fk
 CTq8LMQ7IFOPK3zei7PCw0hZOLwSt5PDLEXpHElVPfhRVDcbVvDPs4pRCbqzydLFyk
 uk9KxVOp+b+mx4kcN2Oah47+i9KwVXSsFHAI7bwIpEAyqkMVgwC0BUJlMsYL6Tl5nY
 kb96lWyWxbRdixkXQ/X0IlSDEuyfNhC2zihSOGbzaIPMU+WMa3VRC/L3h9xFKuYDxC
 vNvgP020HduEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4H49P862J6z9t0Y;
 Wed,  8 Sep 2021 15:17:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org
Subject: Re: [PATCH 1/2] powerpc/perf: Expose instruction and data address
 registers as part of extended regs
In-Reply-To: <1624200360-1429-2-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1624200360-1429-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1624200360-1429-2-git-send-email-atrajeev@linux.vnet.ibm.com>
Date: Wed, 08 Sep 2021 15:17:15 +1000
Message-ID: <87pmtjmysk.fsf@mpe.ellerman.id.au>
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
Cc: kjain@linux.ibm.com, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 rnsastry@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
> Patch adds support to include Sampled Instruction Address Register
> (SIAR) and Sampled Data Address Register (SDAR) SPRs as part of extended
> registers. Update the definition of PERF_REG_PMU_MASK_300/31 and
> PERF_REG_EXTENDED_MAX to include these SPR's.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/perf_regs.h | 12 +++++++-----
>  arch/powerpc/perf/perf_regs.c             |  4 ++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
...
> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
> index b931eed..51d31b6 100644
> --- a/arch/powerpc/perf/perf_regs.c
> +++ b/arch/powerpc/perf/perf_regs.c
> @@ -90,7 +90,11 @@ static u64 get_ext_regs_value(int idx)
>  		return mfspr(SPRN_SIER2);
>  	case PERF_REG_POWERPC_SIER3:
>  		return mfspr(SPRN_SIER3);
> +	case PERF_REG_POWERPC_SDAR:
> +		return mfspr(SPRN_SDAR);
>  #endif
> +	case PERF_REG_POWERPC_SIAR:
> +		return mfspr(SPRN_SIAR);
>  	default: return 0;
>  	}

This file is built for all powerpc configs that have PERF_EVENTS. Which
includes CPUs that don't have SDAR or SIAR.

Don't we need checks in perf_reg_value() like we do for SIER?

I guess we already got this wrong when we added the Power10 registers,
SIER2/3 etc.

cheers
