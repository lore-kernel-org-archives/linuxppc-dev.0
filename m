Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C3C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 05:43:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8108E217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 05:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8RP/xCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8108E217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443V5d2vMKzDqJK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 16:43:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="k8RP/xCU"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443V3c5k2ZzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 16:41:48 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id r124so9555776pgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 21:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=+EU00narZM+oAtb9nqVNjy8vCYE2Vcg6Zve0xM2lu1U=;
 b=k8RP/xCUxV5xtkryv/jf100lW4O5XaRbWAMk287JpR5LmMSL1lZAChVuWUoJxPOD3L
 hVov2BLsWjOMpP6nm4uVflQ+ATADIyGsuNwlawetV47BcEQ6zfD5kCgmH2hIQq04hYpZ
 tJkMCDsjVcHEXR9EKVOC+GJvBbJM/UNQmZQGnTMM5HX7F+TPT/bB4naLtaS4abrs7RCN
 ZFL+bzXRxyH3MBl62uTO9zC9fr2Co2LZQQYgM9FWtTWIuz+26nt4iBMsxPw2SXv6Wmkl
 Cojtg8EKS5le5bt280Xkwd7XVAB+GkykE9UrnBhMw31oI+5k6rLUd7HaEOu90FEj3Pws
 Vgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=+EU00narZM+oAtb9nqVNjy8vCYE2Vcg6Zve0xM2lu1U=;
 b=EEf2/+yilIx39QhhStkqmTJ1K/0OrsofR4Ap91ijlU20RLV5RtRryKArCA+ukRAzYa
 I+CbwRdn+QAiU1+Qm4+UHgZZcaTXlsdxEZVkhelQfFcKB7g9qwrTDZ4nDJ4QZFvuiL/b
 igk4rmCOIZYglryMxpKSHD/NQWU2W8CvLx9g+dB6v5/hAgqaAeBiNNZpf4kIlhpKVYxu
 b6y8de4j9ueXGiBrwDEZm/NrBV5/965Pwbwt4wdFKgpPAzwAi807iiybbNooi2j/wcSX
 /GmoMzcDJrKWa3E+IP+xqU78KXWvHSvS99axd77sVo41wxzk7cAUO4gYAf/h0dYJ8OxL
 7ixg==
X-Gm-Message-State: AHQUAuZ6gUZXhevaOcfc6IpWPBo/7ys9m8FpbGTiHK8h1vJOHe3BYCkQ
 Mpb3DiY+k+zLXbYY4B0fOS8=
X-Google-Smtp-Source: AHgI3IYKIZExQR5r3/aPnC9yZU1oFOJPqaz46Q01uOmBSGih1YxF52Jq80uYH8490YaGWWQstq/MpQ==
X-Received: by 2002:a63:698a:: with SMTP id
 e132mr22420032pgc.136.1550554906838; 
 Mon, 18 Feb 2019 21:41:46 -0800 (PST)
Received: from localhost ([61.69.157.156])
 by smtp.gmail.com with ESMTPSA id v15sm14400741pfa.75.2019.02.18.21.41.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 21:41:46 -0800 (PST)
Date: Tue, 19 Feb 2019 15:41:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v1] powerpc/accounting: do not account system time on
 transition to user.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <a952f14712b90f182c0fcace434b2a0e9f21ed9f.1549636481.git.christophe.leroy@c-s.fr>
In-Reply-To: <a952f14712b90f182c0fcace434b2a0e9f21ed9f.1549636481.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550554276.8eb89h3g4q.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Christophe Leroy's on February 9, 2019 12:40 am:
> Time spent in kernel mode don't need to be accounted on transition
> to user space. As far as the time spent in user is known, it
> is possible to calculate the time spent in kernel by substracting
> the time spent in user.
>=20
> To do so, this patch modifies vtime_delta() to substract the
> time spent in user since the last call to vtime_delta().
>=20
> This patch gives a 2% improvment of null_syscall() selftest on a 83xx.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This looks like a clever little optimization, although I don't know
this time accounting code very well.

> ---
> But surprisingly, this patch degrades the null_syscall selftest by 20% on=
 the 8xx. Any idea of the reason ?

I don't know microarchitecture of any of those CPUs I'm afraid.
On the 64s CPUs, mftb is what hurts.

>=20
>  arch/powerpc/include/asm/accounting.h | 1 +
>  arch/powerpc/include/asm/ppc_asm.h    | 8 +-------
>  arch/powerpc/kernel/asm-offsets.c     | 8 ++------
>  arch/powerpc/kernel/time.c            | 4 +++-
>  4 files changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/accounting.h b/arch/powerpc/include=
/asm/accounting.h
> index c607c5d835cc..2f1ff5f9fd7a 100644
> --- a/arch/powerpc/include/asm/accounting.h
> +++ b/arch/powerpc/include/asm/accounting.h
> @@ -27,6 +27,7 @@ struct cpu_accounting_data {
>  	/* Internal counters */
>  	unsigned long starttime;	/* TB value snapshot */
>  	unsigned long starttime_user;	/* TB value on exit to usermode */
> +	unsigned long utime_asm;
>  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
>  	unsigned long startspurr;	/* SPURR value snapshot */
>  	unsigned long utime_sspurr;	/* ->user_time when ->startspurr set */
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/as=
m/ppc_asm.h
> index e0637730a8e7..be17d570d484 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -28,9 +28,8 @@
>  #define ACCOUNT_STOLEN_TIME
>  #else
>  #define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)				\
> -	MFTB(ra);			/* get timebase */		\
>  	PPC_LL	rb, ACCOUNT_STARTTIME_USER(ptr);			\
> -	PPC_STL	ra, ACCOUNT_STARTTIME(ptr);				\
> +	MFTB(ra);			/* get timebase */		\
>  	subf	rb,rb,ra;		/* subtract start value */	\
>  	PPC_LL	ra, ACCOUNT_USER_TIME(ptr);				\
>  	add	ra,ra,rb;		/* add on to user time */	\
> @@ -38,12 +37,7 @@
> =20
>  #define ACCOUNT_CPU_USER_EXIT(ptr, ra, rb)				\
>  	MFTB(ra);			/* get timebase */		\
> -	PPC_LL	rb, ACCOUNT_STARTTIME(ptr);				\
>  	PPC_STL	ra, ACCOUNT_STARTTIME_USER(ptr);			\
> -	subf	rb,rb,ra;		/* subtract start value */	\
> -	PPC_LL	ra, ACCOUNT_SYSTEM_TIME(ptr);				\
> -	add	ra,ra,rb;		/* add on to system time */	\
> -	PPC_STL	ra, ACCOUNT_SYSTEM_TIME(ptr)
> =20
>  #ifdef CONFIG_PPC_SPLPAR
>  #define ACCOUNT_STOLEN_TIME						\
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 7a1b93c5af63..f2ba7735f56f 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -260,19 +260,15 @@ int main(void)
>  	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
>  	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
>  	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
> -	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
>  	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
> -	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
> -	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.stime);
> +	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime_asm);
>  	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
>  	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
>  	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
>  #else /* CONFIG_PPC64 */
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> -	OFFSET(ACCOUNT_STARTTIME, thread_info, accounting.starttime);
>  	OFFSET(ACCOUNT_STARTTIME_USER, thread_info, accounting.starttime_user);
> -	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.utime);
> -	OFFSET(ACCOUNT_SYSTEM_TIME, thread_info, accounting.stime);
> +	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.utime_asm);
>  #endif
>  #endif /* CONFIG_PPC64 */
> =20
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index bc0503ef9c9c..79420643b45f 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -331,8 +331,10 @@ static unsigned long vtime_delta(struct task_struct =
*tsk,
>  	WARN_ON_ONCE(!irqs_disabled());
> =20
>  	now =3D mftb();
> -	stime =3D now - acct->starttime;
> +	stime =3D now - acct->starttime - acct->utime_asm;
>  	acct->starttime =3D now;
> +	acct->utime +=3D acct->utime_asm;
> +	acct->utime_asm =3D 0;
> =20
>  	*stime_scaled =3D vtime_delta_scaled(acct, now, stime);
> =20
> --=20
> 2.13.3
>=20
>=20
=
