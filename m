Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B2C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:48:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9459521925
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9459521925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4416N94GZDzDqgL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:47:53 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4416LG5YsFzDqHf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:46:14 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id v62so6469218otb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B0dPGRCNmKatrjVoIUq55VqUlKIBw5TV2xm1zcMqDZc=;
 b=WgYtXX6gidfT5LB8gAm5NVadUORHTr6kP0to6YwhjAwvDPY2LdcqPD1xVGoqPs7rsf
 1ZtK5fdbH+i69JVChgPFMDQH+x38dWuyp146iC5JowrZBTa2yC7Wgcx/A/f1JJA4EvGB
 yDhdZ822gYcqqy7iIKhGvEKJYVAKPlIX2g35nAgq7wQa+G8L2UzwWUnBXFDeMF+SENnl
 dI1dgOJHZ2IZJWAdJ+rzm167ZIaU+QcdNAKAQFz/WTm0zMdmWDdev/b2r/RQ7gsUxNAs
 UGjMHm2mn7Shgd/ZanNjJJ7ZA8W6VJWJNf9q9CdWTNhdDKEwG18XHxxItl38Ue4e2+jy
 4gAw==
X-Gm-Message-State: AHQUAub3wV+4oakDF4Hrw6dzXoJJcTjiC2A5CP18dbJhDwgREUfrSE/q
 ll83p1vG6yUniwWjJh6FoIQyvnyr0vHJfIItVxo=
X-Google-Smtp-Source: AHgI3IZgQHJSKnoLPZzKL9wKux0sc32X9U7EzUSc+1uPSTqORyddQJbB+r/ekzllKtB2ttYsv/vnqmvoBgfl+PifaWs=
X-Received: by 2002:a9d:7841:: with SMTP id c1mr5170654otm.354.1550220372529; 
 Fri, 15 Feb 2019 00:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20181208154624.6504-1-malat@debian.org>
 <CA+7wUswJy0z_+aytawQv6+1pOVvH2z8SfOz1sxziHtgjqZ1F9g@mail.gmail.com>
 <e95cb3ea-019f-28b0-0af0-ad8c80b3106b@c-s.fr>
In-Reply-To: <e95cb3ea-019f-28b0-0af0-ad8c80b3106b@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 15 Feb 2019 09:46:01 +0100
Message-ID: <CA+7wUswX34amxhJW827tm9zmSaq6T9NvEpxWpgcofGNL=3Kmxg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 9:21 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 15/02/2019 =C3=A0 09:11, Mathieu Malaterre a =C3=A9crit :
> > On Sat, Dec 8, 2018 at 4:46 PM Mathieu Malaterre <malat@debian.org> wro=
te:
> >>
> >> `pt_regs_check` is a dummy function, its purpose is to break the build
> >> if struct pt_regs and struct user_pt_regs don't match.
> >>
> >> This function has no functionnal purpose, and will get eliminated at
> >> link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINAT=
ION
> >>
> >> This commit adds a prototype to fix warning at W=3D1:
> >>
> >>    arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype =
for =E2=80=98pt_regs_check=E2=80=99 [-Werror=3Dmissing-prototypes]
> >>
> >> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >> ---
> >>   arch/powerpc/kernel/ptrace.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace=
.c
> >> index a398999d0770..341c0060b4c8 100644
> >> --- a/arch/powerpc/kernel/ptrace.c
> >> +++ b/arch/powerpc/kernel/ptrace.c
> >> @@ -3338,6 +3338,10 @@ void do_syscall_trace_leave(struct pt_regs *reg=
s)
> >>          user_enter();
> >>   }
> >>
> >> +void __init pt_regs_check(void);
> >> +/* dummy function, its purpose is to break the build if struct pt_reg=
s and
> >> + * struct user_pt_regs don't match.
> >> + */
> >
> > Another trick which seems to work with GCC is:
> >
> > -void __init pt_regs_check(void)
> > +static inline void __init pt_regs_check(void)
>
> Does this really work ? Did you test to ensure that the BUILD_BUG_ON
> still detect mismatch between struct pt_regs and struct user_pt_regs ?
>

My bad, I was unaware of GCC behavior for static inline in this case.
Sorry for the noise.
Original ugly patch does work though.
>
> >
> >>   void __init pt_regs_check(void)
> >>   {
> >>          BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=3D
> >> --
> >> 2.19.2
> >>
