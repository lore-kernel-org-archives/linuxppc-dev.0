Return-Path: <SRS0=ux5f=HH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Feb 2021 05:18:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F9664FBF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Feb 2021 05:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F9664FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DX3c94M3QzDwfd
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Feb 2021 16:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=ZQsAvHL5; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DX3ZH55m0zDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2021 16:17:09 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id s23so3708983pgh.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2021 21:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
 bh=m0TlPVX0eA3PDOBMFTFNIlovGbxZA2sBbnmx/ym680s=;
 b=ZQsAvHL5GjaSy6vt3eYR8MdRD7OHrLTRlMvB+YWRszmabSc6Z8voZwsX52QHzm3/No
 10gbgJT8BUHxXzX7KMeJyk6dy38TNyKYWyNjdW+qW8cF7PChxmdb6XFE55QTSMe0jsEO
 gObiyopwc5KOr3XYTwkiQBaF4TNZLRHpqfkTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=m0TlPVX0eA3PDOBMFTFNIlovGbxZA2sBbnmx/ym680s=;
 b=Jz1Ntm1wtIjCNvTbUG5VSVXzVBI44X3HC2vwwgiK9/y6Wi2O+ChxJ+2KQXaA/8d7W8
 niZkJM5R7bIwPcIDB2+hVsTK44yRrxfBh0iPb11k2CYA8TD21qgD24EcCLSSUDyZW3l4
 NVcCHvQvsUcW2o+CjHnPNImhmjVpM4lqc5/6X06kfgoaAkAXKoJyogd3eDIYK7vmKwAE
 ISyMz2LkioVnkkH3sik7SMDUdOfWffpm0g+syJ+GeZUESEtqnTe2AKdu2B4anjUYpv2T
 vndegL4n7iECtzfUTnzGSJ8NsGtQozrlnoRYtcoG/jsHqhV60cKd02pe9V1JRYADGT78
 EDUg==
X-Gm-Message-State: AOAM532O9zmV4k4jyMfPalbDSQF7dm0kX7mVOmFjeORL7ZlzA5HXSDBf
 Vn/uNzANHw7U2f6vVYCaK2nwOfT2GtOqLg==
X-Google-Smtp-Source: ABdhPJzj64RpW9+/wGTZLEuslA58al3I9Bo0r4oZWVbSsXtj+qij0EEjC2NmHhu6gieeI3XHHvuEeg==
X-Received: by 2002:a65:6207:: with SMTP id d7mr2747144pgv.92.1612502225520;
 Thu, 04 Feb 2021 21:17:05 -0800 (PST)
Received: from localhost
 (2001-44b8-111e-5c00-a9fe-013b-f6b0-c0a4.static.ipv6.internode.on.net.
 [2001:44b8:111e:5c00:a9fe:13b:f6b0:c0a4])
 by smtp.gmail.com with ESMTPSA id y3sm2934209pfr.125.2021.02.04.21.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 21:17:04 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: "Christopher M. Riedl" <cmr@codefail.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 02/10] powerpc/signal: Add unsafe_copy_{vsx,
 fpr}_from_user()
In-Reply-To: <20210203184323.20792-3-cmr@codefail.de>
References: <20210203184323.20792-1-cmr@codefail.de>
 <20210203184323.20792-3-cmr@codefail.de>
Date: Fri, 05 Feb 2021 16:17:01 +1100
Message-ID: <87h7mrdrg2.fsf@dja-thinkpad.axtens.net>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christopher,

I have checked that each implementation matches the corresponding
*_to_user implementation. We've had some debate about whether the
overarching implementation in the to/from pairs (especially where things
go via a bounce buffer) can be simplified - but that's probably not
really something that this patch set should do.

On that basis:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

> Reuse the "safe" implementation from signal.c except for calling
> unsafe_copy_from_user() to copy into a local buffer.
>
> Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
> ---
>  arch/powerpc/kernel/signal.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
> index 2559a681536e..7dfc536c78ef 100644
> --- a/arch/powerpc/kernel/signal.h
> +++ b/arch/powerpc/kernel/signal.h
> @@ -53,6 +53,30 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
>  				&buf[i], label);\
>  } while (0)
>  
> +#define unsafe_copy_fpr_from_user(task, from, label)	do {		\
> +	struct task_struct *__t = task;					\
> +	u64 __user *__f = (u64 __user *)from;				\
> +	u64 buf[ELF_NFPREG];						\
> +	int i;								\
> +									\
> +	unsafe_copy_from_user(buf, __f, sizeof(buf), label);		\
> +	for (i = 0; i < ELF_NFPREG - 1; i++)				\
> +		__t->thread.TS_FPR(i) = buf[i];				\
> +	__t->thread.fp_state.fpscr = buf[i];				\
> +} while (0)
> +
> +#define unsafe_copy_vsx_from_user(task, from, label)	do {		\
> +	struct task_struct *__t = task;					\
> +	u64 __user *__f = (u64 __user *)from;				\
> +	u64 buf[ELF_NVSRHALFREG];					\
> +	int i;								\
> +									\
> +	unsafe_copy_from_user(buf, __f, sizeof(buf), label);		\
> +	for (i = 0; i < ELF_NVSRHALFREG ; i++)				\
> +		__t->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];	\
> +} while (0)
> +
> +
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  #define unsafe_copy_ckfpr_to_user(to, task, label)	do {		\
>  	struct task_struct *__t = task;					\
> @@ -80,6 +104,10 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
>  	unsafe_copy_to_user(to, (task)->thread.fp_state.fpr,	\
>  			    ELF_NFPREG * sizeof(double), label)
>  
> +#define unsafe_copy_fpr_from_user(task, from, label)			\
> +	unsafe_copy_from_user((task)->thread.fp_state.fpr, from,	\
> +			    ELF_NFPREG * sizeof(double), label)
> +
>  static inline unsigned long
>  copy_fpr_to_user(void __user *to, struct task_struct *task)
>  {
> @@ -115,6 +143,8 @@ copy_ckfpr_from_user(struct task_struct *task, void __user *from)
>  #else
>  #define unsafe_copy_fpr_to_user(to, task, label) do { } while (0)
>  
> +#define unsafe_copy_fpr_from_user(task, from, label) do { } while (0)
> +
>  static inline unsigned long
>  copy_fpr_to_user(void __user *to, struct task_struct *task)
>  {
> -- 
> 2.26.1
