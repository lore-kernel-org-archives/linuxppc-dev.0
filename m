Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E1C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 22:16:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923242064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 22:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra0S3eVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923242064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Yt7X6g4YzF3S4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 09:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ra0S3eVz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ra0S3eVz"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yt4L3mSVzF3VD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 09:13:22 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id a85-v6so12892923qkg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7snZLvx4TlTzQacheAN5EztkSbPtpKfLUDoPtcujf3E=;
 b=Ra0S3eVzO7n64gnJW5njT7o00azITvnl4AJ6zuPbGz9JTDfRaIrRdfnOLzNuiu9mQk
 xHw+ID5jIhTQD6OgQT6OWQrrhniJh8VcrfM3AVgLiHEZSWLypUySPkau3d+fWoy/y2I+
 BVZPJuhG2kSWBb67Nx7HFNQIs9lY+pgb5tvCl9RGQ89/qnvPVXgOcdvRqQxiBtag5Hye
 lB808unFIJDOYCKojV5xj+/GiKzXpUA44zSDMVMswd89sWgQ9xQW0TrW0cDx6vEzfh7P
 zWeLHCaKnT5RDwNZ7pW7vNuCHWN2kgXNoHq+K/XSbsBvU1x1g42EFnWCMooBYZSTyL0T
 fUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7snZLvx4TlTzQacheAN5EztkSbPtpKfLUDoPtcujf3E=;
 b=H48yciIpXYMOeo1Pek14a4af/ut2zprgmkdTg71zmCJ+cpXgOPPLrgl67N/1nVjvPB
 GHNMA9AEV9GfQOZhYol9sDboRgJHWxbUxZj6wiFZemxnLNNPYiXQ+ooGahAmGeZ17xru
 ybffmEZv6nbI2AS7cnEgSU0DifI0hh1NkzqS54Wk1Hkv/zc8ymtqxmy4T/m5ybS4J6zR
 UFKAgkHxeEl9v1xx+3hC1m5uYHocrqtXqqGzNOun1OGPW3u5QbaZbHNBCbUBHGz/dP8t
 CusSXBX/hITvRv6UCR+ydyDGIooPTEQ8zetgwlyuOpyzNGjEBgvlfJmyutFEFFP/BFPG
 dCZA==
X-Gm-Message-State: ABuFfojMbfa6VyvZ/E1AP4Ks5LcGNU6TOg1FVrRjQdfj4Zgikbib0p/s
 prv++Sezk36FNMm/J9QSY2J6Y1rhLrt5PLoxhg==
X-Google-Smtp-Source: ACcGV61vsx6ZLwI0WeL94eyTolHkvJcYcrJNRoCg/m6b5Q0l2+VMckoB2RBHuctC34acy+jL2+WTYMCaQ5UIfuyeGvY=
X-Received: by 2002:a37:6904:: with SMTP id e4-v6mr815213qkc.79.1539641599891; 
 Mon, 15 Oct 2018 15:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
 <20181015211815.GA24993@roeck-us.net>
 <CAL_JsqKXS0rmmwHgLRDy+6k=GYRt-nFJHJD1A+CkFCDEAEAKvg@mail.gmail.com>
 <20181015221053.GA19822@roeck-us.net>
In-Reply-To: <20181015221053.GA19822@roeck-us.net>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 15 Oct 2018 17:13:08 -0500
Message-ID: <CAL_JsqLSBE9FFB7=o5bDJ1hxfNP6mAPJ-qXyEVHfY+xwfgDuWw@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 15
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 5:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Oct 15, 2018 at 04:48:27PM -0500, Rob Herring wrote:
> > On Mon, Oct 15, 2018 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Mon, Oct 15, 2018 at 03:35:12PM -0500, Rob Herring wrote:
> > > > On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > >
> > > > > Hi Guenter,
> > > > >
> > > > > [Just cc'ing the PPC and devicetree folks]
> > > > >
> > > > > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > >
> > > > > > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > > > > >
> > > > > > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > > > > >
> > > > > > Same here. Interestingly, this only affects little endian pseries
> > > > > > boots; big endian works fine. I'll try to bisect later.
> > > > > >
> > > > > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > > > > >
> > > > > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > > > > > Modules linked in:
> > > > > > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > > > > > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > > > > > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > > > > > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > > > > > IRQMASK: 1
> > > > > > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > > > > > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > > > > > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > > > > > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > > > > > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > > > > > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > > > > > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > > Call Trace:
> > > > > > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > > > > > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > > > > > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > > > > > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > > > > > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> > > > > >
> > > > > >
> > > > > > sparc images crash, starting with next-20181009. Bisect with
> > > > > > next-201810112 points to the merge of devicetree/for-next, though
> > > > > > devicetree/for-next itself does not have the problem (bisect log
> > > > > > attached below). The crash is in devicetree code.
> > > > > >
> > > > > > Crash logs:
> > > > > > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > > > > > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio
> > > >
> > > > The sparc crash appears to be related to changes I made. Looking into it.
> > > >
> > >
> > > Let me know if you need me to test anything or do some debugging.
> >
> > Well, I'm not having any luck getting sparc qemu to work. Here's what
> > I'm trying with a sparc32_defconfig kernel:
> >
> > $ qemu-system-sparc -kernel .build-sparc/vmlinux -M SS-4 -nographic -m
> > 256 -no-reboot
> > rom: requested regions overlap (rom phdr #0: .build-sparc/vmlinux.
> > free=0x000000000000057a, addr=0x0000000000000000)
> > qemu-system-sparc: rom check and register reset failed
> >
>
> What is your qemu version ?

2.11 from ubuntu 18.04:
QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.5)

Rob
