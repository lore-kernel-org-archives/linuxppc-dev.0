Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08345C41535
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Dec 2023 06:21:02 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BuZpXEnr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SxHHK2DkMz3cTn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Dec 2023 17:21:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BuZpXEnr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=ghanshyam1898@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SxHGJ5DmTz30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2023 17:20:07 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso1500025b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2023 22:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703226003; x=1703830803; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9TfaeQ/e55ca5rREKZmd6+dLcKbLLpUfdI5rG0zE/E=;
        b=BuZpXEnrQD138hCM0s+gZYY0TPHtXmiCj+t7TAFP9M4q53atNmt+0XXxgJfVmDL4Ul
         AzRGIsdJ1BUmbGBwhMj3Z57OVyp5fNVlDr84zlhkevdlVHmAYoaU0AirqdYESsRdnoRm
         8Q6288a73VO11R7NvFq9PbAFSSorafm1sYM0Q+DFWVcdJsM0wsy0l38ZugYivDZNHwaY
         Oh8FB4PHkgSXcNxBhQh/oFs9fbSis//huKxXJ8fJelJck/P8B5Qj0WqdZn5WZ0DFraeq
         5PeYlLHwH7vYcnCa1vJCP9TcUr/lCzmTDoJRgL6dZJ3uT3NZs2TfKXXQPvBgiHTbEOnR
         noow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703226003; x=1703830803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9TfaeQ/e55ca5rREKZmd6+dLcKbLLpUfdI5rG0zE/E=;
        b=uOrBAsAgTnmJ1RsaZzZ51cYdHTlk8vsJI2uoAPjNotievSi0j6TJZIaiORDezCidPs
         /+AdA/ek0ap7U+u3U+V7M7VeFAMDAFJ4piD8bvveFhd/VE0Du2n5xKKO4jdML0G18s9f
         45DkBGC7PZmkM69zaa6LUrtJKalvEuBIrlpbZ0WtpES0IvzYcurTPQD2zOKqhiFWLNrj
         hLtfCVpd35x+tKcwYYUFqVhK0DZe0IKAdQyeL8mrxMCHeQKOnwoZxVR7EDW6/tvJAw3h
         ntmCR9Cp3/zn6/NbzT1CI2yvpamy1tFcAZZEIXwG4YX9eArFaioFvhErtMCdpTICP9JW
         xDDg==
X-Gm-Message-State: AOJu0Yym1UoVytA5p0eJR4k4/aHv/SJ1RQq82z/7ys1OPSbeM5Y1rMQH
	LM1VuRsMFV4+3sLLsRRVKsZ3pFaiMUnC8gYbpoY=
X-Google-Smtp-Source: AGHT+IGYnf8qMcbRTBP8LBMIpA5ZyX4pFoKeRr9EZGX19R8VWbg9hhI87VLCqwbeti8d5IlZcvVXzHz4dWoCmVkg4Mw=
X-Received: by 2002:a05:6a21:78a7:b0:195:3eb6:da1b with SMTP id
 bf39-20020a056a2178a700b001953eb6da1bmr120999pzc.72.1703226003030; Thu, 21
 Dec 2023 22:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20231215115857.575697-1-ghanshyam1898@gmail.com> <87il4rlrw2.fsf@mail.lhotse>
In-Reply-To: <87il4rlrw2.fsf@mail.lhotse>
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Fri, 22 Dec 2023 11:49:26 +0530
Message-ID: <CAG-Bmoejy6t-EHv96OTnGhvo-P82fhw5pSUM-LqLfh7Hgh5Qew@mail.gmail.com>
Subject: Re: [PATCH] arch: powerpc: kernel: fixed some typos
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
Cc: mahesh@linux.ibm.com, linux-kernel@vger.kernel.org, oohall@gmail.com, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 21, 2023 at 4:55=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Ghanshyam Agrawal <ghanshyam1898@gmail.com> writes:
> > Fixed some typos
> >
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> >  arch/powerpc/kernel/eeh_pe.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Please also fix the case in arch/powerpc/include/asm/eeh.h
>
> The subject should use the correct prefix. You can see what it should be
> using:
>
> $ git log --oneline arch/powerpc/kernel/eeh_pe.c
>
> Please give the patch a better subject, not "some typos", tell me what
> misspelling you're fixing. Same comment for the commit description.
>
> > diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.=
c
> > index e0ce81279624..8e0c1a8b8641 100644
> > --- a/arch/powerpc/kernel/eeh_pe.c
> > +++ b/arch/powerpc/kernel/eeh_pe.c
> > @@ -24,10 +24,10 @@ static int eeh_pe_aux_size =3D 0;
> >  static LIST_HEAD(eeh_phb_pe);
> >
> >  /**
> > - * eeh_set_pe_aux_size - Set PE auxillary data size
> > - * @size: PE auxillary data size
> > + * eeh_set_pe_aux_size - Set PE auxiliary data size
> > + * @size: PE auxiliary data size
>
> While you're changing it you could also mention what the units of the
> size are.
>
> >   *
> > - * Set PE auxillary data size
> > + * Set PE auxiliary data size
>
> This should gain a full stop at the end of the sentence.
>
> >   */
> >  void eeh_set_pe_aux_size(int size)
> >  {
> > --
> > 2.25.1
>
>
> cheers

Hi Michael,

Thank you very much for your suggestions. I will implement them
and send a v2 patch.

You mentioned I need to specify the units of "PE auxiliary data size".
Is the unit BYTES? Sorry for the silly question, I am only beginning
to contribute to the linux kernel.

Thanks & Regards,
Ghanshyam Agrawal
