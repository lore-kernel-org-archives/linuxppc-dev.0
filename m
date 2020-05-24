Return-Path: <SRS0=ulwU=7G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EBEC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2020 09:01:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B2920787
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2020 09:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B2920787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49VDjV0zyXzDqXZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2020 19:01:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.178.242; helo=mslow2.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49VDgd2M3NzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2020 18:59:40 +1000 (AEST)
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 6984B3A25E2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2020 08:53:53 +0000 (UTC)
Received: from localhost.localdomain
 (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
 (Authenticated sender: alex@ghiti.fr)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5C8BB200006;
 Sun, 24 May 2020 08:53:08 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <Anup.Patel@wdc.com>, Atish Patra <Atish.Patra@wdc.com>,
 Zong Li <zong.li@sifive.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/3] vmalloc kernel mapping and relocatable kernel
Date: Sun, 24 May 2020 04:52:56 -0400
Message-Id: <20200524085259.24784-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
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
Cc: Alexandre Ghiti <alex@ghiti.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patchset originally implemented relocatable kernel support but now
also moves the kernel mapping into the vmalloc zone.

The first patch explains why we need to move the kernel into vmalloc
zone (instead of memcpying it around). That patch should ease KASLR
implementation a lot.

The second patch allows to build relocatable kernels but is not selected
by default.

The third patch takes advantage of an already existing powerpc script
that checks relocations at compile-time, and uses it for riscv.

Alexandre Ghiti (3):
  riscv: Move kernel mapping to vmalloc zone
  riscv: Introduce CONFIG_RELOCATABLE
  arch, scripts: Add script to check relocations at compile time

 arch/powerpc/tools/relocs_check.sh |  18 +----
 arch/riscv/Kconfig                 |  12 +++
 arch/riscv/Makefile                |   5 +-
 arch/riscv/Makefile.postlink       |  36 +++++++++
 arch/riscv/boot/loader.lds.S       |   3 +-
 arch/riscv/include/asm/page.h      |  10 ++-
 arch/riscv/include/asm/pgtable.h   |  37 ++++++---
 arch/riscv/kernel/head.S           |   3 +-
 arch/riscv/kernel/module.c         |   4 +-
 arch/riscv/kernel/vmlinux.lds.S    |   9 ++-
 arch/riscv/mm/Makefile             |   4 +
 arch/riscv/mm/init.c               | 121 +++++++++++++++++++++++++----
 arch/riscv/mm/physaddr.c           |   2 +-
 arch/riscv/tools/relocs_check.sh   |  26 +++++++
 scripts/relocs_check.sh            |  20 +++++
 15 files changed, 258 insertions(+), 52 deletions(-)
 create mode 100644 arch/riscv/Makefile.postlink
 create mode 100755 arch/riscv/tools/relocs_check.sh
 create mode 100755 scripts/relocs_check.sh

-- 
2.20.1

