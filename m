Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:18:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE922080F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 00:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NON7VxcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE922080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Bkf4349zDqTR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:18:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::941; helo=mail-ua1-x941.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="NON7VxcJ";
 dkim-atps=neutral
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com
 [IPv6:2607:f8b0:4864:20::941])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Bht3CHMzDqSY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 11:16:30 +1100 (AEDT)
Received: by mail-ua1-x941.google.com with SMTP id a42so451795uad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 16:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AoWMtIV9BjXIPc20XxfyIRC43G0u1RbPWkNgUcYk4Q8=;
 b=NON7VxcJEE7WKDxxCeuaLczyqOKpBeyge1Sj7SUw/Q6OvCTd9/ggI1OAlh+L2dsMht
 hrxehbNLMgSpGEL7+Ektn6Avmj1+PnhKbjQzWU/J8dAji46kRlgbEVBrn5joK+ynXPbn
 M2VynFuxkTuihNwc2Fw1y7p11t4fl46FdSjY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AoWMtIV9BjXIPc20XxfyIRC43G0u1RbPWkNgUcYk4Q8=;
 b=qe8WUHqHo4T4Mz2Y1yoZ7sKBhDtoSGzoHUQHk3Lf9T7JU8gnfHXUu3BZzl7KnVHhKD
 Y5m/lmfwxKmlj9/NuBFjCI6vRdkZtIfEUWLPHT0XmTQ+bT35mlghl7n7IQW3NdYhMQkL
 9zoPBmfjCcZ4hDsXHuHMO1AF/xK7pUsuTfmM1cin+Fd/Cl9ob2G8a7ixrvbtz1pnqpUB
 7sbw59WZDwf6MD5Y20MiL702aP8rHE806ZtqDROe3P29u2RK45SJHzJIBs/Sg0/Ogr2s
 tqRTljDDXSJSkg7PsoM3q/aBH2fTZwd1lcCbnRB4aXoISuXk5Jb8bMNRHEmjaIRicLyr
 bGyA==
X-Gm-Message-State: AHQUAua8Q74TiPoEO1DtzT2yTfnaoQlytfPluXYxZQXjh1rZFMdR0CKZ
 DNrtxKhMRys6Ma59mjFJ9BjCWjJwTZU=
X-Google-Smtp-Source: AHgI3IY4Ni6X/MvkexAfbm5qnPhkFqgK99LOwubwMKTwk2CZl1d9ZQzmJnlnZpO1xgJlLY5GClKSgA==
X-Received: by 2002:a67:c98c:: with SMTP id y12mr797922vsk.60.1550794587108;
 Thu, 21 Feb 2019 16:16:27 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com.
 [209.85.222.49])
 by smtp.gmail.com with ESMTPSA id q199sm102002vke.23.2019.02.21.16.16.24
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 16:16:25 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id s15so423049uap.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 16:16:24 -0800 (PST)
X-Received: by 2002:a67:fe97:: with SMTP id b23mr32945vsr.66.1550794584524;
 Thu, 21 Feb 2019 16:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20190221093601.27920-1-ruscur@russell.cc>
 <CAGXu5j+P1wh0uf1kfMywSTo4NYtwFPSnKXg6wbfyBRqwVRZVYA@mail.gmail.com>
 <8ef1669cdfbcc6114eebc30c610c91c191c7cc7a.camel@russell.cc>
In-Reply-To: <8ef1669cdfbcc6114eebc30c610c91c191c7cc7a.camel@russell.cc>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 21 Feb 2019 16:16:12 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL0ZOzTo2sXiWkgemcwHusX4YuM9b_9y-MZ2THuDoRC+g@mail.gmail.com>
Message-ID: <CAGXu5jL0ZOzTo2sXiWkgemcwHusX4YuM9b_9y-MZ2THuDoRC+g@mail.gmail.com>
Subject: Re: [PATCH 0/7] Kernel Userspace Protection for radix
To: Russell Currey <ruscur@russell.cc>
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Nick Piggin <npiggin@gmail.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 21, 2019 at 4:09 PM Russell Currey <ruscur@russell.cc> wrote:
> On Thu, 2019-02-21 at 08:07 -0800, Kees Cook wrote:
> > On Thu, Feb 21, 2019 at 1:36 AM Russell Currey <ruscur@russell.cc>
> > wrote:
> > > The first three patches of these series are from Christophe's work
> > > and are
> > > the bare minimum framework needed to implement the support for
> > > radix.
> > >
> > > In patch 3, I have removed from Christophe's patch my
> > > implementation of
> > > the 64-bit exception handling code, since we don't have an answer
> > > for
> > > making nested exceptions work yet.  This is mentioned in the final
> > > KUAP
> > > patch.  Regardless, this is still a significant security
> > > improvement
> > > and greatly narrows the attack surface.
> >
> > Nice! Am I understanding correctly that with this series powerpc9 and
> > later, using radix, will pass the lkdtm tests for KUAP and KUEP (i.e.
> > EXEC_USERSPACE and ACCESS_USERSPACE)?
>
> Yes!  We've had execution prevention for a while on radix (which is
> default on POWER9) since 3b10d0095a1e, the only functional thing this
> series does is allow disabling it with nosmep.  This series adds access
> prevention.

Ah-ha; excellent. And CONFIG_PPC_RADIX_MMU is "default y" already. :)

-- 
Kees Cook
