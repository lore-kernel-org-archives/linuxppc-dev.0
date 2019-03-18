Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D99C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 20:06:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551F620989
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 20:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7d+6Fob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551F620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NRym3GLWzDqP6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 07:06:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="e7d+6Fob"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NRwz03WZzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 07:04:50 +1100 (AEDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9A96217F4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1552939488;
 bh=VxP+vAro5vjl+5TW9HBLtbTDE0dvcAVdcTwI/Q3IDxM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=e7d+6Fob+r60jqntGxl0h2CUy/r3aqHdTZ76jqw4a/9SJn8mCMQ9CNRj8fLVhdDZ0
 KhbnKl9+NrTxxbtHOuowKLNayd4qh/ZuLMvi6Xuh/uM0c3LPA0DJYThybTlEtdZEyM
 vezDSpreM/7fFZNIp+BhlHrcJU08bW/8Tt8PyjiM=
Received: by mail-wm1-f49.google.com with SMTP id 4so14307198wmf.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 13:04:47 -0700 (PDT)
X-Gm-Message-State: APjAAAXj6mCvbah2ltJLrnERR2jUHRpmj7V8Ajmy2TtzyLWG323pLP07
 O3sjv7nZLB2eRCFTdM0TO5N8bh6uh8FMF1vYr8Z2cQ==
X-Google-Smtp-Source: APXvYqx0Qp0LaqRE7TDSGtKjrBxrV1SRYxrd9ZsByp+J6+nszeCFG/2GlsipIJinh1+fUEuFHdnHaG+CvXROayqeoko=
X-Received: by 2002:a1c:eb14:: with SMTP id j20mr537361wmh.32.1552939486176;
 Mon, 18 Mar 2019 13:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190318104925.16600-1-sudeep.holla@arm.com>
In-Reply-To: <20190318104925.16600-1-sudeep.holla@arm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 18 Mar 2019 13:04:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXneXdPG246B=Sa4R+MG7r-RwVDA1W3bRPzDwAUCai=xQ@mail.gmail.com>
Message-ID: <CALCETrXneXdPG246B=Sa4R+MG7r-RwVDA1W3bRPzDwAUCai=xQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ptrace: consolidate PTRACE_SYSEMU handling and add
 support for arm64
To: Sudeep Holla <sudeep.holla@arm.com>
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
Cc: Haibo Xu <haibo.xu@arm.com>, Steve Capper <Steve.Capper@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jeff Dike <jdike@addtoit.com>,
 X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Bin Lu <bin.lu@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 18, 2019 at 3:49 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi,
>
> This patchset evolved from the discussion in the thread[0][1]. When we
> wanted to add PTRACE_SYSEMU support to ARM64, we thought instead of
> duplicating what other architectures like x86 and powerpc have done,
> let consolidate the existing support and move it to the core as there's
> nothing arch specific in it.
>

In the discussion from the first version, there was talk of some
testing.  Can you put the test cases in question into v3?

--Andy
