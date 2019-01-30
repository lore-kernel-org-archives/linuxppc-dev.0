Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216ADC169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:42:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AAC20870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg+1AiPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AAC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43q71R1ByszDqSH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 13:42:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=sabyasachi.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gg+1AiPV"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43q6zX58T1zDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 13:40:24 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id w7so9650024pgp.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 18:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PLOcDqFhOlGdCjEtJGjlkRWiUM5TQDzU+PN+xuu7AQQ=;
 b=gg+1AiPVDWSxv1CT89tyRfhywYqPstGuKxcoFv/nxfLLg5HRQ3rewk2YnDobzIjorP
 IUjAaRZlWG7CR4UWTkoy8zVVJusNGPi1pMx8YKR8TfvuEH89QCSr/nMyQXpndInHX1ot
 0hvcDPw35yokKBLbw/7cuutiMjEWSpA61N53A3A+9T8KIXfPjcWkHl9kXeUy1znWzeqx
 yv/wIt4E4g5xPLvQWpXLEgF9f6Gc+2EUaGgbMva/1ELKFKbxX3Y+2UzXEwpJbyKF+Jo/
 WJu1aozRaK1nQjtHv7kkAvkzJ/U34/J0s+fQaYxeNcRcs5GxIx5c5PccLE3AiQS4cako
 vlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PLOcDqFhOlGdCjEtJGjlkRWiUM5TQDzU+PN+xuu7AQQ=;
 b=MdQtzEap1o2h0JCrn+cqAVDdVzzhvKBEsv4xtyB3lbICzkVHQacNH2FaCMQZrtnUN0
 VKAHlKLIDGA7Cza/kE3oiLPZyLAaCFoUfTKRKZrlBYtoUITwzlpwizNhMWrJNEpQr0cb
 t4oyoQ6SgV1+r1tqmJLDoKJHmEMsr1waklkDEKajk3HynagOAfLlRJSWH+/ZqUQqmBEx
 6j0A705WbgoUF73/GHkRlfg2k2zXV4ana16yVnxxubYvXXxvWEt211uPlDXGdejcWW3a
 7aMQIPK+F9qglFsFmSYq5Z599QanYkJByMeIJRDTyLpiq9h4+vxdgONBYlDJN8mvSdaD
 iIGQ==
X-Gm-Message-State: AJcUukfqnCXNGbGUU5FWC5V2JFOS7DfpNxY1w5zP7NnADJOH0b8Y9EAB
 irESIS0AgHYBIs2Wm14ONcC/hdPI8Y7pwhCF5rY=
X-Google-Smtp-Source: ALg8bN6x1ZR3gulClm4Ox1Ttscq/nqrfGIgh15aOlEKNnnuMq2X1AmnNjniRdSJEaiXKodR/4GBsYdS4xa83XcwN6YE=
X-Received: by 2002:a63:5153:: with SMTP id r19mr25806573pgl.281.1548816022812; 
 Tue, 29 Jan 2019 18:40:22 -0800 (PST)
MIME-Version: 1.0
References: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
 <CAFqt6zZPXcX+Qk_CMNaBhs9=dTJuzv4nQzoj09xWLbMuT6NvDQ@mail.gmail.com>
In-Reply-To: <CAFqt6zZPXcX+Qk_CMNaBhs9=dTJuzv4nQzoj09xWLbMuT6NvDQ@mail.gmail.com>
From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Wed, 30 Jan 2019 08:10:11 +0530
Message-ID: <CAJr6mf3SEpHofW_jr5tne=SGEH=dMwb2yKSxsT-2BPV9HLCnMQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/cell: Remove duplicate header
To: Souptick Joarder <jrdr.linux@gmail.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 11:13 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Jan 17, 2019 at 9:49 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Remove linux/syscalls.h which is included more than once
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
>
If no further comment, can we get this patch in queue for 5.1 ?

> > ---
> >  arch/powerpc/platforms/cell/spu_syscalls.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
> > index 263413a..b95d6af 100644
> > --- a/arch/powerpc/platforms/cell/spu_syscalls.c
> > +++ b/arch/powerpc/platforms/cell/spu_syscalls.c
> > @@ -26,7 +26,6 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/binfmts.h>
> > -#include <linux/syscalls.h>
> >
> >  #include <asm/spu.h>
> >
> > --
> > 2.7.4
> >
