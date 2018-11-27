Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795EFC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:21:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50292086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9ibnA6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50292086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4349YG0QxJzDqLl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 04:21:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9ibnA6A";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::b43; helo=mail-yb1-xb43.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="M9ibnA6A";
 dkim-atps=neutral
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4349VG4wmjzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 04:18:30 +1100 (AEDT)
Received: by mail-yb1-xb43.google.com with SMTP id a67-v6so7843956ybg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=iLwNo5aAgJoO8A/cQoo9064ETdaZXAxtr4dUxtDa69w=;
 b=M9ibnA6ASmSTYjR5IFCm+HNSGKOaPDY9bmLWq6LFNPOe87RR5IjNj+xpniycTh2GpY
 kvICKSBm9rYWrtM+lf9Fv6e7q1L/iGwDpCrIsjcle4F6ZVWwAYnVfD/yNkyr6OH7W6Pz
 WknVUVsobihyDH/46Eh1Myye6NYd9V2k234u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=iLwNo5aAgJoO8A/cQoo9064ETdaZXAxtr4dUxtDa69w=;
 b=XvSFVp6JRo7pXWHq54ciibPFf5LVLE5itTF+7NS/QK1IORW2euDsXvX94muOK4KXMk
 IXrndYGnHArtYkVI78fxUgXwTubO1ictO9jPh7xsxOCVYg8/ux0DAVbyVtbZjhVdTK1x
 CIJ7n6Q3yRGXSHbOIqdCYUD3Z12Kgt7LFDA/4C5AKj+vpbrMl/ZVBF+g913A3fnrWcpx
 8ewdcJ5893UnlCzyEC/v1Ewa4Q+o0vrn63iiC6ZR2wWADM20BkQyY4KWuatO1jNptFbT
 ULRRus/JpFccJpYfURoBgZHwmFIpi1b1yy+8SpLoSdoN6LpkgL6VxorqUQT+6HWJozpD
 Dp/w==
X-Gm-Message-State: AA+aEWZsMSU15WQOSqUDuZlQJkMH6DuaAQTkPr81kA/MVEsAeABz/7ZW
 K8o+wRUA20AO5tWSE5CoxofdXeloeGk=
X-Google-Smtp-Source: AFSGD/UG+yMjc9P9uKwglMA1NKNk8AOGoRUhvsbQcWY+ZWe4Q/GMkEB6GtGocYB3i0va/aRrG8is+A==
X-Received: by 2002:a25:5284:: with SMTP id
 g126-v6mr8943496ybb.143.1543339107688; 
 Tue, 27 Nov 2018 09:18:27 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com.
 [209.85.219.169])
 by smtp.gmail.com with ESMTPSA id j186sm1065565ywg.36.2018.11.27.09.18.26
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Nov 2018 09:18:26 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id h187-v6so9363290ybg.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:18:26 -0800 (PST)
X-Received: by 2002:a25:1cc1:: with SMTP id
 c184-v6mr34646520ybc.421.1543339106062; 
 Tue, 27 Nov 2018 09:18:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:18:25
 -0800 (PST)
In-Reply-To: <20181127074327.GD13965@kroah.com>
References: <edfe11c6d1f9bb0a7c2cee655895dfeedc1dda5e.1541613057.git.christophe.leroy@c-s.fr>
 <20181127074327.GD13965@kroah.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Nov 2018 09:18:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK3GMAjaHgZ-iDwBogXSt1OQpo_+Bav6OMqz5fRiRf5EA@mail.gmail.com>
Message-ID: <CAGXu5jK3GMAjaHgZ-iDwBogXSt1OQpo_+Bav6OMqz5fRiRf5EA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: print real addresses
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 26, 2018 at 11:43 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Nov 07, 2018 at 08:14:10PM +0000, Christophe Leroy wrote:
>> Today, when doing a lkdtm test before the readiness of the
>> random generator, (ptrval) is printed instead of the address
>> at which it perform the fault:
>>
>> [ 1597.337030] lkdtm: Performing direct entry EXEC_USERSPACE
>> [ 1597.337142] lkdtm: attempting ok execution at (ptrval)
>> [ 1597.337398] lkdtm: attempting bad execution at (ptrval)
>> [ 1597.337460] kernel tried to execute user page (77858000) -exploit attempt? (uid: 0)
>> [ 1597.344769] Unable to handle kernel paging request for instruction fetch
>> [ 1597.351392] Faulting instruction address: 0x77858000
>> [ 1597.356312] Oops: Kernel access of bad area, sig: 11 [#1]
>>
>> If the lkdtm test is done later on, it prints an hashed address.
>>
>> In both cases this is pointless. The purpose of the test is to
>> ensure the kernel generates an Oops at the expected address,
>> so real addresses needs to be printed. This patch fixes that.
>
> I am pretty sure this is intentional.  Kees?

I've gone back and forth on this and in the end I decided I'd wait and
see if anyone was bothered by it besides just me. :) But, yes, for
lkdtm do really do want a "real" view of the pointer because we're
comparing it against page tables and/or kernel section layout, etc.

I've applied this to my lkdtm -next tree. Thanks!

-- 
Kees Cook
