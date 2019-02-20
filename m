Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F276C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 00:52:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7522147A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 00:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7522147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443zbB2LN0zDqJ8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:52:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443zY22lDNzDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 11:50:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 443zY14Z5Nz9s3l;
 Wed, 20 Feb 2019 11:50:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH 2/6] powerpc sstep: Add darn instruction emulation
In-Reply-To: <40fccd3f879a447d32d0fa26e773674a19cb5a87.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <40fccd3f879a447d32d0fa26e773674a19cb5a87.1535609090.git.sandipan@linux.ibm.com>
Date: Wed, 20 Feb 2019 11:50:28 +1100
Message-ID: <874l8z8eqz.fsf@concordia.ellerman.id.au>
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
Cc: paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sandipan Das <sandipan@linux.ibm.com> writes:

> This adds emulation support for the following integer instructions:
>   * Deliver A Random Number (darn)

This doesn't build with old binutils. We need to support old binutils.

    {standard input}:4343: Error: Unrecognized opcode: `darn'


You need to use PPC_DARN().

cheers

> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index b40ec18515bd..18ac0a26c4fc 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1728,6 +1728,25 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>  				(int) regs->gpr[rb];
>  			goto arith_done;
>  
> +		case 755:	/* darn */
> +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +				return -1;
> +			switch (ra & 0x3) {
> +			case 0:
> +				asm("darn %0,0" : "=r" (op->val));
> +				goto compute_done;
> +
> +			case 1:
> +				asm("darn %0,1" : "=r" (op->val));
> +				goto compute_done;
> +
> +			case 2:
> +				asm("darn %0,2" : "=r" (op->val));
> +				goto compute_done;
> +			}
> +
> +			return -1;
> +
>  
>  /*
>   * Logical instructions
> -- 
> 2.14.4
