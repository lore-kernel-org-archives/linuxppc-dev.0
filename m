Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C2651A0835
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 10:48:50 +1000 (EST)
Date: Wed, 4 Jun 2014 10:48:48 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, catalin.marinas@arm.com,
 azanella@linux.vnet.ibm.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
 akpm@linux-foundation.org
Subject: [PATCH] powerpc: 64bit sendfile is capped at 2GB
Message-ID: <20140604104848.33275ace@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 8f9c0119d7ba (compat: fs: Generic compat_sys_sendfile
implementation) changed the PowerPC 64bit sendfile call from
sys_sendile64 to sys_sendfile.

Unfortunately this broke sendfile of lengths greater than 2G because
sys_sendfile caps at MAX_NON_LFS. Restore what we had previously which
fixes the bug.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index ac062f5..35f8f2f 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -190,7 +190,7 @@ SYSCALL_SPU(getcwd)
 SYSCALL_SPU(capget)
 SYSCALL_SPU(capset)
 COMPAT_SYS(sigaltstack)
-COMPAT_SYS_SPU(sendfile)
+SYSX_SPU(sys_sendfile64,compat_sys_sendfile,sys_sendfile)
 SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
 PPC_SYS(vfork)
