Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6093CC433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 02:14:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BD4208C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 02:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="OP/Amg57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BD4208C2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467Y6z32JVzDqgG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 12:14:19 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467Y345Hk5zDqMm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 12:10:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="OP/Amg57"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 467Y344Lhfz9sN1; Wed, 14 Aug 2019 12:10:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1565748656; bh=rn8nn7nDZW6prBqqprg63BKRnGn4fJeOHCTFgi95aSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OP/Amg578H5HPYz9pLx7vbI154SYRemAbBtahq9i6PsUxSZWDR3+BR8fULNDSeFeT
 lN69qph71OpRbZxQZhsadgnswfMK1QV/clTsnapeSNkeUkRKYQQ4LSjNDbU274LrOF
 ldpdZIDuYSInULN7X+isqlJzTNXPYG8oM18g4tKWYb550qlvqPF/fjB72hsn+NMeQi
 Z1dFASQTsVXoC4N10wAtLxS7KKB63r/mmlAf7tKGmYoHNTY0brp4LWnWEo0MEHCNbG
 n8UVQ8NF2Q774Dm7CJYeh/k3SanuVkQHtyipth09R4+PBmEqmmUDNamcoL/9srZHMD
 03bI8d2GqLCEQ==
Date: Wed, 14 Aug 2019 12:08:03 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 1/2] powerpc: rewrite LOAD_REG_IMMEDIATE() as an
 intelligent macro
Message-ID: <20190814020803.it7i7mjxyruu4vy3@oak.ozlabs.ibm.com>
References: <61d2a0b6f0c89b1ee546851ce9b6bd345e5ec968.1565690241.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61d2a0b6f0c89b1ee546851ce9b6bd345e5ec968.1565690241.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
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

On Tue, Aug 13, 2019 at 09:59:35AM +0000, Christophe Leroy wrote:

[snip]

> +.macro __LOAD_REG_IMMEDIATE r, x
> +	.if \x & ~0xffffffff != 0
> +		__LOAD_REG_IMMEDIATE_32 \r, (\x) >> 32
> +		rldicr	\r, \r, 32, 31
> +		.if (\x) & 0xffff0000 != 0
> +			oris \r, \r, (\x)@__AS_ATHIGH
> +		.endif
> +		.if (\x) & 0xffff != 0
> +			oris \r, \r, (\x)@l
> +		.endif
> +	.else
> +		__LOAD_REG_IMMEDIATE_32 \r, \x
> +	.endif
> +.endm

Doesn't this force all negative constants, even small ones, to use
the long sequence?  For example, __LOAD_REG_IMMEDIATE r3, -1 will
generate (as far as I can see):

	li	r3, -1
	rldicr	r3, r3, 32, 31
	oris	r3, r3, 0xffff
	ori	r3, r3, 0xffff

which seems suboptimal.

Paul.
