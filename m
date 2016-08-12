Return-Path: <prvs=0032113f0d=holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9nyH0X3WzDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 00:56:07 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org
Cc: dave.hansen@linux.intel.com, mingo@kernel.org
From: Holger Brunck <holger.brunck@keymile.com>
Subject: debug problems on ppc 83xx target due to changed struct task_struct
Message-ID: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
Date: Fri, 12 Aug 2016 16:50:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
we are currently trying to update from kernel 3.10 to latest stable kernel 4.4
and we encounter the following problem.

When I try to debug our multithreaded userspace application with gdb I  get
stuck when trying to single step code.

Due to the fact that our ppc 8360 target is mainlined (kmeter1) I was able to
bisect the kernel to check when this problem was introduced. It turns out to be
introduced with commit:

commit 0c8c0f03e3a292e031596484275c14cf39c0ab7a
Author: Dave Hansen <dave@sr71.net>
Date:   Fri Jul 17 12:28:11 2015 +0200

    x86/fpu, sched: Dynamically allocate 'struct fpu'

This patch moves the definition of "struct thread_struct thread;" from the
middle of the "struct task_struct" to the end (include/linux/sched.h). When I
move back the definition to the original place and recompile, everything works
fine. I double-checked this with the latest kernel 4.7 and I have the  same
behaviour.

I also tried a different toolchain (I got poky/jethro with gcc 5.2) and tried a
eldk 5.4 with gcc 4.7, as I am not sure if this is really a kernel problem  or
related to a gdb or gcc. But I still have the same behaviour with a different
toolchain.

Does anyone have an idea why the change in sched.h break my debug usecase?
Anyone out here who is debugging ppc83xx targets flawlessly with a recent kernel?

Any help is apreciated.

Best regards
Holger Brunck
