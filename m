Return-Path: <SRS0=+tx8=JA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0082C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Apr 2021 02:28:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BAB7611C0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Apr 2021 02:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAB7611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FC17V0T9vz3c0F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Apr 2021 13:28:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Z2sUMI6E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Z2sUMI6E; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FC1736p0fz2xZC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Apr 2021 13:28:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FC16y504tz9sSC;
 Sat,  3 Apr 2021 13:28:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1617416890;
 bh=0h9Rkk3pH8W3/mESmW/wTOFUsfeyLufvNbYm/QFLvgA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Z2sUMI6E2b9/GIGqjYHJTE9eseIMOq5EoL75l07QPAf5DqpdH7lYF64fwseXtK3mR
 efwcgFKVjklBsR/MRM2rhMGyNvU0tQIb2e42Deg25VSGOnwh9QPDeoi2uj6AweiTIV
 eCzbyIgMVQ190cMa29hRhDXJMr46qj+v5IsG4Ra3yCIejbuRgfHWGyOlPhKzjcYSk7
 MZCsGV/6FBsfpJu8OqBzJZlt09KZAwIz/hNyErKFLe2lUowq0FjCqUv8xFDQzm1C9w
 4Q0aoQVT8C9IXN03lcDq0v5+l08TmYVwKfU1g8voIxg8cepMsMaT46gAuouHwYiLq1
 uBXjIZP2Cfy2Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/14] powerpc/64s: avoid reloading (H)SRR registers if
 they are still valid
In-Reply-To: <20210315220402.260594-5-npiggin@gmail.com>
References: <20210315220402.260594-1-npiggin@gmail.com>
 <20210315220402.260594-5-npiggin@gmail.com>
Date: Sat, 03 Apr 2021 13:28:07 +1100
Message-ID: <874kgo14qw.fsf@mpe.ellerman.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index ccf913cedd29..b466b3e1bb3f 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -64,6 +64,30 @@ exception_marker:
>  	.section	".text"
>  	.align 7
>  
> +.macro DEBUG_SRR_VALID srr
> +#ifdef CONFIG_PPC_RFI_SRR_DEBUG
> +	.ifc \srr,srr
> +	mfspr	r11,SPRN_SRR0
> +	ld	r12,_NIP(r1)
> +100:	tdne	r11,r12
> +	EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,(BUGFLAG_WARNING | BUGFLAG_ONCE)

This always points at *this* line, not the caller. Works better with the
patch below.

cheers


diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b466b3e1bb3f..ada76b1279f9 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -64,26 +64,26 @@
 	.section	".text"
 	.align 7
 
-.macro DEBUG_SRR_VALID srr
+.macro DEBUG_SRR_VALID srr line
 #ifdef CONFIG_PPC_RFI_SRR_DEBUG
 	.ifc \srr,srr
 	mfspr	r11,SPRN_SRR0
 	ld	r12,_NIP(r1)
 100:	tdne	r11,r12
-	EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,(BUGFLAG_WARNING | BUGFLAG_ONCE)
+	EMIT_BUG_ENTRY 100b,__FILE__,\line,(BUGFLAG_WARNING | BUGFLAG_ONCE)
 	mfspr	r11,SPRN_SRR1
 	ld	r12,_MSR(r1)
 100:	tdne	r11,r12
-	EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,(BUGFLAG_WARNING | BUGFLAG_ONCE)
+	EMIT_BUG_ENTRY 100b,__FILE__,\line,(BUGFLAG_WARNING | BUGFLAG_ONCE)
 	.else
 	mfspr	r11,SPRN_HSRR0
 	ld	r12,_NIP(r1)
 100:	tdne	r11,r12
-	EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,(BUGFLAG_WARNING | BUGFLAG_ONCE)
+	EMIT_BUG_ENTRY 100b,__FILE__,\line,(BUGFLAG_WARNING | BUGFLAG_ONCE)
 	mfspr	r11,SPRN_HSRR1
 	ld	r12,_MSR(r1)
 100:	tdne	r11,r12
-	EMIT_BUG_ENTRY 100b,__FILE__,__LINE__,(BUGFLAG_WARNING | BUGFLAG_ONCE)
+	EMIT_BUG_ENTRY 100b,__FILE__,\line,(BUGFLAG_WARNING | BUGFLAG_ONCE)
 	.endif
 #endif
 .endm
@@ -358,7 +358,7 @@ END_BTB_FLUSH_SECTION
 	mtspr	SPRN_SRR0,r4
 	mtspr	SPRN_SRR1,r5
 1:
-	DEBUG_SRR_VALID srr
+	DEBUG_SRR_VALID srr __LINE__
 
 BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1			/* to clear the reservation */
@@ -753,7 +753,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	stb	r4,PACAHSRR_VALID(r13)
 #endif
 	.endif
-	DEBUG_SRR_VALID \srr
+	DEBUG_SRR_VALID \srr __LINE__
 
 BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1		/* to clear the reservation */
@@ -825,7 +825,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	stb	r4,PACAHSRR_VALID(r13)
 #endif
 	.endif
-	DEBUG_SRR_VALID \srr
+	DEBUG_SRR_VALID \srr __LINE__
 
 BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1		/* to clear the reservation */
