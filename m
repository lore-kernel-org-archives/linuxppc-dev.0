Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9632CC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:03:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F6F2082D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYCnD/hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F6F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kTBb0jgnzF0yv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 09:03:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DYCnD/hd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::c41; helo=mail-yw1-xc41.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="DYCnD/hd";
 dkim-atps=neutral
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kT804Kw8zDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 09:01:19 +1100 (AEDT)
Received: by mail-yw1-xc41.google.com with SMTP id d126-v6so4052694ywa.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p8o8q/k/hXgtNnSyTJbVfD5KErHrWV7dn+4h6/5tV/8=;
 b=DYCnD/hdQOlno7NRTcRXNl6eHQhKPNjN07Yf8xRNZFDucxAM/6CcmZz/nH7Zx0g4om
 uS2M+1sW1MxvH3EbNyjuqgvBj75vLxykCzznyl27LM91GXd9PAgwjhftyjrS1iKN0WIj
 sqIeX8DEQ2KFyzhzyB/TGBi8WYG2kJrR5sjaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p8o8q/k/hXgtNnSyTJbVfD5KErHrWV7dn+4h6/5tV/8=;
 b=MiYpZu3XG9iUzeT8NaUA7xZJHGCXcyaKENZmzymljZWex+OXaJFDZijBE6pmnwq63s
 PbJaPN2N5jTtc0F4RZr1bYWhWexzbo+cAfsz0ZOofNGVxlMA69UFOGrjK+z4gTIjb/uc
 Wqt+CjZsBFt3Hh9U8HaqQ6CDNLCGS0cU2SR/orkxWyTe92rmlMXSI7nNlGnjpHo4cXXJ
 o57ncFWJW96RKL1TePOYD0EsWOS4HQzLx+NibsszR9OhOk8weqj8QUz6YasXHZ7ApdsD
 NcFcrxFftUgSEbkkpUdxyuT2upOQHWHLcE1o3EUvmchgtenkVSc9uzkzC8CiKGEXGv0y
 Af6w==
X-Gm-Message-State: AGRZ1gJkYxRVUbReHuWQYkxM5tiwj7oVBExFjEjSgl8D9VEBo7uE74aj
 wMYkasHD9XpaNfuk/5Y7sr52BSN6txU=
X-Google-Smtp-Source: AJdET5fU1oc0h61ZCYh+wHOSXSHPrnflkhZUu2fhXiPJhv8GywWrSbdRBEIk14yzw1fCfDodFHbfkg==
X-Received: by 2002:a0d:e001:: with SMTP id j1-v6mr144099ywe.391.1540850477608; 
 Mon, 29 Oct 2018 15:01:17 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com.
 [209.85.219.182])
 by smtp.gmail.com with ESMTPSA id d63-v6sm4263174ywf.100.2018.10.29.15.01.15
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Oct 2018 15:01:17 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id j9-v6so4150592ybj.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 15:01:15 -0700 (PDT)
X-Received: by 2002:a25:6e84:: with SMTP id
 j126-v6mr2990841ybc.209.1540850475227; 
 Mon, 29 Oct 2018 15:01:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 15:01:14
 -0700 (PDT)
In-Reply-To: <7DC76493-28C9-4CAA-9262-E809F52459DB@amacapital.net>
References: <20181024153523.10974-1-msammler@mpi-sws.org>
 <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
 <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org>
 <875zxqo0ee.fsf@oldenburg.str.redhat.com>
 <c4d3f5c1-a2dc-5b44-4d12-1fae829a372c@mpi-sws.org>
 <CALCETrX_E5_p1-MjCcdtRQbziCCzXcOCfxRBckZx_zbO1QX=Dw@mail.gmail.com>
 <CAGXu5jLE2VBqo_rkBJ+BJkp1==WLLg=N=-3gjTCCjcN1=bodSg@mail.gmail.com>
 <7DC76493-28C9-4CAA-9262-E809F52459DB@amacapital.net>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 29 Oct 2018 15:01:14 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLrLwRG79-8HF-L7eCk+xEZADQfCqbdfRgsnaLVkttPZA@mail.gmail.com>
Message-ID: <CAGXu5jLrLwRG79-8HF-L7eCk+xEZADQfCqbdfRgsnaLVkttPZA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
To: Andy Lutomirski <luto@amacapital.net>
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
Cc: Florian Weimer <fweimer@redhat.com>, Will Drewry <wad@chromium.org>,
 Linux API <linux-api@vger.kernel.org>, Ram Pai <linuxram@us.ibm.com>,
 Michael Sammler <msammler@mpi-sws.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 25, 2018 at 5:49 PM, Andy Lutomirski <luto@amacapital.net> wrot=
e:
>> On Oct 25, 2018, at 5:35 PM, Kees Cook <keescook@chromium.org> wrote:
>>
>>> On Fri, Oct 26, 2018 at 12:00 AM, Andy Lutomirski <luto@amacapital.net>=
 wrote:
>>> You could bite the bullet and add seccomp eBPF support :)
>>
>> I'm not convinced this is a good enough reason for gaining the eBPF
>> attack surface yet.
>
> Is it an interesting attack surface?  It=E2=80=99s certainly scarier if y=
ou=E2=80=99re worried about attacks from the sandbox creator, but the secur=
ity inside the sandbox should be more or less equivalent, no?

Yeah, I'm more worried about the creator: I don't want kernel exploits
via seccomp APIs. :P There have been kind of a long list of
eBPF-related flaws, so I'd really rather not tie seccomp to it. As for
sandbox escapes, I don't think there's too much concern, but I do
worry about "unexpected" situations exposed by eBPF (i.e. maps or
functions not doing what was expected, or allowing map manipulation
from outside). seccomp cBPF is pretty self-contained right now, so I'd
like a strong reason to justify the increase in code complexity and
related attack surface.

--=20
Kees Cook
