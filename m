Return-Path: <SRS0=ZeYp=6T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E289C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 01:48:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E455A206C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 01:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E455A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49GN0f1Wc5zDqb5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2020 11:48:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49GMz22DFBzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2020 11:46:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49GMz15d17z9sSs;
 Tue,  5 May 2020 11:46:53 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v7 16/28] powerpc: Define and use __get_user_instr{,
 inatomic}()
Date: Tue, 05 May 2020 11:46:53 +1000
Message-ID: <5846057.brnAmokCST@townsend>
In-Reply-To: <20200501034220.8982-17-jniethe5@gmail.com>
References: <20200501034220.8982-1-jniethe5@gmail.com>
 <20200501034220.8982-17-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: npiggin@gmail.com, bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Doesn't change any behaviour from what I can see.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Friday, 1 May 2020 1:42:08 PM AEST Jordan Niethe wrote:
> Define specific __get_user_instr() and __get_user_instr_inatomic()
> macros for reading instructions from user space.
> 
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/include/asm/uaccess.h  | 5 +++++
>  arch/powerpc/kernel/align.c         | 2 +-
>  arch/powerpc/kernel/hw_breakpoint.c | 2 +-
>  arch/powerpc/kernel/vecemu.c        | 2 +-
>  4 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h
> b/arch/powerpc/include/asm/uaccess.h index 2f500debae21..c0a35e4586a5
> 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -105,6 +105,11 @@ static inline int __access_ok(unsigned long addr,
> unsigned long size, #define __put_user_inatomic(x, ptr) \
>  	__put_user_nosleep((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
> 
> +#define __get_user_instr(x, ptr) \
> +	__get_user_nocheck((x).val, (u32 *)(ptr), sizeof(u32), true)
> +
> +#define __get_user_instr_inatomic(x, ptr) \
> +	__get_user_nosleep((x).val, (u32 *)(ptr), sizeof(u32))
>  extern long __put_user_bad(void);
> 
>  /*
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index 9e66e6c62354..b8f56052c6fe 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -304,7 +304,7 @@ int fix_alignment(struct pt_regs *regs)
>  	 */
>  	CHECK_FULL_REGS(regs);
> 
> -	if (unlikely(__get_user(instr.val, (unsigned int __user *)regs->nip)))
> +	if (unlikely(__get_user_instr(instr, (void __user *)regs->nip)))
>  		return -EFAULT;
>  	if ((regs->msr & MSR_LE) != (MSR_KERNEL & MSR_LE)) {
>  		/* We don't handle PPC little-endian any more... */
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c
> b/arch/powerpc/kernel/hw_breakpoint.c index 2db9a7ac7bcb..423603c92c0f
> 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -249,7 +249,7 @@ static bool stepping_handler(struct pt_regs *regs,
> struct perf_event *bp, struct instruction_op op;
>  	unsigned long addr = info->address;
> 
> -	if (__get_user_inatomic(instr.val, (unsigned int *)regs->nip))
> +	if (__get_user_instr_inatomic(instr, (void __user *)regs->nip))
>  		goto fail;
> 
>  	ret = analyse_instr(&op, regs, instr);
> diff --git a/arch/powerpc/kernel/vecemu.c b/arch/powerpc/kernel/vecemu.c
> index bb262707fb5c..adcdba6d534e 100644
> --- a/arch/powerpc/kernel/vecemu.c
> +++ b/arch/powerpc/kernel/vecemu.c
> @@ -266,7 +266,7 @@ int emulate_altivec(struct pt_regs *regs)
>  	unsigned int va, vb, vc, vd;
>  	vector128 *vrs;
> 
> -	if (get_user(instr.val, (unsigned int __user *) regs->nip))
> +	if (__get_user_instr(instr, (void __user *) regs->nip))
>  		return -EFAULT;
> 
>  	word = ppc_inst_val(instr);




