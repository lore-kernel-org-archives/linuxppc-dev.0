Return-Path: <linuxppc-dev+bounces-26165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756EFC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Aug 2026 08:32:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWWpV4xLbz2y8F;
	Fri, 28 Aug 2026 18:32:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1136" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787900265;
	cv=pass; b=PJRRgy/97RSq0HDJGSQCmFiqC3DjzRWQhjear5vDhhPeK/P0oYUjGPE8P3SjLon8yX9On07bkDb9F48Bic+reFSijfPrr579EZ5a20c1CZ5gEnSUJEM7QX042sZvWx3hrEd5xZqzIMi5jXd/H3w0owqcqvAGIJoMxq+cQgud7YJ4wATxt6Pz4pJFU016PEBuM3x3j5zTt4QOhFg3mB8h+XxLnYrB6byTU43J8BOWGScSPz5dQn8n8f30gDwg1UZNbkngtJakercN9y1y/sV1zTJuaHFmwhysIU/3jNN0q/JVzc3KO0iacgutN17nFaGM+f+uPNjGej3x8Y3Z8xDnUg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787900265; c=relaxed/relaxed;
	bh=/8qBjQnZGo43gfBUWHxcrtghJHGBplN8cehz8N8qyTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQmqDQb0WHE+92ZTNu65mbo2FR3QL+W0qsMIi4LHJja9s6Kl92kBrKMFz1ylorF3RY9YFmTOQQuPf38cCAZEgHVnF5amo4OZhsRkp4L044zpdXrpk9MBYrT8HOGONGWnyNgsM1mwmTz4fAhxMzCt+MwdpPhuFPP18Ja19kbGc7+qj3AcWo9sk+Xei7mCUKiPk/OkGPqDo7Dm4feysFuEf6U3bXXNj41pZ62GvHQdwi83TP9p9i+7GWBli+Guat6ITngPJA92DuGFrRA+4h54qQtgKPAKcPhhy4Qpv24sNb7AhfQDHOdI/UzCqAP9cqvTqhIk1CUhDpWJKft5YjJPJg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WGKLBMuU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=rahularukonda2@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WGKLBMuU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=rahularukonda2@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWTjM1yvvz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 16:57:42 +1000 (AEST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-7ff05e5d009so7468497b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 23:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787900258; cv=none;
        d=google.com; s=arc-20260327;
        b=eVm2PwwW0zQ2LyspzD+6wEcGlx4+GhztuZNcmSIj2tvZ7cuUzmM0q+Ppavcy2p9bWO
         hss2+Tz4ARPM90yP3zskzWjdSXMBx1yLWG76hm/eTr/ajLhCokGChtTv2TgCa8GXLpkh
         I1zAdghmnLXaFmV02F8GCqPCqmCt1I4V10TSV1izczC8gDIBsj8HnA8fVTNjCVfh7QyF
         QWiLfCrAUwRatoWw/ZaVbCZB5wStqS3h7pkeoyFZNHJJUkMosF7MyuiUEm4nPOONF/FT
         cemPTIeqjmYkbt3f6ypc28ILfwSJ1pvhLA2oSCReHmiLH9wMDTtoELexPi7sEvL350Ij
         SMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/8qBjQnZGo43gfBUWHxcrtghJHGBplN8cehz8N8qyTk=;
        fh=GMb+eAioESJPon69q9a+QY4Dw6+PL4xndCwbRLPR/tw=;
        b=o1ODvhNkXkvTc9+Y8z7pxfJ3ajrfeWyVRnT0gJ51eh92yHJh7pP2Tjl0YtYW+4X1Xg
         1AsTbl9YSFIl5woCU/zOqgZl0yKX1Tlq5TdLbHo1Gp/Yl/z+SJ0KYsxffMs0AnvY/WLe
         UoObzVROHJUXYNU7oFZ5b8FnpJU74gV9CS8BFKT0dOSnhXBdNh8nL05vdMDtf4xMxxOj
         bmtGkWBpea0PTrDaMKFu0/76ZiV/lz7VKMNyINBMTNuh2DOri2vTJ/VqjUn7hk8oWF3W
         ki7qvQwF5Hy2MlUaicc0+9Ex1qo2DVvNfpDcdWY6X2m6linZS5i5RuuWoTlpCHLqa5GC
         tVdA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787900258; x=1788505058; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8qBjQnZGo43gfBUWHxcrtghJHGBplN8cehz8N8qyTk=;
        b=WGKLBMuUX68UaX5RRHKFWAy0aefHfUaVACPfcZR70uXZFWD+SIt2QzP7HPyQYvP0Gu
         HqdIEfIva4n+yemjPuyksPqBzKVsX1/tbVOO2nNNlOIIaT2OeZyGZ3sO8hyizzmmkgmj
         oPcp3vz1IoqF6KdTfvnRmbrtL08cA2t4f3h1XyfAZmESrE2grUGVLfx++4DAUmAQOCyo
         A4QJrbH6DbQAdOzTRGE6SidQVAEIuWj24wyVko2zK1WJ0wJ7YGtpljhf1QFRYOPDAnvM
         TAHLA3BUroQapXlTjQeTnlFmmwX0ZUv2dW1uTlt5h2k5jTQ0cT31SzWk1RMC63ct6Umd
         Pl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787900258; x=1788505058;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/8qBjQnZGo43gfBUWHxcrtghJHGBplN8cehz8N8qyTk=;
        b=dN0mqrT6+Tg/kPmUWize+zAfXeT2BbNq+JqS29C+SorOhl/P7dxkonkyL+rJk8obzh
         2Eh0Fj5bRHSrl64XVN0L/v8BL1yU1y6MPg+zOuwGzncDpT8bDvm+Z0yFWxykcH/gRa2s
         KP6zW8mxhiNkmyrxAH8cPF8cmIhmSiAD6f1iha/QDnJB27n9G+jxP2vSmQlFGRYT9sIe
         7T+PWHokt2VCwR+SXqMoolcHHRpVKFSJS8llWggasVF5wMTzFLFISYLl93Atm4VSJwCI
         ldH5mvK3NM0JSHGpTxLqs3Fc/rJNBbl+jIBvN2MQ881DG3rd/zo/5MeGy6O1TYcKrNpB
         tK4g==
X-Forwarded-Encrypted: i=1; AHgh+RrEfMBqlST2STpIhzPSWo8c5KDMgUWz7yB/Qc55ROm4b2aRrGT6W/LVAPKE2LibxAsNy+LtZ3JAWHAGxhw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m5ZWOh3ZbygkMnfSQUH2PJDcE6Evaej6+nCYZCbdLk3Z+eUlY8
	tx8P7hVd5xNZlhw5r3lPU4Phcu7SQG7cj1xNpC6iZO+Jho/Cyr7bGWTj60//albm2rU3JB7zCZx
	cV6vwaZT5lRN9UN4PTn3iotABvSo+BPc=
X-Gm-Gg: AR+sD129SP+JYFSMbp+GHax8YxlChXYo4muVAbGtu/Fb04NFL+ddaEsijkfnvNQr6rw
	gkmDYRBRInyAuqYMnFLnHRzqLYTeu76Dai0QfCayBQlN5c4NHKuh1M9jCvopag+KGG8SGmw0WpJ
	5HKya7DzK/5fXojej81jdJtErTcssgEy9aB/xkmJ1coYm89kos5C0xlD4z13znBRoBGeQj3nufE
	Wt/GPD/LqV3bt2Bh5108pt9eNENgv5XN2PeWq9dNHEEdxXLxizQhdnYV/YXwvPEQkOJxpKIONoU
	IJb6OdXoIOTOu1Lh5qPDDxrSnYiaVWBLOgk4BCZdZwMCjnXJfF8CWsI4q94dKUuDCXrwgGv7PHP
	jEQ==
X-Received: by 2002:a05:690c:6606:b0:7db:ccda:a409 with SMTP id
 00721157ae682-85d69e05e99mr19910957b3.9.1787900258332; Thu, 27 Aug 2026
 23:57:38 -0700 (PDT)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260804165112.3859-1-rahularukonda2@gmail.com>
In-Reply-To: <20260804165112.3859-1-rahularukonda2@gmail.com>
From: Rahul Arukonda <rahularukonda2@gmail.com>
Date: Fri, 28 Aug 2026 12:27:27 +0530
X-Gm-Features: AcwNN1Xp24lA0XGBNzSp6mhCKMEHESNwveswRbLq_RyYgvL5rTJ2hc-tP3hk7Q4
Message-ID: <CADu5n7+njmKHKpTHMSWNycAbMnnFCvDchZ_maOYiuq0EPhGsuA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/tools: Fix typo in unrel_branch_check.sh
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000cab5a0065a15f744"

--000000000000cab5a0065a15f744
Content-Type: text/plain; charset="UTF-8"

Hi
I hope you are having a great week.

Iam following up on the patch i submitted for review.
please let me know if you need any additional context in the mean time.

Thank you for your time and guidance.

Best regards,
Rahul

On Tue, 4 Aug, 2026, 10:21 pm , <rahularukonda2@gmail.com> wrote:

> From: Arukonda Rahul <rahularukonda2@gmail.com>
>
> Correct the misspelling "Unkown" to "Unknown" in the error
> message printed by unrel_branch_check.sh.
>
> Signed-off-by: Arukonda Rahul <rahularukonda2@gmail.com>
> ---
>  arch/powerpc/tools/unrel_branch_check.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/tools/unrel_branch_check.sh
> b/arch/powerpc/tools/unrel_branch_check.sh
> index 8301efee1e6c..13dcdc0c49b6 100755
> --- a/arch/powerpc/tools/unrel_branch_check.sh
> +++ b/arch/powerpc/tools/unrel_branch_check.sh
> @@ -59,7 +59,7 @@ while IFS=: read -r from branch to sym; do
>                 fi
>                 printf -v to '0x%x' $(( "0x$from" + to ))
>                 ;;
> -       *)      printf 'Unkown branch format\n'
> +       *)      printf 'Unknown branch format\n'
>                 ;;
>         esac
>         if [ "$to" = "$sim" ]; then
> --
> 2.25.1
>
>

--000000000000cab5a0065a15f744
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi<div dir=3D"auto">I hope you are having a great week.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Iam following up on the p=
atch i submitted for review.</div><div dir=3D"auto">please let me know if y=
ou need any additional context in the mean=C2=A0time.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Thank you for your=C2=A0time and guidance.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Best=C2=A0regards,</div><d=
iv dir=3D"auto">Rahul</div></div><br><div class=3D"gmail_quote gmail_quote_=
container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 4 Aug, 2026, 10:21=
 pm , &lt;<a href=3D"mailto:rahularukonda2@gmail.com">rahularukonda2@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Arukonda R=
ahul &lt;<a href=3D"mailto:rahularukonda2@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">rahularukonda2@gmail.com</a>&gt;<br>
<br>
Correct the misspelling &quot;Unkown&quot; to &quot;Unknown&quot; in the er=
ror<br>
message printed by unrel_branch_check.sh.<br>
<br>
Signed-off-by: Arukonda Rahul &lt;<a href=3D"mailto:rahularukonda2@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">rahularukonda2@gmail.com</a>&gt;<br=
>
---<br>
=C2=A0arch/powerpc/tools/unrel_branch_check.sh | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/arch/powerpc/tools/unrel_branch_check.sh b/arch/powerpc/tools/=
unrel_branch_check.sh<br>
index 8301efee1e6c..13dcdc0c49b6 100755<br>
--- a/arch/powerpc/tools/unrel_branch_check.sh<br>
+++ b/arch/powerpc/tools/unrel_branch_check.sh<br>
@@ -59,7 +59,7 @@ while IFS=3D: read -r from branch to sym; do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf -v to &#39;0=
x%x&#39; $(( &quot;0x$from&quot; + to ))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*)=C2=A0 =C2=A0 =C2=A0 printf &#39;Unkown branc=
h format\n&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*)=C2=A0 =C2=A0 =C2=A0 printf &#39;Unknown bran=
ch format\n&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 esac<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$to&quot; =3D &quot;$sim&quot; ]; th=
en<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--000000000000cab5a0065a15f744--

