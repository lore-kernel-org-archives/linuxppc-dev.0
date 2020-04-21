Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2DAC38A30
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 02:00:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A702070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 02:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvz4lDs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A702070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495mx96h4CzDqwp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 12:00:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::143;
 helo=mail-il1-x143.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hvz4lDs9; dkim-atps=neutral
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495mvC3xX0zDqf2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 11:58:45 +1000 (AEST)
Received: by mail-il1-x143.google.com with SMTP id e8so4820001ilm.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2020 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ONgdaEdtwOtE1WbHzK6vrYxtnxLIZri6ebqz7byTJDo=;
 b=hvz4lDs9FTApEW/Q+q7Lg8c7TUBtGbya2ZA6uOh7zAyvLFuYCf+KRquoKwf5jwufER
 el61XOgassgzdTL1NbmHfy24gl1q+Upg6zP+lPWf/Jf0TAeORYg+uV9b8K0q/uMVWYkz
 jz5QjcR8VcgeLkOK0Xq54g7SHE+sjMvMk8H3ob/i3huAgLREh39RI3eS+vElRQn7Y5EL
 V4u99YupAA4oj3k1Uq8Dg8TJV4AbArpLp6P0zX5TmzC0AfrbXzhgPd6a+Z4EWw9K5NF/
 oPQhOANgCuGiqR5b/YE7mME6tWEh6HTBjDAvUnD9kX+M31pFVtJSBCoWi6gvaat9+3uU
 qK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ONgdaEdtwOtE1WbHzK6vrYxtnxLIZri6ebqz7byTJDo=;
 b=qyF8aFdMHExEOa0K7EEQ2cZsR5ObrwGbf3tWM59lfAqpkVan5MsB5dXLGIKeziFQCS
 Eg305JeDCa27PjgP7cMFt6w5e7gcI7bbGIbWrdY1hrosz7IB+3Yv9+FXFE9fdfCj26ZF
 Pc8l79+z+tnBM1zQRsCnhRc3VYUPP0RmzzXHzsXXSBPAiDdWjIS1nF3gYQF48Enb1yRv
 JZxf9/ybir8R23A4AnGaY6F9H9DtRR0OGofuAKxBgGbqBjaCBckiT7UaR6WF5JeFjkx0
 jJtoS+n27RYTlMccF5/xIb1xTSD3g5kmKcUnaIbgP8wN/jyR5FhshpgG3soLxiwJNtim
 z0/w==
X-Gm-Message-State: AGi0PuYlZiOuNmmGuA2G2uIyZdl0hLyfWtKa8OdXKImYOOf2RmPlbQZJ
 0BS9YB/a2eqWLTYQzNLd84POl7sawLWAYTq0WxI=
X-Google-Smtp-Source: APiQypIRSdeCAPO6xtjbkgA52uU91mLQqeCJ51kpXhikQ3qsaQ5mH57PVbWixXkGa7edxA/byCfsQtC0EQXrqFZZrc8=
X-Received: by 2002:a92:7c01:: with SMTP id x1mr11427717ilc.122.1587434322401; 
 Mon, 20 Apr 2020 18:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200403041055.27535-1-alistair@popple.id.au>
 <20200403153208.GI26902@gate.crashing.org>
 <2217912.fZQhC0vD34@townsend> <2992996.BaUphQCMZx@townsend>
In-Reply-To: <2992996.BaUphQCMZx@townsend>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 21 Apr 2020 11:58:31 +1000
Message-ID: <CAOSf1CGP02VW9adNyBcHF4_BZiv-jKohH4qihj7BmEgAif0VLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: Add base support for ISA v3.1
To: Alistair Popple <alistair@popple.id.au>
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
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 21, 2020 at 11:53 AM Alistair Popple <alistair@popple.id.au> wrote:
>
> On Tuesday, 21 April 2020 11:30:52 AM AEST Alistair Popple wrote:
> > On Saturday, 4 April 2020 2:32:08 AM AEST Segher Boessenkool wrote:
> > > Hi!
> > >
> > > On Fri, Apr 03, 2020 at 03:10:54PM +1100, Alistair Popple wrote:
> > > > +#define   PCR_ARCH_300   0x10            /* Architecture 3.00 */
> > >
> > > It's called 3.0, not 3.00?
> >
> > Thanks. I'll fix that up.
>
> Actually we have already defined it upstream as CPU_FTR_ARCH_300 in arch/
> powerpc/include/asm/cputable.h and PVR_ARCH_300 in arch/powerpc/include/asm/
> reg.h so for consistency we should make it the same here. So either we leave
> this patch as is or we change it to PCR_ARCH_30 along with the existing
> upstream #defines. Thoughts?

I used 300 for consistency with the existing three digit definitions
when I added the CPU_FTR macro. It doesn't really matter since these
are all internal definitions, but I SAY THE BIKESHED SHOULD BE THREE
DIGITS LONG.

Oliver
