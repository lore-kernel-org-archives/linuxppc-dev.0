Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277CC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 16:53:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D7D20824
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EVq9T6bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D7D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kLJL4YFdzDrRP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 03:53:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EVq9T6bf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=jannh@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="EVq9T6bf"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kLCb5f85zF0yl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 03:48:59 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id q5so2767687otl.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZUGdCRhBfd3pStc0PE075EXlzQWP7KBBcXNaG7b06O4=;
 b=EVq9T6bf5Kom2Cbah/P4VxFAXoGNOFYV9wKLqMadUgr0Su0JK0kKfpNOApbLRMYqZq
 O7YUCvTq2Q2D/oDE8+JDRNG1yXqbtG2OEt/Hfd+DSOmIGsS1/2tvOCVg8RXtOPaE3RSj
 4XHN/X86AHV4H+mpQg4onOdQTprciX5TaFOWhznGigO8Xow+XwHLf4mHgZbQt3ZMAg6w
 GxgET9iqO8m6BVT2YkDZph8TFBqvQc0RI4yWtOTHQCUxrFul6d47a8Hz6o/h32akvfmT
 W4An1tmNJSa9nSNW49vlXRu5fg+Vho4/LfJnQSLlCx8YpqcSAOmh3awvGfym+rRB6GRb
 dGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZUGdCRhBfd3pStc0PE075EXlzQWP7KBBcXNaG7b06O4=;
 b=p6pUST057wTT9UWoTThbClSO1UUwRMiWeZnlMpujPmNZnZV9ubpK5O1yLUKggCek4U
 1miWnuOhgI8itZBrf4Solk6OO6P30IAP7hrPpDL2ddUQu57ER1/IqBRL/dTZCBaJM+RJ
 MSBjyPfPXPY6HMdEURr/3AE73UVbISakedJzeGOVSzaZGj/cmMNn9N4ylN2Aoh/O/Y0G
 UlyvuqHe2Z3o/Hhuap6J5lRYbRvPunBlCJlANdE/oGmoiYj4jybNz3nQUOjN1q2ib8h1
 YiJuxtlKymyAr3T+Hk6GVNzSFE5hFEng5Yn9Zd0KvWgLiCSBlOG6RRVF6i+ofWuopyTf
 H4Pg==
X-Gm-Message-State: AGRZ1gKQpEnFn5qv93/NucnFz0NJVVtZP7P+7JY2eA8beN5gOli4cNQz
 3iqA3Eg8EYrxi8ott6VXlOJLAOLUunpwCj2l5kWmhA==
X-Google-Smtp-Source: AJdET5e14aEdHubEpCct6T8pGnwnIY9cVrT4Mo4J8ocMMd8gkijAzph6YQcU7TGBVB/ARa1oWWiUr4rMxSFPgVGSJF0=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr9370309otf.242.1540831737043; 
 Mon, 29 Oct 2018 09:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181029112343.27454-1-msammler@mpi-sws.org>
 <CAGXu5jJ2fFmEXfUzga3XBXcsHPuPWWf5zLeyn8+Z1oZVa8oTuQ@mail.gmail.com>
 <7d93080b-68bd-7563-bd3b-e7ee1545e367@intel.com>
In-Reply-To: <7d93080b-68bd-7563-bd3b-e7ee1545e367@intel.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Oct 2018 17:48:30 +0100
Message-ID: <CAG48ez1mY7Osdsc4iJ1JKq=C60wb9bQF=aHbi1fb=pb_V2XMJA@mail.gmail.com>
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
To: Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: wad@chromium.org, Kees Cook <keescook@chromium.org>,
 Linux API <linux-api@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxram@us.ibm.com,
 Andy Lutomirski <luto@amacapital.net>, msammler@mpi-sws.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 5:37 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 10/29/18 9:25 AM, Kees Cook wrote:
> > On Mon, Oct 29, 2018 at 4:23 AM, Michael Sammler <msammler@mpi-sws.org> wrote:
> >> Add the current value of an architecture specific protection keys
> >> register (currently PKRU on x86) to data available for seccomp-bpf
> >> programs to work on. This allows filters based on the currently
> >> enabled protection keys.
>
> How does the current "assignment" of protection keys to the various uses
> get communicated to the filter?

I assume that you first allocate your protection keys, then install the filter?

> I'm not sure this is a great use for PKRU.  I *think* the basic problem
> is that you want to communicate some rights information down into a
> filter, and you want to communicate it with PKRU.  While it's handy to
> have an extra register that nobody (generally) mucks with, I'm not quite
> convinced that we want to repurpose it this way.

That's not how I understand it; I believe that the context is probably
https://arxiv.org/pdf/1801.06822.pdf ?
My understanding is that PKRU is used for lightweight in-process
sandboxing, and to extend this sandbox protection to the syscall
interface, it is necessary to expose PKRU state to seccomp filters.
In other words, this isn't using PKRU exclusively for passing rights
into a filter, but it has to use PKRU anyway.

> Also, I'm not sure the kernel provides the PKRU guarantees you want at
> the moment.  Our implementation *probably* works, but it's mostly by
> accident.
