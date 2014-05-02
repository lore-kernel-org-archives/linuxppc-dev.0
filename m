Return-Path: <James.Hogan@imgtec.com>
Received: from mailapp01.imgtec.com (unknown [195.59.15.197])
 by ozlabs.org (Postfix) with ESMTP id 456FD140124
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 20:37:20 +1000 (EST)
From: James Hogan <james.hogan@imgtec.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH] powerpc: Remove non-uapi linkage.h export
Date: Fri, 2 May 2014 11:20:41 +0100
Message-ID: <1399026041-28615-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 James Hogan <james.hogan@imgtec.com>, linuxppc-dev@lists.ozlabs.org,
 Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The arch/powerpc/include/asm/linkage.h is being unintentionally exported
in the kernel headers since commit e1b5bb6d1236 (consolidate
cond_syscall and SYSCALL_ALIAS declarations) when
arch/powerpc/include/uapi/asm/linkage.h was deleted but the header-y not
removed from the Kbuild file. This happens because Makefile.headersinst
still checks the old asm/ directory if the specified header doesn't
exist in the uapi directory.

The asm/linkage.h shouldn't ever have been exported anyway. No other
arch does and it doesn't contain anything useful to userland, so remove
the header-y line from the Kbuild file which triggers the export.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>
---
 arch/powerpc/include/uapi/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 48be855ef37b..7a3f795ac218 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -15,7 +15,6 @@ header-y += ioctls.h
 header-y += ipcbuf.h
 header-y += kvm.h
 header-y += kvm_para.h
-header-y += linkage.h
 header-y += mman.h
 header-y += msgbuf.h
 header-y += nvram.h
-- 
1.9.2
