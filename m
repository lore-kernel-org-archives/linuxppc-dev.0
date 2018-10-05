Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E52C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:13:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5868E2084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EJivZJHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5868E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RYCw3C3czF3TS
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 01:13:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EJivZJHy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=amacapital.net
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=luto@amacapital.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amacapital.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=amacapital-net.20150623.gappssmtp.com
 header.i=@amacapital-net.20150623.gappssmtp.com header.b="EJivZJHy"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RY6S31pszF3Sf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 01:08:12 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id 23-v6so4862585pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=alDE5Hfszt+ScKCD3O8u014AQQo/tXWyhSxaRXEN6Ok=;
 b=EJivZJHyA5UUFgWMSowXL2LfrP1RKeHAoJS+LjY0JkvqHRZHu47bN7GLA+X3Pyh/Pp
 uGqX9EROhLmH6wI8LWSqODJgJMe387TJqgq9vUHti3BSgbhI3nUkpAkecJIVsTtrbDbX
 bynb5vA2ByZWlbUQJSlzFQiH4jz4oyd9n7rFSfjjP8XH7H1IRWg9muqJYanUnQch6Pqg
 cIvci/cf1oUT9FijZ0jU7cCUtAsmB2McZetaQT8tVTMdVwYMf2DWgxuSV3nPKSQuxbT2
 sJ3duHEbE8fefCH/G5ZpIE/eorKz7m51r0SjWSQqPiuNB7DtSfC6y/QJQ4V5l2OYDAbk
 a6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=alDE5Hfszt+ScKCD3O8u014AQQo/tXWyhSxaRXEN6Ok=;
 b=Wtq8tX+q/CFNepGjEHcLHBVlRmdt1SdwR0kCme2eseH41l2hv+XMr8YXgCPjiV5+Il
 3SMmhW6iJ2qes/a1HQFq8biLQwaZu+VF0eKV27R/Iyz5o6OJOzRz5XatSo1AAnx/ZCfA
 eTzewBZngbvWlu8D+fhcVmAo9aXsIpQhK6i10Mh3I/5BM41hDQn+AMCR+vGZxW/F3WUN
 wrTVEVeZIcI6pYPSqqIh0m8+NzjJ/hDTM59W0C8Lqz2oWCVUf5zdD+NgWIfHSls3allv
 sxXa+gtI6FIg9J+eePH/NSWERxeHDY8nwnzKK91yK3WGwh7jt0xfsmrM1rOZQrfvQ5YJ
 So5w==
X-Gm-Message-State: ABuFfog9yX+AmUvYTX08kXMgdgVEloQJmmsMhjvM6HLQ71YjTJiHEvm3
 52uUVjgNM2fEDvEUMl3HAJF0TQ==
X-Google-Smtp-Source: ACcGV61oFol6DB+3pV0XWXDGXdkyjNx6hoBZ/3VrUbUTilciFnn58ROyk4r4Mj9ywTfuiJqpiBqF9w==
X-Received: by 2002:a62:18a:: with SMTP id
 132-v6mr12403308pfb.207.1538752090767; 
 Fri, 05 Oct 2018 08:08:10 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d01e:eb5d:f949:e221?
 ([2601:646:c200:7429:d01e:eb5d:f949:e221])
 by smtp.gmail.com with ESMTPSA id v63-v6sm9761718pgd.69.2018.10.05.08.08.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 08:08:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181005141433.GS19272@hirez.programming.kicks-ass.net>
Date: Fri, 5 Oct 2018 08:08:08 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>> new file mode 100644
>> index 000000000000..8fc3b4c9b38f
>> --- /dev/null
>> +++ b/include/linux/ffp.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __LINUX_FFP_H
>> +#define __LINUX_FFP_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/compiler.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_FFP
>> +#include <asm/ffp.h>
>> +#else
>> +
>> +struct ffp {
>> +    void    (**fn)(void);
>> +    void    (*default_fn)(void);
>> +};
>> +
>> +#define DECLARE_FFP(_fn, _def)                        \
>> +    extern typeof(_def) *_fn;                    \
>> +    extern struct ffp const __ffp_ ## _fn
>> +
>> +#define DEFINE_FFP(_fn, _def)                        \
>> +    typeof(_def) *_fn =3D &_def;                    \
>> +    struct ffp const __ffp_ ## _fn                    \
>> +        =3D { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>> +
>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>> +{
>> +    WRITE_ONCE(*m->fn, new_fn);
>> +}
>> +
>> +static inline void ffp_reset_target(const struct ffp *m)
>> +{
>> +    WRITE_ONCE(*m->fn, m->default_fn);
>> +}
>> +
>> +#endif
>> +
>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>> +
>> +#endif
>=20
> I don't understand this interface. There is no wrapper for the call
> site, so how are we going to patch all call-sites when you update the
> target?

I=E2=80=99m also confused.

Anyway, we have patchable functions on x86. They=E2=80=99re called PVOPs, an=
d they=E2=80=99re way overcomplicated.

I=E2=80=99ve proposed a better way that should generate better code, be more=
 portable, and be more maintainable.  It goes like this.

To call the function, you literally just call  the default implementation.  I=
t *might* be necessary to call a nonexistent wrapper to avoid annoying optim=
izations. At build time, the kernel is built with relocations, so the object=
 files contain relocation entries for the call. We collect these entries int=
o a table. If we=E2=80=99re using the =E2=80=9Cnonexistent wrapper=E2=80=9D a=
pproach, we can link in a .S or linker script to alias them to the default i=
mplementation.

To patch them, we just patch them. It can=E2=80=99t necessarily be done conc=
urrently because nothing forces the right alignment. But we can do it at boo=
t time and module load time. (Maybe we can patch at runtime on architectures=
 with appropriate instruction alignment.  Or we ask gcc for an extension to a=
lign calls to a function.)

Most of the machinery already exists: this is roughly how the module loader r=
esolves calls outside of a module.=
