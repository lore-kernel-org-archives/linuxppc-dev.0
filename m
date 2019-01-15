Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C3DC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:32:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7AF20657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 16:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7AF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fG8S6PPhzDqX9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 03:32:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fG6p0LQQzDqC9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:30:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fG6n6mMTz8tFS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:30:57 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fG6n6MPYz9sDB; Wed, 16 Jan 2019 03:30:57 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fG6n2wwmz9sCs
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 03:30:57 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id y20so3550247qtm.13
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2019 08:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/amndcJcfW1SK/+m/Y5kbHQg99CPR00NbuyxNYL6Afc=;
 b=hxORsKAQAeTHGPmazLIEeZ14iWnNBNRZw9BpT5cu1yH4AVAjv/Uhvw1nBerXTVQOur
 y5U8hg+GpBhh4ayWjtay2p1FeQi2ChHIb2WEPQzao8CUpgvqockubUNCFMRkLYHj6jkU
 W1IT1I4Gy/azKwrL6DBJ7jVNv4LT7oP2tQYLhpuYTSujJaJPmQh3DrkSlXOLww1a2qPg
 m521egBMnW5IQck2NwztZdODlcIkQyYqiDxCW5EhfEVzPuHccg/2jS77vy2REa0KgBYQ
 1emMWMKh2WnguatFPptWci8b9VKrujQQZm1kiQKThBaugk8lnWEhdyx7aWv7ISZ2PKtg
 vzrw==
X-Gm-Message-State: AJcUukf0d7XcfpBzN6GIN3hYiQNKCcFOh3+yr9mgusQ3zVVm6QyYhBkZ
 XOiglOWYKXVi6NAhqUt+N9Btmui6YiFMLU6pKgQ=
X-Google-Smtp-Source: ALg8bN53WfpjN7Kuz33kA6KZYIxkkSaz5835OGdarBLSpS1BZTHm4euoaPWLod/oE4v96P8aOpK0H0IsFQZumpkeCPw=
X-Received: by 2002:a05:6214:1087:: with SMTP id
 o7mr3598899qvr.115.1547569855503; 
 Tue, 15 Jan 2019 08:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20190114113620.17558-1-mpe@ellerman.id.au>
 <20190114113620.17558-3-mpe@ellerman.id.au>
In-Reply-To: <20190114113620.17558-3-mpe@ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 17:30:38 +0100
Message-ID: <CAK8P3a1X5e=DvJM_0RsKXnpPZ=QWG48+JOyCdyHDQBMS45L3_w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] powerpc/syscalls: Split SPU-ness out of ABI
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
Cc: linuxppc-dev@ozlabs.org, Firoz Khan <firoz.khan@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 14, 2019 at 12:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Using the ABI field to encode whether a syscall is usable by SPU
> programs or not is a bit of kludge.
>
> The ABI of the syscall doesn't change depending on the SPU-ness, but
> in order to make the syscall generation work we have to pretend that
> it does.
>
> It also means we have more duplicated syscall lines than we need to,
> and the SPU logic is not well contained, instead all of the syscall
> generation targets need to know if they are spu or nospu.
>
> So instead add another column to the table which is a boolean SPU
> field. If the field has the value "spu" then the syscall is available
> to SPU programs, any other value means the syscall is not available to
> SPu programs.

This change unfortunately makes the format of the file incompatible
with the other architectures, which prevents us from adding common
scripts.

There are obviously the existing scripts that we want to generalize
across architectures, but also further ones, like a suggestion by
David Miller to check that each native 32-bit syscall comes with
a matching compat syscall.

       Arnd
