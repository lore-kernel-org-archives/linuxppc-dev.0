Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70D3C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 21:16:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165092054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 21:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8keHK4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165092054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h0Kc0WCYzF3DZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 08:16:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n8keHK4b";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="n8keHK4b"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h0GZ4d7vzF3Cm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 08:13:26 +1100 (AEDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DE552085B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 21:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1540502004;
 bh=wvEMaua9XdNX1S7F8WvyfWYk7OlmWIlhYhxZAJeKwdE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=n8keHK4bHi/xaU7wAjGjXtDkmgMY8Qagu8h7WqN7FIhYyEGhQykJZ8U0GWJsHpN/c
 jQH5Kkd7QhNYJgyFAWFcx20GEGC/gdGKM73Pscz0htyoSgpK2JSVeEUyKcx6BUU7a2
 sqVzAPRLSh/5ae7Jkj81s663W2+KZHMF4yR9w9og=
Received: by mail-qt1-f169.google.com with SMTP id q41-v6so11668550qtq.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 14:13:24 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLEhpHyy8EKRHxtFbMq2dIG7MJ0K45Yy/r9DeWPMSd0cgCPAaLs
 RnDrxcYJwgtRER/kzJDrDqCrcoA5oOgnWTU+cQ==
X-Google-Smtp-Source: AJdET5dPMimUPy72Toq8ADoMpWDW5u//FVc5SZkVtwbySihlnauOZqcr3hb+YS+Sv4mS4dGpTmGh/T9QeMcbV1qAVzw=
X-Received: by 2002:a0c:8c86:: with SMTP id p6-v6mr836511qvb.246.1540502003189; 
 Thu, 25 Oct 2018 14:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181024193256.23734-1-f.fainelli@gmail.com>
 <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
 <20181025093833.GA23607@rapoport-lnx>
 <CAL_JsqL62ttsGSbE1BS5v-mX3pKE-p_HyvuZD6nB+GUbQyetzg@mail.gmail.com>
 <20181025172935.GA27364@rapoport-lnx>
In-Reply-To: <20181025172935.GA27364@rapoport-lnx>
From: Rob Herring <robh@kernel.org>
Date: Thu, 25 Oct 2018 16:13:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJrMq+QHvuOsqEdCFchmXsd4s2XKUD_TboKzeEQprJvjg@mail.gmail.com>
Message-ID: <CAL_JsqJrMq+QHvuOsqEdCFchmXsd4s2XKUD_TboKzeEQprJvjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
To: rppt@linux.ibm.com
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org,
 SH-Linux <linux-sh@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 linux-s390@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Openrisc <openrisc@lists.librecores.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 25, 2018 at 12:30 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Oct 25, 2018 at 08:15:15AM -0500, Rob Herring wrote:
> > +Ard
> >
> > On Thu, Oct 25, 2018 at 4:38 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Wed, Oct 24, 2018 at 02:55:17PM -0500, Rob Herring wrote:
> > > > On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > While investigating why ARM64 required a ton of objects to be rebuilt
> > > > > when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> > > > > because we define __early_init_dt_declare_initrd() differently and we do
> > > > > that in arch/arm64/include/asm/memory.h which gets included by a fair
> > > > > amount of other header files, and translation units as well.
> > > >
> > > > I scratch my head sometimes as to why some config options rebuild so
> > > > much stuff. One down, ? to go. :)
> > > >
> > > > > Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
> > > > > systems that generate two kernels: one with the initramfs and one
> > > > > without. buildroot is one of these build systems, OpenWrt is also
> > > > > another one that does this.
> > > > >
> > > > > This patch series proposes adding an empty initrd.h to satisfy the need
> > > > > for drivers/of/fdt.c to unconditionally include that file, and moves the
> > > > > custom __early_init_dt_declare_initrd() definition away from
> > > > > asm/memory.h
> > > > >
> > > > > This cuts the number of objects rebuilds from 1920 down to 26, so a
> > > > > factor 73 approximately.
> > > > >
> > > > > Apologies for the long CC list, please let me know how you would go
> > > > > about merging that and if another approach would be preferable, e.g:
> > > > > introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
> > > > > something like that.
> > > >
> > > > There may be a better way as of 4.20 because bootmem is now gone and
> > > > only memblock is used. This should unify what each arch needs to do
> > > > with initrd early. We need the physical address early for memblock
> > > > reserving. Then later on we need the virtual address to access the
> > > > initrd. Perhaps we should just change initrd_start and initrd_end to
> > > > physical addresses (or add 2 new variables would be less invasive and
> > > > allow for different translation than __va()). The sanity checks and
> > > > memblock reserve could also perhaps be moved to a common location.
> > > >
> > > > Alternatively, given arm64 is the only oddball, I'd be fine with an
> > > > "if (IS_ENABLED(CONFIG_ARM64))" condition in the default
> > > > __early_init_dt_declare_initrd as long as we have a path to removing
> > > > it like the above option.
> > >
> > > I think arm64 does not have to redefine __early_init_dt_declare_initrd().
> > > Something like this might be just all we need (completely untested,
> > > probably it won't even compile):
> > >
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 9d9582c..e9ca238 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -62,6 +62,9 @@ s64 memstart_addr __ro_after_init = -1;
> > >  phys_addr_t arm64_dma_phys_limit __ro_after_init;
> > >
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > > +
> > > +static phys_addr_t initrd_start_phys, initrd_end_phys;
> > > +
> > >  static int __init early_initrd(char *p)
> > >  {
> > >         unsigned long start, size;
> > > @@ -71,8 +74,8 @@ static int __init early_initrd(char *p)
> > >         if (*endp == ',') {
> > >                 size = memparse(endp + 1, NULL);
> > >
> > > -               initrd_start = start;
> > > -               initrd_end = start + size;
> > > +               initrd_start_phys = start;
> > > +               initrd_end_phys = end;
> > >         }
> > >         return 0;
> > >  }
> > > @@ -407,14 +410,27 @@ void __init arm64_memblock_init(void)
> > >                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
> > >         }
> > >
> > > -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> > > +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> > > +           (initrd_start || initrd_start_phys)) {
> > > +               /*
> > > +                * FIXME: ensure proper precendence between
> > > +                * early_initrd and DT when both are present
> >
> > Command line takes precedence, so just reverse the order.
> >
> > > +                */
> > > +               if (initrd_start) {
> > > +                       initrd_start_phys = __phys_to_virt(initrd_start);
> > > +                       initrd_end_phys = __phys_to_virt(initrd_end);

BTW, I think you meant virt_to_phys() here?

> >
> > AIUI, the original issue was doing the P2V translation was happening
> > too early and the VA could be wrong if the linear range is adjusted.
> > So I don't think this would work.
>
> Probably things have changed since then, but in the current code there is
>
>                 initrd_start = __phys_to_virt(initrd_start);
>
> and in between only the code related to CONFIG_RANDOMIZE_BASE, so I believe
> it's safe to use __phys_to_virt() here as well.

Here is fine yes, but I believe it was the the phys to virt in the DT
code before adjusting the linear range that was the problem.

Rob
