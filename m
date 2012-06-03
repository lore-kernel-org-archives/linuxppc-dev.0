Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AE59B7039
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2012 15:09:28 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v3 PATCH 0/3] ppc32/kprobe: Fix a bug for kprobe stwu r1
Date: Sun, 3 Jun 2012 13:07:43 +0800
Message-ID: <1338700063-30670-4-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1338700063-30670-1-git-send-email-tiejun.chen@windriver.com>
References: <1338700063-30670-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes from V2:

* populate those existed codes to reorganize codes
* add check if we'll trigger kernel stack over flow

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
 arch/powerpc/kernel/entry_32.S         |   43 ++++++++++++++++++++++++++-----
 arch/powerpc/lib/sstep.c               |   37 ++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 9 deletions(-)
