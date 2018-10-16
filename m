Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A791C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 01:03:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB999208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 01:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwnX+Jxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB999208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Yxr53ZMqzF35j
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 12:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SwnX+Jxx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SwnX+Jxx"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YxnL4qbyzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 12:00:38 +1100 (AEDT)
Received: by mail-qt1-x842.google.com with SMTP id d14-v6so23800031qto.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i15KWysMeu4MH4r+I0X38zhZQetTV9oaA0Pq1P90Bwg=;
 b=SwnX+JxxzlP9TyWn9C9H2rGdmRQ1J52lNGTpROsb8U4j2Mb5XGJv0XnzTVTZRHGtd+
 RZIdaOOx49UQ2S4wZds7q55+BEZjHuNJwD+zeUPpogx2o+hvmpU6sVIars1v13YZL4Id
 DAA7XpOd2Fd/8Ilf6rIVpA+F2/5Al73hpTBcYyrGsUVJAYQHGoGVKrxwt1yt/rcapqra
 QNcU/Pd8ptmZWXnwTMrktTPeoay5RLxHKQXwovjVRzW8sRhFS2eCUmayaVmgYOjUCaZd
 aHOAASXbt6gT/ty0NI+zhvkYbhLRWhgvDk/LN1nlQgfP49L3Q/Xww8kAZxq2cofTvLBM
 h2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i15KWysMeu4MH4r+I0X38zhZQetTV9oaA0Pq1P90Bwg=;
 b=Jvlrd7RNBABHhy8KsIKpxWZvAj/P48vCiZRlFzcPIe8L2/cA63bxTYC0wVfq4oBD1Z
 h948UEYh2gn6B7CXMmM1Av4RgSs0J+PMNs2ZlbI1tuNZxxdIlh+DhpH9NDEs5x+G8qVo
 n4ADKlrldXDditVXUZiY0rHroeDkoNRafzRdRGm+EleCGC52GAHVWrxi94EQ3/Ixl+zG
 B4ZatXUF2731i8A5QYAsjcDIbzd49G5Ue0Uq2c39nrH9ice0KrRH72akIAQ+0gwDM1W4
 inbW4Xh1isttkk6r/bvd0FqMMP2ZqSwkUfa1ASPgNI1ibbnFaHAbsKd5t8qr+ylmlWCy
 9ZTg==
X-Gm-Message-State: ABuFfoh47Iut+holUVAm8etbG0DgfLdHJi6lMJDJhWIS4LpdwwqhMH1k
 LYaWs2i3pTFiWxtkd7SYXuMXeJvuxVxlS0+pxw==
X-Google-Smtp-Source: ACcGV63He/VXYAWUeDldpxkRKk3Yj/vWLbp8t1TDuXZnwsG0V24hkdJ+bJFvhJlyxVO6IAUBxcOWkUSffw/Tavh17ZQ=
X-Received: by 2002:a0c:ade7:: with SMTP id x36mr4142659qvc.218.1539651636139; 
 Mon, 15 Oct 2018 18:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
 <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+DAEEa6i9xb-9MMSxu-znc9tZLZwFRADqE+kcxQYXrTg@mail.gmail.com>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 15 Oct 2018 20:00:24 -0500
Message-ID: <CAL_Jsq+t2ZXhtzN0KnnU1jn+JZE3Spfgm8jT60jx8j8gEEKjFQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 15
To: Stephen Rothwell <sfr@canb.auug.org.au>, David Miller <davem@davemloft.net>
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

+davem

On Mon, Oct 15, 2018 at 3:35 PM Rob Herring <robherring2@gmail.com> wrote:
>
> On Mon, Oct 15, 2018 at 3:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi Guenter,
> >
> > [Just cc'ing the PPC and devicetree folks]
> >
> > On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Mon, Oct 15, 2018 at 07:25:46PM +1100, Stephen Rothwell wrote:
> > > >
> > > > My qemu boots of a powerpc pseries_le_defconfig kernel failed today.
> > >
> > > Same here. Interestingly, this only affects little endian pseries
> > > boots; big endian works fine. I'll try to bisect later.
> > >
> > > ALl ppc qemu tests (including big endian pseries) also generate a warning.
> > >
> > > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+0x20/0x68
> > > Modules linked in:
> > > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181015)
> > > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > > IRQMASK: 1
> > > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 00000000000000c0
> > > GPR04: 0000000000000000 0000000000000000 0000000000000000 ffffffffffffffff
> > > GPR08: 0000000000000000 00000000000000c0 0000000000000018 00000000000000b7
> > > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000000
> > > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea500
> > > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > Call Trace:
> > > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80
> > >
> > >
> > > sparc images crash, starting with next-20181009. Bisect with
> > > next-201810112 points to the merge of devicetree/for-next, though
> > > devicetree/for-next itself does not have the problem (bisect log
> > > attached below). The crash is in devicetree code.
> > >
> > > Crash logs:
> > > https://kerneltests.org/builders/qemu-sparc64-next/builds/981/steps/qemubuildcommand_1/logs/stdio
> > > https://kerneltests.org/builders/qemu-sparc-next/builds/975/steps/qemubuildcommand_1/logs/stdio
>
> The sparc crash appears to be related to changes I made. Looking into it.

The problem is a combination of commit 0b9871a3a8cc ("sparc: Convert
to using %pOFn instead of device_node.name") and commit 6d0a70a284be
("vsprintf: print OF node name using full_name"). The Sparc functions
in prom_*.c can't use %pOFn to ultimately construct full_name as %pOFn
is derived from full_name. Reverting the former commit gets QEMU
booting again.

David, Can you revert commit 0b9871a3a8cc. I'll have to find another approach.

Rob
