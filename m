Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E2C862C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 03:22:09 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH 0/4] remap non-modular uses of module_init properly
Date: Mon, 13 Jan 2014 11:21:49 -0500
Message-ID: <1389630113-7919-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The goal is to move module_init/module_exit from init.h and into
module.h -- however in doing so, we uncover several instances in
powerpc code where module_init is used somewhat incorrectly by
non modular code, and a file that needs module.h but isn't sourcing
it.  We need to make these fixups 1st before changing the headers
so that we don't cause build failures.

The changes are largely inert, however we do cause a largely trivial
change in the initcall ordering -- that happens because module_init
is really device_initcall; and yet we shouldn't be using device_initcall
where clearly arch_initcall or subsys_initcall are more appropriate.

Boot tested on sbc8548 on powerpc next branch of today.

Paul Gortmaker (4):
  powerpc: use device_initcall for registering rtc devices
  powerpc: book3s kvm can be modular so it should use module.h
  powerpc: use subsys_initcall for Freescale Local Bus
  powerpc: don't use module_init for non-modular core hugetlb code

 arch/powerpc/kernel/time.c        | 2 +-
 arch/powerpc/kvm/book3s.c         | 2 +-
 arch/powerpc/mm/hugetlbpage.c     | 2 +-
 arch/powerpc/platforms/ps3/time.c | 3 +--
 arch/powerpc/sysdev/fsl_lbc.c     | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

-- 
1.8.5.2
