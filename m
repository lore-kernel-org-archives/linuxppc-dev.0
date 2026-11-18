Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515ED606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LusEqtxq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTvL95jpQz2y2T;
	Wed, 18 Nov 2026 19:05:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b136" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794989153;
	cv=pass; b=ic7IAgy49mCnTYokAOZx15wmZrWd4Ff/7u1TzboQaK4kN1xSjpt+M0mfMrxy3o2e21pCxjErJr6+IW0ZLLykQa9Ac7Y4AB4YKfvbWkjtIZZx25yOfB5Qqyvb/nisCbu68HqxhtHsnbH99VIHQMKWbLg/NHOod34/iJBZv1+/pjo1qhE3Dpl6m7qE+VkesAlBcTuNCUm4GzhBEUYko9Sztwn2mE5RdmgGnafcXfPa4wVevF3rAITbOwPscwiXgvijUEc6Mlf+D8yYlvKQad0Y6WmpbFkrIBCqqymABNbSBua+qHxs8ecTQuElKlaBnF+AYLHDZ6jiC1R10Gezn5FSrw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794989153; c=relaxed/relaxed;
	bh=MUIaPENjMzjeulHsfKVIa48wZ7dv9KJpO2DKgAnakYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEWS/ZnAXamZf7LpkxfcXpg7XYTiJ2OVTyjnlYxRXwqX9VtuFNAM4XPhPij8eaqYTOCAQNsz9aUqJmH75G2y3pQJ7tXzGF+9DFFEJ901UMRPphExqXrqak2f3lYu81S+yjtL3v5Zjepjbhg7Cnlfyn+h9nKtqAn99ob9K+kQCYw7ytAo9Prv0ekz2tTohOHRyEGEsba8h+GKgg1vZNhH6dv5UVFWqBSD0dXKRx8miKidcwScpNntmwd9LPAxh+Lz9mtFKT+ZOKYTYhvCv/nLVuDf5ociRjI98WQ0NL9QZsXMKRuKjPrQgbcWzXACzY91oUBc/Uzn2YFgVkPb+Wpw4Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LusEqtxq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LusEqtxq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com [IPv6:2607:f8b0:4864:20::b136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTvL72ZPyz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:05:50 +1100 (AEDT)
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-679a2b5fe87so630716d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794989148; cv=none;
        d=google.com; s=arc-20260327;
        b=SO4KJBmnrcnBqiEcS6SANKoIGV/AxNzaDl1iGtvrzVLxz9ZDiUeXD2ks7zb4vtU831
         0Hr2712B66AprYFYwbLnyfQlBcqebhIDI7s51mRyW7Yi2kZthJbImEIYhsCvQkmPp/2M
         IJwnlUROoDSJUX9foC092TcgYld/XV7qqIAbZ8iusQoJ11WIN6Os0DzrmruKalbBX1/e
         /Z6IdlkbqPkebu3lyWFFESX2IS6/9VgaDsvBip9iGhn6TfhYKU9hFv1P4WY4wiHX2CJb
         n6uR8XcSosNi5dFlJgw0JT02gD9uY1s3s+d/MbzShdFDMnSBOycxNWjJ0rvuU1sX+WmB
         Ybjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MUIaPENjMzjeulHsfKVIa48wZ7dv9KJpO2DKgAnakYo=;
        fh=mONTQSS3TzDOuwrdrbHuF0F3K/kRAP9mzcly0YpBW4g=;
        b=BXNsd1A51rRoc13X5243ZG55VHx+ZkqHKtAc8lplB9A7Tki/pM8u2TJb7sfeAkzmgr
         TqgxOYXT9KFvh+LEJsB6kjl+tu9CXy1GGmWr06uBxTHGdZddwV/JHvIsNejgA8UvRMZE
         H4uuyCBtIelSFozO2TaOImtgRgP/Ht9XRtjv7NpCtf6xzWxGoCUd1YnlEm0YpnDr72aZ
         nEz4XqjjEjcMH2Fxlpc6i8AQMMrDWGdBltRm34ae1Lcz1bZ907aWVKg6mGHbHWGz8cBa
         By+IZdqIS8VCjCqkJ89e/hpysS1vQY0KvmfZ+fHj37O6atureBkJWIyT3gRG3QBSQoOb
         7vng==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794989148; x=1795593948; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUIaPENjMzjeulHsfKVIa48wZ7dv9KJpO2DKgAnakYo=;
        b=LusEqtxqKykGhez1lagrerpbGdkmfbvTSghUQgHp0DVmF5z9K++VxVTg0UOWm+1XuO
         9axmnQN1AHMZGtJauFlbSPE5A8Ar8EU2PPAMTtaJuyb7ijrWnUz7qygB7F29zIrGcqFn
         8SlYqKHVrMDx5/HDJH5zrSFytmyx91F5wmEDxB4mISRnumuXikOStuvu5Vmz0Yg0ZRAP
         ZGBrX/7bOHP1KQwnVvqoJCJoySL83yq1BX/d92gMJ+3pKNxJ3odj7Zk2SLpicAWrPQu6
         7nRIDOjiUPz6+4RTCVA1G+woaCIjy4OZQ7cJa6plIcqZHEpqWDaSx3HMXKGTM3eVLx3A
         +tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794989148; x=1795593948;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MUIaPENjMzjeulHsfKVIa48wZ7dv9KJpO2DKgAnakYo=;
        b=jhMHUXEeYKCZP33gua44qkwywlNerLANvP+ICfjiDuQa8coSJWbn/W3znXmqkN9oId
         QB4sUEYKlf7L3X/ICnVzKZbHQSOHRPCTK9vw5j75K0ZUaZ/+EwdRujZaBrSQOH5keNBG
         tGxSQ7av22HCTUZi0OCM6ASGUJqdqZWxzHECjmrfWMWRJOpa/rKKlKO+rUrYPMptEFMg
         d6asvuCsPgmYmFJB/CvhFBCiGIDMtX35GostDC2ZmZuHYycgBlHhilhzIFeVCw8t30QD
         +89s/yXo4JDYqEqUbVm7p6oqOdpeb0TmcfZQCRYQVes/qkrg6T9JPsSiZ4rPK945dQAW
         2Q5Q==
X-Forwarded-Encrypted: i=1; AL+hErE5BrDm5LMyLelRPlsHO8UgGZ00pFnbqCPuYgiwxzL7rl58QyhfgU6WYTKiLuiD57JuNMScwnIDOeenPfo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9ipqX70GXtGJFXKIfejXYOkgj7OdLdBTozLkor33+ZvgNtlaP5
	fXzT3rQT4in+LjmKVEFvZDIEs6wBhU0J/oG+b7mEazdwSFr+pVP6GeTYqE4mA62uPQZS/lXyVxJ
	xLfDfnar2W0QafHDQuelXizbOfeq98xuHC0NNEwo=
X-Gm-Gg: AZFdTZcYUtLeUetOBPva9ypHYiClG68oBAerWYqLIdXkgbYAr0R4cAw1SU6D0pTMl2W
	2PHa9E54uv6+luNO3NIVO40L9RxHynjGfWM+lUl6ZvkH1vMBlpeca9Df3ZXC8lIDHwoPmKXirD6
	2rH+B+ydshjsCeiHCHaU2tr27EX7Et3c7ig2bhLcZahW3Zq9JOJSkYRcWpAINi7VdX9KZNzmxTK
	WfGvyaB0QRYpCF2C3W3VTnAYncDxGazsWKJ8WbRly3AcWpuzZFE1bNd3/4iVZy5ABwBTA5MhSZf
	oPgPE0GVV8waRnaFB4BKFNkeohRi/RmC6ncu02lT84clKTkVuzh5tfXdo2MlmFEq2UneuZtUjV1
	mWc7sf/saEx96rzgOr5fhDtMb+U8hJ6R4goDCy58RG2d3ORZVEjbyGw==
X-Received: by 2002:a05:690e:440d:b0:675:6f49:f5a0 with SMTP id
 956f58d0204a3-67dd400597bmr377211d50.141.1794989147498; Wed, 18 Nov 2026
 00:05:47 -0800 (PST)
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
References: <20260807084050.25216-1-yadavgaurav386@gmail.com> <a4na92vc.ritesh.list@gmail.com>
In-Reply-To: <a4na92vc.ritesh.list@gmail.com>
From: Gaurav Yadav <yadavgaurav386@gmail.com>
Date: Wed, 18 Nov 2026 13:35:36 +0530
X-Gm-Features: Aa3M54o1jToGLyxqk2f4gkQ1VzxxFI2IvEFSK0PtoIwka3iJZ12LPKmtALRzYWg
Message-ID: <CANo8Ldu_Y=GduFxxukfbNQT-MOQmR8N0V8evYQPpO2+i1L1hSQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000832f380660887a31"
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000832f380660887a31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Ritesh.

Adding the tag and sending a v2 shortly.

On Sun, Nov 15, 2026 at 9:17=E2=80=AFAM Ritesh Harjani <ritesh.list@gmail.c=
om>
wrote:

> Gaurav Yadav <yadavgaurav386@gmail.com> writes:
>
> > Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
> > and remove the corresponding TODO comment.
> >
> > Using vcpu_err() provides vCPU-aware logging context, making it easier
> > to associate register dumps with specific vCPU instances in logs.
> >
> > Signed-off-by: Gaurav Yadav <yadavgaurav386@gmail.com>
> > ---
> >  arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
>
> Fair enough, this will print vcpu_id as an additional info here.
> Looks good to me. Please feel free to add:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
>

--=20
With Regards
Gaurav Yadav
+919310150558

--000000000000832f380660887a31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, Ritesh.<br><br>Adding the tag and sending a v2 sho=
rtly.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Sun, Nov 15, 2026 at 9:17=E2=80=AFAM Ritesh H=
arjani &lt;<a href=3D"mailto:ritesh.list@gmail.com">ritesh.list@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ga=
urav Yadav &lt;<a href=3D"mailto:yadavgaurav386@gmail.com" target=3D"_blank=
">yadavgaurav386@gmail.com</a>&gt; writes:<br>
<br>
&gt; Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()<b=
r>
&gt; and remove the corresponding TODO comment.<br>
&gt;<br>
&gt; Using vcpu_err() provides vCPU-aware logging context, making it easier=
<br>
&gt; to associate register dumps with specific vCPU instances in logs.<br>
&gt;<br>
&gt; Signed-off-by: Gaurav Yadav &lt;<a href=3D"mailto:yadavgaurav386@gmail=
.com" target=3D"_blank">yadavgaurav386@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------<br>
&gt;=C2=A0 1 file changed, 12 insertions(+), 13 deletions(-)<br>
<br>
Fair enough, this will print vcpu_id as an additional info here.<br>
Looks good to me. Please feel free to add:<br>
<br>
Reviewed-by: Ritesh Harjani (IBM) &lt;<a href=3D"mailto:ritesh.list@gmail.c=
om" target=3D"_blank">ritesh.list@gmail.com</a>&gt;<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"2"=
>With Regards</font><div><font size=3D"2">Gaurav Yadav</font></div><div><fo=
nt size=3D"2">+919310150558</font></div></div></div></div></div></div></div=
>

--000000000000832f380660887a31--

