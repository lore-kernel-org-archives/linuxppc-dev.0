Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3E606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LpFQGe96
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQFr81XBjz2yLY;
	Thu, 12 Nov 2026 20:45:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794476744;
	cv=pass; b=jjC1lY3so8eJ2qRNgRuhZu37AzIvSB+ubIKOq2xO5238AHDa0AWFpS0C9GdUTEyUh0fvcWrQzmKr0KbIoj64POBx1ou8AxjRN14KekbgK9WWx0nnEY2EHBkgqIsVFlPiemCEdkpl02q8BCwVr/z8ZspjLta4SeEzzO1+9Ln+Iz27tbUzPvS8N616Yaf8DqJhBDoRDOl1xOlMiuLNyi+XpgcfCPSMNcIxqC2wfPLCaiG84SzshH61HTS+4LMQNWFBt9wjWbCwMKLP0Z6HlmG3IUki3SJkz0vN2f8yuZ9mLbhcu8nIHEHvPpESXpTN8I+OhFvP+EAES4dufhtkB92gbw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794476744; c=relaxed/relaxed;
	bh=pUztPGYiaiQLwA4o+66h/TGEfoZCdk+MYBdySUZIrnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krJcuq7B+5jJ0qYpuo6KhN966TeKXtQFWhWNeUM6aM1DJKopA8TO7EKCwucW1WhvPKtankVqkvTh/K83HGWF9q87gzdU8W+PDkLj6R67tVs7pV6pxQkvbHoili+xltFwZehcx7NW9gtWQzhoSBaSl0b4gdZb36GNeylAffWsURYAmYfHRz8RTJfeIyNPfAJsW2u5RA7v582x8Q3GpSldKHdJZF0ABp3DPbrU0Vbyl8ii+YpUsOAtqKppynFobFa/7EReHnOPzZ/DotmPAczeThWt2TrDIgMQje1cep5rrw+6ZWguXN5mnqt3y0bpjE7EyKAtrwerHAGH9CR4p6qxVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LpFQGe96; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LpFQGe96;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQFr71ntkz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 20:45:42 +1100 (AEDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-8b2d14968c9so44487587b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 01:45:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794476739; cv=none;
        d=google.com; s=arc-20260327;
        b=NIjM0X1siZJJKIS9urpfLs/iVeY5VxuPyyMEIeAp/YUGt/De9piU5VWJvLu1eF+6mQ
         xu9YeCje7079ZmTaMkRNckJqiOzrPv/R6epuGnMUqmXJ34TojlXBAfHA5TAdn9lbcXl9
         eGH+yS2M2hz3tNtCG+SUEcHAk7axw/gc5QHz2YPYCa6O7T+k7f5YvZCFsou57NDiQapy
         2couvxmoMLS2VZ62teTZGSh+mvygD/bLRNPXkGL1SDbj88etjWuXh8q326//74h7Spna
         b6UEo+7+FgUw5gX2AXuOiV2zos+MixiLqD+Yjgo7PESGY7LjCYE1iLAN53oK3PAyzVx1
         3iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pUztPGYiaiQLwA4o+66h/TGEfoZCdk+MYBdySUZIrnk=;
        fh=UxBCZYfS1fVXgnBO1r3VujDQLf5BxFLKCpHNk+tmshM=;
        b=BX8Wkt5PExDcF6AFZG0lnDHJ1XpiRpkbK09T0X0jRVvCLBSnIbIC4DiWyUH8Z4f/Gw
         OMvqDlbWaTUxV7FJtFT9LnNiXZvx7EwqGfDLwjKxtDI2TI78eUFn0y3qT418gv6VMduD
         1KgXYHiyN1BmZPTaS3erM1unQi9nfA5GasFjI+lYr6c+f/JgRMJmG7jCAay4jSDNVrGq
         ELm4dLoXPtkGKamwdkhGM2QtRBIRLWLq3U/v3ojvthGFX2SGYA0dkV+bxtFpSQhZVh+T
         zKKuFcjW+a8h3SxoHnih2cN0mMPCyOPCBdJvgHLTv5t73Qk6+5lEcTZRHjOa/yY3DLN7
         0Oqw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794476739; x=1795081539; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUztPGYiaiQLwA4o+66h/TGEfoZCdk+MYBdySUZIrnk=;
        b=LpFQGe96otQc6lvbMv4bOjl6IqQJUkuOA5KC2RLjbbqx/W0h7v4ilOJbDbfDSfRcmn
         ghyq5QP8ZTvDQNRtLountAnPtrXlND9KdgnDOa8f4tH1BHlbJlwqnO/79MwILlcWhqP8
         nGBnaTrcVUMzOJxUlqEJ154C96rIrgegcDmcsXupJumWt8U/05xMtyXIo6e5hJ2sPB+F
         yXk2OZCQkH4K5yCiZzSOpvW/0yYykt+82bVUgH4IeUpuPNmG25o2eKWyYwCEYnfMg8Ww
         MGDVzO2svDspzzazbc04yuRjHS6gNAHXgbmrcmTF/nChCl1ZpeWZitpK5hPktFsitnCT
         iVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476739; x=1795081539;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pUztPGYiaiQLwA4o+66h/TGEfoZCdk+MYBdySUZIrnk=;
        b=Yp2NxyDTXE1iY22nunZckhTG5soqgG3IkoMYaakuQe/qmZKoAbPAULdzlaTqwP16wd
         ljMQI+qOLkyeuj8EVmURWjZthYUl6HKg+XiFTaHTGQK2ieH0RGeFsKdTUTtTrOjJEQkQ
         vm4XUVhIjI92n6PPrDBlB8Nfe921ubEjk9vVfuoytqRajumzs+ceN9WTEP6SAbGop8vd
         Rvth4ZE0T2e1fm72j1qAMkvThZsAmH4hPpLV39u0uYfrb1hcd9oPNXRR4mIkj17A8aAt
         Bh2ko28mqbpb77XRlKfEUIfbq/5a4G8Za5OjgMHH+l8JkeaDpDgSIH8ZXKEFVcx1BAT6
         542Q==
X-Forwarded-Encrypted: i=1; AL+hErHYX+RkPftJiO0byNEojBCVsu8ob5CAVdEgMwZKBhNBW2spVOICtviL3zRb/T+sW31yEY8ra9TomPYFWIM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+6RzrTtvhXQSF00AP+aVa1mEj1HL5Wm2dcPymtjVNSXCHrGeQm
	JJMDQ8gTbUEyRHPCiPmgbjfD860nPbZb736L60+9mYTw9X+5Lr3zdzgK94O0VClNV1ALopqsBJQ
	JLGA/JjtA963fc7X+ejoqzGUrOUSKZRg=
X-Gm-Gg: AYBFou06f1vnIoMuhJ6Gty7V14s6zAbB9cSLbKdyfT//QuUOSSqylsBEO7XrTQghWlC
	Lg4my6yKTSOAWDfcipgbvqLCiNq4bI3jHrDkYEc6T9js2vdsu0mb5r2nU8YeApJ6lryv/ZMEj4k
	AB6ZINuSnNTx/tMISUtGFhXoWbjTMpeYiNLk7GDGbXP3uP8UmxUGyeXxyqaAldJJTIyK3wu07wf
	/6KsQ5VG6LrLSxFogkSgIbsGN/8h23ajGWowR9QI91TjMdLd92pxYd3prXlFOccMj/R8X3tqNrz
	AV38gHOhRpuk15arkhlEi5hicm6KSDmZY/L9UAMeMeBdcAC2U0W5cxMnKbRDwX+jcvdjXDmpuBd
	svMcSkW9jQSguWC5cXZY1ZHCTdz6z8y1e
X-Received: by 2002:a05:690c:ec6:b0:8b0:97f5:a858 with SMTP id
 00721157ae682-8b3a8160e03mr36811947b3.59.1794476739344; Thu, 12 Nov 2026
 01:45:39 -0800 (PST)
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
References: <20260807084050.25216-1-yadavgaurav386@gmail.com>
In-Reply-To: <20260807084050.25216-1-yadavgaurav386@gmail.com>
From: Gaurav Yadav <yadavgaurav386@gmail.com>
Date: Thu, 12 Nov 2026 15:15:28 +0530
X-Gm-Features: AclHuK9nWzCJsx1-0BHphL5yTBFNhSLgVwDeAcnIjuucTD8j-6wr6zv__eDMy_0
Message-ID: <CANo8LdupO8EGsYOBgrb_8bK2td_a0gHdXECSZ=Jx_amoQAW2sw@mail.gmail.com>
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000009b3d4c0660112cc9"
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000009b3d4c0660112cc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A gentle reminder: please take a look.

On Fri, Aug 7, 2026 at 2:11=E2=80=AFPM Gaurav Yadav <yadavgaurav386@gmail.c=
om>
wrote:

> Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
> and remove the corresponding TODO comment.
>
> Using vcpu_err() provides vCPU-aware logging context, making it easier
> to associate register dumps with specific vCPU instances in logs.
>
> Signed-off-by: Gaurav Yadav <yadavgaurav386@gmail.com>
> ---
>  arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index f3ddb24ece74..23159eb5f5af 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -86,26 +86,25 @@ const struct kvm_stats_header kvm_vcpu_stats_header =
=3D {
>                        sizeof(kvm_vcpu_stats_desc),
>  };
>
> -/* TODO: use vcpu_printf() */
>  void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
>  {
>         int i;
>
> -       printk("pc:   %08lx msr:  %08llx\n", vcpu->arch.regs.nip,
> -                       vcpu->arch.shared->msr);
> -       printk("lr:   %08lx ctr:  %08lx\n", vcpu->arch.regs.link,
> -                       vcpu->arch.regs.ctr);
> -       printk("srr0: %08llx srr1: %08llx\n", vcpu->arch.shared->srr0,
> -                                           vcpu->arch.shared->srr1);
> +       vcpu_err(vcpu, "pc:   %08lx msr:  %08llx\n", vcpu->arch.regs.nip,
> +                vcpu->arch.shared->msr);
> +       vcpu_err(vcpu, "lr:   %08lx ctr:  %08lx\n", vcpu->arch.regs.link,
> +                vcpu->arch.regs.ctr);
> +       vcpu_err(vcpu, "srr0: %08llx srr1: %08llx\n",
> vcpu->arch.shared->srr0,
> +                vcpu->arch.shared->srr1);
>
> -       printk("exceptions: %08lx\n", vcpu->arch.pending_exceptions);
> +       vcpu_err(vcpu, "exceptions: %08lx\n",
> vcpu->arch.pending_exceptions);
>
>         for (i =3D 0; i < 32; i +=3D 4) {
> -               printk("gpr%02d: %08lx %08lx %08lx %08lx\n", i,
> -                      kvmppc_get_gpr(vcpu, i),
> -                      kvmppc_get_gpr(vcpu, i+1),
> -                      kvmppc_get_gpr(vcpu, i+2),
> -                      kvmppc_get_gpr(vcpu, i+3));
> +               vcpu_err(vcpu, "gpr%02d: %08lx %08lx %08lx %08lx\n", i,
> +                        kvmppc_get_gpr(vcpu, i),
> +                        kvmppc_get_gpr(vcpu, i+1),
> +                        kvmppc_get_gpr(vcpu, i+2),
> +                        kvmppc_get_gpr(vcpu, i+3));
>         }
>  }
>
> --
> 2.54.0
>
>

--=20
With Regards
Gaurav Yadav
+919310150558

--0000000000009b3d4c0660112cc9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">A gentle reminder: please take a look.</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Aug 7, 2026 at 2:11=E2=80=AFPM Gaurav Yadav &lt;<a href=3D"mailto=
:yadavgaurav386@gmail.com">yadavgaurav386@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Replace generic printk()=
 calls in kvmppc_dump_vcpu() with vcpu_err()<br>
and remove the corresponding TODO comment.<br>
<br>
Using vcpu_err() provides vCPU-aware logging context, making it easier<br>
to associate register dumps with specific vCPU instances in logs.<br>
<br>
Signed-off-by: Gaurav Yadav &lt;<a href=3D"mailto:yadavgaurav386@gmail.com"=
 target=3D"_blank">yadavgaurav386@gmail.com</a>&gt;<br>
---<br>
=C2=A0arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------<br>
=C2=A01 file changed, 12 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c<br>
index f3ddb24ece74..23159eb5f5af 100644<br>
--- a/arch/powerpc/kvm/booke.c<br>
+++ b/arch/powerpc/kvm/booke.c<br>
@@ -86,26 +86,25 @@ const struct kvm_stats_header kvm_vcpu_stats_header =3D=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sizeof(kvm_vcpu_stats_desc),<br>
=C2=A0};<br>
<br>
-/* TODO: use vcpu_printf() */<br>
=C2=A0void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printk(&quot;pc:=C2=A0 =C2=A0%08lx msr:=C2=A0 %=
08llx\n&quot;, vcpu-&gt;arch.regs.nip,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vcpu-&gt;arch.shared-&gt;msr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printk(&quot;lr:=C2=A0 =C2=A0%08lx ctr:=C2=A0 %=
08lx\n&quot;, vcpu-&gt;arch.regs.link,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vcpu-&gt;arch.regs.ctr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printk(&quot;srr0: %08llx srr1: %08llx\n&quot;,=
 vcpu-&gt;arch.shared-&gt;srr0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0vcpu-&gt;arch.shared-&gt;srr1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vcpu_err(vcpu, &quot;pc:=C2=A0 =C2=A0%08lx msr:=
=C2=A0 %08llx\n&quot;, vcpu-&gt;arch.regs.nip,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;arch.shar=
ed-&gt;msr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vcpu_err(vcpu, &quot;lr:=C2=A0 =C2=A0%08lx ctr:=
=C2=A0 %08lx\n&quot;, vcpu-&gt;arch.regs.link,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;arch.regs=
.ctr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vcpu_err(vcpu, &quot;srr0: %08llx srr1: %08llx\=
n&quot;, vcpu-&gt;arch.shared-&gt;srr0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;arch.shar=
ed-&gt;srr1);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0printk(&quot;exceptions: %08lx\n&quot;, vcpu-&g=
t;arch.pending_exceptions);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vcpu_err(vcpu, &quot;exceptions: %08lx\n&quot;,=
 vcpu-&gt;arch.pending_exceptions);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 32; i +=3D 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(&quot;gpr%02=
d: %08lx %08lx %08lx %08lx\n&quot;, i,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 kvmppc_get_gpr(vcpu, i),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 kvmppc_get_gpr(vcpu, i+1),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 kvmppc_get_gpr(vcpu, i+2),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 kvmppc_get_gpr(vcpu, i+3));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vcpu_err(vcpu, &quo=
t;gpr%02d: %08lx %08lx %08lx %08lx\n&quot;, i,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvmppc_get_gpr(vcpu, i),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvmppc_get_gpr(vcpu, i+1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvmppc_get_gpr(vcpu, i+2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 kvmppc_get_gpr(vcpu, i+3));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"2"=
>With Regards</font><div><font size=3D"2">Gaurav Yadav</font></div><div><fo=
nt size=3D"2">+919310150558</font></div></div></div></div></div></div></div=
>

--0000000000009b3d4c0660112cc9--

