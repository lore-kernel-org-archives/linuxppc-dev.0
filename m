Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9AC433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:41:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FEC2087D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mxAs7mDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FEC2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bsc620KYTzDqNT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 22:41:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsbV95lkFzDqMx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 22:13:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mxAs7mDv; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BsbV903Vgz9sPB;
 Thu, 17 Sep 2020 22:13:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1600344833;
 bh=QWo3xwLQS+VBRllq+upIybe85CQnXyLuqiZ4DVpiiK8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mxAs7mDv7Ar4iX8zhJPE/FIxuM1ZUOdJ4AHUqD1D38oLQxLbLC1+IYevbBkC++j8F
 66R2Q4H3aKIsilMY2GO5XV7kPerOQprP4yBwOJQrncb+O0KhOYLMLC08w6TDU+y05Q
 vvsX8NUKM7vHwqTzWFjsXO0vUHNFOlgXB6njvanh297OcVvbogUKAnLD8ftHq20NOj
 znm3qjAMhU+vgxE0Ot4HVG03d9reEHafRUcDyOo9Bm66RK2KYsWcMPVKqF3Z6QXio0
 Hndgam7ZhNo+EGqYWTyMfa6OQNUGcJHN2mo5TU2DlJaXrB8pIyq5V7o2GdZYijd6pH
 hGpeVHaX82H8A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Exclude pmc5/6 from the irrelevant PMU
 group constraints
In-Reply-To: <1600257900-2043-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1600257900-2043-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Date: Thu, 17 Sep 2020 22:13:51 +1000
Message-ID: <87wo0sob28.fsf@mpe.ellerman.id.au>
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
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
> PMU counter support functions enforces event constraints for group of
> events to check if all events in a group can be monitored. Incase of
> event codes using PMC5 and PMC6 ( 500fa and 600f4 respectively ),
> not all constraints are applicable, say the threshold or sample bits.
> But current code includes pmc5 and pmc6 in some group constraints (like
> IC_DC Qualifier bits) which is actually not applicable and hence results
> in those events not getting counted when scheduled along with group of
> other events. Patch fixes this by excluding PMC5/6 from constraints
> which are not relevant for it.
>
> Fixes: 7ffd948 ('powerpc/perf: factor out power8 pmu functions')
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/isa207-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
> index 964437a..186fad8 100644
> --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -288,6 +288,9 @@ int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
>  
>  		mask  |= CNST_PMC_MASK(pmc);
>  		value |= CNST_PMC_VAL(pmc);
> +
> +		if (pmc >= 5)
> +			goto ebb_bhrb;

This is fairly subtle. Can you please put a block comment above the if
explaining in a few lines what's going on.

cheers
