Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A5C04AB5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 12:10:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25F12070B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 12:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAtfIILd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25F12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KPcW6L0jzDqg4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 22:10:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AAtfIILd"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45KPZ11PwMzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2019 22:08:09 +1000 (AEST)
Received: by mail-it1-x142.google.com with SMTP id h20so2727420itk.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jun 2019 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dZ7R0pcXA65PXniczVNE7XA0L8Asj1FxMwzaYfr9tp0=;
 b=AAtfIILdQAkBLgG0upntqLzSwtwspE9LuROSskeXQSGVHkW/JZJXM1aLo7VT7zhH5I
 S9WtYibb2Cj+qHHT8/2rVPSDPvzPqAFHhkL92NOdxsaHz97TWjgUH6jquViDUkIa2Gwn
 Nq7gwocMm2NbInnFzu8LFbHFfl11C+2rWPAUi1+J4E/sZQJ4/gy6jgPVesGkySKqlB6o
 Dx8yeCC0T7b87SPrd2qdv7esEXduKqGDH9cUPupUQU/w/YlHK/i+/a1MOKhafR8Jp9PP
 zyBx3h0qGsrFrrQ3rHC0YnSyMQqK13z5QGc/HgSL+ngZ+AkuUcsBdttkfXql5m4vMd3c
 VXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dZ7R0pcXA65PXniczVNE7XA0L8Asj1FxMwzaYfr9tp0=;
 b=az/sygXh73dFwJYw8BpKUDcKGLxxePtivFRM7jg5CbyY2DkCkD0YPLywZCbtvyNAfq
 MXPg7Ijew3+QKXzxvnIz28Nk2w2gSg5gDePY7m/T6fhHbYSvLeqQLyXcEfUWAcqXO4V0
 rG2POkLEZl80i1zPuFxoJhbIZS3hv2qXXHSP/q50otAsB9d1JZT2qTwU2EaHchsJRT0u
 Uw7p8ioU27EdMY9v+R/WulOwEIplo2aiMxn3JCteuKqxI1Hk0ntx7Wd/iWpyeWTkNfR8
 gQYdEAVfpWLLMqVpchqkCWlyMKCZdNW8dbmesD4+hJ1FMLQ/Ckdozi3qHFzjj4/pKTul
 v8+g==
X-Gm-Message-State: APjAAAWvXfnB0VVFD8/s/dGNQ+BQwcNg3nC8NFi2Gw97TZhNB054TeU8
 tf7D5LcTBwvjZuS7IHXExlj+nxRlDu5jEyUn2UU=
X-Google-Smtp-Source: APXvYqyOTE4GT8vWWdF91SU85htM+ex0Uy5QBCXBLYg9jnh2e7xZ2Ow6/H+m3BwA/eqLoJ1vHYhnrOmiSdq677k4LBQ=
X-Received: by 2002:a24:d145:: with SMTP id w66mr29390110itg.71.1559822885848; 
 Thu, 06 Jun 2019 05:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190530070355.121802-1-aik@ozlabs.ru>
 <deb34b5f-9472-2156-e58d-8dbcb0a38979@anastas.io>
 <4003261.yxAxO8Uj8t@townsend>
In-Reply-To: <4003261.yxAxO8Uj8t@townsend>
From: Oliver <oohall@gmail.com>
Date: Thu, 6 Jun 2019 22:07:54 +1000
Message-ID: <CAOSf1CEKwFHLHLC+CAiEiH=9v+hfRgTSuNUH3hXR4eDyQM1G9g@mail.gmail.com>
Subject: Re: [PATCH kernel v3 0/3] powerpc/ioda2: Yet another attempt to allow
 DMA masks between 32 and 59
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Shawn Anastasio <shawn@anastas.io>,
 David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sam Bobroff <sbobroff@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 6, 2019 at 5:17 PM Alistair Popple <alistair@popple.id.au> wrote:
>
> I have been hitting EEH address errors testing this with some network
> cards which map/unmap DMA addresses more frequently. For example:
>
> PHB4 PHB#5 Diag-data (Version: 1)
> brdgCtl:    00000002
> RootSts:    00060020 00402000 a0220008 00100107 00000800
> PhbSts:     0000001c00000000 0000001c00000000
> Lem:        0000000100000080 0000000000000000 0000000000000080
> PhbErr:     0000028000000000 0000020000000000 2148000098000240 a008400000000000
> RxeTceErr:  2000000000000000 2000000000000000 c000000000000000 0000000000000000
> PblErr:     0000000000020000 0000000000020000 0000000000000000 0000000000000000
> RegbErr:    0000004000000000 0000004000000000 61000c4800000000 0000000000000000
> PE[000] A/B: 8300b03800000000 8000000000000000
>
> Interestingly the PE[000] A/B data is the same across different cards
> and drivers.

TCE page fault due to permissions so odds are the DMA address was unmapped.

What cards did you get this with? I tried with one of the common
BCM5719 NICs and generated network traffic by using rsync to copy a
linux git tree to the system and it worked fine.
