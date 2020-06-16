Return-Path: <SRS0=a/z+=75=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F5C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 23:38:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6F6207E8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 23:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NBWNC05r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6F6207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ml4R42FVzDqt0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2020 09:37:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ml2m5t5yzDqcv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2020 09:36:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=NBWNC05r; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49ml2l68BHz9sRW;
 Wed, 17 Jun 2020 09:36:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1592350591;
 bh=2ZCS7Dh608RJEO9Lgix0JgZdLLkBM4xFxCu3aQdMlA0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NBWNC05rGhSwtxcjMW8kWMIJADUBn/taS3hLv5a6fehC/QJOg4lapoM0dvIsCjtv8
 IDDsNi2aTp+K89fGUH7TVZ5s4r6yTUpks+D504Rhya2fZqSckqeTk1nbHOJOTdSSAO
 8+hL9q8ClZuowo8Kdo3FRIq5VyLBlgY9GoUzdNRxyW91kp8CJHuoBo84DwLvRmRdyJ
 4mSCFlv8lTZatv2P78ddtaVdqilAQTG5xmak1W2vQpj8XLKz3xZHKoKzYndw37HNc/
 sOsPCuReHTsh3HRAifG/NrxIv9XZLafL3SBFGvVzTv6k50VeAPAOVm2Z660f6x0gfv
 9wWQxoP9IVX8Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Return correct error if TCE
 level allocation failed
In-Reply-To: <20200616104231.27805-1-aik@ozlabs.ru>
References: <20200616104231.27805-1-aik@ozlabs.ru>
Date: Wed, 17 Jun 2020 09:37:01 +1000
Message-ID: <87lfkmeg6a.fsf@mpe.ellerman.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> The iommu_table_ops::xchg_no_kill() callback updates TCE. It is quite
> possible that not entire table is allocated if it is huge and multilevel
> so xchg may also allocate subtables. If failed, it returns H_HARDWARE
> for failed allocation and H_TOO_HARD if it needs it but cannot do because
> the alloc parameter is "false" (set when called with MMU=off to force
> retry with MMU=on).
>
> The problem is that having separate errors only matters in real mode
> (MMU=off) but the only caller with alloc="false" does not check the exact
> error code and simply returns H_TOO_HARD; and for every other mode
> alloc is "true". Also, the function is also called from the ioctl()
> handler of the VFIO SPAPR TCE IOMMU subdriver which does not expect
> hypervisor error codes (H_xxx) and will expose them to the userspace.
>
> This converts wrong error codes to a simple -1.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> I could make it "return alloc ? -ENOMEM : -EBUSY" but
> is EBUSY a good match for H_TOO_HARD?

I think -EAGAIN would be the best match.

But it would be simpler if it just returned -ENOMEM always. In both
cases the problem is that the function needs to allocate memory but
couldn't.

If a caller passes alloc=false, it knows that, so if it sees ENOMEM it
can retry with alloc=true.

cheers
