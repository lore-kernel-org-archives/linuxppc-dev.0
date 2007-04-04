Return-Path: <dzickus@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id E6DF0DDE34
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:26:50 +1000 (EST)
Date: Wed, 4 Apr 2007 13:25:19 -0400
From: Don Zickus <dzickus@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] allow vmsplice to work in 32-bit mode on ppc64
Message-ID: <20070404172519.GZ11029@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trivial change to pass vmsplice arguments through the compat layer on
pp64.

Signed-off-by: Don Zickus <dzickus@redhat.com>


diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 8d853c5..0b00068 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -288,7 +288,7 @@ COMPAT_SYS(ppoll)
 SYSCALL_SPU(unshare)
 SYSCALL_SPU(splice)
 SYSCALL_SPU(tee)
-SYSCALL_SPU(vmsplice)
+COMPAT_SYS_SPU(vmsplice)
 COMPAT_SYS_SPU(openat)
 SYSCALL_SPU(mkdirat)
 SYSCALL_SPU(mknodat)
