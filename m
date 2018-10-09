Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF2C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 04:34:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C51214C2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 04:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkK6NVqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C51214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tksn2jJwzF3FZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 15:34:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WkK6NVqI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WkK6NVqI"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TkqQ2Hl9zF39C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 15:32:49 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id c8-v6so154671plo.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 21:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yhpEXwVV+gBeM7/D6qo6xsBYADreV2L5BcJ/l365BbQ=;
 b=WkK6NVqImTlyp5pp5Q+sw6B24/8ZY6PMDsY0ircgrRYnA7TUobS0wwmPNk9gvSH3UL
 1kvYYByUQ94WYiwr5+sEMhHtcPlqgHnIZ2ZlWkyZ6wtoTwOkKBo6MjAngN6yJYliHV5D
 aO9D/Jjj4oxi1GmmceaPxEH9BUzUryHiYA1Y773LFlYK8LyuR+f7oG/X9ZS54lqpMyUA
 ooyJIBzlZwTzM8GBqEEIpY2j+qIQsSpqSYc3PID7taYTkTJlRo06jmeht3dTRy8nMpa4
 L/tvMJLpifTEH0tIS5Cl7QOWDD2KSBAgJCAZcrdSLaFp9duMOZsRa+hGhDbZWYPOdhil
 vOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yhpEXwVV+gBeM7/D6qo6xsBYADreV2L5BcJ/l365BbQ=;
 b=uho7yHIkWRST93Jub3iwHSCkhOvL08Fxmbt1LSypE4ELDadl9mIQcqG/zV72cMCNce
 ROZR1xWmqYIqec0bECE31JqU200eMZDoeOlvzYJW/Y6f5x+xdzXz4gHo5j59JcUdZjqt
 Kpz3R25tpI+wd29zFfKQRjgwYAJhJaxpKjpT2XLAMbYZnelHFgN2r7+NV2ze8v615SqB
 5NEJDIxACDHGo4sxI9H07P5CDXNHV2JrjExkzVoi0AfmJ2oZMtsXCH51VaT581/so5pw
 m8gwReCxEEzlC373uaBeGplXxAzPSYRr5JjAO7Yho0gf3JC3GJHFvIf43d9w61RykwXe
 FX9g==
X-Gm-Message-State: ABuFfoja8TsgaHyu/wj48b5DxQdlx8vTZmzVzdpCMSy03ROiV0VXpe/E
 FeiO5DcLelhHG+y03KRqzWc=
X-Google-Smtp-Source: ACcGV63xcQWHBT5Ds3Uz7H97cSqVsdj69Cn8c1hka2fOOI6qQuvTZq744N4WM0FVMT2Pgs5cLkr3eg==
X-Received: by 2002:a17:902:b696:: with SMTP id
 c22-v6mr11409892pls.37.1539059567944; 
 Mon, 08 Oct 2018 21:32:47 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-121-136.tpgi.com.au.
 [60.240.121.136])
 by smtp.gmail.com with ESMTPSA id r18-v6sm16618391pgv.17.2018.10.08.21.32.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Oct 2018 21:32:47 -0700 (PDT)
Date: Tue, 9 Oct 2018 14:32:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a
 non-maskable interrupt
Message-ID: <20181009143241.026f3e7f@roar.ozlabs.ibm.com>
In-Reply-To: <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
 <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 8 Oct 2018 17:39:11 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Hi Nick,
>=20
> Le 19/07/2017 =C3=A0 08:59, Nicholas Piggin a =C3=A9crit=C2=A0:
> > Use nmi_enter similarly to system reset interrupts. This uses NMI
> > printk NMI buffers and turns off various debugging facilities that
> > helps avoid tripping on ourselves or other CPUs.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   arch/powerpc/kernel/traps.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index 2849c4f50324..6d31f9d7c333 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *regs)
> >  =20
> >   void machine_check_exception(struct pt_regs *regs)
> >   {
> > -	enum ctx_state prev_state =3D exception_enter();
> >   	int recover =3D 0;
> > +	bool nested =3D in_nmi();
> > +	if (!nested)
> > +		nmi_enter(); =20
>=20
> This alters preempt_count, then when die() is called
> in_interrupt() returns true allthough the trap didn't happen in=20
> interrupt, so oops_end() panics for "fatal exception in interrupt"=20
> instead of gently sending SIGBUS the faulting app.

Thanks for tracking that down.

> Any idea on how to fix this ?

I would say we have to deliver the sigbus by hand.

    if ((user_mode(regs)))
        _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
    else
        die("Machine check", regs, SIGBUS);
