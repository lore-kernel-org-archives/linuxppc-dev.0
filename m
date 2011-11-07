Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 3B6E21007D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 10:31:35 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove buggy 9-year-old test for binutils < 2.12.1
Date: Mon,  7 Nov 2011 18:30:43 -0500
Message-Id: <1320708643-32631-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent binutils refuses to assemble AltiVec opcodes when in e500/SPE
mode, as some of those opcodes alias the "SPE" instructions.  This
triggers an ancient binutils version check even when building a kernel
with CONFIG_ALTIVEC disabled.

In theory, the check could be conditionalized on CONFIG_ALTIVEC, but in
practice it has long outlived its utility.  It is virtually impossible
to find binutils older than 2.12.1 (released 2002) in the wild anymore.
Even ancient RedHat Enterprise Linux 4 has binutils-2.14.

To fix the kernel build when done natively on e500 systems with this new
binutils, the test is simply removed.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/Makefile |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 57af16e..70ba0c0 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -255,12 +255,6 @@ checkbin:
 		echo 'disable kernel modules' ; \
 		false ; \
 	fi
-	@if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then \
-		echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build ' ; \
-		echo 'correctly with old versions of binutils.' ; \
-		echo '*** Please upgrade your binutils to 2.12.1 or newer' ; \
-		false ; \
-	fi
 
 CLEAN_FILES += $(TOUT)
 
-- 
1.7.2.5
