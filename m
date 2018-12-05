Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E168C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 07:42:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECBB2082B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 07:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECBB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438rLL6vr8zDqLy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 18:42:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438rHx54FCzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 18:40:45 +1100 (AEDT)
Received: by mail-ot1-f67.google.com with SMTP id 81so17805949otj.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 23:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JNQhOhszSHcggNaD1SBayBjLbXetxd8vVoIXLJFOLls=;
 b=hk/oWL0WMnwx1nhzSUwLpa7HNVURRCJg8Ckpon7+v61NJyhMbz1LI3S/ZWtemoVXG5
 jcglHE0dKoYogfLcoD6NgQ10oH9jMLte9aRsWhZC5A/PsBnxrlnh1OOP7BmoXo7h30fY
 tntvpccFSkE6VT+KOxqydXrAX1w8ZmJ9fUACoaxrR2i1jNQlfmIkxpowppOZ91FA/yHL
 hF04fSc/u/WFqVDWq7bm8UdvB9Jfq43XFzwSh4d8FArWUwX0koxPAJTdvBcl0qoUYNv2
 rJ05DS4ixhB0HQA3mVVvdJa4PbKEyqSAbBP8iN1Q4Qwop0RvEvhYnsQHK+b6huD8txLP
 qU3w==
X-Gm-Message-State: AA+aEWb/PutWrMc7vcUW5plQm6NvLDQ8o8DEqROLqi9si/v+oYrT5MJM
 FWtFzKe+J6ON59IlO6Jwmqehcmi1nVCFk0iuFSg=
X-Google-Smtp-Source: AFSGD/UrN4JljRWTRvMnVubzH//Z4S09NkST192w6Ii7WNXmmFTNNpclxl8mDG/jGvBm7M+5sx76yyp2nKe6X0pHP6Y=
X-Received: by 2002:a05:6830:1289:: with SMTP id
 z9mr13755442otp.281.1543995643229; 
 Tue, 04 Dec 2018 23:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20181204205345.9514-1-malat@debian.org>
 <ba978bc1-e137-8abf-01a0-e1c68341a95f@c-s.fr>
In-Reply-To: <ba978bc1-e137-8abf-01a0-e1c68341a95f@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 5 Dec 2018 08:40:31 +0100
Message-ID: <CA+7wUswgOLp8z6-VOf86=dSf1PCOT4CW4RpMOC-J_p2xBiZkwA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Move the old 6xx -mcpu logic before the
 TARGET_CPU logic
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

On Tue, Dec 4, 2018 at 10:28 PM Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 04/12/2018 =C3=A0 21:53, Mathieu Malaterre a =C3=A9crit :
> > The code:
> >
> >    ifdef CONFIG_6xx
> >    KBUILD_CFLAGS          +=3D -mcpu=3Dpowerpc
> >    endif
> >
> > was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
> > explicitly in kernel compiles"). This change was acceptable since the
> > TARGET_CPU logic was 64-bit only.
> >
> > Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
> > also on PPC32") this logic is no longer acceptable after the TARGET_CPU
> > specific. It currently appends -mcpu=3Dpowerpc at the end of the comman=
d
> > line, after any TARGET_CPU specific:
> >
> >    gcc -Wp,-MD,init/.do_mounts.o.d ...
> >      -mcpu=3Dpowerpc -mbig-endian -m32 ...
> >      -mcpu=3De300c2 ...
> >      -mcpu=3Dpowerpc ...
> >      ../init/do_mounts.c
> >
> > Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> > Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> > Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142=
315.html
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/Makefile | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 8a2ce14d68d0..544b30667ea5 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -30,6 +30,10 @@ endif
> >   endif
> >   endif
> >
> > +ifdef CONFIG_6xx
> > +KBUILD_CFLAGS                +=3D -mcpu=3Dpowerpc
> > +endif
> > +
>
> Could you make the patch on top of my serie (ie after the change of
> CONFIG_6xx to CONFIG_BOOK3S_32 ?

Sure. That will defeat the point of the Fixes: line, but I guess who
cares anyway ? Will re-submit asap.

> The serie is in origin/next-test
>
> Thanks,
> Christophe
>
> >   ifeq ($(CROSS_COMPILE),)
> >   KBUILD_DEFCONFIG :=3D $(shell uname -m)_defconfig
> >   else
> > @@ -241,10 +245,6 @@ KBUILD_CFLAGS    +=3D $(call cc-option,-fno-dwarf2=
-cfi-asm)
> >   # often slow when they are implemented at all
> >   KBUILD_CFLAGS               +=3D $(call cc-option,-mno-string)
> >
> > -ifdef CONFIG_6xx
> > -KBUILD_CFLAGS                +=3D -mcpu=3Dpowerpc
> > -endif
> > -
> >   cpu-as-$(CONFIG_4xx)                +=3D -Wa,-m405
> >   cpu-as-$(CONFIG_ALTIVEC)    +=3D $(call as-option,-Wa$(comma)-maltive=
c)
> >   cpu-as-$(CONFIG_E200)               +=3D -Wa,-me200
> >
