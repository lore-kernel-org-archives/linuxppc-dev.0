Return-Path: <SRS0=wbJF=JV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C97CC433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Apr 2021 13:52:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C873861490
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Apr 2021 13:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C873861490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FSCJs1Hw1z303g
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Apr 2021 23:52:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=XzK4dnfU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::133;
 helo=mail-lf1-x133.google.com; envelope-from=sxwjean@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XzK4dnfU; dkim-atps=neutral
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FSCJN01GTz2yR7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Apr 2021 23:52:01 +1000 (AEST)
Received: by mail-lf1-x133.google.com with SMTP id g8so81631983lfv.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Apr 2021 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jCOp7RZ+iu6cfzLw/VonyR2hYz8LTHhRBEdxzPYuVcg=;
 b=XzK4dnfUjaa18YTv5ERftP59UulNix2QP1HZGGPY7zmpnt+C2OBLGwsn2qCXHIlt9h
 53Tz6YR+Cfb7/Oa4RnaMsiSFxCgFt7mGpRi59uxVfarHRhx54VJe9oQYscLkZvGm8XAd
 ZxLHtbZQkp92s+8Hz0bxzlDDyJbR1xITI4j2TphaCDiNo9Q424354c7k93C1enUBwAX3
 WVtNnI5Vpla+dLynsdWqW6uEOhJWjZSF5AItV9PZdnJR6iFjhq8M1qDEjkf74Ep77wfq
 5ONu4xgqi5fhP2tLH3fDqv0/JfdO1cNKH960kGxjjscKrbwDtyYf1Ztm+s8W/OgX6/yg
 LKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jCOp7RZ+iu6cfzLw/VonyR2hYz8LTHhRBEdxzPYuVcg=;
 b=jTY0lsTz0P/X87y3oREOzWn3w7RgGb22MfyrTzIvB8oP9Bh8B0nj+U9qNC8nZYSeGc
 f/wqSwiaWDKL1ADLo9gx/db+zMsDp/+/VkYgW/HJS3IUalnnLJtVCLsOnYfFvPss7jF4
 799uO361RdvGoygq+VjDCvqiNEsd9NMDeook+6sUH2H7NN+5wqIvt9AZp3cLD/ljdBmm
 dZ4kTB5IBb87h5dreqPAHPZmQ8vhSV0pAazZAhjrS80BzE6ZJ7DfkPMqkPpmnKhN9Iym
 1+cfKDrUw19Cd9gQYCmmb7eCABvY4PaZfHjf6XOfI2JLj+0chRnE57Z5Dh5q/jiPRkY0
 P2mg==
X-Gm-Message-State: AOAM532nphEHgSHiWbOlKM9OhL4U8wW4zRJki+io93sTfuj2blOgSQYK
 5Xzs8R1v2bQETyPhP0u7my7uN2oEqKHsQeciXSQ=
X-Google-Smtp-Source: ABdhPJxNSl4Ds3+3NRYLP1M4XlNF4lsytCjH8ibqpqR58NCb8atatdL9iMeH3luV4c8AR4aW+fVwDYb2EZkHlWL8NFg=
X-Received: by 2002:ac2:5042:: with SMTP id a2mr6027441lfm.650.1619272314835; 
 Sat, 24 Apr 2021 06:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210422151022.17868-1-sxwjean@me.com>
 <20210422151022.17868-2-sxwjean@me.com>
 <ac6cf0ae-7565-180e-03b2-5e72f89a823a@csgroup.eu>
In-Reply-To: <ac6cf0ae-7565-180e-03b2-5e72f89a823a@csgroup.eu>
From: Xiongwei Song <sxwjean@gmail.com>
Date: Sat, 24 Apr 2021 21:51:28 +0800
Message-ID: <CAEVVKH-p4NqizZjC0DNEUgsw9eWurd1YWxW5QQwTxvUZHR5g4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc: Print esr register when hitting Program
 Interrupt
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: ravi.bangoria@linux.ibm.com, mikey@neuling.org,
 Xiongwei Song <sxwjean@me.com>, 0x7f454c46@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, npiggin@gmail.com,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 22, 2021 at 11:29 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 22/04/2021 =C3=A0 17:10, Xiongwei Song a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > The esr register has the details of Program Interrupt on BookE/4xx cpus=
,
> > printing its value is helpful.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   arch/powerpc/kernel/process.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index 5c3830837f3a..664aecf8ee2e 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1459,6 +1459,7 @@ static bool interrupt_detail_printable(int trap)
> >       case INTERRUPT_MACHINE_CHECK:
> >       case INTERRUPT_DATA_STORAGE:
> >       case INTERRUPT_ALIGNMENT:
> > +     case INTERRUPT_PROGRAM:
>
> With this, it will also print the DSISR on 8xx/6xx so it will print garba=
ge.
>
> 8xx/6xx provide the information in SRR1. If you want to proceed, you have=
 to do the same as in ISI:
> Copy the content of SRR1 into regs->dsisr in the assembly handler in head=
_book3s_32.S and in the
> instruction TLB error handler in head_8xx.S

Good point.
