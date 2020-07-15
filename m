Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727DC433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 13:13:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E75720657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 13:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="g5uR6QyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E75720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6HrN3qYZzDqn5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 23:13:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6Hnb4kQ8zDqkK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 23:10:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=g5uR6QyV; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B6HnZ1zyFz9sTN;
 Wed, 15 Jul 2020 23:10:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594818658;
 bh=Xl0iqpDYvnC3VoaPLAWfGt5RziLUL9LXdKIAOH+0uMA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=g5uR6QyVGZ4Lga7D3FkIk1boLhgdTzGCiw7hmVdFVn/WF64NBLExjn8GRhVSgRAki
 RpJfaCL9OxQiRWiThAzdjtYRuTTk4I71tIH9v35WCNsRAPGctt0XLHmHClS14tAim8
 qTYu1JRIvARRenyZySnsAlvL0P6jdipvFDhDs4wzVW40nCT0UCpSnMhv7SDuYc6XUX
 8k/KklGvOZgV+vmq0NWNhgI/axlgnWuplNaWDbqUlStcIWJCsAreBhlxwdPZkh5JWI
 VqDBlzNAU3WlqMtGWxastdVyBC4/G/kLhv9S2KEUNE1jLPkl+X5peo8QxQp18qUC11
 /znaMFkRIe2UQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Haren Myneni <haren@linux.ibm.com>
Subject: Re: [PATCH V2 1/2] powerpc/vas: Report proper error code for address
 translation failure
In-Reply-To: <019fd53e7538c6f8f332d175df74b1815ef5aa8c.camel@linux.ibm.com>
References: <019fd53e7538c6f8f332d175df74b1815ef5aa8c.camel@linux.ibm.com>
Date: Wed, 15 Jul 2020 23:10:53 +1000
Message-ID: <87zh80udnm.fsf@mpe.ellerman.id.au>
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
Cc: tulioqm@br.ibm.com, abali@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 rzinsly@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Haren Myneni <haren@linux.ibm.com> writes:
> P9 DD2 NX workbook (Table 4-36) says DMA controller uses CC=5
> internally for translation fault handling. NX reserves CC=250 for
> OS to notify user space when NX encounters address translation
> failure on the request buffer. Not an issue in earlier releases
> as NX does not get faults on kernel addresses.
>
> This patch defines CSB_CC_FAULT_ADDRESS(250) and updates CSB.CC with
> this proper error code for user space.

I added:

Fixes: c96c4436aba4 ("powerpc/vas: Update CSB and notify process for fault CRBs")

> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
>
> Changes in V2:
> - Use CSB_CC_FAULT_ADDRESS instead of CSB_CC_ADDRESS_TRANSLATION
>   to distinguish from other error codes.
> - Add NX workbook reference in the comment.

The change log goes after the --- line.

> ---
>  Documentation/powerpc/vas-api.rst          | 2 +-
>  arch/powerpc/include/asm/icswx.h           | 4 ++++
>  arch/powerpc/platforms/powernv/vas-fault.c | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/powerpc/vas-api.rst b/Documentation/powerpc/vas-api.rst
> index 1217c2f..788dc83 100644
> --- a/Documentation/powerpc/vas-api.rst
> +++ b/Documentation/powerpc/vas-api.rst
> @@ -213,7 +213,7 @@ request buffers are not in memory. The operating system handles the fault by
>  updating CSB with the following data:
>  
>  	csb.flags = CSB_V;
> -	csb.cc = CSB_CC_TRANSLATION;
> +	csb.cc = CSB_CC_FAULT_ADDRESS;
>  	csb.ce = CSB_CE_TERMINATION;
>  	csb.address = fault_address;
>  
> diff --git a/arch/powerpc/include/asm/icswx.h b/arch/powerpc/include/asm/icswx.h
> index 965b1f3..9bc7c58 100644
> --- a/arch/powerpc/include/asm/icswx.h
> +++ b/arch/powerpc/include/asm/icswx.h
> @@ -77,6 +77,10 @@ struct coprocessor_completion_block {
>  #define CSB_CC_CHAIN		(37)
>  #define CSB_CC_SEQUENCE		(38)
>  #define CSB_CC_HW		(39)
> +/*
> + * P9 DD NX Workbook 3.2 (Table 4-36): Address translation fault

I changed that to "P9 DD2 NX" which I assume is what you meant, it
matches the change log.

> + */
> +#define	CSB_CC_FAULT_ADDRESS	(250)
>  
>  #define CSB_SIZE		(0x10)
>  #define CSB_ALIGN		CSB_SIZE
> diff --git a/arch/powerpc/platforms/powernv/vas-fault.c b/arch/powerpc/platforms/powernv/vas-fault.c
> index 266a6ca..3d21fce 100644
> --- a/arch/powerpc/platforms/powernv/vas-fault.c
> +++ b/arch/powerpc/platforms/powernv/vas-fault.c
> @@ -79,7 +79,7 @@ static void update_csb(struct vas_window *window,
>  	csb_addr = (void __user *)be64_to_cpu(crb->csb_addr);
>  
>  	memset(&csb, 0, sizeof(csb));
> -	csb.cc = CSB_CC_TRANSLATION;
> +	csb.cc = CSB_CC_FAULT_ADDRESS;
>  	csb.ce = CSB_CE_TERMINATION;
>  	csb.cs = 0;
>  	csb.count = 0;
> -- 
> 1.8.3.1


cheers
