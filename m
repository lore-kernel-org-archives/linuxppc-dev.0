Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B2CC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 05:21:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9598521773
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 05:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGjf+Msj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9598521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43NSJV1lXlzDqV1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 16:21:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VGjf+Msj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="VGjf+Msj"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43NSFf0ncLzDqTK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 16:19:00 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id z7so14658108iti.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Dec 2018 21:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vTO+iFapKycw8LXxhWPSoaeNUpIXXF2j8h+GKpEFVlg=;
 b=VGjf+MsjIrlu9wL3ms3pflyDPI3wnRSqluS6yyZqFQRSUffaITrQlZZ+SKBzt+g316
 bIJYV05HA8UlBCMOqwYRJliEchNFFO2RKqW0syyXxMB4BKppBmfeyvTxG2oSKhewLkPk
 EvPy16xTFaX5M9kEQVFhIjZjeJeIeNVMA4Vgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vTO+iFapKycw8LXxhWPSoaeNUpIXXF2j8h+GKpEFVlg=;
 b=pTFlZSCBtXYhzfJBbdHllqapc0eWk6ZmWlYElKoRJyuDLASJKB0iw5y74F5GpAK/P7
 doHPcVTM6IXFHPVlIFleJtIMY4HrcjUA39B4nYbcIc2X85cg3VfMhQWAm1rIlfQpwcyA
 iQ+/a6sTFlg4W1W6JT9Y0IiVv9FXvkjU9huZGJ/HmYpaeSx/ZvDIBKLUIvdMKuwYBHEX
 C0pv0U9Te4jdLEJoNrFJGOulJAzOCFHFURu+hgl50XiMyMIdLAMIAFjXbJkrd+/wRApE
 OkT/SZ7py4eSE9sX4pQqb0J8tL5TjdAwJz801Zv2jWu8ozwN/IeoGeKdtBYLeiHl0Hj6
 U2gg==
X-Gm-Message-State: AJcUukeLoPzn+rde/pOK5nZm30dFZg/IE7TWPITDU2qSx0HprGzusRCZ
 JOdBIyQUG+nNRQqZdaWS4wdjTpAzit6pf3I/iFwm6g==
X-Google-Smtp-Source: ALg8bN586OyuKHkbmBRvB6xE1DNKrqznhgCVKWUsq1RgiPm+4ui0Eh6vPjjD+4xzILcNF86/30216aS06Ge1YXqHZ/k=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr7290173iti.166.1545628738904; 
 Sun, 23 Dec 2018 21:18:58 -0800 (PST)
MIME-Version: 1.0
References: <1545043236-11649-2-git-send-email-firoz.khan@linaro.org>
 <43N38M4cw7z9sNJ@ozlabs.org>
In-Reply-To: <43N38M4cw7z9sNJ@ozlabs.org>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 24 Dec 2018 10:48:50 +0530
Message-ID: <CALxhOnhfPbMBXcTP1eT3OTv7ZTQ4OKHOEJxq9coPX6Si39umqQ@mail.gmail.com>
Subject: Re: [v6,1/5] powerpc: add __NR_syscalls along with NR_syscalls
To: Michael Ellerman <patch-notifications@ellerman.id.au>
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
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 y2038 Mailman List <y2038@lists.linaro.org>, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Ram Pai <linuxram@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Breno Leitao <leitao@debian.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 23 Dec 2018 at 18:58, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
>
> On Mon, 2018-12-17 at 10:40:32 UTC, Firoz Khan wrote:
> > NR_syscalls macro holds the number of system call exist
> > in powerpc architecture. We have to change the value of
> > NR_syscalls, if we add or delete a system call.
> >
> > One of the patch in this patch series has a script which
> > will generate a uapi header based on syscall.tbl file.
> > The syscall.tbl file contains the number of system call
> > information. So we have two option to update NR_syscalls
> > value.
> >
> > 1. Update NR_syscalls in asm/unistd.h manually by count-
> >    ing the no.of system calls. No need to update NR_sys-
> >    calls until we either add a new system call or delete
> >    existing system call.
> >
> > 2. We can keep this feature in above mentioned script,
> >    that will count the number of syscalls and keep it in
> >    a generated file. In this case we don't need to expli-
> >    citly update NR_syscalls in asm/unistd.h file.
> >
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with NR_syscalls asm/unistd.h. The macro __NR_syscalls
> > also added for making the name convention same across all
> > architecture. While __NR_syscalls isn't strictly part of
> > the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Series applied to powerpc next, thanks.

Thanks Micheal!

Firoz

>
> https://git.kernel.org/powerpc/c/8a19eeeab66dfdd7c67bc8e3048ac0
>
> cheers
