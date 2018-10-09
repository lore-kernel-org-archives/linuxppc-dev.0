Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CE9C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:19:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18302204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoRJIZIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18302204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tx9l6VzFzF39g
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:19:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoRJIZIo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoRJIZIo"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tx4c4ntnzF39C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 23:14:56 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id l17-v6so762242pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=atSgHrnNu+91+0dyDv68os0nFpmFIyy5S/5zdKfmp04=;
 b=OoRJIZIoFQvK15FbFXKjiGVc030BA4p1m6WfDnNHugVtIAh6lqxyZ1izzzaFjMiMSj
 m6rNI8oSAvjoeu083dVI2hkq9owXIjqWDNf6yS+3R7+T7W04Mei//z334H2Emv8Dbzg3
 TgMzwSaY2WH8NovV3zSrv6yEeuNeMmcz3zTm5kiGoUcNWqqJGzjrbQl33r/fjnt4bo4h
 BdNUvFEHqod1GCdlI9w05AxrgaWgwDfYmBh3L+FWRT8XD9RUYQ3iMSVUaNu4uZj/Nu25
 l//jGIZYsL8mboOivWv9KdJvK3vBPyfMnkV40otyQGSP30XcXvyT7hP+T4+cLqNbgDpJ
 zXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=atSgHrnNu+91+0dyDv68os0nFpmFIyy5S/5zdKfmp04=;
 b=cwai7b0a6Rh7UHqJRZqXNfffhN9CbTpaVBAXOXGdKhevPzjaOvkv8e7u89/zeirxCN
 QDkckYMV4zBOdvSe22pHsrDWwT8JrVwDLTKS5eQNMCK0zaTTMRVqQ0xyqLFh+2MdCnLu
 P1o+37LfxWj7id3Y5sQZl2wKOzWhLT8Oi/JjooRVqqxom+gkf/i81UtV0vK8g3aBdyx/
 DCQKEiKSmNTiQHzH+0dRyaWgkqLAP2pXzK1eIPq9wNAbMpevyeO+IwgYEhR7fIEfAoO8
 mRdgjQfPI3TIkwIiHWMKZdwQPkQILDyCF4dbzd/zvzScfzI2i8Kc2nz/0pts6TsO/Fxn
 KeQw==
X-Gm-Message-State: ABuFfoiSm6vRN/egaD/JxHQRBXqYKwLwC2lOojQwKO/XaPdzPPSh7tAH
 fxoDN3A/jU6EnmqdbcOrCpk=
X-Google-Smtp-Source: ACcGV62C58vSS9oGpNiFW3t5S9jz9JMUXLgV4eANLJ6DO3ZWYoYu8WIu6bX2aUMzwzplbnVdTlesXQ==
X-Received: by 2002:a62:939d:: with SMTP id
 r29-v6mr29959815pfk.55.1539087294059; 
 Tue, 09 Oct 2018 05:14:54 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-121-136.tpgi.com.au.
 [60.240.121.136])
 by smtp.gmail.com with ESMTPSA id q2-v6sm69654360pfc.17.2018.10.09.05.14.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 05:14:53 -0700 (PDT)
Date: Tue, 9 Oct 2018 22:14:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a
 non-maskable interrupt
Message-ID: <20181009221446.33b926e3@roar.ozlabs.ibm.com>
In-Reply-To: <e4c9e983-db3e-ab50-c30b-9d538e202147@c-s.fr>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
 <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
 <20181009143241.026f3e7f@roar.ozlabs.ibm.com>
 <ccf61fc2-1f2e-7b67-c481-fa4c00a65aae@c-s.fr>
 <20181009153058.2564e7a1@roar.ozlabs.ibm.com>
 <0539727f-8420-3176-30b5-f4a6a1ccd4a4@c-s.fr>
 <20181009211650.042d428c@roar.ozlabs.ibm.com>
 <e4c9e983-db3e-ab50-c30b-9d538e202147@c-s.fr>
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

On Tue, 9 Oct 2018 14:01:37 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 09/10/2018 =C3=A0 13:16, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Tue, 9 Oct 2018 09:36:18 +0000
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> On 10/09/2018 05:30 AM, Nicholas Piggin wrote: =20
> >>> On Tue, 9 Oct 2018 06:46:30 +0200
> >>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >>>     =20
> >>>> Le 09/10/2018 =C3=A0 06:32, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>>>> On Mon, 8 Oct 2018 17:39:11 +0200
> >>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >>>>>        =20
> >>>>>> Hi Nick,
> >>>>>>
> >>>>>> Le 19/07/2017 =C3=A0 08:59, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>>>>>> Use nmi_enter similarly to system reset interrupts. This uses NMI
> >>>>>>> printk NMI buffers and turns off various debugging facilities that
> >>>>>>> helps avoid tripping on ourselves or other CPUs.
> >>>>>>>
> >>>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>>>>> ---
> >>>>>>>      arch/powerpc/kernel/traps.c | 9 ++++++---
> >>>>>>>      1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/tr=
aps.c
> >>>>>>> index 2849c4f50324..6d31f9d7c333 100644
> >>>>>>> --- a/arch/powerpc/kernel/traps.c
> >>>>>>> +++ b/arch/powerpc/kernel/traps.c
> >>>>>>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs *re=
gs)
> >>>>>>>     =20
> >>>>>>>      void machine_check_exception(struct pt_regs *regs)
> >>>>>>>      {
> >>>>>>> -	enum ctx_state prev_state =3D exception_enter();
> >>>>>>>      	int recover =3D 0;
> >>>>>>> +	bool nested =3D in_nmi();
> >>>>>>> +	if (!nested)
> >>>>>>> +		nmi_enter(); =20
> >>>>>>
> >>>>>> This alters preempt_count, then when die() is called
> >>>>>> in_interrupt() returns true allthough the trap didn't happen in
> >>>>>> interrupt, so oops_end() panics for "fatal exception in interrupt"
> >>>>>> instead of gently sending SIGBUS the faulting app. =20
> >>>>>
> >>>>> Thanks for tracking that down.
> >>>>>        =20
> >>>>>> Any idea on how to fix this ? =20
> >>>>>
> >>>>> I would say we have to deliver the sigbus by hand.
> >>>>>
> >>>>>        if ((user_mode(regs)))
> >>>>>            _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
> >>>>>        else
> >>>>>            die("Machine check", regs, SIGBUS);
> >>>>>        =20
> >>>>
> >>>> And what about all the other things done by 'die()' ?
> >>>>
> >>>> And what if it is a kernel thread ?
> >>>>
> >>>> In one of my boards, I have a kernel thread regularly checking the H=
W,
> >>>> and if it gets a machine check I expect it to gently stop and the die
> >>>> notification to be delivered to all registered notifiers.
> >>>>
> >>>> Until before this patch, it was working well. =20
> >>>
> >>> I guess the alternative is we could check regs->trap for machine
> >>> check in the die test. Complication is having to account for MCE
> >>> in an interrupt handler.
> >>>
> >>>          if (in_interrupt()) {
> >>>                   if (!IS_MCHECK_EXC(regs) || (irq_count() - (NMI_OFF=
SET + HARDIRQ_OFFSET)))
> >>>                       panic("Fatal exception in interrupt");
> >>>          }
> >>>
> >>> Something like that might work for you? We needs a ppc64 macro for the
> >>> MCE, and can probably add something like in_nmi_from_interrupt() for
> >>> the second part of the test. =20
> >>
> >> Don't know, I'm away from home on business trip so I won't be able to
> >> test anything before next week. However it looks more or less like a
> >> hack, doesn't it ? =20
> >=20
> > I thought it seemed okay (with the right functions added). Actually it
> > could be a bit nicer to do this, then it works generally :
> >=20
> >           if (in_interrupt()) {
> >                    if (!in_nmi() || in_nmi_from_interrupt())
> >                        panic("Fatal exception in interrupt");
> >           } =20
>=20
>=20
> Yes looks nice, but:
> 1/ what is in_nmi_from_interrupt() ? Is it (in_nmi() && (in_irq() ||=20
> in_softirq()) ?

  return (irq_count() - (NMI_OFFSET + HARDIRQ_OFFSET))) !=3D 0;

(basically just in_interrupt() with the nmi_enter undone)

> 2/ what about in_nmi_from_nmi(), how do we detect that ?

Oh good point, I'm not sure. I guess we could irq_enter() in the
nested case, I think that would make in_nmi_from_interrupt()
return true.

Thanks,
Nick
