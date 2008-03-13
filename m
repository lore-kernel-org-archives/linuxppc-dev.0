Return-Path: <roland@redhat.com>
Received: from QMTA01.westchester.pa.mail.comcast.net
	(qmta01.westchester.pa.mail.comcast.net [76.96.62.16])
	by ozlabs.org (Postfix) with ESMTP id 1A4F4DDF71
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 19:33:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH -mm 3/4] x86_64 ia32 ptrace: use compat_ptrace_request for
	siginfo
In-Reply-To: Roland McGrath's message of  Thursday,
	13 March 2008 01:31:07 -0700
	<20080313083107.8BDE926F992@magilla.localdomain>
References: <20080313083107.8BDE926F992@magilla.localdomain>
Message-Id: <20080313083350.0A0D426F992@magilla.localdomain>
Date: Thu, 13 Mar 2008 01:33:50 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This removes the special-case handling for PTRACE_GETSIGINFO
and PTRACE_SETSIGINFO from x86_64's sys32_ptrace.  The generic
compat_ptrace_request code handles these.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/x86/kernel/ptrace.c |   30 +-----------------------------
 1 files changed, 1 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 77d9ddd..42305fa 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1184,32 +1184,6 @@ static int genregs32_set(struct task_struct *target,
 	return ret;
 }
 
-static long ptrace32_siginfo(unsigned request, u32 pid, u32 addr, u32 data)
-{
-	siginfo_t __user *si = compat_alloc_user_space(sizeof(siginfo_t));
-	compat_siginfo_t __user *si32 = compat_ptr(data);
-	siginfo_t ssi;
-	int ret;
-
-	if (request == PTRACE_SETSIGINFO) {
-		memset(&ssi, 0, sizeof(siginfo_t));
-		ret = copy_siginfo_from_user32(&ssi, si32);
-		if (ret)
-			return ret;
-		if (copy_to_user(si, &ssi, sizeof(siginfo_t)))
-			return -EFAULT;
-	}
-	ret = sys_ptrace(request, pid, addr, (unsigned long)si);
-	if (ret)
-		return ret;
-	if (request == PTRACE_GETSIGINFO) {
-		if (copy_from_user(&ssi, si, sizeof(siginfo_t)))
-			return -EFAULT;
-		ret = copy_siginfo_to_user32(si32, &ssi);
-	}
-	return ret;
-}
-
 asmlinkage long sys32_ptrace(long request, u32 pid, u32 addr, u32 data)
 {
 	struct task_struct *child;
@@ -1255,11 +1229,9 @@ asmlinkage long sys32_ptrace(long request, u32 pid, u32 addr, u32 data)
 	case PTRACE_SETFPXREGS:
 	case PTRACE_GETFPXREGS:
 	case PTRACE_GETEVENTMSG:
-		break;
-
 	case PTRACE_SETSIGINFO:
 	case PTRACE_GETSIGINFO:
-		return ptrace32_siginfo(request, pid, addr, data);
+		break;
 	}
 
 	child = ptrace_get_task_struct(pid);
