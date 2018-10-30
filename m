Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56AECDE44
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 22:32:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3672D20664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 22:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jcKtztE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3672D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42l5nw4H32zDsGh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 09:32:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jcKtztE2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::944; helo=mail-ua1-x944.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="jcKtztE2";
 dkim-atps=neutral
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com
 [IPv6:2607:f8b0:4864:20::944])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42l5hX1DNmzF2Ct
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 09:28:12 +1100 (AEDT)
Received: by mail-ua1-x944.google.com with SMTP id c5so3519387uak.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bImqfsi8wLzHdpxcSUnzMo8Inz8+K2mhWJsVdXrdeuE=;
 b=jcKtztE2YqHIN/ivS3T1ZCw84PseggOPg6ZMa6O+Xwi3o8ePR9CuItoF1UQkA4p71Q
 AGZsRypdJ3G1dlog6rYXRUmhTbTueRGExx76PbPoqNk4VZEgIpuWOJayPkTqJ742AM58
 KK7v5W/wbozKkaVztZ4jBMT+ZKckAgfW1zzOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bImqfsi8wLzHdpxcSUnzMo8Inz8+K2mhWJsVdXrdeuE=;
 b=Hvpmjqdg8utHcv3ZJqic9cEnIfGFUHYU8/QQ2hnYa0bHR+nrZfAledIVWVUZCSGwq+
 NuJlpoPlIkyWzgAkYoQLZZ7KaCkSYgwVXB1uCO09bZh1MlMuFuQDy1om8ac7ucMFpbxC
 2UWJlCsfk5KL0W+252qI/b8lRsv7oi0w/wVhGDTWyAf6d78BE18cYj/lCdXdFZ0PRRlR
 U8EnEkRSU8GVzq98aisSg96ajHSxo63gS93vj71ShzSKaA1VeYZV/dAZXZJti8wq2hhb
 5zBGCz1l0aA2Zr6k7t2FwMHDCXrQBu46fSW0tIAgq0xe/IemRq7ipLOspYQW7Ht2Fcu4
 0D9Q==
X-Gm-Message-State: AGRZ1gKu/1332Xl4mHsyQTPbCVaHJ/RRr767+6OrOYpy6eNqIlH5tWgd
 WB/PgqhMJLT+es6VKJ90HycrE3oh5O8=
X-Google-Smtp-Source: AJdET5enqe4l3PuBZadOMWKRGijCM/nMuHNEdA/vgM9c0v6N9WdD8FHTjgLA6SOl8dcwrDRIkstIVw==
X-Received: by 2002:ab0:3392:: with SMTP id y18mr287968uap.117.1540938489154; 
 Tue, 30 Oct 2018 15:28:09 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com.
 [209.85.221.175])
 by smtp.gmail.com with ESMTPSA id w132sm4810052vkd.37.2018.10.30.15.28.08
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Oct 2018 15:28:08 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id o10-v6so3440500vki.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 15:28:08 -0700 (PDT)
X-Received: by 2002:a1f:8ac6:: with SMTP id m189mr251182vkd.79.1540938171170; 
 Tue, 30 Oct 2018 15:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-8-dianders@chromium.org>
 <20181030114603.xdvyvayzw2an5c3q@holly.lan>
In-Reply-To: <20181030114603.xdvyvayzw2an5c3q@holly.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Oct 2018 15:22:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
Message-ID: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
Subject: Re: [PATCH 7/7] kgdb: Remove irq flags and local_irq_enable/disable
 from roundup
To: Daniel Thompson <daniel.thompson@linaro.org>
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
Cc: kstewart@linuxfoundation.org, linux-mips@linux-mips.org, dalias@libc.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-sh@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, mhocko@suse.com, paulus@samba.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, ysato@users.sourceforge.jp,
 x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, kgdb-bugreport@lists.sourceforge.net,
 jhogan@kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, ying.huang@intel.com,
 rppt@linux.vnet.ibm.com, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, pombredanne@nexb.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 rkuo@codeaurora.org, paul.burton@mips.com, Vineet Gupta <vgupta@synopsys.com>,
 Jason Wessel <jason.wessel@windriver.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Tue, Oct 30, 2018 at 4:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:07AM -0700, Douglas Anderson wrote:
> > The function kgdb_roundup_cpus() was passed a parameter that was
> > documented as:
> >
> > > the flags that will be used when restoring the interrupts. There is
> > > local_irq_save() call before kgdb_roundup_cpus().
> >
> > Nobody used those flags.  Anyone who wanted to temporarily turn on
> > interrupts just did local_irq_enable() and local_irq_disable() without
> > looking at them.  So we can definitely remove the flags.
>
> On the whole I'd rather that this change...
>
>
> > Speaking of calling local_irq_enable(), it seems like a bad idea and
> > it caused a nice splat on my system with lockdep turned on.
> > Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>
> ... and fixes for this this were in separate patches. They don't appear
> especially related.

Agreed that this is cleaner.  Done for v2.

-Doug
