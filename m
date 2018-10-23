Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5790C67863
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 10:36:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D85B2082E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 10:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ1FQW2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D85B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g69c60bYzDrMc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 21:36:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZ1FQW2s";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZ1FQW2s"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fqdw31rkzDrL3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 10:41:08 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id bh10-v6so1361059plb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=7OS2r3euy1TczlyR46QbFm62nalquqEBBOjTowUcAkM=;
 b=JZ1FQW2sjznoZVhwKxRvzGXbACgNDowsPsyxlWZVVG7INAURVS5jcxx915CmrAtFRB
 8hWt+dLKEAVaszN//gmUjAYoT7FDyiMui97wYDmRNVObbg407myVHSOQQZ2tzM6HKXjZ
 mHfpSVcF4JVoAjUiAlqOz8+OgLkgiyNTMN4slZ2nQdl2qnD25v68X/twk29GWgHctS5W
 xnYbKMErl9Jjcz+rWWWrl4jqwHUvFwF5J4+jg0wCCfi+5wfY10suO+glJ/huiOk8gQQR
 VFWKT2AnmDQl75D4iT3d+hUeGJI3o/5MTq/bf6m/xNvsxIAEvup7H34zIhNHpVjgjKte
 er4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7OS2r3euy1TczlyR46QbFm62nalquqEBBOjTowUcAkM=;
 b=OLJDx8uoHZNYK/Tr+lHBTiHL4BDWcGa5h7dakfjxQAkY2XfdDMP4+2r3krnn63KfM8
 MWXcMaTBxUT0j27jBu5s9od/0bgFC06Ll4gx5Fwvae0iNn3t1ncFut+Y1d3jeyYNPo7w
 OT0y/uUB+svVf2LbHubnznZeeVx8wHal1QfHJN8++9nMXne+H4PKNSAlfZmtXSSvi/zY
 gM94ZEm+dgUxPeG7AzYTgRz+s1uxso/XYx53hY9NHie9ztBj+1RmwK5XFVApHntV78MW
 TydVDKhEdh2yU/gWqJ9THsXZAYLW6Zt9L6tlhK+1+BAUv+eA2h3dxUT1gurEClwW5haP
 adlg==
X-Gm-Message-State: AGRZ1gLaYKLAbvla6rOMLuphLb1LCe5n7kitgsTfoHhasKnY+jYcIO8Q
 XCNK+zytQe4TdoBADsM1Su4=
X-Google-Smtp-Source: AJdET5fBJhLb6MQXskYp1eO10D2a24G6cKuepRaM3H/nhlH771jer1HqF14MUwzRYB/YVHWQB+Kq3Q==
X-Received: by 2002:a17:902:6e08:: with SMTP id
 u8-v6mr162695plk.64.1540338065703; 
 Tue, 23 Oct 2018 16:41:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id a5-v6sm3041223pfo.53.2018.10.23.16.41.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Oct 2018 16:41:04 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
Date: Tue, 23 Oct 2018 16:40:41 -0700
Message-Id: <20181023234044.1138-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 24 Oct 2018 21:33:24 +1100
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
Cc: "open list:MIPS" <linux-mips@linux-mips.org>,
 Alan Kao <alankao@andestech.com>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
 Matt Redfearn <matt.redfearn@mips.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Andrew Morton <akpm@linux-foundation.org>,
 "open list:IA64 Itanium PLATFORM" <linux-ia64@vger.kernel.org>,
 James Hogan <jhogan@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Vincent Chen <deanbo422@gmail.com>,
 "open list:S390" <linux-s390@vger.kernel.org>,
 "open list:C6X ARCHITECTURE" <linux-c6x-dev@linux-c6x.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
 Helge Deller <deller@gmx.de>,
 Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 "open list:TENSILICA XTENSA PORT xtensa" <linux-xtensa@linux-xtensa.org>,
 Jessica Yu <jeyu@kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 Stafford Horne <shorne@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 "open list:OPENRISC ARCHITECTURE" <openrisc@lists.librecores.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 Fenghua Yu <fenghua.yu@intel.com>, arnd@arndb.de,
 Andrey Konovalov <andreyknvl@google.com>, Jeff Dike <jdike@addtoit.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>,
 "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Ley Foon Tan <lftan@altera.com>,
 "David S. Miller" <davem@davemloft.net>, Rich Felker <dalias@libc.org>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:SPARC + UltraSPARC sparc/sparc64" <sparclinux@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 Greg Ungerer <gerg@linux-m68k.org>, Jonas Bonn <jonas@southpole.se>,
 Richard Weinberger <richard@nod.at>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Mark Salter <msalter@redhat.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>,
 Michal Simek <monstr@monstr.eu>, Vineet Gupta <vgupta@synopsys.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

While investigating why ARM64 required a ton of objects to be rebuilt
when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
because we define __early_init_dt_declare_initrd() differently and we do
that in arch/arm64/include/asm/memory.h which gets included by a fair
amount of other header files, and translation units as well.

This patch series proposes adding an empty initrd.h to satisfy the need
for drivers/of/fdt.c to unconditionally include that file, and moves the
custom __early_init_dt_declare_initrd() definition away from
asm/memory.h

This cuts the number of objects rebuilds from 1920 down to 26, so a
factor 73 approximately.

Apologies for the long CC list, please let me know how you would go
about merging that and if another approach would be preferable, e.g:
introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
something like that.

Florian Fainelli (2):
  arch: Add asm-generic/initrd.h and make use of it for most
    architectures
  arm64: Create asm/initrd.h

 arch/alpha/include/asm/Kbuild      |  1 +
 arch/arc/include/asm/Kbuild        |  1 +
 arch/arm/include/asm/Kbuild        |  1 +
 arch/arm64/include/asm/initrd.h    | 13 +++++++++++++
 arch/arm64/include/asm/memory.h    |  8 --------
 arch/c6x/include/asm/Kbuild        |  1 +
 arch/h8300/include/asm/Kbuild      |  1 +
 arch/hexagon/include/asm/Kbuild    |  1 +
 arch/ia64/include/asm/Kbuild       |  1 +
 arch/m68k/include/asm/Kbuild       |  1 +
 arch/microblaze/include/asm/Kbuild |  1 +
 arch/mips/include/asm/Kbuild       |  1 +
 arch/nds32/include/asm/Kbuild      |  1 +
 arch/nios2/include/asm/Kbuild      |  1 +
 arch/openrisc/include/asm/Kbuild   |  1 +
 arch/parisc/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild    |  1 +
 arch/riscv/include/asm/Kbuild      |  1 +
 arch/s390/include/asm/Kbuild       |  1 +
 arch/sh/include/asm/Kbuild         |  1 +
 arch/sparc/include/asm/Kbuild      |  1 +
 arch/um/include/asm/Kbuild         |  1 +
 arch/unicore32/include/asm/Kbuild  |  1 +
 arch/x86/include/asm/Kbuild        |  1 +
 arch/xtensa/include/asm/Kbuild     |  1 +
 drivers/of/fdt.c                   |  1 +
 include/asm-generic/initrd.h       |  1 +
 27 files changed, 38 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h
 create mode 100644 include/asm-generic/initrd.h

-- 
2.17.1

