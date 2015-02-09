Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0133.outbound.protection.outlook.com [157.56.110.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D10A1A033B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 18:55:41 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC][PATCH 1/3] powerpc: Don't force ENOSYS as error on syscall fail
Date: Mon, 9 Feb 2015 07:55:14 +0000
Message-ID: <1423468516-8688-2-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1423468516-8688-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1423468516-8688-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: pmoore@redhat.com, linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In certain scenarios - e.g. seccomp filtering with ERRNO as default action -
the system call fails for other reasons than the syscall not being available.
The seccomp filter can be configured to store a user-defined error code on
return from a blacklisted syscall.

The RFC is this: are there currently any user-space scenarios where it is
required that the system call return ENOSYS as error code on failure, no matter
the circumstances? I don't want to break userspace requirements. I have not
added code to force this error code in situations different than
secure_computing failure, in order to keep overhead at a minimum.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 arch/powerpc/kernel/entry_32.S | 3 ++-
 arch/powerpc/kernel/entry_64.S | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 59848e5..52e48dd 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -425,7 +425,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	b	1b
 #endif  /* CONFIG_44x */
 
-66:	li	r3,-ENOSYS
+66:
+#	li	r3,-ENOSYS
 	b	ret_from_syscall
 
 	.globl	ret_from_fork
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e6bfe8e..80db02e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -269,7 +269,7 @@ syscall_dotrace:
 	b	.Lsyscall_dotrace_cont
 
 syscall_enosys:
-	li	r3,-ENOSYS
+#	li	r3,-ENOSYS
 	b	syscall_exit
 	
 syscall_exit_work:
-- 
2.1.4
