Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE5EC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 00:53:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD12C2147A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 00:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD12C2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443zcy1dDgzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:53:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443zZc4dYlzDqKr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 11:51:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 443zZc3731z9sDL;
 Wed, 20 Feb 2019 11:51:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH 1/6] powerpc sstep: Add maddhd, maddhdu,
 maddld instruction emulation
In-Reply-To: <2962112510464de01b24f9e1014909fde3380d52.1535609090.git.sandipan@linux.ibm.com>
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <2962112510464de01b24f9e1014909fde3380d52.1535609090.git.sandipan@linux.ibm.com>
Date: Wed, 20 Feb 2019 11:51:52 +1100
Message-ID: <871s438eon.fsf@concordia.ellerman.id.au>
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
>   * Multiply-Add High Doubleword (maddhd)
>   * Multiply-Add High Doubleword Unsigned (maddhdu)
>   * Multiply-Add Low Doubleword (maddld)

This doesn't build with old binutils.

    {standard input}:2089: Error: Unrecognized opcode: `maddld'
    {standard input}:2104: Error: Unrecognized opcode: `maddhdu'
    {standard input}:1141: Error: Unrecognized opcode: `maddhd'


You'll need to add hand built versions, see ppc-opcode.h for examples.

cheers

> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index d81568f783e5..b40ec18515bd 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
>  int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>  		  unsigned int instr)
>  {
> -	unsigned int opcode, ra, rb, rd, spr, u;
> +	unsigned int opcode, ra, rb, rc, rd, spr, u;
>  	unsigned long int imm;
>  	unsigned long int val, val2;
>  	unsigned int mb, me, sh;
> @@ -1292,6 +1292,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>  	rd = (instr >> 21) & 0x1f;
>  	ra = (instr >> 16) & 0x1f;
>  	rb = (instr >> 11) & 0x1f;
> +	rc = (instr >> 6) & 0x1f;
>  
>  	switch (opcode) {
>  #ifdef __powerpc64__
> @@ -1305,6 +1306,38 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>  			goto trap;
>  		return 1;
>  
> +#ifdef __powerpc64__
> +	case 4:
> +		if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +			return -1;
> +
> +		switch (instr & 0x3f) {
> +		case 48:	/* maddhd */
> +			asm("maddhd %0,%1,%2,%3" : "=r" (op->val) :
> +			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
> +			    "r" (regs->gpr[rc]));
> +			goto compute_done;
> +
> +		case 49:	/* maddhdu */
> +			asm("maddhdu %0,%1,%2,%3" : "=r" (op->val) :
> +			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
> +			    "r" (regs->gpr[rc]));
> +			goto compute_done;
> +
> +		case 51:	/* maddld */
> +			asm("maddld %0,%1,%2,%3" : "=r" (op->val) :
> +			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
> +			    "r" (regs->gpr[rc]));
> +			goto compute_done;
> +		}
> +
> +		/*
> +		 * There are other instructions from ISA 3.0 with the same
> +		 * primary opcode which do not have emulation support yet.
> +		 */
> +		return -1;
> +#endif
> +
>  	case 7:		/* mulli */
>  		op->val = regs->gpr[ra] * (short) instr;
>  		goto compute_done;
> -- 
> 2.14.4
