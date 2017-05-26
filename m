Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYww324MVzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 16:19:47 +1000 (AEST)
Date: Fri, 26 May 2017 16:19:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: use the asm-genric versions of some uapi includes
Message-ID: <20170526161946.7bf423c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are completely obvious as all they do is include the asm-generic
versions.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/uapi/asm/Kbuild     | 5 +++++
 arch/powerpc/include/uapi/asm/param.h    | 1 -
 arch/powerpc/include/uapi/asm/poll.h     | 1 -
 arch/powerpc/include/uapi/asm/resource.h | 1 -
 arch/powerpc/include/uapi/asm/statfs.h   | 6 ------
 5 files changed, 5 insertions(+), 9 deletions(-)
 delete mode 100644 arch/powerpc/include/uapi/asm/param.h
 delete mode 100644 arch/powerpc/include/uapi/asm/poll.h
 delete mode 100644 arch/powerpc/include/uapi/asm/resource.h
 delete mode 100644 arch/powerpc/include/uapi/asm/statfs.h

Compile tested with powerpc ppc64_defconfig and headers_install output
compared with only the include guards different (in statfs.h).

diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index b15bf6bc0e94..9aba4af4122e 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -1,2 +1,7 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += param.h
+generic-y += poll.h
+generic-y += resource.h
+generic-y += statfs.h
diff --git a/arch/powerpc/include/uapi/asm/param.h b/arch/powerpc/include/uapi/asm/param.h
deleted file mode 100644
index 965d45427975..000000000000
--- a/arch/powerpc/include/uapi/asm/param.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/param.h>
diff --git a/arch/powerpc/include/uapi/asm/poll.h b/arch/powerpc/include/uapi/asm/poll.h
deleted file mode 100644
index c98509d3149e..000000000000
--- a/arch/powerpc/include/uapi/asm/poll.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/poll.h>
diff --git a/arch/powerpc/include/uapi/asm/resource.h b/arch/powerpc/include/uapi/asm/resource.h
deleted file mode 100644
index 04bc4db8921b..000000000000
--- a/arch/powerpc/include/uapi/asm/resource.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/resource.h>
diff --git a/arch/powerpc/include/uapi/asm/statfs.h b/arch/powerpc/include/uapi/asm/statfs.h
deleted file mode 100644
index 5244834583a4..000000000000
--- a/arch/powerpc/include/uapi/asm/statfs.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_POWERPC_STATFS_H
-#define _ASM_POWERPC_STATFS_H
-
-#include <asm-generic/statfs.h>
-
-#endif
-- 
2.11.0

-- 
Cheers,
Stephen Rothwell
