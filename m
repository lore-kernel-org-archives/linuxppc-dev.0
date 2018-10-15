Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7951C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:38:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EED20881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM70C+jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EED20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Yqz10y7VzDr3t
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:38:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TM70C+jD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TM70C+jD"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YqvN2fMTzF3Sd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 07:35:28 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id b4-v6so23086745qtc.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TAtnSjVe5Oy8huocfAyz3IfRC4sqlvNBpftSm57vUu0=;
 b=TM70C+jDJ9tR8DEdCXsoToUI5XyS9nR3UBV0Y8TQfu0aTVq6tOaV1grUXSLkSaRd09
 S+roWn7spaXm+1IBsFwZ+v8nTf8ELK5DtTGf/FEwd0geIWi+5FxqM/2XfMAi3BXlPSbE
 K0r/wpjX824+674Dvrpmw6gEZSKTzpjj8yx55hDoOGat39UPIbT9hKAdQxSCdQJqVvsg
 JK3C8P4VKw5KJCUQ07Ca2zRLS6vAREz9EMt4ikiGga0EADWsvD23HhBQADlP123xSsVK
 pvpNLgZ08IOcZ8wh/zhrx7Hdj+M6uM8XcBe3GMGrLSocIIvX11YS60UilAoIqOA/BVOX
 vrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TAtnSjVe5Oy8huocfAyz3IfRC4sqlvNBpftSm57vUu0=;
 b=p8iGmwCCVbCnvQVAuiZDF4yLqyQDEcCBJvQRVo6pWxI+rlC7Ch7Cq+Em3qTEztbNft
 zd0OpVfFbbzY2Fb70pvKUr/NZ6nHr/Qf/Lc4CqXhjS49xbv4bLtSJ9F/RzBD5MDG8rNJ
 XK6KAcIG4I3QOrKqUwEuFurDJI/kjWyxPq4YRGyP5Odk5g0tkaBFclDx2bGxhWmD7cmq
 ovqiI4U4fxsRuYTWJl/yamPJORwAgaNghDGBHrIrT0QrQLsSjOGgSteQSDEREm1cMgGM
 KbDXrf6HjeQ1y9qgFzJif7OJeNonpik7qmom1fXNQircdc7i8a+eTyFHRGWjLEB3rA2x
 Fd3A==
X-Gm-Message-State: ABuFfoh9zUqGGyoiB+w7H+Q31mdao8H2Q3PxY3zixCJ86Wwc2JNipB85
 3w+o1vGWiaCrd6R1jUJFYBgPMUv8aIU3NeCWfQ==
X-Google-Smtp-Source: ACcGV62DWIcbOKxUfy8fn6CAQBDlWxCdNzBLfEG12UAAd1z6B6vY10IaKW0xnVVNhf+YRBzIW2bPqz24B3vkD7cKv+Y=
X-Received: by 2002:a0c:bd15:: with SMTP id m21mr18950066qvg.77.1539635725276; 
 Mon, 15 Oct 2018 13:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
In-Reply-To: <20181016071240.3f62816d@canb.auug.org.au>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 15 Oct 2018 15:35:12 -0500
Message-ID: <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 15
To: Stephen Rothwell <sfr@canb.auug.org.au>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Guenter,
>
> [Just cc'ing the PPC and devicetree folks]
>
> On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > >
> > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> >
> > Same here. Interestingly, this only affects little endian pseries
> > boots; big endian works fine. I'll try to bisect later.
> >
> > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> >
> > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > IRQMASK: 1
> > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > Call Trace:
> > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> >
> >
> > sparc images crash, starting with next-20181009. Bisect with
> > next-201810112 points to the merge of devicetree/for-next, though
> > devicetree/for-next itself does not have the problem (bisect log
> > attached below). The crash is in devicetree code.
> >
> > Crash logs:
> > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio

The sparc crash appears to be related to changes I made. Looking into it.

Rob
