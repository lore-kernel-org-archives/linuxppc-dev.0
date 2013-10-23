Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D38A22C033F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 20:31:34 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [v6][PATCH 0/5] powerpc/book3e: powerpc/book3e: make kgdb to work well
Date: Wed, 23 Oct 2013 17:31:20 +0800
Message-ID: <1382520685-11609-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

Tested on fsl-p5040 DS.

v6:

* rebase
* change the C code to initialize the exception stack addresses in the PACA instead.
* Clear the PACA_IRQ_HARD_DIS force to exit directly from this debug exception
  without replaying interrupt.
* so drop "book3e/kgdb: update thread's dbcr0".

v5:

* rebase on merge branch.

Note the original patch, [ATCH 5/7] kgdb/kgdbts: support ppc64, is already merged
by Jason.

v4:

* use DEFINE_PER_CPU to allocate kgdb's thread_info
* add patch 7 to make usre copy thread_info only !__check_irq_replay
* leave "andi.   r14,r11,MSR_PR" out of "#ifndef CONFIG_KGDB"
  since cr0 is still used lately.
* retest

v3:

* make work when enable CONFIG_RELOCATABLE
* fix one typo in patch,
  "powerpc/book3e: store critical/machine/debug exception thread info": 
	ld	r1,PACAKSAVE(r13);
    ->  ld	r14,PACAKSAVE(r13);
* remove copying the thread_info since booke and book3e always copy
  the thead_info now when we enter the debug exception, and so drop
  the v2 patch, "book3e/kgdb: Fix a single stgep case of lazy IRQ"

v2:

* Make sure we cover CONFIG_PPC_BOOK3E_64 safely
* Use LOAD_REG_IMMEDIATE() to load properly
	the value of the constant expression in load debug exception stack 
* Copy thread infor form the kernel stack coming from usr
* Rebase latest powerpc git tree

v1:

* Copy thread info only when we are from !user mode since we'll get kernel stack
  coming from usr directly.
* remove save/restore EX_R14/EX_R15 since DBG_EXCEPTION_PROLOG already covered
  this.
* use CURRENT_THREAD_INFO() conveniently to get thread.
* fix some typos
* add a patch to make sure gdb can generate a single step properly to invoke a
  kgdb state.
* add a patch to if we need to replay an interrupt, we shouldn't restore that
  previous backup thread info to make sure we can replay an interrupt lately
  with a proper thread info.
* rebase latest powerpc git tree

v0:

This patchset is used to support kgdb for book3e.

----------------------------------------------------------------
Tiejun Chen (5):
      powerpc/book3e: initialize crit/mc/dbg kernel stack pointers
      powerpc/book3e: store crit/mc/dbg exception thread info
      powerpc/book3e: support kgdb for kernel space
      powerpc/kgdb: use DEFINE_PER_CPU to allocate kgdb's thread_info
      powerpc/book3e/kgdb: Fix a single stgep case of lazy IRQ

 arch/powerpc/kernel/exceptions-64e.S |   26 ++++++++++++++++++++++----
 arch/powerpc/kernel/kgdb.c           |   13 ++++++++++---
 arch/powerpc/kernel/setup_64.c       |   18 ++++++++++++------
 3 files changed, 44 insertions(+), 13 deletions(-)

Tiejun
