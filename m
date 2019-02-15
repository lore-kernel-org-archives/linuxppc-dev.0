Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7768AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:13:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98F9218FF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98F9218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415cL736mzDqXb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:13:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415ZW4943zDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:11:47 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id v62so6342595otb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3cA10avh2RJqVKzPkWhDR1H+JTQFljMSI7C8GFBdv68=;
 b=TnhyxrQwYZA1vDy/9klGf1EzQ0BoILCZq+3ViFsFK7hvP/7VD0HNeRWCI9KgvooRsZ
 GfrCB97OahhMgDYkFX/cNETBhJ6Ngz1J7JX43xoSWpQLZ3YsheCosFf56558K+1N5Jxm
 V3vcAX4rMzU1mF1UNHR/i81D9E/99/BgfJSQ2unzgaSLNXV3p5m6QiaLCM+l1qtfXc8G
 JnIc44ivRTghT2x5l0+201rkS1ve2zSbc4zihRU7IVh0FCaqfrRqy2ueppyXM7B1QfJ0
 RaDLNid96Qyq3G2Rc7g90y77MGd0tTjvL/YWGQ1tEGRWQlSM7SrSX+G1Z1PvSy8i822g
 HB4g==
X-Gm-Message-State: AHQUAuaRwHsdNeaRlT3itzR7JOMn6wN/beX/vSjqwLvcXMm3HTEEYQCA
 Xs5HLCsFA+SzUriXkPLtAoOv7Um2Th1Nzoh5QmY=
X-Google-Smtp-Source: AHgI3IZHGRbHp85QSkjsm/PAG/vOAXBxQ6nW2o9ez2D+Wch/1sVS8llpq8a4EHj6Z+hG1Zdy1CikmZcMS/w2H6j2vxQ=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr4671323otk.281.1550218305450; 
 Fri, 15 Feb 2019 00:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20181208154624.6504-1-malat@debian.org>
In-Reply-To: <20181208154624.6504-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 15 Feb 2019 09:11:34 +0100
Message-ID: <CA+7wUswJy0z_+aytawQv6+1pOVvH2z8SfOz1sxziHtgjqZ1F9g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
To: Michael Ellerman <mpe@ellerman.id.au>
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
 Paul Mackerras <paulus@samba.org>, Oleg Nesterov <oleg@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 8, 2018 at 4:46 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> `pt_regs_check` is a dummy function, its purpose is to break the build
> if struct pt_regs and struct user_pt_regs don't match.
>
> This function has no functionnal purpose, and will get eliminated at
> link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>
> This commit adds a prototype to fix warning at W=3D1:
>
>   arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype for =
=E2=80=98pt_regs_check=E2=80=99 [-Werror=3Dmissing-prototypes]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index a398999d0770..341c0060b4c8 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3338,6 +3338,10 @@ void do_syscall_trace_leave(struct pt_regs *regs)
>         user_enter();
>  }
>
> +void __init pt_regs_check(void);
> +/* dummy function, its purpose is to break the build if struct pt_regs a=
nd
> + * struct user_pt_regs don't match.
> + */

Another trick which seems to work with GCC is:

-void __init pt_regs_check(void)
+static inline void __init pt_regs_check(void)

>  void __init pt_regs_check(void)
>  {
>         BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=3D
> --
> 2.19.2
>
