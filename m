Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66648C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Sep 2021 03:27:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E14610C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Sep 2021 03:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18E14610C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HBGVH3HBCz307L
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Sep 2021 13:27:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=EEb72HSn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=EEb72HSn; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HBGTW4s9mz2yJS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Sep 2021 13:27:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1631935624;
 bh=2bTe2HFevLjQ4dA9TYlB4P8vEbsjdrVvlgNzwhq0U2o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EEb72HSnmYCo67/e0LfInIJ/C4NiLLB7KZU2pH2tGZO4ZKcHuIBxAWl3sNanpAGCA
 QJYJ9fQ32GPB884/xjz+H8mOEI4O1E+JGKGRxV+6HQnyDR+RXy7YxI2qNt6ZylDA46
 b1ii0NIq7q5uVui6xRsHUG1Lj4IzzwEmlIgRJHExN3YO2l5es7UCmGFvzmVLAJ27aH
 JASdHLOJrQlJq3l/K2XlhH13a6Kus+FmsdEs0bzUHydgvt6nBBM3J5SRDSkLyqYGX+
 nltVfESCe0ixpxyvzBJ5wNuMn2XRFmRND/CLsEiuCXoFMQG+WvPqpzmu/CKsa7Th3m
 R9pQj0Xirak8g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HBGTN2KPCz9sW4;
 Sat, 18 Sep 2021 13:27:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
In-Reply-To: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
References: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
Date: Sat, 18 Sep 2021 13:26:57 +1000
Message-ID: <87tuiiimwu.fsf@mpe.ellerman.id.au>
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
> Long time ago we had a config item called STRICT_MM_TYPECHECKS
> to build the kernel with pte_t defined as a structure in order
> to perform additional build checks or build it with pte_t
> defined as a simple type in order to get simpler generated code.
>
> Commit 670eea924198 ("powerpc/mm: Always use STRICT_MM_TYPECHECKS")
> made the struct based definition the only one, considering that the
> generated code was similar in both cases.
>
> That's right on ppc64 because the ABI is such that the content of a
> struct having a single simple type element is passed as register,
> but on ppc32 such a structure is passed via the stack like any
> structure.
>
> Simple test function:
>
> 	pte_t test(pte_t pte)
> 	{
> 		return pte;
> 	}
>
> Before this patch we get
>
> 	c00108ec <test>:
> 	c00108ec:	81 24 00 00 	lwz     r9,0(r4)
> 	c00108f0:	91 23 00 00 	stw     r9,0(r3)
> 	c00108f4:	4e 80 00 20 	blr
>
> So, for PPC32, restore the simple type behaviour we got before
> commit 670eea924198, but instead of adding a config option to
> activate type check, do it when __CHECKER__ is set so that type
> checking is performed by 'sparse' and provides feedback like:
>
> 	arch/powerpc/mm/pgtable.c:466:16: warning: incorrect type in return expression (different base types)
> 	arch/powerpc/mm/pgtable.c:466:16:    expected unsigned long
> 	arch/powerpc/mm/pgtable.c:466:16:    got struct pte_t [usertype] x

OK that's a good trade off.

One question below ...

> diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
> index d11b4c61d686..c60199fc6fa6 100644
> --- a/arch/powerpc/include/asm/pgtable-types.h
> +++ b/arch/powerpc/include/asm/pgtable-types.h
> @@ -5,14 +5,26 @@
>  /* PTE level */
>  #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>  typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
> -#else
> +#elif defined(__CHECKER__) || !defined(CONFIG_PPC32)

It would be nicer if this logic was in Kconfig.

eg. restore config STRICT_MM_TYPECHECKS but make it always enabled for
64-bit, and depend on CHECKER for 32-bit.

The only thing is I'm not sure if we can test __CHECKER__ in Kconfig?

cheers
