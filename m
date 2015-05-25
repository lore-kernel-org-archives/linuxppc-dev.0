Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A17B41A0773
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 08:53:33 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 behanw@converseincode.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] Build ppc64le kernel with llvm/clang
Date: Tue, 26 May 2015 08:53:24 +1000
Message-Id: <1432594410-31198-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that Michael has fixed the 32 bit VDSO issue in his next branch, there are only
a few remaining things left to get the ppc64le kernel building with clang.

The last patch is a hack to workaround some generic Makefile issues. Hopefully the
relevant bits of the LLVMLinux tree will get merged upstream to fix them.

Anton Blanchard (6):
  powerpc: Fix duplicate const clang warning in user access code
  powerpc: Only use -mabi=altivec if toolchain supports it
  powerpc: Only use -mtraceback=no, -mno-string and -msoft-float if
    toolchain supports it
  powerpc: Don't use -mno-strict-align on clang
  powerpc: Don't use gcc specific options on clang
  llvm: A few Makefile hacks

 Makefile                           |  5 +++++
 arch/powerpc/Makefile              | 14 ++++++++++----
 arch/powerpc/include/asm/uaccess.h |  8 ++++----
 arch/powerpc/lib/Makefile          |  2 +-
 lib/raid6/Makefile                 |  2 +-
 5 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.1.4
