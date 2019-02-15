Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F5C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:12:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D23D218FF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D23D218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415ZF1qHtzDqZD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:11:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415XR6CF5zDqSY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:09:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4415XR4gxDz8sw2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:09:59 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4415XR4JMRz9s7h; Fri, 15 Feb 2019 19:09:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4415XQ6rzlz9s7T
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2019 19:09:58 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id 98so15231528oty.1
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2019 00:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1SrFt8aq3wwPpZ4nluBP2vLNmqlrd6Q/47bBqhHE1E4=;
 b=ib8z869OWLtbDaINjkn1WeL/0WjZNjgXIuQaCNB8xVznakxtoPCrrs5+Q4fe1CuXtJ
 bzHEfX3tF1Q+myKAggg5iZPRpKJPx110WEDwz+fI1w9r/aHVU84734s+0GDuppK1NQc0
 9owOuLdMSZcsvAq6hLZTuj0M1VGL8qR6X+s6Jj7XfNUj/9WwQtM19PW5xnMh2d9WIxte
 oO1WIndCkwDgLYKgaKk/RfjVGqSMBvu/fiE21WhIkzjWwIrsW9v82gI5X3lZvmxJpGOJ
 dd9sGuO7heW3KyP/JlBTVqtme/5tmObbTfPzfokc+gnk8QepjxF+IYoTozW4KbJvbKwx
 5ueg==
X-Gm-Message-State: AHQUAuZ6L9DXWPhzSuYn+Xu3b9hnBX5Qt6M/p+8/ZIXk2mfed7FzxdxD
 g3/weSYb5k7YRebnKV4oEEuwg3Qp70rmAB45xXFGDnP6
X-Google-Smtp-Source: AHgI3Ib2z4+tjwwrEwgWbCW2xnyzi7dvwkr1TGldP5oXE68Srj5ulz/tpyHr41lqRD+c5QvIRIKFhBM8WaqRMC/IV+4=
X-Received: by 2002:aca:f5d7:: with SMTP id t206mr4923215oih.141.1550218196341; 
 Fri, 15 Feb 2019 00:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20190215061400.20302-1-mpe@ellerman.id.au>
In-Reply-To: <20190215061400.20302-1-mpe@ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 15 Feb 2019 09:09:45 +0100
Message-ID: <CA+7wUszvErrmyo9jAuPk0dtvwKd3cw4jSb04z5Q4DkGEjGiY7w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
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
Cc: linuxppc-dev@ozlabs.org, Meelis Roos <mroos@linux.ee>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 7:14 AM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
>
> GCC 8 warns about the logic in vr_get/set(), which with -Werror breaks
> the build:
>
>   In function =E2=80=98user_regset_copyin=E2=80=99,
>       inlined from =E2=80=98vr_set=E2=80=99 at arch/powerpc/kernel/ptrace=
.c:628:9:
>   include/linux/regset.h:295:4: error: =E2=80=98memcpy=E2=80=99 offset [-=
527, -529] is
>   out of the bounds [0, 16] of object =E2=80=98vrsave=E2=80=99 with type =
=E2=80=98union
>   <anonymous>=E2=80=99 [-Werror=3Darray-bounds]
>   arch/powerpc/kernel/ptrace.c: In function =E2=80=98vr_set=E2=80=99:
>   arch/powerpc/kernel/ptrace.c:623:5: note: =E2=80=98vrsave=E2=80=99 decl=
ared here
>      } vrsave;
>
> This has been identified as a regression in GCC, see GCC bug 88273.

Good point, this does not seems this will be backported.

> However we can avoid the warning and also simplify the logic and make
> it more robust.
>
> Currently we pass -1 as end_pos to user_regset_copyout(). This says
> "copy up to the end of the regset".
>
> The definition of the regset is:
>         [REGSET_VMX] =3D {
>                 .core_note_type =3D NT_PPC_VMX, .n =3D 34,
>                 .size =3D sizeof(vector128), .align =3D sizeof(vector128)=
,
>                 .active =3D vr_active, .get =3D vr_get, .set =3D vr_set
>         },
>
> The end is calculated as (n * size), ie. 34 * sizeof(vector128).
>
> In vr_get/set() we pass start_pos as 33 * sizeof(vector128), meaning
> we can copy up to sizeof(vector128) into/out-of vrsave.
>
> The on-stack vrsave is defined as:
>   union {
>           elf_vrreg_t reg;
>           u32 word;
>   } vrsave;
>
> And elf_vrreg_t is:
>   typedef __vector128 elf_vrreg_t;
>
> So there is no bug, but we rely on all those sizes lining up,
> otherwise we would have a kernel stack exposure/overwrite on our
> hands.
>
> Rather than relying on that we can pass an explict end_pos based on
> the sizeof(vrsave). The result should be exactly the same but it's
> more obviously not over-reading/writing the stack and it avoids the
> compiler warning.
>

maybe:

Link: https://lkml.org/lkml/2018/8/16/117

In any case the warning is now gone:

Tested-by: Mathieu Malaterre <malat@debian.org>

> Reported-by: Meelis Roos <mroos@linux.ee>
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/ptrace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 7535f89e08cd..d9ac7d94656e 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -567,6 +567,7 @@ static int vr_get(struct task_struct *target, const s=
truct user_regset *regset,
>                 /*
>                  * Copy out only the low-order word of vrsave.
>                  */
> +               int start, end;
>                 union {
>                         elf_vrreg_t reg;
>                         u32 word;
> @@ -575,8 +576,10 @@ static int vr_get(struct task_struct *target, const =
struct user_regset *regset,
>
>                 vrsave.word =3D target->thread.vrsave;
>
> +               start =3D 33 * sizeof(vector128);
> +               end =3D start + sizeof(vrsave);
>                 ret =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf, &=
vrsave,
> -                                         33 * sizeof(vector128), -1);
> +                                         start, end);
>         }
>
>         return ret;
> @@ -614,6 +617,7 @@ static int vr_set(struct task_struct *target, const s=
truct user_regset *regset,
>                 /*
>                  * We use only the first word of vrsave.
>                  */
> +               int start, end;
>                 union {
>                         elf_vrreg_t reg;
>                         u32 word;
> @@ -622,8 +626,10 @@ static int vr_set(struct task_struct *target, const =
struct user_regset *regset,
>
>                 vrsave.word =3D target->thread.vrsave;
>
> +               start =3D 33 * sizeof(vector128);
> +               end =3D start + sizeof(vrsave);
>                 ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &v=
rsave,
> -                                        33 * sizeof(vector128), -1);
> +                                        start, end);
>                 if (!ret)
>                         target->thread.vrsave =3D vrsave.word;
>         }
> --
> 2.20.1
>
