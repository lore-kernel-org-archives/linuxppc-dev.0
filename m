Return-Path: <SRS0=bXCp=74=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A34C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 15:36:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9834206D7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 15:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MammdyoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9834206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49lwRq5G0QzDqXN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 01:36:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d41;
 helo=mail-io1-xd41.google.com; envelope-from=brgerst@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=MammdyoU; dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49lwNX5xtSzDqQM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 01:34:04 +1000 (AEST)
Received: by mail-io1-xd41.google.com with SMTP id r77so18337483ior.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2020 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HwRsf1wA8NUSGSOKG/QxGcXlEzglL7CjJxi7J6vRu78=;
 b=MammdyoUIwR0+8BMgOGo8Ubv1yDldOm8IhUp/SS/QLenCF/Ac02/4NFoTzA7MpVeOG
 PywyXf2yodud/GMNwOmMun5Z75iDu2ePtvDN0RNYETMBZGlmVSsaYThp1uqO+hnjAaUu
 k1nKEDoM10jrt4ec36o/fgZIpnxf94zjtdoyldYfJqLIGNTK8nsWW/EGQwqzjh/cqbs0
 kkUJdOKz99T3BY7UJDY4ovGrm93fkjR7sC9BXi8sE6/iXyyLXx/lWtDDd8KNSO3OcIHn
 K8uin7wx8uMtjoKgq5/bZWyjEprNfaEw1Vvu9Miic4S3OLY3oB5/SfKJwzviYr1NUq8c
 DDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HwRsf1wA8NUSGSOKG/QxGcXlEzglL7CjJxi7J6vRu78=;
 b=rUcnKIPsLQyOrqWQgKY7gNauVF/YWUpcisUKtdAVUSI82c3gi1FJaDW9z6gagO2KfZ
 9Q7LvPZQAzqaLm1zQZSKhrz4vXL14CblcTD5rmH7OT9R0c6RIP/TfuB1gEVxEfdR4ncu
 1VM6C6rMhNpilQ1mb6c2U6Mc3PNdWnavu8Zczx9YlWlO0qWfuWfh22LYCjDOYbCO91Aa
 pUbbUsKzx6j4ztWTeJPGXMNtvl6DoXgT9melo5HRJK31bKXETGP5j14Zw/X1L7YheVTB
 KPuxIEbHWFD0fcxa7dbtGZYKbcRJba2Ksx1OAepreVtT+kHpNALSq6DyeGVbXl5GnBaf
 X7jA==
X-Gm-Message-State: AOAM530uw7HeQg/jPAws7e3SdVWZ7SXfGKTlBpGtwb5rewHAY4MuAQXu
 QWYwK9VK6NFmi5i8KoobsFdPcMPE/ONlDtV0dg==
X-Google-Smtp-Source: ABdhPJxdGyqicvmBjO3kQ/FFXeZQlATaOH5wfsus++n/tHm7bnDzj6tCg+lMi3lpa9xRO1aEc8Xk7JDuAgsu2nEqCQE=
X-Received: by 2002:a02:896:: with SMTP id 144mr10534416jac.126.1592235240683; 
 Mon, 15 Jun 2020 08:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de>
 <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
 <20200615141239.GA12951@lst.de>
 <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
 <20200615144310.GA15101@lst.de>
 <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com>
 <20200615150926.GA17108@lst.de>
In-Reply-To: <20200615150926.GA17108@lst.de>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 15 Jun 2020 11:33:49 -0400
Message-ID: <CAMzpN2htYX7s6pmRg-c8qwZL1f1_+sB=ztDG_L=617hWsm-=8g@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 15, 2020 at 11:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 15, 2020 at 04:46:15PM +0200, Arnd Bergmann wrote:
> > How about this one:
> >
> > diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.=
c
> > index 3d8d70d3896c..0ce15807cf54 100644
> > --- a/arch/x86/entry/syscall_x32.c
> > +++ b/arch/x86/entry/syscall_x32.c
> > @@ -16,6 +16,9 @@
> >  #undef __SYSCALL_X32
> >  #undef __SYSCALL_COMMON
> >
> > +#define __x32_sys_execve __x64_sys_execve
> > +#define __x32_sys_execveat __x64_sys_execveat
> > +
>
>
> arch/x86/entry/syscall_x32.c:19:26: error: =E2=80=98__x64_sys_execve=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98__x32_sys=
_execve=E2=80=99?
>    19 | #define __x32_sys_execve __x64_sys_execve
>       |                          ^~~~~~~~~~~~~~~~
> arch/x86/entry/syscall_x32.c:22:39: note: in expansion of macro =E2=80=98=
__x32_sys_execve=E2=80=99
>    22 | #define __SYSCALL_X32(nr, sym) [nr] =3D __x32_##sym,
>       |                                       ^~~~~~
> ./arch/x86/include/generated/asm/syscalls_64.h:344:1: note: in expansion =
of macro =E2=80=98__SYSCALL_X32=E2=80=99
>   344 | __SYSCALL_X32(520, sys_execve)
>       | ^~~~~~~~~~~~~
> arch/x86/entry/syscall_x32.c:20:28: error: =E2=80=98__x64_sys_execveat=E2=
=80=99 undeclared here (not in a function); did you mean =E2=80=98__x32_sys=
_execveat=E2=80=99?
>    20 | #define __x32_sys_execveat __x64_sys_execveat
>       |                            ^~~~~~~~~~~~~~~~~~
> arch/x86/entry/syscall_x32.c:22:39: note: in expansion of macro =E2=80=98=
__x32_sys_execveat=E2=80=99
>    22 | #define __SYSCALL_X32(nr, sym) [nr] =3D __x32_##sym,
>       |                                       ^~~~~~
> ./arch/x86/include/generated/asm/syscalls_64.h:369:1: note: in expansion =
of macro =E2=80=98__SYSCALL_X32=E2=80=99
>   369 | __SYSCALL_X32(545, sys_execveat)
>       | ^~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:281: arch/x86/entry/syscall_x32.o] E=
rror 1
> make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
> make[1]: *** Waiting for unfinished jobs....
> kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable=
 instruction
> make: *** [Makefile:1764: arch/x86] Error 2
> make: *** Waiting for unfinished jobs....

If you move those aliases above all the __SYSCALL_* defines it will
work, since that will get the forward declaration too.  This would be
the simplest workaround.

--
Brian Gerst
