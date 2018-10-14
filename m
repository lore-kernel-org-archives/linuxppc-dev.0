Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AEDC6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 12:59:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9612077C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 12:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iABS1Buu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9612077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Y1r82p5ZzF37q
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 23:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iABS1Buu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=lantianyu1986@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iABS1Buu"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Y1nW6qrhzF1XK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 23:57:35 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id g2-v6so7867435pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QOh3/rAAMNg6qWlR3ockjsVxuDsHmKYoJ0FCAyRqfh4=;
 b=iABS1BuuIxLgQKHch2Dlc2zTZiMd5aUIeqllYaFVgeR7hoGPuvGN0BBSP3H1vOGBVn
 KnNmfDgbSWbJo+V1YyBGzEulGIQI4dKrQDtk/qd41E6RZlIfP2uxnp0+oBAtOmE4lG68
 x70+eGZP6uqx3qIucJWNiOGFfutGJX0zNuk02P85pVbzAfz/cdNnL7N6mjQ9px/1vLGR
 0JCrXbMG1TROv4dsnHtWFYQhX2S77DifFBaPTKHxH7wYOLvmaT9qB/OI8BYNCWShL/X9
 mFcN7LHngJUy/JxGOyjI6S48h8FN8nkPma5iSqUuYea8u+8O4wp45CoWdE8sNLx2J/u+
 jenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QOh3/rAAMNg6qWlR3ockjsVxuDsHmKYoJ0FCAyRqfh4=;
 b=eNZ7l4YfO9+8jaS9C0jjc8v0L6FiHtAXkaEjkhNEEDZOFNZDbxYpl6gfIWLY49bP+w
 s5Q8LWcf8CAgDFikhFeoH5tGo89b8SUWxpqQa/bHqbJtXPjsv59r0FTQ4S9MrDZUBK6i
 /8fN7qny17kEkPiI4/EHSipAtxUuMgnyzY2xR/p8v0VpYRdvpmKKnYaI2hgQ+cPwKC15
 L8F2L7mozCE6dV95U11MMfxlm0YbHcC0orbiOh7kSGJ48djoTfhVzqnP1J+eS0qslvoA
 6dddSQvvB5dDpnd3Qpt3xcX9/isXA9HEUSHShmnALzgJ5O3LGEvOmtFPHxVGda50B3WU
 jvXQ==
X-Gm-Message-State: ABuFfoivtdTGJAu8N8u7LYi3tzs4jLI/JwPxAlf6C/4XoJk6n+L1W+rs
 wx6C6w0J2rOH3wWShL0YUHcUBfdZwUx+YTldXK4=
X-Google-Smtp-Source: ACcGV60zf0Hi3mZezp2hDEDaLIs17dXAsuvuc8YysL8650sEBPqrqgQAvzNYudsoqEWRyq2I1MEzwEjavgjecjVnptw=
X-Received: by 2002:a62:8910:: with SMTP id
 v16-v6mr13526160pfd.106.1539521853925; 
 Sun, 14 Oct 2018 05:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
In-Reply-To: <1BDC7949-CFED-46C2-9D05-42864B0AD0F0@oracle.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Sun, 14 Oct 2018 20:57:22 +0800
Message-ID: <CAOLK0pxC9S7YzoC-YmE7bw2VyPEZfxZSCOW+hW+t3Mi8V6Y-RQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
To: liran.alon@oracle.com
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
Cc: linux-mips@linux-mips.org, linux@armlinux.org, kvm <kvm@vger.kernel.org>,
 Radim Krcmar <rkrcmar@redhat.com>, catalin.marinas@arm.com,
 will.deacon@arm.com,
 "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
 the arch/x86 maintainers <x86@kernel.org>, michael.h.kelley@microsoft.com,
 Ingo Molnar <mingo@redhat.com>, jhogan@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, devel@linuxdriverproject.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 christoffer.dall@arm.com, ralf@linux-mips.org, paul.burton@mips.com,
 Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Liran & Thomas:
              Thanks for your review.


On Sun, Oct 14, 2018 at 5:20 PM Liran Alon <liran.alon@oracle.com> wrote:
>
>
>
> > On 14 Oct 2018, at 11:16, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sun, 14 Oct 2018, Liran Alon wrote:
> >>> On 13 Oct 2018, at 17:53, lantianyu1986@gmail.com wrote:
> >>>
> >>> +
> >>> +static inline bool kvm_available_flush_tlb_with_range(void)
> >>> +{
> >>> +   return kvm_x86_ops->tlb_remote_flush_with_range;
> >>> +}
> >>
> >> Seems that kvm_available_flush_tlb_with_range() is not used in this pa=
tch=E2=80=A6
> >
> > What's wrong with that?
> >
> > It provides the implementation and later patches make use of it. It's a
> > sensible way to split patches into small, self contained entities.
> >
> > Thanks,
> >
> >       tglx
> >
>
> I guess it=E2=80=99s a matter of taste, but I prefer to not add dead-code=
 for patches
> in order for each commit to compile nicely without warnings of declared a=
nd unused functions.
> I would prefer to just add this utility function on the patch that actual=
ly use it.
>
> -Liran
>

Normally, I also prefer to put the function definition into the patch
which use it.
But the following patch "KVM: Replace old tlb flush function with new
one to flush a specified range"
and other patches which use new functions will change a lot of places.
It's not friendly for review and
so I split them into pieces.
--
Best regards
Tianyu Lan
