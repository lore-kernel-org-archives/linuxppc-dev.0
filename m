Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4AEE1A0EF5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 17:12:14 +1000 (AEST)
In-Reply-To: <dd848073cfae511453b9f558c0fbb3859909f268.1434071179.git.sam.bobroff@au1.ibm.com>
To: Sam bobroff <sam.bobroff@au1.ibm.com>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
Subject: Re: [1/1] powerpc/tm: Abort syscalls in active transactions (v2)
Message-Id: <20150619071214.97DEB140213@ozlabs.org>
Date: Fri, 19 Jun 2015 17:12:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-12-06 at 01:06:32 UTC, Sam bobroff wrote:
> This patch changes the syscall handler to doom (tabort) active
> transactions when a syscall is made and return very early without
> performing the syscall and keeping side effects to a minimum (no CPU
> accounting or system call tracing is performed). Also included is a
> new HWCAP2 bit, PPC_FEATURE2_HTM_NOSC, to indicate this
> behaviour to userspace.

> ---
>  Documentation/powerpc/transactional_memory.txt  | 32 ++++++++++++-------------
>  arch/powerpc/include/asm/cputable.h             | 10 ++++----
>  arch/powerpc/include/uapi/asm/cputable.h        |  1 +
>  arch/powerpc/include/uapi/asm/tm.h              |  2 +-
>  arch/powerpc/kernel/cputable.c                  |  4 +++-
>  arch/powerpc/kernel/entry_64.S                  | 28 ++++++++++++++++++++++
>  tools/testing/selftests/powerpc/tm/tm-syscall.c |  3 ++-

You forgot to add the tm-syscall test back into the Makefile, when I do that I get:

  In file included from tm-syscall.c:21:0:
  tm-syscall.c: In function ‘tm_syscall’:
  tm-syscall.c:86:7: error: ‘PPC_FEATURE2_HTM_NOSC’ undeclared (first use in this function)
       & PPC_FEATURE2_HTM_NOSC));
         ^

Because the toolchain headers don't contain that definition.

To fix it you need to include the generated kernel headers:

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 1b616fa79e93..4bea62a319dc 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -5,7 +5,7 @@ all: $(TEST_PROGS)
 $(TEST_PROGS): ../harness.c
 
 tm-syscall: tm-syscall-asm.S
-tm-syscall: CFLAGS += -mhtm
+tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
 
 include ../../lib.mk
 

I've fixed it up for you.

cheers
