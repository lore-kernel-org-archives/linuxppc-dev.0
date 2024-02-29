Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F12C48BF6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Feb 2024 17:16:01 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RERCmQBi;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlyYC59kgz3vfD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2024 04:15:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RERCmQBi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlyXL0TT5z3vc8
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2024 04:15:13 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a3122b70439so213119266b.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Feb 2024 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709226910; x=1709831710; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1Zw5VQp0F6Dx4Oge15y8ses9uRS5Ow56YjY/TYeF0w=;
        b=RERCmQBia5IeL3zk882MN3A4js6ekNiNZZSsasC8/RuS/QMY9/QA59EIfjqc+y9BPL
         rfngYgAZ2LDkady5JEn2eSx2CVeNvAvYe5762Q0+DE40Y58qXpzl30/AKiVjcZHn5gyg
         dUtleTdlZa4jYOSxm8JSqDJz1gKUIu3qA+HcU+T1OgKIYglIV/MU5oc8KWnIdh1aSBgF
         Dq73pXk8adIAQd7Bz5OeOmad72xMOyB+Lnf8ZbAJNARkrlg23K63L5vi4H9/SBwIwsFe
         YpDBE+wqNsrWf+DDNXxfJqDkk2etRnKOEQr/9dKK7p2q/HHiUvTO4A90rdF4SVgYoCfO
         UTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226910; x=1709831710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1Zw5VQp0F6Dx4Oge15y8ses9uRS5Ow56YjY/TYeF0w=;
        b=YqHfvekWTOuUIU/2ECw5tcqabZhcGWKLhN2MNZdxD5JROOUJ36GWDfv9+CL6ake1Vr
         npWVWElUGJyc/36sk2l7WT6BC9Jyy15JcRhvq3JSO2koeSeeyA2Vp0HKdoG4DEuUt3an
         1KRNplTQl4xiTlS422ONVYEuwotsaijf78mmqE5zG6HffP5CMPKOxXjbzVgKm1ATfzTP
         uQ7Rc1m+vZqv/qpIOHrS9vYg4gIJwzU0BORZD5XH2XxFL1IrMMCEcIvT/Lyoe06gQrmW
         ThIfbyhtlIGWwRbZ41kSr8tUsfX8OvMyJ/2eJ+33R4U1nJXPYOaz7n8tH3YjAKOKxctW
         HVnw==
X-Gm-Message-State: AOJu0YznZTX7hnSR0eu3axVH+/rHfJXqN4rUN0dI5VF9P54XMn+rfku+
	JkI72xnK3jHMq0m2RIfn4sjAF97hS94lYmpo7ZbHeca+FanTuhXD7G57k81sl4f3GwsNEAX4fOl
	Acr4cvvzlDFnVVCwunBV9JZc62KM=
X-Google-Smtp-Source: AGHT+IHQS8BwSw9lEJ6rm/Chxn2/ElOL/HSgC3eW4gh3iutYz8oEZt4qX35nDw5NEmCOvaIIPFe2P9qHDAKzdSk4GlQ=
X-Received: by 2002:a17:906:2653:b0:a44:1180:9c18 with SMTP id
 i19-20020a170906265300b00a4411809c18mr1939553ejc.55.1709226909753; Thu, 29
 Feb 2024 09:15:09 -0800 (PST)
MIME-Version: 1.0
References: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
In-Reply-To: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 Feb 2024 19:14:33 +0200
Message-ID: <CAHp75VekfCq8c9h1k57LRjs2GZQ+ep9SdFbEWbDd98z_ySQ+Lw@mail.gmail.com>
Subject: Re: [kselftests/powerpc] Primitives test build failure with linux-next
To: Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: tanzhasanwork@gmail.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kselftest@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 29, 2024 at 3:53=E2=80=AFPM Sachin Sant <sachinp@linux.ibm.com>=
 wrote:
>
> Powerpc specific selftests (specifically powerpc/primitives) included in =
linux-next
> tree fails to build with following error
>
> gcc -std=3Dgnu99 -O2 -Wall -Werror -DGIT_VERSION=3D'"next-20240229-0-gf30=
3a3e2bcfb-dirty"' -I/home/sachin/linux-next/tools/testing/selftests/powerpc=
/include  -I/home/sachin/linux-next/tools/testing/selftests/powerpc/primiti=
ves    load_unaligned_zeropad.c ../harness.c  -o /home/sachin/linux-next/to=
ols/testing/selftests/powerpc/primitives/load_unaligned_zeropad
> In file included from load_unaligned_zeropad.c:26:
> word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or direc=
tory
>     7 | #include <linux/bitops.h>
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
>
> The header file in question was last changed by following commit
>
> commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
>     kernel.h: removed REPEAT_BYTE from kernel.h

Thanks for the report.
What is missing here are the steps to reproduce it here. E.g., I have
an x86_64 machine, I can use QEMU if required.

--=20
With Best Regards,
Andy Shevchenko
