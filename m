Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1E8C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:14:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3764520851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3764520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zDRf6mXFzF37J
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 03:14:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.195; helo=mail-qk1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zDPZ0gXYzF39Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 03:12:17 +1100 (AEDT)
Received: by mail-qk1-f195.google.com with SMTP id d135so49412628qkc.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 08:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v/CljHlhtduQLF35Irouy1QmlECeaT79XOoHMWeQgcA=;
 b=BCieHZChCRPS6Erz8/dbU1z3RJwzcPkdqFXsHhqlKykPsrTeKNAY9ibGhJ4iQuY08L
 mMedCJ5oYGi4pbTURQwDAmzNMB3QWRZ1U5nAh4gBJO33yOZkvU2mUji910ueUsly6eT7
 cPmUyoXJHphDZ0z2xhTPDb/O17AW3oRLlZbJw3u0r2BNHK8gRav/uzlJDEpwR0imx1Ez
 P2WfqmoE6Ym98j3Aiz97TC65CMZ7bGdhNBJFtxQ8f/CDGOAs8G5L7Niqqm2v7NgZvIOM
 KlRAE91bZMa7VPOjCF1Il7S+8UC2z4OsOOZ1t0zQvpBH71kpz1nr9AHDJ5uJiVHelP5L
 uQ4A==
X-Gm-Message-State: AGRZ1gIKjP9QqlSJGOOTWhmkrUlelMaSiq45SBvO6Q7AI5XhdHQUxPFZ
 heMqdz34C7IlsYeHT36pOFSNRWP+sZCIsON5+uY=
X-Google-Smtp-Source: AJdET5dPIGsiE6RUf3i4cx4BCE5CZGvyj34krT9bAqeMDTqC1zdXy6tixqW2CNM/QRGHQTM99Pv5+MW2YDUPY+gahUQ=
X-Received: by 2002:a37:a3c6:: with SMTP id
 m189mr21184819qke.173.1542643934914; 
 Mon, 19 Nov 2018 08:12:14 -0800 (PST)
MIME-Version: 1.0
References: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
 <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542189798-27713-3-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Nov 2018 17:11:58 +0100
Message-ID: <CAK8P3a2AsQKPpFRKpNiEo2TVjfanuTSUjhO1wxgvLYyiqeaMNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc: move macro definition from asm/systbl.h
To: Firoz Khan <firoz.khan@linaro.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 linux-arch <linux-arch@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, linuxram@us.ibm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, leitao@debian.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 14, 2018 at 11:04 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> index 01b5171..c4321b9 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -76,7 +76,6 @@
>  SYSCALL_SPU(ssetmask)
>  SYSCALL_SPU(setreuid)
>  SYSCALL_SPU(setregid)
> -#define compat_sys_sigsuspend sys_sigsuspend
>  SYS32ONLY(sigsuspend)

I think the macro here is just a workaround for the fact that SYS32ONLY()
always prepends the name with 'compat_' for the compat version, and there
is no other macro to do this. After the conversion, this can easily be
done using the regular table, as you need separate names for the
32-bit entries anyway.

>  SYSX(sys_ni_syscall,compat_sys_s
> diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
> index 8ae8620..7517a43 100644
> --- a/arch/powerpc/platforms/cell/spu_callbacks.c
> +++ b/arch/powerpc/platforms/cell/spu_callbacks.c
> @@ -47,6 +47,7 @@
>  #define COMPAT_SPU_NEW(func)   sys_##func,
>  #define SYSX_SPU(f, f3264, f32)        f,
>
> +#define compat_sys_sigsuspend  sys_sigsuspend
>  #include <asm/systbl.h>
>  };

The spu_callbacks.c and systbl_chk.c files don't need this macro,
but that doesn't matter once you drop this patch.

      Arnd
