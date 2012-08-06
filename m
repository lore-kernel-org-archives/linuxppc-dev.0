Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AD9A2C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 23:27:27 +1000 (EST)
Received: from mail251-tx2 (localhost [127.0.0.1])	by
 mail251-tx2-R.bigfish.com (Postfix) with ESMTP id 143521D00331	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:23 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.254])	by
 mail251-tx2.bigfish.com (Postfix) with ESMTP id 21ED3740045	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:21 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q76DRIpq014467	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 06:27:19 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/6] powerpc/booke64: add core support for KVM
Date: Mon, 6 Aug 2012 16:27:02 +0300
Message-ID: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add core support for KVM on 64-bit Book3E PowerPC, mainly
integrating the DO_KVM macro. KVM arch specific patches will follow shortly.

Mihai Caraman (6):
  powerpc/booke64: fix machine check handler to use the right prolog
  powerpc/booke64: use GSRR registers in Guest Doorbell interrupts
  powerpc/booke64: add DO_KVM kernel hooks
  powerpc/booke64: remove mfspr srr1 duplicate in exception prolog
  powerpc/booke64: use SPRG0/3 scratch for bolted TLB miss & crit int
  powerpc/booke64: restore VDSO information on critical exception

 arch/powerpc/include/asm/exception-64e.h |    6 +-
 arch/powerpc/include/asm/paca.h          |    3 +
 arch/powerpc/include/asm/reg.h           |    6 +-
 arch/powerpc/kernel/asm-offsets.c        |    1 +
 arch/powerpc/kernel/exceptions-64e.S     |  194 +++++++++++++++++++-----------
 arch/powerpc/kernel/vdso.c               |    2 +
 arch/powerpc/mm/tlb_low_64e.S            |   18 ++-
 7 files changed, 151 insertions(+), 79 deletions(-)

-- 
1.7.4.1
