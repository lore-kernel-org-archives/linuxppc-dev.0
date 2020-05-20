Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D24AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 02:43:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E771E2075F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 02:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="psNGesol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E771E2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49RcW73KXSzDqYB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 12:43:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RcTS16yNzDqTn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 12:41:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=psNGesol; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49RcTR2TT8z9sTM;
 Wed, 20 May 2020 12:41:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1589942507;
 bh=/tvNqMPuWhi87zX+Hg6r60qzUXfi7yM5x349FQ/1+CA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=psNGesol9AaBxOc3HoXwmCix83pYLtlXOY7vv9dwoW+7mbc0Hr1hQfj+fM+5+ZBAK
 ymtAq38MxkEWe72ZPXDe53MCCELHiUWmdFnh9l4Is/72QadtGFfEsqm5BmQH5EjVW+
 /9EOyejjR4FDbT7jeIlckv/SGSnqG4HNFwTS3IS5yCJeUSXqsJmTpvkeh29uT57gum
 SyDwmCqu3jPt7EaKgNHC/AS2GYVS5wi3Jro5kqbduP8Gx2vzvW1krzm5ktR1nmFyNq
 8SyLEMoAIrU9CUmVnuI0AwNjtRzRWJgshoz2pigRQRw06ily4C+OZF7RVVQ7GCvSCK
 hpX7yUF0fVmxw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/7] powerpc: Add new HWCAP bits
In-Reply-To: <20200519003157.31946-2-alistair@popple.id.au>
References: <20200519003157.31946-1-alistair@popple.id.au>
 <20200519003157.31946-2-alistair@popple.id.au>
Date: Wed, 20 May 2020 12:42:09 +1000
Message-ID: <871rnf49a6.fsf@mpe.ellerman.id.au>
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
Cc: aneesh.kumar@linux.ibm.com, mikey@neuling.org, npiggin@gmail.com,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alistair Popple <alistair@popple.id.au> writes:
> POWER10 introduces two new architectural features - ISAv3.1 and matrix
> multiply accumulate (MMA) instructions. Userspace detects the presence
> of these features via two HWCAP bits introduced in this patch. These
> bits have been agreed to by the compiler and binutils team.

Do we have an explanation of why we're exposing MMA separately.

I believe it's because ISA v3.1 says that MMA is optional, in the table
on page ix?

cheers

> diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
> index 540592034740..2692a56bf20b 100644
> --- a/arch/powerpc/include/uapi/asm/cputable.h
> +++ b/arch/powerpc/include/uapi/asm/cputable.h
> @@ -50,6 +50,8 @@
>  #define PPC_FEATURE2_DARN		0x00200000 /* darn random number insn */
>  #define PPC_FEATURE2_SCV		0x00100000 /* scv syscall */
>  #define PPC_FEATURE2_HTM_NO_SUSPEND	0x00080000 /* TM w/out suspended state */
> +#define PPC_FEATURE2_ARCH_3_1		0x00040000 /* ISA 3.1 */
> +#define PPC_FEATURE2_MMA		0x00020000 /* Matrix Multiply Accumulate */
>  
>  /*
>   * IMPORTANT!
> -- 
> 2.20.1
