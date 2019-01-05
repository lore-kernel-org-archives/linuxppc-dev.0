Return-Path: <SRS0=xMQ5=PN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71737C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 19:52:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFD720675
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Jan 2019 19:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VmxmtenY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFD720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43XC3x2S43zDqHV
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jan 2019 06:52:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="VmxmtenY"; dkim-atps=neutral
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43XC234h3yzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jan 2019 06:50:50 +1100 (AEDT)
Received: by mail-lf1-x135.google.com with SMTP id i26so27631903lfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Jan 2019 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3gtEwaNEjdCPGtTV4trcD0HAWT7H2A0cIc7LlFZEwkA=;
 b=VmxmtenY0hqZ43PiYoxT6Af0o//0e6oNsWTVsnZU9p5aoauCFoF/yN8ifsNeHxQFDf
 3JRiLxvtKiG1Q7ByKKjj5xV4EV4St/RySjEaDLuE4qmmD/u8r1fP7gDRwWKCQC3AbkeK
 4neRr9b86Gpjk5I1bvrQ8wrtQRQEVRp3AmlXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3gtEwaNEjdCPGtTV4trcD0HAWT7H2A0cIc7LlFZEwkA=;
 b=FCI73U+0+WqlsfnV/7ND+gpeJvzoz4B4G6jMKPo1DXFOWcOvUYE8DT2bHXRj3DGO6u
 mT0fU35Hes4yTP0P5Yqdc4WaHRW5GIuTwBvwU1e0yzHW+InRXGJicC8EZ2XZYxigussg
 ZAXB73tTnQfHnAVtpLB6mYK7hKQfs8WrjJpZ0ffi/4be9Ocx0kVg6Z3nvkl1lN7O2srm
 RXNbchIOmMrdgcP7dnmRTyCEPajA1Z2ABTSxhJWvYov8WgzQxniyS/5gEvjM+r1Yrzcs
 S0prPEt2+9CC2quMCsKRMAJPuEXSysTVJ/QIO6PKfvV9e9jLmpOg9if+amyBlqf+oM++
 9K/A==
X-Gm-Message-State: AA+aEWZrliegrk6paNkomCM12EgVUQmuH+Js2Sp/qbWIbnoNMthubJfl
 u9+VU1U04VovJi0CbjF+FStXw64gCC8=
X-Google-Smtp-Source: AFSGD/Vn6Eg4xmfFXHtRgDul5O2ZovFXrpez9mnrGLxhlsLe6/8jmN3DxT1YjvaA2d1fj2z5rf+7Rw==
X-Received: by 2002:a19:1a14:: with SMTP id a20mr26414733lfa.1.1546717846918; 
 Sat, 05 Jan 2019 11:50:46 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id b21sm11750299lfi.7.2019.01.05.11.50.45
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Jan 2019 11:50:46 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id u89-v6so35134332lje.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Jan 2019 11:50:45 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id
 s2-v6mr31179695ljs.118.1546717845563; 
 Sat, 05 Jan 2019 11:50:45 -0800 (PST)
MIME-Version: 1.0
References: <87ftu8y3vw.fsf@concordia.ellerman.id.au>
 <877efjxquj.fsf@concordia.ellerman.id.au>
In-Reply-To: <877efjxquj.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Jan 2019 11:50:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiE-_Dc7FDirP=_QGYt6pU7TEYdbGhCTeDnasj5s1uOOQ@mail.gmail.com>
Message-ID: <CAHk-=wiE-_Dc7FDirP=_QGYt6pU7TEYdbGhCTeDnasj5s1uOOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.21-2 tag
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
Cc: diana.craciun@nxp.com, Mathieu Malaterre <malat@debian.org>,
 linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, chunkeey@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 5, 2019 at 3:53 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >   powerpc: Drop use of 'type' from access_ok() (2019-01-04 23:07:59 +1100)
>
> I see you've fixed this in your tree already.

No problem. It was my mess-up to begin with, and I just did the
obvious resolution (only difference between our fixes was whitespace,
and that I obviously also fixed up sparc32 as well).

                 Linus
