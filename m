Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11853C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:22:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A462147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A462147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jnxh2X5wzDqGl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:22:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jnkg0pDgzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 08:13:14 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id q24so3900779otk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 14:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3jmJXa4rzUEjqLYYUxVP8wSbrNr3+v4uEdwLGkO9joA=;
 b=ArVpk+yp6jBVbVLRXkXFJqqfxwYm6QXZHLKCTECIkiChhIOllpPp02c30VextudMZS
 Wt2rmAIH0EEeFjtpuTTmNCmPBFPCCzqRVzN06IEd5k5nR9tP9KloaaZB9DVbCuif11Yz
 ruEYUmzUEwLRQAuQQfnvychxQtfP1gye7WJD08iQPTZ7raHatqGhRWW57/vq3fZ81jFJ
 YEl3BsD7m3b1QCD0qhfFjzcBSCo4vZGLn7MTu9Z3auw5XLPvGN73ej7Cq2JWKfpfBCSs
 nXTfYtup5gcDZkkDctxAKI8rOCBRJqcawYPFiHp9wt30Jf8pFtvPYAwRQvFhxJ9vDV9f
 TwUQ==
X-Gm-Message-State: APjAAAUOnErtvHaok4q52q7xZ0MM8QrpKgI7mHrBX+8BNWir/hzHiqYG
 KrP/algKumhV+L+1frXmI5SDth9TK2uvjO2otbw=
X-Google-Smtp-Source: APXvYqzN2+BHlrw2pWgucJMJKUY//qSZUyb7RDQg4jcbZNAvYOwJ1WSHOgGonfgzc6DOPGRUWj2muPjZQ2TYGJJThIE=
X-Received: by 2002:a9d:5616:: with SMTP id e22mr25903782oti.365.1552425191717; 
 Tue, 12 Mar 2019 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190312202008.29681-1-malat@debian.org>
 <57a0d93c-8784-d6af-a5fb-75e31455ae57@c-s.fr>
In-Reply-To: <57a0d93c-8784-d6af-a5fb-75e31455ae57@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 12 Mar 2019 22:12:59 +0100
Message-ID: <CA+7wUsyA698UtNLni7wi3=cKjbCd1V71YA0sxDtMD=MmQvQxTQ@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 9:56 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 12/03/2019 =C3=A0 21:20, Mathieu Malaterre a =C3=A9crit :
> > Add gcc attribute unused for `rc` variable.
> >
> > Fix warnings treated as errors with W=3D1:
> >
> >    arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not u=
sed [-Werror=3Dunused-but-set-variable]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/lib/sstep.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> > index 3d33fb509ef4..32d092f62ae0 100644
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, =
long v2)
> >   int analyse_instr(struct instruction_op *op, const struct pt_regs *re=
gs,
> >                 unsigned int instr)
> >   {
> > -     unsigned int opcode, ra, rb, rc, rd, spr, u;
> > +     unsigned int opcode, ra, rb, rc __maybe_unused, rd, spr, u;
>
> I think it would be better to enclose 'rc' inside a #ifdef CONFIG_PPC64

Hum odd, I would have bet you would have suggested me to use
IS_ENABLED with some crazy scheme (I was not able to mix it with the
switch case nicely).

Anyway I'll try your suggestion and post a v2.

> Christophe
>
> >       unsigned long int imm;
> >       unsigned long int val, val2;
> >       unsigned int mb, me, sh;
> >
