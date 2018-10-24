Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D603ECDE46
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 19:58:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F4E20832
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 19:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPXWBrBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F4E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gLf90VtLzDr8C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 06:58:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pPXWBrBY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="pPXWBrBY"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gLb85cjxzDr87
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 06:55:32 +1100 (AEDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50A1020838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1540410930;
 bh=odyqBKiYzBv5IdIjuzYAxZmBJIO7/EssQKEqn+zv55Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pPXWBrBY48yKmVZsXTwnisZP13JqtDYYYkw0MgF5fzrB0Kyr3C1w180LeNbCUqTMI
 7jGgJ5Aa6GlqBjlH1EXuO620tqj2AM9TpbqXXOJqD8ThiOnXSMbaekyyxcisqwNUJm
 6H8xB6oFAY5/Mosi2BOK2RnN9DT9LDaSAgYcgCaw=
Received: by mail-qt1-f180.google.com with SMTP id o17-v6so1396834qtq.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 12:55:30 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKN14EEijOotvZkoLI4l5BWKv63fA2Jlp/ndI3vC5cGaq3yECRh
 sXzd+0lfUh3vmQ3Dds/yMTLazDiNopHokdYhuQ==
X-Google-Smtp-Source: AJdET5fsfiJJQiRG4tYbtk5oK2Hs+N0GSRD1ejgIMFFWz394cehWWCibOhJ12q0e8gCpcmQUgoAPaMWg1f+S+gdFGLQ=
X-Received: by 2002:ac8:5414:: with SMTP id
 b20-v6mr106396qtq.144.1540410929467; 
 Wed, 24 Oct 2018 12:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181024193256.23734-1-f.fainelli@gmail.com>
In-Reply-To: <20181024193256.23734-1-f.fainelli@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Oct 2018 14:55:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
Message-ID: <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
To: Florian Fainelli <f.fainelli@gmail.com>
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
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Openrisc <openrisc@lists.librecores.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi all,
>
> While investigating why ARM64 required a ton of objects to be rebuilt
> when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> because we define __early_init_dt_declare_initrd() differently and we do
> that in arch/arm64/include/asm/memory.h which gets included by a fair
> amount of other header files, and translation units as well.

I scratch my head sometimes as to why some config options rebuild so
much stuff. One down, ? to go. :)

> Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
> systems that generate two kernels: one with the initramfs and one
> without. buildroot is one of these build systems, OpenWrt is also
> another one that does this.
>
> This patch series proposes adding an empty initrd.h to satisfy the need
> for drivers/of/fdt.c to unconditionally include that file, and moves the
> custom __early_init_dt_declare_initrd() definition away from
> asm/memory.h
>
> This cuts the number of objects rebuilds from 1920 down to 26, so a
> factor 73 approximately.
>
> Apologies for the long CC list, please let me know how you would go
> about merging that and if another approach would be preferable, e.g:
> introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
> something like that.

There may be a better way as of 4.20 because bootmem is now gone and
only memblock is used. This should unify what each arch needs to do
with initrd early. We need the physical address early for memblock
reserving. Then later on we need the virtual address to access the
initrd. Perhaps we should just change initrd_start and initrd_end to
physical addresses (or add 2 new variables would be less invasive and
allow for different translation than __va()). The sanity checks and
memblock reserve could also perhaps be moved to a common location.

Alternatively, given arm64 is the only oddball, I'd be fine with an
"if (IS_ENABLED(CONFIG_ARM64))" condition in the default
__early_init_dt_declare_initrd as long as we have a path to removing
it like the above option.

Rob
