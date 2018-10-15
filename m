Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48423C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 22:55:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F32A204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 22:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBypfhSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F32A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Yv0m35yzzF3Ry
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 09:55:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBypfhSh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::844; helo=mail-qt1-x844.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBypfhSh"; 
 dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yty94kxgzF3Ry
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 09:53:05 +1100 (AEDT)
Received: by mail-qt1-x844.google.com with SMTP id b4-v6so23489907qtc.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=duCa1nK8gaa1XD1+tXdyfBVi5VNEM8pn4CvEMSSCaoA=;
 b=UBypfhShbRqS2gPjtrXl93iSYdpf5O4LVQ8FeBGQb1WyzDwqQyb73lquWh3owkxVwP
 duQflbnJiyynIN946X3PD84lepzXE6+kYRLCjo0cAmEmSN0C3LXQhY4uDEJKGgg68GIn
 ksiF7fu2ZcSoI+iyP/QPZDMNy08f1DxpBoUP8hrdCP+nBU4YnngR2SgLn2Ur1Ml0Xf5o
 FvHK1gSucsnQA0dJzmbzPwOP35zLp+xjFPAt86cW5TF3DiTV5vhZF/ImvO2UO1IfyrPz
 kPqyl335BaXsJOw6dgI2140lVM+qfmglWDqRQmwKk7qjdj9u0BICPjFqgKJgYXveA4KY
 4WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=duCa1nK8gaa1XD1+tXdyfBVi5VNEM8pn4CvEMSSCaoA=;
 b=Oq0eghjmNOhUUloe6NgU8aPqbIOuaKhnCpM4f6yN6Xevm86ZoA8QLPqmFZTJhiiWRX
 PwN+WEp5VWPoMRV/JQGMLmWbYn7OjaxzgvDMdbq5ASyIfQ/CK7jwBvyV7BnHcfC3vQ/a
 7wz6fBVmOKjvwxFNHhsFqjPhHwkxieK5EjoebTcVRp8bcBPjNeA+eXkguz3tmHscDFo8
 xH5aNmPWPv2oTyYRodgCwfYi4Y6HNA6ea3xAAA8TuPBBLtjwA7u5CZMmmReEch2V/2Tx
 Ol/P4ZEL6MSrBgqq27VMwCCI820OJybhC9CSWtk3mSeqa7HXaxeCfVhtcs6HH0dlTWEw
 Uo5A==
X-Gm-Message-State: ABuFfogyB4XVHz8FM8yKg45Q0i8DGLRbDG70PMnOHGQoQtwCGiXZsAgz
 Inne3HSEHh54GxjP2gQZRut5F6K12BD2HV1rBQ==
X-Google-Smtp-Source: ACcGV60ojtKbCX/wAhaCluZuzlDKKZ0h0hzbBx6Z1t77UOcYk8QIHEqv4hXlG+NpatEH9n6GMyGmwa92NeCYp61Yn8M=
X-Received: by 2002:a0c:8c86:: with SMTP id
 p6-v6mr18696370qvb.246.1539643982971; 
 Mon, 15 Oct 2018 15:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
 <20181015211815.GA24993@roeck-us.net>
 <CAL_JsqKXS0rmmwHgLRDy+6k=GYRt-nFJHJD1A+CkFCDEAEAKvg@mail.gmail.com>
 <20181015221053.GA19822@roeck-us.net>
 <CAL_JsqLSBE9FFB7=o5bDJ1hxfNP6mAPJ-qXyEVHfY+xwfgDuWw@mail.gmail.com>
 <20181015223424.GA31977@roeck-us.net>
In-Reply-To: <20181015223424.GA31977@roeck-us.net>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 15 Oct 2018 17:52:51 -0500
Message-ID: <CAL_JsqKLJeTp6-Rjdf=yS1_QWPmHWzW639rxijRRo2TPG4W++Q@mail.gmail.com>
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

On Mon, Oct 15, 2018 at 5:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Oct 15, 2018 at 05:13:08PM -0500, Rob Herring wrote:
> > On Mon, Oct 15, 2018 at 5:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Mon, Oct 15, 2018 at 04:48:27PM -0500, Rob Herring wrote:
> > > > On Mon, Oct 15, 2018 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > >
> > > > > On Mon, Oct 15, 2018 at 03:35:12PM -0500, Rob Herring wrote:
> > > > > > On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > > > >
> > > > > > > Hi Guenter,
> > > > > > >
> > > > > > > [Just cc'ing the PPC and devicetree folks]
> > > > > > >
> > > > > > > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > >
> > > > > > > > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > > > > > > >
> > > > > > > > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > > > > > > >
> > > > > > > > Same here. Interestingly, this only affects little endian pseries
> > > > > > > > boots; big endian works fine. I'll try to bisect later.
> > > > > > > >
> > > > > > > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > > > > > > >
> > > > > > > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > > > > > > > Modules linked in:
> > > > > > > > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > > > > > > > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > > > > > > > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > > > > > > > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > > > > > > > IRQMASK: 1
> > > > > > > > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > > > > > > > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > > > > > > > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > > > > > > > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > > > > > > > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > > > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > > > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > > > > > > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > > > > > > > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > > > > > > > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > > > > Call Trace:
> > > > > > > > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > > > > > > > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > > > > > > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > > > > > > > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > > > > > > > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > > > > > > > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> > > > > > > >
> > > > > > > >
> > > > > > > > sparc images crash, starting with next-20181009. Bisect with
> > > > > > > > next-201810112 points to the merge of devicetree/for-next, though
> > > > > > > > devicetree/for-next itself does not have the problem (bisect log
> > > > > > > > attached below). The crash is in devicetree code.
> > > > > > > >
> > > > > > > > Crash logs:
> > > > > > > > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > > > > > > > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio
> > > > > >
> > > > > > The sparc crash appears to be related to changes I made. Looking into it.
> > > > > >
> > > > >
> > > > > Let me know if you need me to test anything or do some debugging.
> > > >
> > > > Well, I'm not having any luck getting sparc qemu to work. Here's what
> > > > I'm trying with a sparc32_defconfig kernel:
> > > >
> > > > $ qemu-system-sparc -kernel .build-sparc/vmlinux -M SS-4 -nographic -m
> > > > 256 -no-reboot
> > > > rom: requested regions overlap (rom phdr #0: .build-sparc/vmlinux.
> > > > free=0x000000000000057a, addr=0x0000000000000000)
> > > > qemu-system-sparc: rom check and register reset failed
> > > >
> > >
> > > What is your qemu version ?
> >
> > 2.11 from ubuntu 18.04:
> > QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.5)
> >
>
> Update: Works for me with
>         QEMU emulator version 2.11.93 (Debian 1:2.12~rc3+dfsg-1)

Seems to be some regression in 2.11.1. It works fine with my own build
with 3.0 based.

Rob
