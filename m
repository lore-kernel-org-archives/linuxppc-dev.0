Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D28912C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 14:04:26 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [v3][PATCH 0/6] powerpc/book3e: make kgdb to work well
Date: Wed, 27 Feb 2013 11:04:15 +0800
Message-ID: <1361934261-31840-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset is used to support kgdb/gdb on book3e.

Validated on p4080ds and p5040ds with test single step and breakpoint

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

------
Tiejun Chen (6):
      powerpc/book3e: load critical/machine/debug exception stack
      powerpc/book3e: store critical/machine/debug exception thread info
      book3e/kgdb: update thread's dbcr0
      powerpc/book3e: support kgdb for kernel space
      kgdb/kgdbts: support ppc64
      powerpc/kgdb: remove copying the thread_info

 arch/powerpc/kernel/exceptions-64e.S |   69 ++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/kgdb.c           |   41 +++++---------------
 drivers/misc/kgdbts.c                |    2 +
 3 files changed, 77 insertions(+), 35 deletions(-)

Tiejun
