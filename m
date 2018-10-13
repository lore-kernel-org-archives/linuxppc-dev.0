Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8725DC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 08:50:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D840520859
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 08:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbamk+Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D840520859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XJMB3YWZzF3Hw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 19:50:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbamk+Jf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbamk+Jf"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XJJZ1wH4zF3Df
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 19:48:30 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y11-v6so6999143plt.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qSZC+eggdpDMiIzo3vE3ubtzhmbwNihKA0ZZgSKuLes=;
 b=nbamk+Jf9HiEAy+H77fDPUR9eQc0Ko2eey8VzDZ6wsjLzRR5Pj086F/cdiNFXUiBES
 5T0IbOvhSvpIEJU/oWIMSurD2H6AxU0qJq2qpRIkTwC41DrPgsLVKfNgaYQCIp9p6Lhh
 /eMegK3YR0+wxBs7ZDYfFAgk4y11Jzl2z0faubQD9NfzcTD+38QzXGATDyjOa9WI8kRF
 /YTCoTxr0sc2dVGiD/SAOD+e8dDOTYqaAPByTJf6FwhowEyNu59s8/2dRM24gcf7/eoN
 qx92rCSOWHhEC2ryWhCSWEb8mOZ3wn1/y8Qww918TtoRwwKppnYj/9jV1HscS7f2otgy
 Kv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qSZC+eggdpDMiIzo3vE3ubtzhmbwNihKA0ZZgSKuLes=;
 b=uV7zPH+TLH6BlwwrER0dGIj9ylMv0XL4zZQavSyXo/0bFjIgbm/e0Vpeg8BRmYEA/0
 w80DsgvKN6ozFx5utYRRBhg2v+/xl09use5QmcNUFoqavhdP3vMxeq7YkZ1NtR/fVRDl
 iXlQeXwEV6nh1DZeSfO334C+Sna2mF2VfURVClW4r9imunfaWy571FU6yOoNlr7ku4lT
 6FWRnW7eFZsiFG9pRpijXqNqHg6fIv9EWTzDNFvMhTv4NSWEeR7Td2Oi5tJauu90Sobr
 36V9vz9kvYoqp9BKxsHbzHf6PngWIY0Zi5TM3FiPD+mAx0xujCmJ2Cogk8uBRI6pqLom
 2v7w==
X-Gm-Message-State: ABuFfoi0vvl0GIAFkkyOhAabYAqNJ2bh0MZFxqHFvTRCd7RPWmlKWjD2
 brI6sOzcNvXzFIFxfoPkuQo=
X-Google-Smtp-Source: ACcGV60Mtmt9gJJLBTerrXEz0vtOmSV4L7j7x/fEGDShpitgcmZTsVllq+uf+SMbIvP2DQ54kT4TxA==
X-Received: by 2002:a17:902:bf09:: with SMTP id
 bi9-v6mr9039275plb.118.1539420508226; 
 Sat, 13 Oct 2018 01:48:28 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (61-68-185-28.tpgi.com.au. [61.68.185.28])
 by smtp.gmail.com with ESMTPSA id
 w187-v6sm631360pfw.3.2018.10.13.01.48.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 13 Oct 2018 01:48:27 -0700 (PDT)
Date: Sat, 13 Oct 2018 18:48:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a
 non-maskable interrupt
Message-ID: <20181013184815.6a80d196@roar.ozlabs.ibm.com>
In-Reply-To: <bb79aa53-8924-b334-93d6-fc907c8880e1@c-s.fr>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
 <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
 <20181009143241.026f3e7f@roar.ozlabs.ibm.com>
 <ccf61fc2-1f2e-7b67-c481-fa4c00a65aae@c-s.fr>
 <20181009153058.2564e7a1@roar.ozlabs.ibm.com>
 <0539727f-8420-3176-30b5-f4a6a1ccd4a4@c-s.fr>
 <20181009211650.042d428c@roar.ozlabs.ibm.com>
 <9f0cbf48-d278-08bf-cb32-8b9608768025@c-s.fr>
 <bb79aa53-8924-b334-93d6-fc907c8880e1@c-s.fr>
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

On Sat, 13 Oct 2018 08:29:48 +0000
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> On 10/11/2018 02:31 PM, Christophe LEROY wrote:
> >=20
> >=20
> > Le 09/10/2018 =C3=A0 13:16, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >> On Tue, 9 Oct 2018 09:36:18 +0000
> >> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >> =20
> >>> On 10/09/2018 05:30 AM, Nicholas Piggin wrote: =20
> >>>> On Tue, 9 Oct 2018 06:46:30 +0200
> >>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote: =20
> >>>>> Le 09/10/2018 =C3=A0 06:32, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>>>>> On Mon, 8 Oct 2018 17:39:11 +0200
> >>>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote: =20
> >>>>>>> Hi Nick,
> >>>>>>>
> >>>>>>> Le 19/07/2017 =C3=A0 08:59, Nicholas Piggin a =C3=A9crit=C2=A0: =
=20
> >>>>>>>> Use nmi_enter similarly to system reset interrupts. This uses NMI
> >>>>>>>> printk NMI buffers and turns off various debugging facilities th=
at
> >>>>>>>> helps avoid tripping on ourselves or other CPUs.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>>>>>> ---
> >>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 arch/powerpc/kernel/traps.c | 9 ++++++-=
--
> >>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 1 file changed, 6 insertions(+), 3 dele=
tions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/arch/powerpc/kernel/traps.c=20
> >>>>>>>> b/arch/powerpc/kernel/traps.c
> >>>>>>>> index 2849c4f50324..6d31f9d7c333 100644
> >>>>>>>> --- a/arch/powerpc/kernel/traps.c
> >>>>>>>> +++ b/arch/powerpc/kernel/traps.c
> >>>>>>>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs=20
> >>>>>>>> *regs)
> >>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 void machine_check_exception(struct pt_=
regs *regs)
> >>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 {
> >>>>>>>> -=C2=A0=C2=A0=C2=A0 enum ctx_state prev_state =3D exception_ente=
r();
> >>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int recover =3D=
 0;
> >>>>>>>> +=C2=A0=C2=A0=C2=A0 bool nested =3D in_nmi();
> >>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!nested)
> >>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nmi_enter(); =20
> >>>>>>>
> >>>>>>> This alters preempt_count, then when die() is called
> >>>>>>> in_interrupt() returns true allthough the trap didn't happen in
> >>>>>>> interrupt, so oops_end() panics for "fatal exception in interrupt"
> >>>>>>> instead of gently sending SIGBUS the faulting app. =20
> >>>>>>
> >>>>>> Thanks for tracking that down. =20
> >>>>>>> Any idea on how to fix this ? =20
> >>>>>>
> >>>>>> I would say we have to deliver the sigbus by hand.
> >>>>>>
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((user_mode(regs)))
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _exce=
ption(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 die("=
Machine check", regs, SIGBUS); =20
> >>>>>
> >>>>> And what about all the other things done by 'die()' ?
> >>>>>
> >>>>> And what if it is a kernel thread ?
> >>>>>
> >>>>> In one of my boards, I have a kernel thread regularly checking the =
HW,
> >>>>> and if it gets a machine check I expect it to gently stop and the d=
ie
> >>>>> notification to be delivered to all registered notifiers.
> >>>>>
> >>>>> Until before this patch, it was working well. =20
> >>>>
> >>>> I guess the alternative is we could check regs->trap for machine
> >>>> check in the die test. Complication is having to account for MCE
> >>>> in an interrupt handler.
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (in_interrupt())=
 {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_MCHECK_EXC(regs) || (irq_count=
() -=20
> >>>> (NMI_OFFSET + HARDIRQ_OFFSET)))
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic("Fatal e=
xception in interrupt");
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>>
> >>>> Something like that might work for you? We needs a ppc64 macro for t=
he
> >>>> MCE, and can probably add something like in_nmi_from_interrupt() for
> >>>> the second part of the test. =20
> >>>
> >>> Don't know, I'm away from home on business trip so I won't be able to
> >>> test anything before next week. However it looks more or less like a
> >>> hack, doesn't it ? =20
> >>
> >> I thought it seemed okay (with the right functions added). Actually it
> >> could be a bit nicer to do this, then it works generally :
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (in_interrup=
t()) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!in_nmi() || in_nmi_from_interr=
upt())
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic("Fata=
l exception in interrupt");
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =20
> >>>
> >>> What about the following ? =20
> >>
> >> Hmm, in some ways maybe it's nicer. One complication is I would like t=
he
> >> same thing to be available for platform specific machine check
> >> handlers, so then you need to pass is_in_interrupt to them. Which you
> >> can do without any problem... But is it cleaner than the above? =20
> >=20
> > For me it looks cleaner than twiddle the preempt_count depending on=20
> > whether we were or not already in nmi() .
> >=20
> > Let's draft something and see what it looks like. =20
>=20
> Ok, finaly I went to your solution, see below, as it avoids having to=20
> modify all subarch and platform specific machine check handlers.
>=20
> Unfortunately it doesn't solves the issue, it only delays it:
>=20
> oops_end() calls do_exit(), which has the following test:
>=20
> 	if (unlikely(in_interrupt()))
> 		panic("Aiee, killing interrupt handler!");
>=20
>=20
> So at the time being I still have no idea how to fix that, have you ?

Huh, I'm not sure. x86's MCE handling looks like it does this:

                /*
                 * We might have interrupted pretty much anything.  In
                 * fact, if we're a machine check, we can even interrupt
                 * NMI processing.  We don't want in_nmi() to return true,
                 * but we need to notify RCU.
                 */
                rcu_nmi_enter();

But I don't see why they don't want the full NMI treatment there. I
thought the whole point was to do everything so you would get e.g.,
the NMI-safe printk and so on.

The reason the in_interrupt checks work below is because the synchronous
trap handlers e.g., for BUG do not enter interrupt context so the
question is about they context they interrupted. Maybe the right way to
go is nmi_exit just before deciding to oops.

Perhaps we could ask lkml.

Thanks,
Nick
