Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C6BC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:24:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE4F21738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE4F21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SxMN0cKqzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 23:24:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43SxFP5cJ3zDqJc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 23:19:21 +1100 (AEDT)
Received: by mail-qt1-f194.google.com with SMTP id y20so29133590qtm.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 04:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LtZXBXSwQzuhM6llgbZc1NEGQibmPDxx7rAlim7Nhm0=;
 b=JV+Muwgz0OYw6iWNjlfmXXu/xNpyYhXaGGdI7/V+5pbFvYdaXzCW59jCxEmAsEcNdK
 PShycjMCLKIfU/STgwz/aBsN42LZ/9wKkI17OjfQXeqkNgW5G0+VO8cYXuG6IhHOVBg6
 4Fg8iye2dZKM4ZFMEp1J2Jg5RYg0Nbd6ZGmrYgXFr+s9C0zuNfVFAQqBwwPHdAhitKjh
 pJXKl7VbfN2AUbWhtO6nGbyxsqp2/OjTdS1NjbTx2h2dHVzFjRnBs5Jb6MVMNdU+IWtc
 +h0A4281z2/CdQxaHZlrDglEAQ6L7V+EUvs/6ht65g+SHBvh7vQP6PqNJDhzAFj1hWd1
 brVQ==
X-Gm-Message-State: AJcUukeP2aN0BiA4tb7serWxHs6i788zIhh+OIPomyBmhl+w0HVZZRPo
 JohjJkKAOTn8JFzFlc/3QXaGqUycJxfZSeqQTpE=
X-Google-Smtp-Source: ALg8bN4oVjvi2Q14NJJtP8prMbk3T1Rd1/JF9EUL0lUZ8LZc/JYzPccFVMlzIZtenBQWTy7yJiaL6KrX0cDNvAcpXBw=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr35156465qvm.149.1546258759237; 
 Mon, 31 Dec 2018 04:19:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
 <alpine.LNX.2.21.1812301750320.424@nippy.intranet>
 <20181230185300.Horde.o5iU5x8n8UeDsyjemaBU_w7@messagerie.si.c-s.fr>
 <alpine.LNX.2.21.1812310847210.444@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812310847210.444@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Dec 2018 13:19:03 +0100
Message-ID: <CAK8P3a09GW_r6L74LtaPKdjcPONk7qweLMuCgrw=7daQ5tBcCQ@mail.gmail.com>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 30, 2018 at 11:12 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sun, 30 Dec 2018, LEROY Christophe wrote:

> But I'm over-simplifying. Arnd's alternative actually goes like this,
>
> #if defined(CONFIG_MAC) && !defined(CONFIG_ATARI)
> const struct nvram_ops arch_nvram_ops = {
>         /* ... */
> }
> #elif !defined(CONFIG_MAC) && defined(CONFIG_ATARI)
> const struct nvram_ops arch_nvram_ops = {
>         /* ... */
> }
> #elif defined(CONFIG_MAC) && defined(CONFIG_ATARI)
> const struct nvram_ops arch_nvram_ops = {
>         /* ... */
> }
> #endif
>
> So, you're right, this isn't "duplication", it's "triplication".

Ok, I failed to realized that MAC and ATARI are not mutually exclusive.
I agree that your original version is best then.

       Arnd
