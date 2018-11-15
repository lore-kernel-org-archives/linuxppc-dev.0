Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3272AC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:48:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9352086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 02:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="n2Fp4/bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9352086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wQlr4GfWzF3Xl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 13:48:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=neuling.org header.i=@neuling.org header.b="n2Fp4/bj";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wQhM1Dc5zF3Zm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 13:45:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="n2Fp4/bj"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42wQhL2gbSz9s5c;
 Thu, 15 Nov 2018 13:45:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1542249922;
 bh=DmfFXKkZyBaLqkQHYiUFwV8ZSxZV6Ge8uTPX5i/QNdM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=n2Fp4/bjT2Usny4xeF5+iiDl0MMRKLYEhrRYlXx7lbKdFPaMMEwB7l4rzAIJqnvmg
 rsgqgJfXiADJHpQyJCEDgfB6hHy28EXsggBJ89jx5R7Vypp1dUyC0iGZ9d52uBTHhB
 7m2bIJjq03nU1UoP6Ut34yN7IOz5RKXuaznqdRkfCA8m4Tm8cZd0rZwOnKDrqSuHoH
 Ym8hcHL26p+mYKoqTnD6+0IYyMbhqtLOdJ1cbp3uBYY9FYBnXc+xBhfTFNNycIrEFV
 R/Y8TmGl/qEiwcpJX71itIH54366wH5Ceo1B1jmLpyGsln8SKp3oKPqFh27vtQxpPb
 3GEnba/Gg41DQ==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 532782A164C; Thu, 15 Nov 2018 13:45:22 +1100 (AEDT)
Message-ID: <4147cbf0c8edf0888ca99397f61640eeece57be2.camel@neuling.org>
Subject: Re: [RFC PATCH 08/14] powerpc/tm: Recheckpoint at exit path
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org, 
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 15 Nov 2018 13:45:22 +1100
In-Reply-To: <1541508028-31865-9-git-send-email-leitao@debian.org>
References: <1541508028-31865-1-git-send-email-leitao@debian.org>
 <1541508028-31865-9-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Cc: ldufour@linux.vnet.ibm.com, cyrilbur@gmail.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-11-06 at 10:40 -0200, Breno Leitao wrote:
> In the past, TIF_RESTORE_TM was being handled with the rest of the TIF
> workers,
> but, that was too early, and can cause some IRQ to be replayed in suspend=
ed
> state (after recheckpoint).
>=20
> This patch moves TIF_RESTORE_TM handler to as late as possible, it also
> forces the IRQ to be disabled, and it will continue to be until RFID, so,
> no IRQ will be replayed at all. I.e, if trecheckpoint happens, it will RF=
ID
> to userspace.
>=20
> This makes TIF_RESTORE_TM a special case that should not be handled
> similarly to the _TIF_USER_WORK_MASK.
>=20
> Since _TIF_RESTORE_TM is not part of _TIF_USER_WORK_MASK anymore, we
> need to force system_call_exit to continue to leaves through
> fast_exception_return, so, we add the flags together with
> _TIF_USER_WORK_MASK at system_call_exist path.
>=20
> If this flag is set at system_call_exit, it means that recheckpoint
> will be called, and doing it through fast_exception_return is the only
> way to do so.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/include/asm/thread_info.h |  2 +-
>  arch/powerpc/kernel/entry_64.S         | 23 ++++++++++++++---------
>  2 files changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/thread_info.h
> b/arch/powerpc/include/asm/thread_info.h
> index 544cac0474cb..2835d60bc9ef 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -139,7 +139,7 @@ void arch_setup_new_exec(void);
> =20
>  #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>  				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> -				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
> +				 _TIF_PATCH_PENDING | \
>  				 _TIF_FSCHECK)
>  #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
> =20
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 17484ebda66c..a86619edf29d 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -255,7 +255,7 @@ system_call_exit:
> =20
>  	ld	r9,TI_FLAGS(r12)
>  	li	r11,-MAX_ERRNO
> -	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MAS
> K|_TIF_PERSYSCALL_MASK)
> +	andi.   r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK=
|
> _TIF_PERSYSCALL_MASK |_TIF_RESTORE_TM)
>  	bne-	.Lsyscall_exit_work
> =20
>  	andi.	r0,r8,MSR_FP
> @@ -784,14 +784,6 @@ _GLOBAL(ret_from_except_lite)
>  	SCHEDULE_USER
>  	b	ret_from_except_lite
>  2:
> -#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	andi.	r0,r4,_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM
> -	bne	3f		/* only restore TM if nothing else to do */
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	bl	restore_tm_state
> -	b	restore
> -3:
> -#endif
>  	bl	save_nvgprs
>  	/*
>  	 * Use a non volatile GPR to save and restore our thread_info flags
> @@ -938,6 +930,19 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRES=
S)
>  	 */
>  	.globl	fast_exception_return
>  fast_exception_return:
> +
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	CURRENT_THREAD_INFO(r4, r1)
> +	ld	r4,TI_FLAGS(r4)
> +	andi.   r0,r4,_TIF_RESTORE_TM
> +	beq	22f
> +	ld	r4,_MSR(r1) 	/* TODO: MSR[!PR] shouldn't be here */
> +	andi.	r0,r4,MSR_PR
> +	beq	22f  /* Skip if Kernel thread */
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	restore_tm_state

Calling out to C here is a bit concerning this late.

The main thing you are calling out to is asm anyway (with a small C wrapper=
).=20
We might want to adapt the asm this case, rather than the old model of gett=
ing
it called from __switch_to(). We shouldn't need to call
tm_reclaim/tm_recheckpoint from C anymore (especially if we use BUG_ON() ra=
ther
than WARN_ON() in the cases already mentioned.).

Same for patch 1.

> +22:
> +#endif
>  	ld	r3,_MSR(r1)
>  	ld	r4,_CTR(r1)
>  	ld	r0,_LINK(r1)
