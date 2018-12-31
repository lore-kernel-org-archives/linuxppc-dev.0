Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219D1C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:27:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B29721738
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B29721738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SxQ86KVxzDqKG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 23:26:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43SxKm17Z8zDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 23:23:06 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id u47so24547020qtj.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 04:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J+Q1VfDsEMhpgAIiPRmFiPtlULVuqu36McELugsuCY0=;
 b=jedulD+GuyUFhpYLvsKI4wi0TUuxaOnIaLSdMqlUh69xW5pt1OjM+aUf0bVbB4KKVB
 CCea3oHYwzn6B5b7nzEyCXvB5gX5dC0QH9q/n6c0lfNATZFVyMc+mIikeI9qJtNyjSIt
 4Ave95EqOVD/Ub/j3c9H0gWbw8zQzybL5xA7QLVF+6Hs9dSbJOC5++ZnYt5Gr9UJCRL8
 7AnXQrWhTBbcJz4rmY+NkNUzx7kgXOYnH1oTRubn6+zWZ+GsUmT1Z/vhESDMwOkQEHuV
 5HHlP7fxRCP5E9BCJscOtS9NN7N8AcYGB4fPMnWfMSp01uj2t4X69Xx7dFHpiICKhzZN
 zF/g==
X-Gm-Message-State: AA+aEWbVMOlt8RGsKIkJR0TZA6t5Wk/a7+wrg6Z+BfolNAsSzLlNz/aH
 EzRhKW77vHfZsMuY0odmvOcxtYdLCR793ip9DDw=
X-Google-Smtp-Source: ALg8bN7SbnHMjAYUYwtcYYE2S1x4Ki2e0zodzAAhG/AQLJf6iERpo2wfVTtsYlpaDkjHUa6am1ixrbf5NzmLtw34Vck=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr33774681qtm.96.1546258983914; 
 Mon, 31 Dec 2018 04:23:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
 <alpine.LNX.2.21.1812301051280.215@nippy.intranet>
 <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301430221.215@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Dec 2018 13:22:47 +0100
Message-ID: <CAK8P3a28RETYsF4XxXadwYJ1sWFpopgHa3-mn00U7tPzQzRBjQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
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
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 30, 2018 at 5:05 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Sun, 30 Dec 2018, I wrote:
>
> >
> > I'm not opposed to exported functions in place of a singleton ops
> > struct. Other things being equal I'm inclined toward the ops struct,
> > perhaps because I like encapsulation or perhaps because I don't like
> > excess generality. (That design decision was made years ago and I don't
> > remember the reasoning.)
>
> The rationale for the ops struct was that it offers introspection.
>
> It turns out that PPC64 device drivers don't care about byte-at-a-time
> accessors and X86 device drivers don't care about checksum validation.
> But that only gets us so far.
>
> We still needed a way to find out whether the arch has provided
> byte-at-a-time accessors (i.e. PPC32 and M68K Mac) or byte range accessors
> (i.e. PPC64 and those platforms with checksummed NVRAM like X86 and M68K
> Atari).
>
> You can't resolve this question at build time for a multi-platform kernel
> binary, so pre-processor tricks don't help.
>
> Device drivers tend to want to access NVRAM one byte at a time. With this
> patch series, those platforms which need checksum validation always set
> byte-at-a-time methods to NULL. (Hence the atari_scsi changes in patch 3.)
>
> The char misc driver is quite different to the usual device drivers,
> because the struct file_operations methods always access a byte range.
>
> The NULL methods in the ops struct allow the nvram.c misc device to avoid
> inefficient byte-at-a-time accessors where possible, just as
> arch/powerpc/kernel/nvram_64.c presently does.


Ok, I see. That sounds absolutely reasonable, so let's stay with
the structure as you proposed.

       Arnd
