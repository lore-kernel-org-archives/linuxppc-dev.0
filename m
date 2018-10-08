Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F83FC65C20
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:04:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2D22085B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="QS3VYTGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2D22085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TStj5PSZzF3FN
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:04:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=globallogic.com header.i=@globallogic.com header.b="QS3VYTGf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=globallogic.com
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=maksym.kokhan@globallogic.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none)
 header.from=globallogic.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=globallogic.com header.i=@globallogic.com
 header.b="QS3VYTGf"; dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TSqB4vbHzF3Dh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 05:01:42 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id v19-v6so21932338qtg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=globallogic.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f2k0TKw50pOrfGHnaXCp0SuI47IFEOzwJuYb7aXgCKE=;
 b=QS3VYTGf0fifLHmLBkzjBLN6hwaoWTOL6tOK/hCr6D9GzABipc1gMf/rBnbXU5OqD/
 AI5x+qdVEjfbocSHtF1haSOC2Dbd4Gxji7qFMSsvsImKB/Duxy61dIMGNKfRZNrWzXmb
 GuYIvayBgnfeJBlsFBYuXM054yaCNuA636iRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f2k0TKw50pOrfGHnaXCp0SuI47IFEOzwJuYb7aXgCKE=;
 b=AYKrJQviMHupYvCT/po3C3/1QcbADg09+yfj0AOow0tzIffOcXdS+AjitfeDdiFg1L
 xn7oVg9EOi0pWQEXLtoVK1Yv3Jo4yBbQwvMfohJxotx9hyDpUwTBEQXQFm9YDIsmYo5S
 qqCgfw1hIvPyBGMVK7/uUkQjV5grKD7iGxnG6duJvJkakcglWP3dGy6HD9K6eQL5gaxQ
 qFdAW9q0Beo7cjBow9FG2S7EZphnlU6xZAD+UNLrusMCjB5OcZ+nhWRcy9ol86Vy2f8s
 AEeEcywlHNQ8Xj6HZ1a6oHUi5bQi9BjfURw1UUtHqXRlIXL99ZwLjiE4zpYbCxn+4azd
 I55Q==
X-Gm-Message-State: ABuFfojm83CN1z29EmJRTHgF8yTo++ULN0dcUrOuEP+qo17NtKEHyAMS
 +hI/kpkvdfltxsPhb060HNeQjc0+iSsLNfwYIPH/5Q==
X-Google-Smtp-Source: ACcGV60GO9C0aLzJZoqpTqN40b/nvsrtaoyXynAbWGKEBEAgXKyUwq1A+V0K76QFGVdbvejiMcEMz712iVnZLIy9qJk=
X-Received: by 2002:aed:2e04:: with SMTP id
 j4-v6mr19136647qtd.47.1539021699631; 
 Mon, 08 Oct 2018 11:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com>
In-Reply-To: <20180929181725.GB27441@fifo99.com>
From: Maksym Kokhan <maksym.kokhan@globallogic.com>
Date: Mon, 8 Oct 2018 21:01:28 +0300
Message-ID: <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To: Daniel Walker <dwalker@fifo99.com>
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
Cc: linux-mips@linux-mips.org, linux-efi@vger.kernel.org,
 Ruslan Bilovol <rbilovol@cisco.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Frank Rowand <frowand.list@gmail.com>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Daniel Walker <danielwa@cisco.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Bordunov <aborduno@cisco.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi, Daniel

On Sat, Sep 29, 2018 at 9:17 PM <dwalker@fifo99.com> wrote:
>
> On Thu, Sep 27, 2018 at 07:55:08PM +0300, Maksym Kokhan wrote:
> > Daniel Walker (7):
> >   add generic builtin command line
> >   drivers: of: ifdef out cmdline section
> >   x86: convert to generic builtin command line
> >   arm: convert to generic builtin command line
> >   arm64: convert to generic builtin command line
> >   mips: convert to generic builtin command line
> >   powerpc: convert to generic builtin command line
> >
>
> When I originally submitted these I had a very good conversion with Rob Herring
> on the device tree changes. It seemed fairly clear that my approach in these
> changes could be done better. It effected specifically arm64, but a lot of other
> platforms use the device tree integrally. With arm64 you can reduce the changes
> down to only Kconfig changes, and that would likely be the case for many of the
> other architecture. I made patches to do this a while back, but have not had
> time to test them and push them out.

Can you please share this patches? I could test them and use to improve this
generic command line implementation.

> In terms of mips I think there's a fair amount of work needed to pull out their
> architecture specific mangling into something generic. Part of my motivation for
> these was to take the architecture specific feature and open that up for all the
> architecture. So it makes sense that the mips changes should become part of
> that.

This is really makes sense, and we have intentions to implement it
afterward. It would be easier to initially merge this simple
implementation and then develop it step by step.

> The only changes which have no comments are the generic changes, x86, and
> powerpc. Those patches have been used at Cisco for years with no issues.
> I added those changes into my -next tree for a round of testing. Assuming there
> are no issues I can work out the merging with the architecture maintainers.
> As for the other changes I think they can be done in time, as long as the
> generic parts of upstream the rest can be worked on by any of the architecture
> developers.

Thanks,
Maksym
