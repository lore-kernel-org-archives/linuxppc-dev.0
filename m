Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880BEC64EB0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:33:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0086C20C0A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFimOmF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0086C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tm9N6DmyzF3M5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:33:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MFimOmF9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MFimOmF9"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tm6f1JctzF3M2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 16:31:06 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id r64-v6so220976pfb.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 22:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PAvZi4B1j4NUthD1J1hm7F7WJLP0ZYFQKrPDBjle3/I=;
 b=MFimOmF9SksYsYcT8VPs6I3K/pPiB505J6wUH2b4mHsPIkbzygU2OdfrAhTOejnWI5
 Ib3HIsPyTbs46dfcE2KNWmyp7SLYmarR2WzEVkgs61z1EzqEA+OPihc3Pur+0801wnId
 MHYJ6OTRQ8/NrghTAk0XtobAzNiomu1oG9fl1Z1EolH0Ta5J7B6K+9hqzwSA4BrkBVwz
 fBgReZeRCwOIw82ohiLt89prrdDnEhjfAsMPHxHhuian+Cg+y4Lxy81x0+boQ0Cy1FFB
 i5Sq6DO9yklXjTSAdNcvh+V1l3W93wWVRVxznr6N+NlowDmBjprYquxBtpigKYdTnT39
 +/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PAvZi4B1j4NUthD1J1hm7F7WJLP0ZYFQKrPDBjle3/I=;
 b=NT4zOWTUdu8bQKHxFag0vvdPkNZ22FErQos40rBWnzNzQT26z1glzvgkICgazDABbp
 uriW+FPOz1WaHjG3lCymgeXRV9SzHDpJtr7mI25CjZKFiDdu9RZMUzA2IJxrREktz9g5
 SseHO4Ekpx2B7pQYmDDVvFpzNtiBwfWYI1D5mXgM9zMLR1YtrtZ5MxcEmOjoE2CO5Ntx
 qW7l9/I3kMnXTJ2h8AbE+AbN4guXuZVq28t6qZoUU4CJZ4QbcHk1zCrbvJ+YOEBgHC4w
 64Dt7+JUixqUALd1Gm3Y2H14FPvjvHKPalGwXiq2AjL6P9OtCfq36wJqWSN8pKK8mi+4
 apGQ==
X-Gm-Message-State: ABuFfoiz8cvO0IRjkuw/ZRNLXP24C+vcCivmmgeHzPHAvBeFIQ+OmhCA
 ag7oDYwvJ9BUXa8mgFaMW0w=
X-Google-Smtp-Source: ACcGV62AQ6Y1odG1G6Vt4IF4Mx3jylHpUFFAuW5mqudSHYKGPFtd2Ly6FRxHIaRjh2pBbgRRfYTkHA==
X-Received: by 2002:a62:42d4:: with SMTP id
 h81-v6mr29132563pfd.0.1539063063910; 
 Mon, 08 Oct 2018 22:31:03 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-121-136.tpgi.com.au.
 [60.240.121.136])
 by smtp.gmail.com with ESMTPSA id x69-v6sm26733261pff.175.2018.10.08.22.31.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Oct 2018 22:31:03 -0700 (PDT)
Date: Tue, 9 Oct 2018 15:30:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a
 non-maskable interrupt
Message-ID: <20181009153058.2564e7a1@roar.ozlabs.ibm.com>
In-Reply-To: <ccf61fc2-1f2e-7b67-c481-fa4c00a65aae@c-s.fr>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
 <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
 <20181009143241.026f3e7f@roar.ozlabs.ibm.com>
 <ccf61fc2-1f2e-7b67-c481-fa4c00a65aae@c-s.fr>
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

On Tue, 9 Oct 2018 06:46:30 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 09/10/2018 =C3=A0 06:32, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Mon, 8 Oct 2018 17:39:11 +0200
> > Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> Hi Nick,
> >>
> >> Le 19/07/2017 =C3=A0 08:59, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>> Use nmi_enter similarly to system reset interrupts. This uses NMI
> >>> printk NMI buffers and turns off various debugging facilities that
> >>> helps avoid tripping on ourselves or other CPUs.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>>    arch/powerpc/kernel/traps.c | 9 ++++++---
> >>>    1 file changed, 6 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> >>> index 2849c4f50324..6d31f9d7c333 100644
> >>> --- a/arch/powerpc/kernel/traps.c
> >>> +++ b/arch/powerpc/kernel/traps.c
> >>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *regs)
> >>>   =20
> >>>    void machine_check_exception(struct pt_regs *regs)
> >>>    {
> >>> -	enum ctx_state prev_state =3D exception_enter();
> >>>    	int recover =3D 0;
> >>> +	bool nested =3D in_nmi();
> >>> +	if (!nested)
> >>> +		nmi_enter(); =20
> >>
> >> This alters preempt_count, then when die() is called
> >> in_interrupt() returns true allthough the trap didn't happen in
> >> interrupt, so oops_end() panics for "fatal exception in interrupt"
> >> instead of gently sending SIGBUS the faulting app. =20
> >=20
> > Thanks for tracking that down.
> >  =20
> >> Any idea on how to fix this ? =20
> >=20
> > I would say we have to deliver the sigbus by hand.
> >=20
> >      if ((user_mode(regs)))
> >          _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
> >      else
> >          die("Machine check", regs, SIGBUS);
> >  =20
>=20
> And what about all the other things done by 'die()' ?
>=20
> And what if it is a kernel thread ?
>=20
> In one of my boards, I have a kernel thread regularly checking the HW,=20
> and if it gets a machine check I expect it to gently stop and the die=20
> notification to be delivered to all registered notifiers.
>=20
> Until before this patch, it was working well.

I guess the alternative is we could check regs->trap for machine
check in the die test. Complication is having to account for MCE
in an interrupt handler.

       if (in_interrupt()) {
                if (!IS_MCHECK_EXC(regs) || (irq_count() - (NMI_OFFSET + HA=
RDIRQ_OFFSET)))
                    panic("Fatal exception in interrupt");
       }

Something like that might work for you? We needs a ppc64 macro for the
MCE, and can probably add something like in_nmi_from_interrupt() for
the second part of the test.

Thanks,
Nick
