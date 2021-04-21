Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46B6C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 02:24:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3568861413
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 02:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3568861413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQ4BW3FKdz30DT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 12:24:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=aiC0xXu0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b34;
 helo=mail-yb1-xb34.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=aiC0xXu0; dkim-atps=neutral
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQ4B25KmBz2xZj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 12:24:08 +1000 (AEST)
Received: by mail-yb1-xb34.google.com with SMTP id p202so1800722ybg.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Apr 2021 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aUd0rlyTJsHIyxAtkp6ITtvZKr4JaYN52eEf+GEPEHc=;
 b=aiC0xXu0EaC3i7AY09GnTA/b+S4XriNAO7cmw0l5RDOAmQVkLxjA55vl0w2bJtdzoD
 7hYxDjgoFezUn2Ilq5VDTzfjnLjSNnxnXnSwAK8juYaS+KZ+hbut92xRPywgKBKxyYVr
 7TONhBVJEVMl3UOar3QWgVpUu+tR3VrWuZ8kVVHY28Fu9mQw2P6yQYl8LK46eN1/bg70
 c4V7XkeDm2bpzX3VJUv/kgtpioBfyMA0eMZirEK7hJ913gyaxpuCUfRtaQYtw0PpIG9t
 cejn+CpRuX2pWgMpsX7l8MQwi2wc/DDtZ4iHujb67QaSV35GZrjUZbTN6jwUwt8V/0ut
 kRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aUd0rlyTJsHIyxAtkp6ITtvZKr4JaYN52eEf+GEPEHc=;
 b=BSr44BYzOxzPBaaUXd1lpJr29ERZliLRA6AR/Mo8SqYqUBGZgfzH4iLyaMMetzHIQc
 DnqhC2XikLythbSKxds6vBBlHnn3FQHoAwrwUdOzOxeXJCMWUmodqHjNp9cdw7M83rcw
 /SuIJYO99+7JURRo31tPPoC2yT8c//hh85KR1OGfnuqTPpskkMGIhF3YiiQmf+53UGZq
 r6hz3o+OZY7t8SPeisq/1X4vm0pWdEcMGlARGBBwmOpcCsJDzBnp3iCGfaDQyIJy6Inu
 3iBupuyAMK5wetfBv08LcERfJKj13C4nKBN6VV+TLAV+WKTZ/lp9UpXkJ0RLwqmEbq9B
 rM+w==
X-Gm-Message-State: AOAM531KRAfYKrozGlZDLPmg1u1cj59xy8dvPDcJ1eYlcgNtk3wZBkzl
 PTuxR3Q1gavFtHLgt2r57Ijr0h10aKFYvFcugbM=
X-Google-Smtp-Source: ABdhPJzaDjuBw4gtQYvvvxcCC6ROb2/vKvLkZYad1aMYY10f9PXU1GMsTYa98K1/rOQjteFfXi/2Wwa8BtV4BPOLql8=
X-Received: by 2002:a25:5146:: with SMTP id f67mr28436206ybb.332.1618971844317; 
 Tue, 20 Apr 2021 19:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210330045132.722243-1-jniethe5@gmail.com>
 <20210330045132.722243-7-jniethe5@gmail.com>
 <87im577eh3.fsf@mpe.ellerman.id.au>
In-Reply-To: <87im577eh3.fsf@mpe.ellerman.id.au>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Wed, 21 Apr 2021 12:23:53 +1000
Message-ID: <CACzsE9pgZRaoHT0Ca=NB3srEMJMvLuiFkYA98xFDiUPyfmoV5Q@mail.gmail.com>
Subject: Re: [PATCH v10 06/10] powerpc/mm/ptdump: debugfs handler for W+X
 checks at runtime
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: ajd@linux.ibm.com, Kees Cook <keescook@chromium.org>, cmr@codefail.de,
 Nicholas Piggin <npiggin@gmail.com>, naveen.n.rao@linux.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 31, 2021 at 10:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Jordan Niethe <jniethe5@gmail.com> writes:
> > From: Russell Currey <ruscur@russell.cc>
> >
> > Optionally run W+X checks when dumping pagetable information to
> > debugfs' kernel_page_tables.
> >
> > To use:
> >     $ echo 1 > /sys/kernel/debug/check_wx_pages
> >     $ cat /sys/kernel/debug/kernel_page_tables
> >
> > and check the kernel log.  Useful for testing strict module RWX.
> >
> > To disable W+X checks:
> >       $ echo 0 > /sys/kernel/debug/check_wx_pages
> >
> > Update the Kconfig entry to reflect this.
> >
> > Also fix a typo.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > [jpn: Change check_wx_pages to act as mode bit affecting
> >       kernel_page_tables instead of triggering action on its own]
> > Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> > ---
> > v10: check_wx_pages now affects kernel_page_tables rather then triggers
> >      its own action.
>
> Hmm. I liked the old version better :)
>
> I think you changed it based on Christophe's comment:
>
>   Why not just perform the test everytime someone dumps kernel_page_tables ?
>
>
> But I think he meant *always* do the check when someone dumps
> kernel_page_tables, not have another file to enable checking and then
> require someone to dump kernel_page_tables to do the actual check.
Yes, I guess I misinterpreted that.
>
> Still I like the previous version where you can do the checks
> separately, without having to dump the page tables, because dumping can
> sometimes take quite a while.
>
> What would be even better is if ptdump_check_wx() returned an error when
> wx pages were found, and that was plumbed out to the debugs file. That
> way you can script around it.
Ok I'll go back to how it was and add in returning an error.
>
> cheers
