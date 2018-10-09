Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5155C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:19:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8E4214C4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuCZosiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8E4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TvrX6t0ZzF3B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 22:19:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuCZosiw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuCZosiw"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tvnl1pBmzF39Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 22:16:58 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id l81-v6so686055pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pa7vEVoOVEMh1ttml1yYqW1Nzcq1XB8h3JQ8HTmJHU8=;
 b=SuCZosiwMDaLlXvZGEowuBCre7LF5CoCzrhBbFuMuyI87KKq6S+Uy+V8z47RhURy6M
 6acfH0Prn3Me8nY8BtW3t6gcHU0n2+A40smyC1OlNM1Cz3gY7NZdBeNLMq1Susm1hez1
 6FHMO4/0AT7Xf8mgTO3eLW/k5hxBivqXsYtZERwvlMbgA08dITV40GPa+RWJijwXwW0W
 DNxdgWoVF5JJaJsKxa5Xfes26RxjWmJNz1b9Q92BLIrPTpl1o7ZO+WYwzrKtrYtR7js4
 4med68eus83nphxa3Q0Nxv+sz0kp/g2P4RXQTSlkHPNXYVMzxhOV0nAHHkIwV4X2DjHz
 5Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pa7vEVoOVEMh1ttml1yYqW1Nzcq1XB8h3JQ8HTmJHU8=;
 b=D3ioLuM98ER48TbtP3v1gr1ikP3KuSMgCCxmDQSet9lw0ZVFIrzlgeakNGbfPxDjAo
 QKQyV4GD8LxYJBRyozwH2t/nevzGGZQgUHibBhLGGK0tBEjzwVhsBuSzmrq7k0gQT1e4
 9olAsiF4wO8D5icJPSL/OM24N4EA23mWDVvJmyVwt/pRgCE11sjBaXXYQZii4BKncrYe
 uaEMtEaJ2780AEl6UifKM3G3JeBxp8HHQ8Q6SNYDK7+GV531AqBacDWZp3TmiS3QyMoo
 M3iLp/2vwfUFOsx3xzBQAm1sLzvSYgmZ8irKMU1b8aQQSFqwC1iUws0KuC2xsmJzUt0L
 hXsg==
X-Gm-Message-State: ABuFfoh+m1xZnoZavIMXimXWhmvNQOMYmU40TUKJawhQfLW+KLQDUXmr
 UfHkE2lZX2O7ST8PBR9Obag=
X-Google-Smtp-Source: ACcGV63sR+Cp1dhLUkTrdCh+oeoJp+S0ssjvz0mv4fYTjTjSYRlWq5SWG8IttEhJNCnDwQwS6cSsbw==
X-Received: by 2002:a63:904a:: with SMTP id
 a71-v6mr25784754pge.264.1539083816972; 
 Tue, 09 Oct 2018 04:16:56 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-121-136.tpgi.com.au.
 [60.240.121.136])
 by smtp.gmail.com with ESMTPSA id k70-v6sm33786692pfc.76.2018.10.09.04.16.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 04:16:56 -0700 (PDT)
Date: Tue, 9 Oct 2018 21:16:50 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a
 non-maskable interrupt
Message-ID: <20181009211650.042d428c@roar.ozlabs.ibm.com>
In-Reply-To: <0539727f-8420-3176-30b5-f4a6a1ccd4a4@c-s.fr>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
 <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
 <20181009143241.026f3e7f@roar.ozlabs.ibm.com>
 <ccf61fc2-1f2e-7b67-c481-fa4c00a65aae@c-s.fr>
 <20181009153058.2564e7a1@roar.ozlabs.ibm.com>
 <0539727f-8420-3176-30b5-f4a6a1ccd4a4@c-s.fr>
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

On Tue, 9 Oct 2018 09:36:18 +0000
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> On 10/09/2018 05:30 AM, Nicholas Piggin wrote:
> > On Tue, 9 Oct 2018 06:46:30 +0200
> > Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> Le 09/10/2018 =C3=A0 06:32, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>> On Mon, 8 Oct 2018 17:39:11 +0200
> >>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >>>     =20
> >>>> Hi Nick,
> >>>>
> >>>> Le 19/07/2017 =C3=A0 08:59, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>>>> Use nmi_enter similarly to system reset interrupts. This uses NMI
> >>>>> printk NMI buffers and turns off various debugging facilities that
> >>>>> helps avoid tripping on ourselves or other CPUs.
> >>>>>
> >>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>>> ---
> >>>>>     arch/powerpc/kernel/traps.c | 9 ++++++---
> >>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/trap=
s.c
> >>>>> index 2849c4f50324..6d31f9d7c333 100644
> >>>>> --- a/arch/powerpc/kernel/traps.c
> >>>>> +++ b/arch/powerpc/kernel/traps.c
> >>>>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *regs)
> >>>>>    =20
> >>>>>     void machine_check_exception(struct pt_regs *regs)
> >>>>>     {
> >>>>> -	enum ctx_state prev_state =3D exception_enter();
> >>>>>     	int recover =3D 0;
> >>>>> +	bool nested =3D in_nmi();
> >>>>> +	if (!nested)
> >>>>> +		nmi_enter(); =20
> >>>>
> >>>> This alters preempt_count, then when die() is called
> >>>> in_interrupt() returns true allthough the trap didn't happen in
> >>>> interrupt, so oops_end() panics for "fatal exception in interrupt"
> >>>> instead of gently sending SIGBUS the faulting app. =20
> >>>
> >>> Thanks for tracking that down.
> >>>     =20
> >>>> Any idea on how to fix this ? =20
> >>>
> >>> I would say we have to deliver the sigbus by hand.
> >>>
> >>>       if ((user_mode(regs)))
> >>>           _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
> >>>       else
> >>>           die("Machine check", regs, SIGBUS);
> >>>     =20
> >>
> >> And what about all the other things done by 'die()' ?
> >>
> >> And what if it is a kernel thread ?
> >>
> >> In one of my boards, I have a kernel thread regularly checking the HW,
> >> and if it gets a machine check I expect it to gently stop and the die
> >> notification to be delivered to all registered notifiers.
> >>
> >> Until before this patch, it was working well. =20
> >=20
> > I guess the alternative is we could check regs->trap for machine
> > check in the die test. Complication is having to account for MCE
> > in an interrupt handler.
> >=20
> >         if (in_interrupt()) {
> >                  if (!IS_MCHECK_EXC(regs) || (irq_count() - (NMI_OFFSET=
 + HARDIRQ_OFFSET)))
> >                      panic("Fatal exception in interrupt");
> >         }
> >=20
> > Something like that might work for you? We needs a ppc64 macro for the
> > MCE, and can probably add something like in_nmi_from_interrupt() for
> > the second part of the test. =20
>=20
> Don't know, I'm away from home on business trip so I won't be able to=20
> test anything before next week. However it looks more or less like a=20
> hack, doesn't it ?

I thought it seemed okay (with the right functions added). Actually it
could be a bit nicer to do this, then it works generally :

         if (in_interrupt()) {
                  if (!in_nmi() || in_nmi_from_interrupt())
                      panic("Fatal exception in interrupt");
         }

>=20
> What about the following ?

Hmm, in some ways maybe it's nicer. One complication is I would like the
same thing to be available for platform specific machine check
handlers, so then you need to pass is_in_interrupt to them. Which you
can do without any problem... But is it cleaner than the above?

I guess one advantage of yours is that a BUG somewhere in the NMI path
will panic the system. Or is that a disadvantage?

Thanks,
Nick


>=20
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index fd58749b4d6b..1f09033a5103 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -208,7 +208,7 @@ static unsigned long oops_begin(struct pt_regs *regs)
>   NOKPROBE_SYMBOL(oops_begin);
>=20
>   static void oops_end(unsigned long flags, struct pt_regs *regs,
> -			       int signr)
> +		     int signr, bool is_in_interrupt)
>   {
>   	bust_spinlocks(0);
>   	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> @@ -247,7 +247,7 @@ static void oops_end(unsigned long flags, struct=20
> pt_regs *regs,
>   		mdelay(MSEC_PER_SEC);
>   	}
>=20
> -	if (in_interrupt())
> +	if (is_in_interrupt)
>   		panic("Fatal exception in interrupt");
>   	if (panic_on_oops)
>   		panic("Fatal exception");
> @@ -288,7 +288,7 @@ static int __die(const char *str, struct pt_regs=20
> *regs, long err)
>   }
>   NOKPROBE_SYMBOL(__die);
>=20
> -void die(const char *str, struct pt_regs *regs, long err)
> +static void nmi_die(const char *str, struct pt_regs *regs, long err,=20
> bool is_in_interrupt)
>   {
>   	unsigned long flags;
>=20
> @@ -303,7 +303,13 @@ void die(const char *str, struct pt_regs *regs,=20
> long err)
>   	flags =3D oops_begin(regs);
>   	if (__die(str, regs, err))
>   		err =3D 0;
> -	oops_end(flags, regs, err);
> +	oops_end(flags, regs, err, is_in_interrupt);
> +}
> +NOKPROBE_SYMBOL(nmi_die);
> +
> +void die(const char *str, struct pt_regs *regs, long err)
> +{
> +	nmi_die(str, regs, err, in_interrupt());
>   }
>   NOKPROBE_SYMBOL(die);
>=20
> @@ -737,6 +743,7 @@ int machine_check_generic(struct pt_regs *regs)
>   void machine_check_exception(struct pt_regs *regs)
>   {
>   	int recover =3D 0;
> +	bool is_in_interrupt =3D in_interrupt();
>   	bool nested =3D in_nmi();
>   	if (!nested)
>   		nmi_enter();
> @@ -765,7 +772,7 @@ void machine_check_exception(struct pt_regs *regs)
>   	if (check_io_access(regs))
>   		goto bail;
>=20
> -	die("Machine check", regs, SIGBUS);
> +	nmi_die("Machine check", regs, SIGBUS, is_in_interrupt);
>=20
>   	/* Must die if the interrupt is not recoverable */
>   	if (!(regs->msr & MSR_RI))
>=20
>=20
> Thanks
> Christophe

