Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5A1C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 06:36:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A052D2083A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 06:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A052D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bK835zZ7zF3SR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 17:36:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bK5r20z2zF3LK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 17:34:40 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id p125-v6so23120882oic.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 23:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Tb+a2A2yo+HKbh2+8CHwWioJMEJeOPzD5jgZVMkpjg0=;
 b=CAo53IGKsSsBRjVMYf5Y12j037+f5cFrYNngrhOQ0NTX9KKFqkM7wHprfDDxgwSk3y
 l+tsA97j99K4MJgLgdBytQHiuncFX03uMUYNznrTlCv63FmxxW/pB05pIrW99IBr87SW
 cvALrrpuAMepDYvyX1p/sG5tf2ZczpdJocu7LmJuQZthwwgqmqHyNt4nrcHbeVWz7W4Y
 mPtZ5X667CRAgRS95/rgdLOvO4A5DFWwFBcafF3++bXlR96jS+R4OUehpeOt4h1J7YOL
 09i7TXSYLP9V90Olh6dI8zUC2ThoddaqLVwGe1QArJ2RPeU//p4uKuvkhVEm+sBPtM26
 HGDg==
X-Gm-Message-State: ABuFfog2qK5pX9revt+oay7ECrq0jzZIHhQXmquS6ylsfudMlBJuawZM
 tljGMeJ8B4QbnDZ1MAO3Gq5A78PU1RX2gquRz9g=
X-Google-Smtp-Source: ACcGV63InGBrHIYYs3pbOsbcfC6xmpzajy95515nL7SLZkNKXK0P+L75d81QeLzB4p2judjsDB2yziiVB67zayZ4UAQ=
X-Received: by 2002:aca:aac7:: with SMTP id
 t190-v6mr16383981oie.218.1539844477965; 
 Wed, 17 Oct 2018 23:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181017192558.8039-1-malat@debian.org>
 <373dd30b-70d1-5e06-c55e-45f8f6763edf@c-s.fr>
In-Reply-To: <373dd30b-70d1-5e06-c55e-45f8f6763edf@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 18 Oct 2018 08:34:25 +0200
Message-ID: <CA+7wUswVQNRKbiyockD+xkAo3=0qXW9zMS=pXWT-xTxJi0hPfg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add missing include <asm/stacktrace.h>
To: Christophe LEROY <christophe.leroy@c-s.fr>
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

On Thu, Oct 18, 2018 at 6:37 AM Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 17/10/2018 =C3=A0 21:25, Mathieu Malaterre a =C3=A9crit :
> > In commit 88b0fe175735 ("powerpc: Add show_user_instructions()") the
> > function show_user_instructions was added.
> >
> > This commit adds an include of header file <asm/stacktrace.h> to provid=
e
> > the missing function prototype. Silence the following gcc warning
> > (treated as error with W=3D1):
> >
> >    arch/powerpc/kernel/process.c:1302:6: error: no previous prototype f=
or =E2=80=98show_user_instructions=E2=80=99 [-Werror=3Dmissing-prototypes]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> This is already fixed, see
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3Dc9386bfd37d37f29588de9ea9add455510049c33

Excellent !

Sorry for the noise :(

> Christophe
>
> > ---
> >   arch/powerpc/kernel/process.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index bb6ac471a784..1c64491e9702 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -65,6 +65,7 @@
> >   #include <asm/livepatch.h>
> >   #include <asm/cpu_has_feature.h>
> >   #include <asm/asm-prototypes.h>
> > +#include <asm/stacktrace.h>
> >
> >   #include <linux/kprobes.h>
> >   #include <linux/kdebug.h>
> >
