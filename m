Return-Path: <SRS0=Qe0n=G2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ABCC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Jan 2021 00:34:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698FD23B5D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Jan 2021 00:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698FD23B5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMxwQ40xgzDsP0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Jan 2021 11:34:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMxtl3RkDzDrdn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2021 11:33:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=KbESrxoc; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DMxtk3TQ1z9sCD;
 Sat, 23 Jan 2021 11:33:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1611361998;
 bh=YAxlk8k11nNwNUlzDfMSZoqeEjgPN09p3XD8ocRp4V8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KbESrxocBZ+gf05ijhnQWE+090FCyIHReRggZgAcuu4FJhWJs3yrrNXvT4qCS6amR
 Oze2iKs8XoDyzUUAAakiea7TS2ByatCUDQWmGhhHf49hWciL5H1Kj4FlRqhFAciFJJ
 ITgIWooCTVlFPKBpKxMYl6TbP1l9n+gYDaV8Bia1u8BOXn5ZBeslzRzIbOvvA+m0T1
 Fw3wj1XuXLGKyE4mt3xJKsCNk4HEhgKP24uAhRAC3F2V+cwoN57j5zcgaPb8m9H2l4
 TpF+ViwyguEtB5Nf/bX8xID2SMsJGbbNX7k5Ib9uLSnSGRoLfShtZSDZAPv0kKvE47
 r3nSqe0qihA7A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] lib/sstep: Fix incorrect return from analyze_instr()
In-Reply-To: <161124771457.333703.14641179082577500423.stgit@thinktux.local>
References: <161124771457.333703.14641179082577500423.stgit@thinktux.local>
Date: Sat, 23 Jan 2021 11:33:15 +1100
Message-ID: <87zh10pk50.fsf@mpe.ellerman.id.au>
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
Cc: naveen.n.rao@linux.ibm.com, ravi.bangoria@linux.ibm.com, paulus@samba.org,
 sandipan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ananth N Mavinakayanahalli <ananth@linux.ibm.com> writes:
> We currently just percolate the return value from analyze_instr()
> to the caller of emulate_step(), especially if it is a -1.
>
> For one particular case (opcode = 4) for instructions that
> aren't currently emulated, we are returning 'should not be
> single-stepped' while we should have returned 0 which says
> 'did not emulate, may have to single-step'.
>
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
> Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/sstep.c |   49 +++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 5a425a4a1d88..a3a0373843cd 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1445,34 +1445,39 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>  
>  #ifdef __powerpc64__
>  	case 4:
> -		if (!cpu_has_feature(CPU_FTR_ARCH_300))
> -			return -1;
> -
> -		switch (word & 0x3f) {
> -		case 48:	/* maddhd */
> -			asm volatile(PPC_MADDHD(%0, %1, %2, %3) :
> -				     "=r" (op->val) : "r" (regs->gpr[ra]),
> -				     "r" (regs->gpr[rb]), "r" (regs->gpr[rc]));
> -			goto compute_done;
> +		/*
> +		 * There are very many instructions with this primary opcode
> +		 * introduced in the ISA as early as v2.03. However, the ones
> +		 * we currently emulate were all introduced with ISA 3.0
> +		 */
> +		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +			switch (word & 0x3f) {
> +			case 48:	/* maddhd */
> +				asm volatile(PPC_MADDHD(%0, %1, %2, %3) :
> +					     "=r" (op->val) : "r" (regs->gpr[ra]),
> +					     "r" (regs->gpr[rb]), "r" (regs->gpr[rc]));
> +				goto compute_done;

Indenting everything makes this patch harder to read, and I think makes
the resulting code harder to read too. We already have two levels of
switch here, and we're inside a ~1700 line function, so keeping things
simple is important I think.

Doesn't this achieve the same result?

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index bf7a7d62ae8b..d631baaf1da2 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1443,8 +1443,10 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 
 #ifdef __powerpc64__
 	case 4:
-		if (!cpu_has_feature(CPU_FTR_ARCH_300))
-			return -1;
+		if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
+			op->type = UNKNOWN;
+			return 0;
+		}
 
 		switch (word & 0x3f) {
 		case 48:	/* maddhd */
@@ -1470,7 +1472,8 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		 * There are other instructions from ISA 3.0 with the same
 		 * primary opcode which do not have emulation support yet.
 		 */
-		return -1;
+		op->type = UNKNOWN;
+		return 0;
 #endif
 
 	case 7:		/* mulli */


cheers

