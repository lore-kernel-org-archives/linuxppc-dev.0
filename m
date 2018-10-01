Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311ACC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 15:28:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE47204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 15:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE47204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P5lR4KpDzF39s
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 01:28:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P5hK1NLxzF31R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 01:25:36 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id h15-v6so13483979otj.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2018 08:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=UyCzgVa0S9jSz66CwZemQEtwQKyE2g8HQUKaESq/u1s=;
 b=LhigtsNfkDGw/+LTkQRpp6J8tsRyLjNK4pUo2LakY0RZRRCeTF6s8IgACAXf63VmhD
 7PI/OMB8njKMvqbNpsdpV2pqgLEU7NitNwRE6DDByIWt/g/Opyz4Sfz7RxDMRUtIX4Af
 Se53ZBOmYi3/EbWgan8cfPem5W8y9Bm5r8GDC6ZDFaiKZRxYfVlvXXdoOKPSTe9Nx3dy
 us2YG5EEc6OrhYWBzQdnHtmsHrfmj/vGaV+GGM9IsfiLe6dstL3Bv1yfiiq3T6a0JLvS
 /2Zn3aqe28sWGgr8mXc0js3pjqTyWjZNlgWEAoZQfHz4qQzc18Cl0fmtd9lXZoieogJj
 91Wg==
X-Gm-Message-State: ABuFfog7On8k9g6j0nK903t0/pZwOteHJRx77viynEf//5XRPD1cGnAV
 FCt2yICDLc8lAERCJDSgPw==
X-Google-Smtp-Source: ACcGV63U/9K7378gByl64xe8uZ+wZl67iUuVreJToGbhZPR74UhMNSBcYY1EZOgrsjJBChS4j/bmTQ==
X-Received: by 2002:a9d:461a:: with SMTP id y26mr3008875ote.113.1538407534222; 
 Mon, 01 Oct 2018 08:25:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 s203-v6sm2047035oif.33.2018.10.01.08.25.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Oct 2018 08:25:33 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v4 0/9] Devicetree build consolidation
Date: Mon,  1 Oct 2018 10:25:22 -0500
Message-Id: <20181001152531.3385-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
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
Cc: linux-mips@linux-mips.org, Will Deacon <will.deacon@arm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, linux-kbuild@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Michal Marek <michal.lkml@markovi.net>,
 Vineet Gupta <vgupta@synopsys.com>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, nios2-dev@lists.rocketboards.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series addresses a couple of issues I have with building dts files.

First, the ability to build all the dts files in the tree. This has been
supported on most arches for some time with powerpc being the main
exception. The reason powerpc wasn't supported was it needed a change
in the location built dtb files are put.

Secondly, it's a pain to acquire all the cross-compilers needed to build
dtbs for each arch. There's no reason to build with the cross compiler and
the host compiler is perfectly fine as we only need the pre-processor.

I started addressing just those 2 problems, but kept finding small
differences such as target dependencies and dtbs_install support across
architectures. Instead of trying to align all these, I've consolidated the
build targets moving them out of the arch makefiles.

I'd like to take the series via the DT tree.

PPC maintainers, really need you review/ack on this especially patch 1.

Rob


v4:
 - Make dtbs and %.dtb rules depend on arch/$ARCH/boot/dts path rather than
   CONFIG_OF_EARLY_FLATTREE
 - Fix install path missing kernel version for dtbs_install
 - Fix "make CONFIG_OF_ALL_DTBS=y" for arches like ARM which selectively
   enable CONFIG_OF (and therefore dtc)

v3:
 - Rework dtc dependency to avoid 2 entry paths to scripts/dtc/. Essentially,
   I copied 'scripts_basic'.
 - Add missing scripts_basic dependency for dtc and missing PHONY tag.
 - Drop the '|' order only from dependencies
 - Drop %.dtb.S and %.dtb.o as top-level targets
 - PPC: remove duplicate mpc5200 dtbs from image-y targets

v2:
 - Fix $arch/boot/dts path check for out of tree builds
 - Fix dtc dependency for building built-in dtbs
 - Fix microblaze built-in dtb building
 - Add dtbs target for microblaze


Rob Herring (9):
  powerpc: build .dtb files in dts directory
  nios2: build .dtb files in dts directory
  nios2: use common rules to build built-in dtb
  nios2: fix building all dtbs
  c6x: use common built-in dtb support
  kbuild: consolidate Devicetree dtb build rules
  powerpc: enable building all dtbs
  c6x: enable building all dtbs
  microblaze: enable building all dtbs

 Makefile                           | 37 +++++++++++++++++++-
 arch/arc/Makefile                  |  6 ----
 arch/arm/Makefile                  | 20 +----------
 arch/arm64/Makefile                | 17 +--------
 arch/c6x/Makefile                  |  2 --
 arch/c6x/boot/dts/Makefile         | 17 ++++-----
 arch/c6x/boot/dts/linked_dtb.S     |  2 --
 arch/c6x/include/asm/sections.h    |  1 -
 arch/c6x/kernel/setup.c            |  4 +--
 arch/c6x/kernel/vmlinux.lds.S      | 10 ------
 arch/h8300/Makefile                | 11 +-----
 arch/microblaze/Makefile           |  4 +--
 arch/microblaze/boot/dts/Makefile  |  4 +++
 arch/mips/Makefile                 | 15 +-------
 arch/nds32/Makefile                |  2 +-
 arch/nios2/Makefile                | 11 +-----
 arch/nios2/boot/Makefile           | 22 ------------
 arch/nios2/boot/dts/Makefile       |  6 ++++
 arch/nios2/boot/linked_dtb.S       | 19 -----------
 arch/powerpc/Makefile              |  3 --
 arch/powerpc/boot/Makefile         | 55 ++++++++++++++----------------
 arch/powerpc/boot/dts/Makefile     |  6 ++++
 arch/powerpc/boot/dts/fsl/Makefile |  4 +++
 arch/xtensa/Makefile               | 12 +------
 scripts/Makefile                   |  3 +-
 scripts/Makefile.lib               |  2 +-
 scripts/dtc/Makefile               |  2 +-
 27 files changed, 102 insertions(+), 195 deletions(-)
 delete mode 100644 arch/c6x/boot/dts/linked_dtb.S
 create mode 100644 arch/nios2/boot/dts/Makefile
 delete mode 100644 arch/nios2/boot/linked_dtb.S
 create mode 100644 arch/powerpc/boot/dts/Makefile
 create mode 100644 arch/powerpc/boot/dts/fsl/Makefile

--
2.17.1
