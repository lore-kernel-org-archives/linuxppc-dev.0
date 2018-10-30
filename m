Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0550C6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:02:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181AC2082D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngqvoVqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181AC2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kvpn071DzF1Q4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:02:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ngqvoVqC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ngqvoVqC"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kvm22J39zF1Cr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 02:00:33 +1100 (AEDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D509120831
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1540911631;
 bh=Hc+hlHS3aRqyDEd1NfDRRTBYE0yYIaFyC57wsxwYOpI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ngqvoVqCSBhB+J5HbBcWWUBK++pQ7yhgMHjacsF9SHSWm98yElwMezH2HEbqNrvIN
 xsAj1QZtfMb2l2gNhvuMSHa0mzuHKvm6k3Sj89o/SFRldzQFjp7QphU8jP5/XtXsaT
 UMgj5jzxAphg3mWcQOTkBMB1FnD9hjPynN6ToN6M=
Received: by mail-wm1-f46.google.com with SMTP id w7-v6so1069478wmc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 08:00:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJzZARk8SM936399++K6NEaiiX2/UcF3npPsd+J4mt6AI+r7KFR
 qaPD10LDjC20S04aAWJeXR9BPaHvokyDlNpDhq5IIg==
X-Google-Smtp-Source: AJdET5eADw3llxB/QBHgPe0GjVPIR6TXmPb0lrHJDbFObJY6D6ehsaXkO7rrxhzxm2c5cV7NAU0kXA4F9DCdZ77Dv7M=
X-Received: by 2002:a1c:b20b:: with SMTP id
 b11-v6mr2081584wmf.64.1540911629267; 
 Tue, 30 Oct 2018 08:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-2-robh@kernel.org>
 <874ld3jz6v.fsf@concordia.ellerman.id.au>
 <871s87jz3g.fsf@concordia.ellerman.id.au>
In-Reply-To: <871s87jz3g.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Oct 2018 10:00:17 -0500
X-Gmail-Original-Message-ID: <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
Message-ID: <CABGGisw_bd+bJedZ_T2e-dxmRnXf2N_gGBZj8u+QVGQxj_gc+Q@mail.gmail.com>
Subject: Re: [PATCH 01/21] of: Add cpu node iterator for_each_of_cpu_node()
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 30, 2018 at 9:20 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Hi Rob,
> >
> > Sorry I missed this when you posted it.
> >
> > Rob Herring <robh@kernel.org> writes:
> >> Iterating thru cpu nodes is a common pattern. Create a common iterator
> >> which can find child nodes either by node name or device_type == cpu.
> >> Using the former will allow for eventually dropping device_type
> >> properties which are deprecated for FDT.
> >
> > Device trees we see on powerpc generally don't (never?) use "cpu" as the
> > node name for CPU nodes. And many of those device trees come from
> > firmware, so we can't update them.
> >
> > So dropping support for device_type is a non-starter from our POV.
>
> ps. presumably that's what you meant by deprecated *for FDT*.

Right.

> But anyway just wanted to make sure we are on the same page.

Yes, I was aware at least older powerpc DTs don't use 'cpu' for node names.

Rob
