Return-Path: <hidehiro.kawai.ez@hitachi.com>
Received: from mailx.hitachi.co.jp (mailx.hitachi.co.jp [133.145.228.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 50AB31A0E24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 22:17:53 +1000 (AEST)
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by mailx.hitachi.co.jp (Postfix) with ESMTP id F23B82168084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 20:39:55 +0900 (JST)
Subject: [PATCH 0/3] kexec: crash_kexec_post_notifiers boot option related
 fixes
To: Andrew Morton <akpm@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 10 Jul 2015 20:33:31 +0900
Message-ID: <20150710113331.4368.10495.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a bugfix patch set for crash_kexec_post_notifiers boot option
which allows users to call panic notifiers and kmsg dumpers before
kdump.

The main patch is PATCH 3/3, and it fixes two problems reported by
Daniel Walker (https://lkml.org/lkml/2015/6/24/44). 

 Problem 1:
 If crash_kexec_post_notifiers boot option is specified, some
 shutting down process which assume other cpus are still alive
 don't work properly.

 Problem 2:
 If crash_kexec_post_notifiers boot option is specified, register
 information of other cpus are not saved to crash dumps.

PATCH 3/3 is also another solution for a bug reported by Daisuke
Hatayama (https://lkml.org/lkml/2015/5/15/284).  So, this patch
replace commits 5375b70 and f45d85f which fix the bug.

---

Hidehiro Kawai (3):
      panic: Disable crash_kexec_post_notifiers if kdump is not available
      kexec: Pass panic message to crash_kexec()
      kexec: Change the timing of callbacks related to "crash_kexec_post_notifiers" boot option


 Documentation/kernel-parameters.txt |    4 ++
 arch/arm/kernel/traps.c             |    2 +
 arch/arm64/kernel/traps.c           |    2 +
 arch/metag/kernel/traps.c           |    2 +
 arch/mips/kernel/traps.c            |    2 +
 arch/powerpc/kernel/traps.c         |    2 +
 arch/s390/kernel/ipl.c              |    2 +
 arch/sh/kernel/traps.c              |    2 +
 arch/x86/kernel/dumpstack.c         |    2 +
 arch/x86/platform/uv/uv_nmi.c       |    2 +
 include/linux/kernel.h              |    1 +
 include/linux/kexec.h               |    7 +++-
 kernel/kexec.c                      |   62 ++++++++++++++++++++++++++++++-----
 kernel/panic.c                      |   23 ++++---------
 14 files changed, 80 insertions(+), 35 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
