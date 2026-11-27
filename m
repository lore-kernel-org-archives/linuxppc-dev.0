Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F812606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBYJOb7W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbLgH5KX9z2xqh;
	Fri, 27 Nov 2026 15:54:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795755275;
	cv=pass; b=j7P/xKSUy01dpKJiNieCKqx2u7F2pgQcbnPZ5EQUfJCBWQialVDYiAT7pvc6Fa++SaQw0W0SUhtxGFy3k575BQV4qejFSPtg6yHfVlbThXNEephIHfxAf8EJ393xxsqGYjvbukGzdNzVTCTYJfBiA2GGR6K1qUN/yO0vlzUaMk5F2IaERUFHJq/H1W8SJZAA/q2KtCQMVEKgIV4R8wreuICWu4FRpqIloEzwvyGebuTV06WNbtO/KmsNnDD2aGMw0wzr/TX+X7tA5Vugs1tzzwHdPDFwRlWjODTEBaE0A0Ec5leqPCGttal5Vq+pMQSL/AAs0Yge9IY8OMIJpACebA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795755275; c=relaxed/relaxed;
	bh=ca5GWDf4jgGneh61BwrLZEyvHZy4e93iWraBSkY9xes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbnWcASCfZqTN+WnlJGzoO2+0WkaQnz+7svN/82Q8P8DbGLU3gNlLGl0tDvedvEMqWufGa2OCUubgt14YN8XogqxnVed3IJgRcxtOxwU+PdfjMYQanlP6djDkCKP/SpKOQza+ZUnct/EBQFpgCt5U5GhkZ91pTD3237Sle5rk09NmrhFCoN9KHlFkTt7y1XqRQUw5Itx+lzLLTzLMVcpTw5B3A4og33TlCQqtQTEIAiYdA8bYsgxCY/KvJSfma2WWBRT2Q7QwhVuZSrWFCnOSKa+uzF4uY4050hyIPV2yCr1g1ZN4zttwmORdJdBEN9xIQNY3eaZXDSQwwsNASVJfg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBYJOb7W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=zhouzhouyi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FBYJOb7W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=zhouzhouyi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com [IPv6:2607:f8b0:4864:20::b133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbLgG0Yz4z2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 15:54:33 +1100 (AEDT)
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-67c24619b19so6420782d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 20:54:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795755270; cv=none;
        d=google.com; s=arc-20260327;
        b=jphXXfHcCzOTcH4n+lOmABO/bTDaw6RrDzfNL+PWwPA6FO2lsPlZ8pyo6l24zx5x7I
         F9TOqvIwQ8rtpQWvIFGL+iFrXdD1WExmUA4I+H04EBcuzZn6iW+DlWKJE23RvGOEV1/u
         63RqxZU3VmZyKrggeNz1T27W8Ng1XUIZ781+knt7YF1+R66p342Wx/hf8Edh+V2kvh32
         hTVjvLl0VEKx2dnSw92dKEUa8flcCHy96bbFn88qkhFWaXxvGe/qHiJUAOMQM65lp/Lz
         DL/CVdwEkLTj1aJITI+oQv7sk5LG2eGUUUsbyFNS8/7tzMSfmfCoYVL2bG3CTxHeivsz
         bcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ca5GWDf4jgGneh61BwrLZEyvHZy4e93iWraBSkY9xes=;
        fh=M+Ir8hX+tq0BehKL9wmyu2EEkfE0Pib+wY0KMiM6QaM=;
        b=Ew6oGUX7Lff9MLssnunxuWS92EvRfd+WDtf7/aiqGrjg5KS2Y3TVcTZVo55OIFJrF9
         pgQE5LyUPKHYujLwiOAoBL1nYUhNlOOmJFA7MWBlNrRgLuaalrmGfnPHK/MysKfD75Ys
         c2rqOeK/w4wCKZgjhqb7X1ZDMpA878RPvRINQybnbO7rUVA8hK1Y27/spN+S0ygIlrPg
         NKY4K+Ey/DraPiKORcOQ5ds/fwzh34Cw5hpUoVsdXReLR6MCSwBMIM70cf9QTpdew/6B
         KDgypJwz5S5DaYrBuq3xFAlsMLT6zubQ+Xty2daF3zwmYHFxyM3EhoC5RyzP7U1O31jp
         YxqA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755270; x=1796360070; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ca5GWDf4jgGneh61BwrLZEyvHZy4e93iWraBSkY9xes=;
        b=FBYJOb7WwucbSRyc+re3VEiT/VGej/1dsc/MQHhWFz8xEztVcY3NEDSlptQEm2V2Ub
         W/hYSa15FtQO1osIOKqFUSA/6jcSVaqBm/MqscJ23ebcYXnkpvRKzVSf6IYqXP+4ouml
         FsMdGlmrfE/6FeU9hkOjX2c/sDysXCa8IekboVJo02cV9xZIJJVCEDl3jmy/c7sCXgYp
         Nfi3FHjgRCn9fyuV1jMh4tq8gWnYFOig66qzBF+f57bZfQOydQUiqV2XHHLfZ52ITLVr
         MTr1qFPlce1/sCboU+NVrz1ox/BdMbbvNqJkWYrpzq18SQM8AqVbbkpNKaJigKF6tkJZ
         Hw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755270; x=1796360070;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ca5GWDf4jgGneh61BwrLZEyvHZy4e93iWraBSkY9xes=;
        b=0fbnBav6A89iwa+2zmC9kTUptKvCwMeIWeqvK1Csc+tffBSOifrK06O4xRoWwvIghD
         6X8A2yAMJyhjqFv2HH6kXCAxJ3r0pImmpMdDTynZC1FHKBC7up6RPkIvP418bdJV7CIS
         GGk5o65O+WAISHS1cqh1zW3HWhzUtTCbcwuybnmNYy5GoFgdTou9L11jFpuobj8UsBlD
         4KSCwda4b1GmriBxoBXFcBBOf+40fn0rbPBQkyr/jb+qDTUrLhgHYgQ+bMw8/fmR0NGO
         w/Nc5Jy48djoJR/JMiTi5tZUib4ecrE7uzDy1O5Vm5z2pQxCm0hYx+KJ/fyJT7S2KuOW
         Y4lg==
X-Forwarded-Encrypted: i=1; AL+hErEaXEiTj1vZW89HKN/kXjz6sYpXyy3Atgwjhyem22rbhYtIDzOY164cP72vp4nw8WcgwXrmqr5qujs96Gk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8umyQTYMi5xz6mHyiiSdYmcsEzwFlJQbqsRigOg20Yx0ZnwZlL
	Jjc0X89UQ4ezsegb0dAAVElmR5YzUoKK5JNPBCiIflVH1BzMV/lQ5EUX3Pf2ikskGzWBR78hGQQ
	VjtbRiSoLbcAOa2fFg45uUDgWIgpHiKY=
X-Gm-Gg: AZFdTZc/E5nocIQ/+7RwvNONmNqceVsA8Cp9Yij1+giKqiYhHkjLU9c8QqxlKhhraKp
	gx7WiGJdd6iatbaJkFuJ34xZbwzHbAo7XZwupKnG7f4htzgJYtEL6yxd39l0+Og3ya9gp7xtPIo
	hHj5m3uq0zqg9Z0QlGFWLk0lEqP+iCvb4ScjmdgPZT/AyJYYs8bXelqHv+a+PVbwFvJFs5UpTEk
	knSPunxzfDbh/rZyoskCru9aqIKqnjW/KC/dyWAdquo8Olr8RPetgERCysnou5ct7FnJx2T2YP7
	KDk7NCjVVRT0uJ+XosGM2GLPFBo5smTkkKSeg7VRxs41We4RdS1HbOgmKJNYCbgczAB0FYQS1zY
	Vn2Dyl/Qn/a6jSic7utvNckr5oUtwmnqMU5VQWpAiSH/BCuXRv4UXFS9DqJPQw7qcVRntBtMzOw
	1uaS4oZ2JZ16ofGFYX+HUBLh9dYQ==
X-Received: by 2002:a05:690e:169f:b0:67d:d725:3de with SMTP id
 956f58d0204a3-67df42c441dmr11888936d50.13.1795755270655; Thu, 26 Nov 2026
 20:54:30 -0800 (PST)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261127010124.848125-1-zhouzhouyi@gmail.com> <awkKKfv4ZrVYy0Ky@kernel.org>
In-Reply-To: <awkKKfv4ZrVYy0Ky@kernel.org>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Fri, 27 Nov 2026 12:54:19 +0800
X-Gm-Features: Aa3M54oR8NQ0Cxlg0KZcJLObFXILsGDr7yclfPLiAmakdtKmUmytZVv6tEJkr2Y
Message-ID: <CAABZP2y8nvTFG+0ChusQy=T6mJKtWf3VLmrCkRKTeH6Xq5+_PA@mail.gmail.com>
Subject: Re: [PATCH] tpm: ibmvtpm: Fix unused suspend callback with CONFIG_PM_SLEEP=n
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, lance@osuosl.org, rcu@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org, Li Jun <lijun01@kylinos.cn>
Content-Type: multipart/alternative; boundary="00000000000002d42806613adb66"
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000002d42806613adb66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank Jarkko for your review

I will prepare a 2nd version of patch

Thanks
Zhouyi

On Fri, Nov 27, 2026 at 12:42=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:

> On Fri, Nov 27, 2026 at 01:01:24AM +0000, Zhouyi Zhou wrote:
> > Discovered in the Open Source Lab of Oregon State University when runni=
ng
> > RCU torture.sh on a ppc64le VM.
> >
> > With CONFIG_TCG_IBMVTPM=3Dy and CONFIG_PM_SLEEP disabled,
> SIMPLE_DEV_PM_OPS()
> > omits the references to the system sleep callbacks. This leaves
> > tpm_ibmvtpm_suspend() unused and produces the following warning:
> >
> >   warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-functio=
n]
> >
> > Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
> > sees the callback references and can discard the unused PM code when
> > system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
> > called directly from tpm_ibmvtpm_send().
> >
> > Tested on PPC VM of the Open Source Lab
> > of Oregon State University.
> >
> > Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm powe=
r
> management")
> >
>
> nit: should not have empty line here.
>
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> >  drivers/char/tpm/tpm_ibmvtpm.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
> b/drivers/char/tpm/tpm_ibmvtpm.c
> > index 51c7e2add3d2..9840d0ebe6a3 100644
> > --- a/drivers/char/tpm/tpm_ibmvtpm.c
> > +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> > @@ -462,7 +462,8 @@ static const struct tpm_class_ops tpm_ibmvtpm =3D {
> >       .req_canceled =3D tpm_ibmvtpm_req_canceled,
> >  };
> >
> > -static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend,
> tpm_ibmvtpm_resume);
> > +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops,
> > +                             tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
>
> I'd keep these in same line.
>
> >
> >  /**
> >   * ibmvtpm_crq_get_next - Get next responded crq
> > @@ -714,7 +715,7 @@ static struct vio_driver ibmvtpm_driver =3D {
> >       .remove          =3D tpm_ibmvtpm_remove,
> >       .get_desired_dma =3D tpm_ibmvtpm_get_desired_dma,
> >       .name            =3D tpm_ibmvtpm_driver_name,
> > -     .pm              =3D &tpm_ibmvtpm_pm_ops,
> > +     .pm              =3D pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
> >  };
> >
> >  /**
> >
> > base-commit: 5f22fb20497f4983094131f00a734362300d22d2
>
> Otherwise, it's good.
>
> Br, Jarkko
>

--00000000000002d42806613adb66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank Jarkko for your review<div><br></div><div>I will pre=
pare a 2nd version of patch</div><div><br></div><div>Thanks=C2=A0</div><div=
>Zhouyi</div></div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 27, 2026 at 12:42=E2=80=AFPM=
 Jarkko Sakkinen &lt;<a href=3D"mailto:jarkko@kernel.org">jarkko@kernel.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Fri, Nov 27, 2026 at 01:01:24AM +0000, Zhouyi Zhou wrote:<br>
&gt; Discovered in the Open Source Lab of Oregon State University when runn=
ing<br>
&gt; RCU torture.sh on a ppc64le VM.<br>
&gt; <br>
&gt; With CONFIG_TCG_IBMVTPM=3Dy and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_P=
M_OPS()<br>
&gt; omits the references to the system sleep callbacks. This leaves<br>
&gt; tpm_ibmvtpm_suspend() unused and produces the following warning:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0warning: &#39;tpm_ibmvtpm_suspend&#39; defined but not use=
d [-Wunused-function]<br>
&gt; <br>
&gt; Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler=
<br>
&gt; sees the callback references and can discard the unused PM code when<b=
r>
&gt; system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also=
<br>
&gt; called directly from tpm_ibmvtpm_send().<br>
&gt; <br>
&gt; Tested on PPC VM of the Open Source Lab<br>
&gt; of Oregon State University.<br>
&gt; <br>
&gt; Fixes: fc0ddb3174b0 (&quot;char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtp=
m power management&quot;)<br>
&gt; <br>
<br>
nit: should not have empty line here.<br>
<br>
&gt; Signed-off-by: Zhouyi Zhou &lt;<a href=3D"mailto:zhouzhouyi@gmail.com"=
 target=3D"_blank">zhouzhouyi@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/char/tpm/tpm_ibmvtpm.c | 5 +++--<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibm=
vtpm.c<br>
&gt; index 51c7e2add3d2..9840d0ebe6a3 100644<br>
&gt; --- a/drivers/char/tpm/tpm_ibmvtpm.c<br>
&gt; +++ b/drivers/char/tpm/tpm_ibmvtpm.c<br>
&gt; @@ -462,7 +462,8 @@ static const struct tpm_class_ops tpm_ibmvtpm =3D =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.req_canceled =3D tpm_ibmvtpm_req_canceled,<=
br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm=
_ibmvtpm_resume);<br>
&gt; +static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume)=
;<br>
<br>
I&#39;d keep these in same line.<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* ibmvtpm_crq_get_next - Get next responded crq<br>
&gt; @@ -714,7 +715,7 @@ static struct vio_driver ibmvtpm_driver =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D tpm_ibmvtpm_remove,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.get_desired_dma =3D tpm_ibmvtpm_get_desired=
_dma,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D tpm_ibmvtpm_driver_name,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0.pm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D &amp;tpm_ibmvtpm_pm_ops,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.pm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D pm_sleep_ptr(&amp;tpm_ibmvtpm_pm_ops),<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /**<br>
&gt; <br>
&gt; base-commit: 5f22fb20497f4983094131f00a734362300d22d2<br>
<br>
Otherwise, it&#39;s good.<br>
<br>
Br, Jarkko<br>
</blockquote></div>

--00000000000002d42806613adb66--

