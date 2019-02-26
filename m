Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B421CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:45:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B49A2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V+kM/FN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49A2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447npG5mf6zDqTw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 16:45:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="V+kM/FN1"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447nmd73CzzDqDK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 16:43:39 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id b2so5648863pgl.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 21:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D5xyv1fNfDGlGg9siZmH4kTxv/+JHEmjDQOSbD75FlM=;
 b=V+kM/FN1oYtNuAe0bWJL+QhJ0n1PnBRPlKoLdIQ/BpF1aZHXmKHRnloXWMkZgJsw8C
 b5uqn+Ygzn4uddKHes8qiFONB/JRG1EAmkeU37Edsmnm/gKKr0fkrp8ZIBIVP1elo5El
 3+bczcqNwaJyFZeIx0fIMupSKib8KeeG1V7IJWlB3Fi6m36Kdzz9CEmaP3O97t6xj/HM
 ZKAmHquYWWs9JY9Pmp6gb+MTfmBffrxZH8Y0MF/HpR+QbXZlBDi+Z2xyadSLPOTr/d6u
 /EZLWaNc7wxfY3lUUC0qGT+RpSwCi35d+BimLHkbJ+lCsK56nfowsLPMNzdT1drZ7V+k
 rJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D5xyv1fNfDGlGg9siZmH4kTxv/+JHEmjDQOSbD75FlM=;
 b=ILep2TNPI/vDoE/OB9WNJHO1RvvkJkelqjZarI6Cnq3s+jZITHCSLjdbauK10S7woZ
 fCAgNKrkult/KeQQvKFJK9SlH/7UTVGt9J11JfaLbRrEAJVNKpa1IQWh8T6rUDjP1HNs
 aUxdLux8h7fKTD2wo3R8rDtFjb/QpW4Nqhl0DgAhFTnmNkJ1HkHLwmw1jMFXypjyST2N
 GIvMA8+2Z2cvwcxhAriGHzgZxr/RCWhAmo2PPLTvhVAM9uMbCOXMvg8yJTBw8C+waCCU
 4FNmOxeeJWmOn8de3Pnz3INsI91e8NeNXe+drZazNSUBV4b3hWYs5Se6R0tRS2IdrdIC
 4FDQ==
X-Gm-Message-State: AHQUAuY59RYILB6UK6ws7UvnO0RHG8UyfyNC0GRo53qdH71tVAzZxBTC
 /JKs7u4TEcweL3QlN6sMgUYQ+1dalUoB5gvZI/R9Iw==
X-Google-Smtp-Source: AHgI3IblwsDq0v8w8uwDFDXShUnGCXvsmZCLS8U72WJ/yG50fLocYpIaMzDH+pF3bkPLatzQ2GN2GmFAnlAXAVBgLXU=
X-Received: by 2002:a63:5506:: with SMTP id j6mr22882913pgb.202.1551159816396; 
 Mon, 25 Feb 2019 21:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20190226053855.7020-1-natechancellor@gmail.com>
In-Reply-To: <20190226053855.7020-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 25 Feb 2019 21:43:24 -0800
Message-ID: <CAKwvOd=PsmVmxoQVT1fhGx+eMkKRqJV_yUQ56_Fs0R-guTuo2Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/xmon: Fix opcode being uninitialized in
 print_insn_powerpc
To: Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 25, 2019 at 9:39 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> arch/powerpc/xmon/ppc-dis.c:157:7: warning: variable 'opcode' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:167:7: note: uninitialized use occurs here
>   if (opcode == NULL)
>       ^~~~~~
> arch/powerpc/xmon/ppc-dis.c:157:3: note: remove the 'if' if its
> condition is always true
>   if (cpu_has_feature(CPU_FTRS_POWER9))
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/xmon/ppc-dis.c:132:38: note: initialize the variable
> 'opcode' to silence this warning
>   const struct powerpc_opcode *opcode;
>                                      ^
>                                       = NULL
> 1 warning generated.
>
> This warning seems to make no sense on the surface because opcode is set
> to NULL right below this statement. However, there is a comma instead of
> semicolon to end the dialect assignment, meaning that the opcode
> assignment only happens in the if statement. Properly terminate that
> line so that Clang no longer warns.
>
> Fixes: 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation changes)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/390
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

haha! (shows office mates).  Nice find, and fix!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/powerpc/xmon/ppc-dis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
> index 9deea5ee13f6..27f1e6415036 100644
> --- a/arch/powerpc/xmon/ppc-dis.c
> +++ b/arch/powerpc/xmon/ppc-dis.c
> @@ -158,7 +158,7 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
>      dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
>                 | PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
>                 | PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
> -               | PPC_OPCODE_VSX | PPC_OPCODE_VSX3),
> +               | PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
>
>    /* Get the major opcode of the insn.  */
>    opcode = NULL;
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
