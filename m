Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9ACC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327D220651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327D220651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KNN75bKjzDqMX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 07:14:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KNL65FxbzDq77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 07:12:30 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id t206so2540832oib.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 13:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iI8a6LJ4CW9r1pdJ3NyV/ChlC2LdijtQmINha9gU4os=;
 b=LyrkLZFTmD9GpO4CDbXeG4SQdLi+BXPQtrPaDh3SWq92wz5BvhjqFEdcSxNoppPEzG
 LDpIKEiYJyNyqrEoVu+6b0yr9jOhFDvYkJlbVD/i+qooT0lPXosTwrB+MefOZnettLdW
 btf3Wu0iSvFEFW6k5ocLg5JbXIrxH0v5X3Q6IfaWkOFGWMKLoZdwVcMGlcxuJn9bUKa2
 QLiFIEqVbFuqFgK7f/pZ79MPw8v3ICz0IoOkv5HdNxbuKK+GuV18NCbck385A+3t8knd
 LAq4k3eXjRqsXkvGNc5xX/FA+j3MKrFiIet/khPPlyugem2BL7Bnwsp8T0AiUUiWtKXN
 LuNg==
X-Gm-Message-State: APjAAAW4E76wL1C0vsu9TInyr/L1Yj4qtX4sFCGOPP6M5JihcgYtMAnk
 T0q5YO/pBOt2zK0lPd5jPWH2puJQYO3evie8ihA=
X-Google-Smtp-Source: APXvYqyC2OAQypyh5sX6ij0BneoZE29K00fYlhe4ZnHfUd3DAFnMmh2UITcwkT7CBecyFQRW34dGhjDQ9SzThbYvO3M=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr253458oia.107.1552507947168; 
 Wed, 13 Mar 2019 13:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190312202008.29681-1-malat@debian.org>
 <57a0d93c-8784-d6af-a5fb-75e31455ae57@c-s.fr>
 <CA+7wUsyA698UtNLni7wi3=cKjbCd1V71YA0sxDtMD=MmQvQxTQ@mail.gmail.com>
 <94d90740-c970-01b0-c430-bafc2e9eecd3@c-s.fr>
In-Reply-To: <94d90740-c970-01b0-c430-bafc2e9eecd3@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 13 Mar 2019 21:12:15 +0100
Message-ID: <CA+7wUsw+pmeS-oG5MMMjKB34R98vqHf1jxT=Fmx5oxiGLnYzBQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: sstep: Mark variable `rc` as unused in function
 'analyse_instr'
To: Christophe Leroy <christophe.leroy@c-s.fr>
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
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 12, 2019 at 10:26 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 12/03/2019 =C3=A0 22:12, Mathieu Malaterre a =C3=A9crit :
> > On Tue, Mar 12, 2019 at 9:56 PM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >>
> >>
> >>
> >> Le 12/03/2019 =C3=A0 21:20, Mathieu Malaterre a =C3=A9crit :
> >>> Add gcc attribute unused for `rc` variable.
> >>>
> >>> Fix warnings treated as errors with W=3D1:
> >>>
> >>>     arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but no=
t used [-Werror=3Dunused-but-set-variable]
> >>>
> >>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >>> ---
> >>>    arch/powerpc/lib/sstep.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> >>> index 3d33fb509ef4..32d092f62ae0 100644
> >>> --- a/arch/powerpc/lib/sstep.c
> >>> +++ b/arch/powerpc/lib/sstep.c
> >>> @@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1=
, long v2)
> >>>    int analyse_instr(struct instruction_op *op, const struct pt_regs =
*regs,
> >>>                  unsigned int instr)
> >>>    {
> >>> -     unsigned int opcode, ra, rb, rc, rd, spr, u;
> >>> +     unsigned int opcode, ra, rb, rc __maybe_unused, rd, spr, u;
> >>
> >> I think it would be better to enclose 'rc' inside a #ifdef CONFIG_PPC6=
4
> >
> > Hum odd, I would have bet you would have suggested me to use
> > IS_ENABLED with some crazy scheme (I was not able to mix it with the
> > switch case nicely).
>
> Well I guess yes, you could also get rid of the #ifdef __powerpc64__ and
> instead add the following just after the 'case 4:'
>
> if (!IS_ENABLED(CONFIG_64))
>         break;
>
> That's less uggly than adding two #ifdef/#endif

So you mean changing:

#ifdef __powerpc64__
  case 4:
    if (!cpu_has_feature(CPU_FTR_ARCH_300))
      return -1;

into:

  case 4:
    if (!IS_ENABLED(CONFIG_PPC64))
      break;
    if (!cpu_has_feature(CPU_FTR_ARCH_300))
      return -1;

So suddenly case label '4' becomes visible for ppc32, is that really
what you wanted ?

> Christophe
>
> >
> > Anyway I'll try your suggestion and post a v2.
> >
> >> Christophe
> >>
> >>>        unsigned long int imm;
> >>>        unsigned long int val, val2;
> >>>        unsigned int mb, me, sh;
> >>>
