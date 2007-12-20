Return-Path: <roland@redhat.com>
Received: from QMTA02.emeryville.ca.mail.comcast.net
	(qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
	by ozlabs.org (Postfix) with ESMTP id 68AE9DDE49
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:02:40 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 23/43] powerpc compat_ptrace_request
Message-Id: <20071220115849.4CD4626F98B@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:58:49 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes some duplicated code by calling the new generic
compat_ptrace_request from powerpc's compat_sys_ptrace.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace32.c |   34 ++--------------------------------
 1 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index fea6206..6612304 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -27,6 +27,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/signal.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -112,20 +113,6 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		goto out_tsk;
 
 	switch (request) {
-	/* when I and D space are separate, these will need to be fixed. */
-	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
-	case PTRACE_PEEKDATA: {
-		unsigned int tmp;
-		int copied;
-
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
-		ret = -EIO;
-		if (copied != sizeof(tmp))
-			break;
-		ret = put_user(tmp, (u32 __user *)data);
-		break;
-	}
-
 	/*
 	 * Read 4 bytes of the other process' storage
 	 *  data is a pointer specifying where the user wants the
@@ -225,19 +212,6 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		break;
 	}
 
-	/* If I and D space are separate, this will have to be fixed. */
-	case PTRACE_POKETEXT: /* write the word at location addr. */
-	case PTRACE_POKEDATA: {
-		unsigned int tmp;
-		tmp = data;
-		ret = 0;
-		if (access_process_vm(child, addr, &tmp, sizeof(tmp), 1)
-				== sizeof(tmp))
-			break;
-		ret = -EIO;
-		break;
-	}
-
 	/*
 	 * Write 4 bytes into the other process' storage
 	 *  data is the 4 bytes that the user wants written
@@ -337,10 +311,6 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		break;
 	}
 
-	case PTRACE_GETEVENTMSG:
-		ret = put_user(child->ptrace_message, (unsigned int __user *) data);
-		break;
-
 	case PTRACE_GETREGS: { /* Get all pt_regs from the child. */
 		int ui;
 	  	if (!access_ok(VERIFY_WRITE, (void __user *)data,
@@ -402,7 +372,7 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		break;
 
 	default:
-		ret = ptrace_request(child, request, addr, data);
+		ret = compat_ptrace_request(child, request, addr, data);
 		break;
 	}
 out_tsk:
-- 
1.5.3.6
