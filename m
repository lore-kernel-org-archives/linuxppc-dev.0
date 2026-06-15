Return-Path: <linuxppc-dev+bounces-22654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E12CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 17:59:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfHvV1KNVz3brl;
	Tue, 16 Jun 2026 03:59:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781546390;
	cv=pass; b=MPIJeMG1C1dgZpB4mGegaggndL5rcay/1pDu1ZRry4vDGr8reCFeJ6uJMeG5OcT19f6KF6X1YPaO52D8rCsVVwiHWNXewVSF2V9/mfAa5oo76hSnhEN+66LkiHZE3aAq4HwTWcAZ2K+emjODpK9NvKKjgfb82lqFW4A8tmerIMo7HnxmvTTAoO+4qfu5k12eIWykbYYIh5M8ilMAOuY254Iku9QHqac8KEqHdqYeryW6tHMNun92zBx00m9+/W+xd2nYgLEcQspRkiIf0g6LsgLqJ2CAOwXY7mVKKG5MufzHknQKnmmLoxKAS+PSh27R3RLyYgpJ6Y2CLupHedSkWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781546390; c=relaxed/relaxed;
	bh=N7DCS1FhJDnbMeFiAtGx2JiLKTME+H3qz4ArR/Ptiac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGz/sqIjm1dtuI3+qhX639zbypLoJ/FuNWsqbweH6GSa/Qxf6VMHkg+8JDhPrLEare1KYrwopsSDya3oK9j6n4z+KNafM2NrQshEDid+iVfT/67iKu6gsVXEzHN+3khbc7cz5e6v8Jnv7etEXpAn66dir6OrxpLhmWfqTBq8oxJC9ziLGSxgYNQC7tUpeXHxq/8CHH+aOT5IVOieH0wAK5w6UCu1PQun0/91KhLgt7cC7dg83n1s2hdNXhI9PWDK8fPcOIcEup26XXFZQRnOiwrxlavf4QmczpdvgpjqpSPeRo21hIofUrCHmL1/quGjnscs+QdEPcyRxQS9989SSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TiPMFQrq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TiPMFQrq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com [IPv6:2607:f8b0:4864:20::b131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfHvS4kl2z3brL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 03:59:47 +1000 (AEST)
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-660e9ea23cbso1870913d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 10:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546385; cv=none;
        d=google.com; s=arc-20240605;
        b=joswUqDKOV9YTcpkyLVY/xe9xb2I7tl7L86GcUBvsju/nbJm3Sqv2E21j5ZsKK8H9z
         btg9HIiyd5vc8ML76F1fEWOwKo0VuqdVSvPpUILs3Ok6Vi5mL97RDJcVDsZmV4bJFGAq
         rPo9ava8FHoX0UW8WhjA597PqjxjlC2HR3zAGYZ7oG/mYPu/nQSD4D4yhCCFmk4+OlIe
         hB6UAAqtI2cpRsLID7Jtk6z/GFaOWbzhZb5H4mWoWD6oPJnlft23w5B5jrOsMOb/5WnO
         I1y1vu78PovY4qdeue1j0MvTfP/LCqx/MDrTlKYnoYe4/h+Ufitgns0nxiAjsDtvmlvD
         eihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7DCS1FhJDnbMeFiAtGx2JiLKTME+H3qz4ArR/Ptiac=;
        fh=9ggvHVetauklk/4C19fJ+3sDx43EZ9xRfncf26OouBQ=;
        b=OAA8MFsgXO5/f2c4WJ+FvkTOt/ly2H4n7Q1alSYBn43LiAe8x7C7lGQUoZqt7f4CGy
         UqzykC0FeBfVpl3m/u2B56qE/WLDqndWnbj5er4IfPExJ9u7i8EgxQbhjTLY+an9Ocge
         2Wc3Xh7zZAayMXfsxc5aeljOULoBxQKPQHLDpELUPpALqjj7NbwAOQzzfY62U4K5zEDg
         UKmF5F1AsrRRu+m5U6XExrqZlx2YpI7hMHCyh84hDINb+rfyJeLjV7g4gsOYvBRP+R7l
         iZywkBGGOjOM880vIYst23RkMcebfCLRhxNYAXdJ/dYMgudlEz7qWzPQ0zGld6PugCmO
         2W5g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781546385; x=1782151185; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7DCS1FhJDnbMeFiAtGx2JiLKTME+H3qz4ArR/Ptiac=;
        b=TiPMFQrq4NZ1YvtgNeVJQbXuMUWMdBa8OClfljhh7xSInwBY3OJLilR70t7LLGpXUa
         /l8B/oaIlCrOBWXN0euZgYKb1hMAK/96mgJ7L34kjZO+PLxST7UsDtmygllljx8JyxUy
         unn4pRHUQ1qqxFlqla030m9Tzo0xWuwBAcKRgcHggEVoDHydAIe7EXfcFmToK5YkjBNR
         lFqKSp2q4/7jqqhrNC+Mo65psK+dN0zW8xDJHEGRnbxmG1+DrzDS3Pc6i2CNuoOON3E4
         yK9MI6ZypHRUbhFWdWaROhJsE6v6pSfrfuvpA13bTuKXp4vViIO0C7NFjNSDaIyVwH3d
         2ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546385; x=1782151185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7DCS1FhJDnbMeFiAtGx2JiLKTME+H3qz4ArR/Ptiac=;
        b=gawmPMUM1HxnijqRgpS+BwXreLbO7tM6OCmmYf9CpsZEWHU0sZE59roDYMt4h/VnZM
         ZXdOBttFsUnzcA2pBoAIHkSYXe+SlDNkarmVCpS4hXk5sKcBqscRq9hnZ7j+4MBBzVKs
         AYQaLGV1ONSU9DMMlf3TTr0vEhiE2ZzORcSVt1JV2DEwkVYhho+xAwmvTkmaMlumo0Kf
         9qmxjRJ6rXPA9SCdY86xKrxxj1t7fRCj9zCffQSMBV3Y2lacGbfBJd/UUcaffYePTRoj
         5MBDvGZ+mtctmLAgEOIIVNkd1Z5cJkk31A3SIhexyhy1iiwQhm7BbQ1ov+C1vQHS8t+R
         PPZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+R71EwQeWov8GbdxQgNAgIPNybKyhNNliE6od2z//VhzggcgN9eKFN8ir6XTkcDTh3T6tFsr/k7MQwuT4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyCx0Dbii8XspE0XZjtsbWwhIPyp+rwmmv5XL3mj3P5QR+2EJC
	d1tqyGy9Cltytk3/kuuxe2R0oEFhRTJkxDq7Vd1CGl3DxnjVZB0onXuTecZnuywvoEj9VdJ6sz/
	jsh+zkBUor+VukZynRgBpF1A7K3accdg=
X-Gm-Gg: Acq92OGf9QR35whqF5wIZU2FwfgOe2CMp15RY1Xo8yE03krdp8PvocYMV5llmXu3Aeo
	gQu/f4a1/bde8MfqYhZIw3PgC9Rmxh/6CfJ3rbzWgVqCGI9U6VoQP9CkJBoWQtAIYLRZbqKNx8n
	h5YI3SnPahgev/e+0mTJbHt0PTfSTYhNQXq9DO73ZjJpZBKSbPyYz8fScid93Q7RV4y2OxI/9Xm
	uoM4DJFcq70aKESG6bMHV9qE/gWVQEWa1kB2SfJfhxOaOzTnROz9Yvzab/22yJ6m6qtkz0jw7D7
	K/tML1da64BSFOc=
X-Received: by 2002:a05:690e:124a:b0:660:5df1:f243 with SMTP id
 956f58d0204a3-66278346bd2mr13188710d50.50.1781546384795; Mon, 15 Jun 2026
 10:59:44 -0700 (PDT)
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
References: <20260510171353.1406018-1-ekffu200098@gmail.com>
 <20260510171353.1406018-3-ekffu200098@gmail.com> <20260601220346.GB54006-robh@kernel.org>
In-Reply-To: <20260601220346.GB54006-robh@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 16 Jun 2026 02:59:32 +0900
X-Gm-Features: AVVi8Ce3VjKsZhdbSUBBzYGD6PwF3j2b4jhtEgG1brsSGXPufZKHeAEi0A9pCcg
Message-ID: <CABFDxMHRqNDg1TmuYSWFuF95rYgDX2SpThn-TvbTGMTen8kx2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/fdt: make early_init_dt_scan_chosen() return void
To: Rob Herring <robh@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, saravanak@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 2, 2026 at 7:03=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 11, 2026 at 02:13:53AM +0900, Sang-Heon Jeon wrote:
> > Since commit 064e32dc5b03 ("of: fdt: Honor CONFIG_CMDLINE* even
> > without /chosen node, take 2"), early_init_dt_scan_chosen() always
> > returns 0, so the return value checks at its callers have become
> > dead code.
> >
> > Drop the return value, change the function to return void, and
> > update its declaration and callers accordingly. No functional
> > change.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > dt-test result
> >
> > [    0.684136] ### dt-test ### start of unittest - you will see error m=
essages
> > [    0.685849] ### dt-test ### EXPECT \ : Duplicate name in testcase-da=
ta, renamed to "duplicate-name#1"
> > [    0.685870] Duplicate name in testcase-data, renamed to "duplicate-n=
ame#1"
> > [    0.689496] ### dt-test ### EXPECT / : Duplicate name in testcase-da=
ta, renamed to "duplicate-name#1"
> >
> > ...
> >
> > [    1.693384] ### dt-test ### EXPECT / : OF: resolver: overlay phandle=
 fixup failed: -22
> > [    1.693386] ### dt-test ### EXPECT / : OF: resolver: node label 'thi=
s_label_does_not_exist' not found in live devicetree symbols table
> > [    1.694968] ### dt-test ### end of unittest - 405 passed, 0 failed
> > ---
> >  drivers/of/fdt.c       | 10 ++--------
> >  include/linux/of_fdt.h |  2 +-
> >  2 files changed, 3 insertions(+), 9 deletions(-)
>
> Looks like this is dependent on patch 1, so I'm assuming the PPC folks
> will take the series.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for reviewing, Rob :)

The merge window is now open. PPC folks, could you take a look and
pick this series up for 7.2?

Best Regards,
Sang-Heon Jeon

