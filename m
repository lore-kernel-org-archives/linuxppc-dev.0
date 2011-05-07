Return-Path: <psomas@cslab.ece.ntua.gr>
Received: from diomedes.noc.ntua.gr (diomedes.noc.ntua.gr [147.102.222.220])
	by ozlabs.org (Postfix) with ESMTP id D3799B712E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 May 2011 00:11:40 +1000 (EST)
From: Stratos Psomadakis <psomas@cslab.ece.ntua.gr>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] ppc: Fix compiler warning in ptrace.c [-Wno-array-bounds]
Date: Sat,  7 May 2011 17:11:30 +0300
Message-Id: <1304777491-7947-2-git-send-email-psomas@cslab.ece.ntua.gr>
In-Reply-To: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
References: <1304777491-7947-1-git-send-email-psomas@cslab.ece.ntua.gr>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The trick used to bypass the thread_struct fpr array in order to access the
struct fpscr, in arch/powerpc/kernel/ptrace.c, can trigger an "array subscript
is above array bounds [-Werror=array-bounds]" warning.

Add -Wno-array-bounds to CFLAGS_ptrace.o, in arch/powerpc/kernel/Makefile to
slience this warning.

Signed-off-by: Stratos Psomadakis <psomas@ece.ntua.gr>
---
 arch/powerpc/kernel/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 3bb2a3e..92b1002 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
+CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"' -Wno-array-bounds
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
-- 
1.5.6.5
