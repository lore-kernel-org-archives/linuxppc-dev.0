Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E327B70C2
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 19:51:41 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: ppc32/kprobe: Fix a bug for kprobe stwu r1
Date: Mon, 12 Dec 2011 16:50:49 +0800
Message-ID: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>
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

ppc32/kprobe: Fix a bug for kprobe stwu r1

There patches is used to fix that known kprobe bug,
[BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu' lead to system crash/freeze

https://lkml.org/lkml/2011/7/3/156

We withdraw the original way to provide a dedicated exception stack. Now we
implement this based on Ben's suggestion:

https://lkml.org/lkml/2011/11/30/327

Here I fix this bug only for ppc32 since Ben address another problem in ppc64
exception return codes. So I think I'd better send another patch to fix this
bug issued from ppc64 firstly. Then its convenient to merge this fix into ppc64.

Tiejun Chen (4):
      powerpc/kprobe: introduce a new thread flag
      ppc32/kprobe: introduce copy_exc_stack
      ppc32/kprobe: complete kprobe and migrate exception frame
      ppc32/kprobe: don't emulate store when kprobe stwu r1

 arch/powerpc/include/asm/page_32.h     |    1 +
 arch/powerpc/include/asm/thread_info.h |    2 ++
 arch/powerpc/kernel/entry_32.S         |   26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S          |   16 +++++++++++++++-
 arch/powerpc/kernel/ppc_ksyms.c        |    1 +
 arch/powerpc/lib/sstep.c               |   19 +++++++++++++++++--
 6 files changed, 62 insertions(+), 3 deletions(-)

Tiejun
