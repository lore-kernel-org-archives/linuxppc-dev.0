Return-Path: <SRS0=IsZE=EK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5BDC4741F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 12:22:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B90A208C7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 12:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdFcNNsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B90A208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CR5PP2ghfzDqB4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 23:22:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=zhuyifei1999@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ZdFcNNsE; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CR4fx6SnMzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2020 22:48:41 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id k7so887298plk.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2020 03:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7IzbM9m4aaHXdrXJm05MLSazuYENXBo0KE7aGRSwMEM=;
 b=ZdFcNNsEPd+MrYWXHoLvBaTyKHUZhwFwZu3J/PQqzp5Y/s91VRqgtwgRqnPdnsJFzV
 u8ndi/4ac74yeUDpbQr7HXPlEJnbasb7cO8o7gJ5QfnXfnqvT0IrHsEaICKEwxEa70A2
 YXFhqPLDhnbJkNUfiRkcSqJ8rcr7T7iBd7vGmo4WjMykCP58kLBQOzps+/fitCtmG7lx
 rqQXdb82DTVqzyozftIz+18xHfX9wm2lvzWUKmKLYyJ3imRpyuFKCfkdabT8dbUsAWYG
 nv0yauU0g8FHPsO317oAA4Yrr0jRGmrdqn85extqA7+6MeHG+mc31wlEfpFhQQxxW9Z6
 hBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7IzbM9m4aaHXdrXJm05MLSazuYENXBo0KE7aGRSwMEM=;
 b=plhJxu4EY9yDmxDz4cWGrgnM1Cu2rtWwxmfQiX/aMD4E4W57fjGU7jKOphYHokrVJG
 fjOUm+Dgnrh56AUB4UPF/sGVoe9mKJHraIfH91DHzM3GRezop0K5lk07BjtrE+eeACbt
 QEoDQp/aKPxNu0Lpk4aR/mJ3G2f/05oTRCvQ2dDAZRGa8UAPJUStiWSUXjM6C2yQnNCZ
 N2H3syMM/mmSW3g8fbPobgMkN6nA85qZpwUyxAln1JOTtIQDR260PwkSh2QNgPV9jY3g
 ITTgyXi63FaY9VK/YoAanIxdl8/JqehOQqlZsEbc81uKh5eYSBtUWtiJMgTZFDfHZUKy
 ebNg==
X-Gm-Message-State: AOAM533OwofpgJRfFOAHh7jkYpWS4vLTo7jn/YRnOETt3Wu42ViDeSxx
 dW0orIWbFsrfbbsEjbEcBQXSNe6w/YeMbcTZTUU=
X-Google-Smtp-Source: ABdhPJwhKGHgOtsgYmsX8K8geLNyRT+0OoRlLf1+UEBmK6aJHTGU8p2K0A8JMelevcl7yJOdhQWuD2QnmsGaSXA3des=
X-Received: by 2002:a17:902:d30c:b029:d6:8208:bb1 with SMTP id
 b12-20020a170902d30cb02900d682080bb1mr29348288plc.44.1604490514732; Wed, 04
 Nov 2020 03:48:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu>
 <87wnz1to9n.fsf@mpe.ellerman.id.au>
In-Reply-To: <87wnz1to9n.fsf@mpe.ellerman.id.au>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Wed, 4 Nov 2020 05:48:21 -0600
Message-ID: <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
Subject: Re: [PATCH seccomp 3/8] powerpc: Enable seccomp architecture tracking
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 04 Nov 2020 23:09:28 +1100
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
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>,
 Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>,
 linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>,
 linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>,
 linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Josep Torrellas <torrella@illinois.edu>,
 Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org,
 Linux Containers <containers@lists.linux-foundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
 David Laight <David.Laight@aculab.com>,
 Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Tycho Andersen <tycho@tycho.pizza>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 4, 2020 at 4:22 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > +#ifdef __LITTLE_ENDIAN__
>
> As Kees mentioned this should (must?!) match the configured endian.
>
> But I think it would still be better to use the CONFIG symbol, which is
> CONFIG_CPU_LITTLE_ENDIAN.

My attempt here is to be consistent with asm/syscall.h
syscall_get_arch [1]. Would it make sense to change that to
CONFIG_CPU_LITTLE_ENDIAN then?

[1] https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/syscall.h#L116

> > +# define SECCOMP_ARCH_NATIVE         (AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
>
> You use __SECCOMP_ARCH_LE there, but previously you only defined
> __SECCOMP_ARCH_LE_BIT.
>
> Is there some magic somewhere that defines __SECCOMP_ARCH_LE based on
> __SECCOMP_ARCH_LE_BIT ?

Oops, my bad here.

> > +# define SECCOMP_ARCH_NATIVE_NR              NR_syscalls
> > +# define SECCOMP_ARCH_NATIVE_NAME    "ppc64"
>
> What's the name used for?

This is used in the last patch in this series to report in procfs the
name of each architecture tracked by the bitmap cache.

> Usually we use "ppc64" for 64-bit big endian and "ppc64le" for 64-bit
> little endian.
>
> And usually we use "ppc" for 32-bit.

Ok.

YiFei Zhu
