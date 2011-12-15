Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C28951007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2011 22:00:52 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2 0/3] ppc32/kprobe: Fix a bug for kprobe stwu r1
Date: Thu, 15 Dec 2011 19:00:07 +0800
Message-ID: <1323946810-4868-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes from V1:

* use memcpy simply to withdraw copy_exc_stack
* add !(regs->msr & MSR_PR)) and
	WARN_ON(test_thread_flag(TIF_EMULATE_STACK_STORE));
  to make sure we're in goot path.
* move this migration process inside 'restore'
* clear TIF flag atomically 

Tiejun Chen (3):
      powerpc/kprobe: introduce a new thread flag
      ppc32/kprobe: complete kprobe and migrate exception frame
      ppc32/kprobe: don't emulate store when kprobe stwu r1

 arch/powerpc/include/asm/thread_info.h |    3 ++
 arch/powerpc/kernel/entry_32.S         |   35 ++++++++++++++++++++++++++++++++
 arch/powerpc/lib/sstep.c               |   25 +++++++++++++++++++++-
 3 files changed, 61 insertions(+), 2 deletions(-)

Tiejun
