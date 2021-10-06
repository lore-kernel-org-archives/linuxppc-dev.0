Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6AC4332F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BE861154
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07BE861154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HPgJr4wy0z3c4y
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 03:44:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.177;
 helo=mail-oi1-f177.google.com; envelope-from=robherring2@gmail.com;
 receiver=<UNKNOWN>)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HPgJL71Rdz2xtc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2021 03:43:45 +1100 (AEDT)
Received: by mail-oi1-f177.google.com with SMTP id s69so4785397oie.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Oct 2021 09:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jBzMvIMgnR7M/3yhI7B+vslrQk5E3C0Pdi0d+USOXmM=;
 b=ojCTUGSChOzH+WzmCcVchXTEvnBnl6ULsHWfmLIt56kWLxGtbVbGjuGCFgK4MnhTsf
 Y4nPBg2RAuiLp1UEcjgSLwa9pFxKw180KjbbDjUJvQ5DMIbLlJFJ1FYYiWobx566dCSK
 Xq9B2inhklihGlTXEJoZrZaWGoS31LrpUOF/iFmCRll6s1i9+h4veiV/InlHiRy3tkxF
 ywsZskntO87eh24br+sc9s8xU03LzSMR560u/W9rl9CND2n6WFpSZWULg6FDdwl8UvZI
 vfs63gW2OODIJ5NxXkP4EeVdfug0ECF/NzYgLXvrXehbRykeNfvSa7tdxYRhMmBxkA9u
 +FsQ==
X-Gm-Message-State: AOAM5325cOz8XO+mVz8+235tBWU6ITJeUVVAaNWjcmfQ1hKn1VV1/L86
 SLtKfYDztT59MZM4VwzWAg==
X-Google-Smtp-Source: ABdhPJx7CXhXT5M1W0CAhtBp2h8eMcQ5I0cRndKVwy8olo5SejcUQh3JemHdw8Jrz5VsbxC5vFcqCA==
X-Received: by 2002:a05:6808:2221:: with SMTP id
 bd33mr8117373oib.64.1633538615382; 
 Wed, 06 Oct 2021 09:43:35 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 09:43:34 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@armlinux.org.uk>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/12] DT: CPU h/w id parsing clean-ups and cacheinfo id
 support
Date: Wed,  6 Oct 2021 11:43:20 -0500
Message-Id: <20211006164332.1981454-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-sh@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Borislav Petkov <bp@alien8.de>,
 bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@linutronix.de>,
 Frank Rowand <frowand.list@gmail.com>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The first 10 patches add a new function, of_get_cpu_hwid(), which parses
CPU DT node 'reg' property, and then use it to replace all the open
coded versions of parsing CPU node 'reg' properties.

The last 2 patches add support for populating the cacheinfo 'id' on DT
platforms. The minimum associated CPU hwid is used for the id. The id is
optional, but necessary for resctrl which is being adapted for Arm MPAM.

Tested on arm64. Compile tested on arm, x86 and powerpc.

Rob

Rob Herring (12):
  of: Add of_get_cpu_hwid() to read hardware ID from CPU nodes
  ARM: Use of_get_cpu_hwid()
  ARM: broadcom: Use of_get_cpu_hwid()
  arm64: Use of_get_cpu_hwid()
  csky: Use of_get_cpu_hwid()
  openrisc: Use of_get_cpu_hwid()
  powerpc: Use of_get_cpu_hwid()
  riscv: Use of_get_cpu_hwid()
  sh: Use of_get_cpu_hwid()
  x86: dt: Use of_get_cpu_hwid()
  cacheinfo: Allow for >32-bit cache 'id'
  cacheinfo: Set cache 'id' based on DT data

 arch/arm/kernel/devtree.c       | 22 ++-------------------
 arch/arm/mach-bcm/bcm63xx_pmb.c |  6 +++---
 arch/arm64/kernel/smp.c         | 31 ++----------------------------
 arch/csky/kernel/smp.c          |  6 ++----
 arch/openrisc/kernel/smp.c      |  6 +-----
 arch/powerpc/kernel/smp.c       |  7 +------
 arch/riscv/kernel/cpu.c         |  3 ++-
 arch/sh/boards/of-generic.c     |  5 ++---
 arch/x86/kernel/devicetree.c    |  5 ++---
 drivers/base/cacheinfo.c        | 34 ++++++++++++++++++++++++++++++++-
 drivers/of/base.c               | 22 +++++++++++++++++++++
 include/linux/cacheinfo.h       |  2 +-
 include/linux/of.h              |  1 +
 13 files changed, 74 insertions(+), 76 deletions(-)

-- 
2.30.2

