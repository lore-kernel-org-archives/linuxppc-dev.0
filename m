Return-Path: <roland@redhat.com>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by ozlabs.org (Postfix) with ESMTP id 4754CDDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:21:44 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 8/8] powerpc ptrace: arch_ptrace -ENOSYS return
In-Reply-To: Roland McGrath's message of  Wednesday,
	19 March 2008 14:17:14 -0700
	<20080319211714.8B14226F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
Message-Id: <20080319212110.082F126F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:21:10 -0700 (PDT)
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Return -ENOSYS from arch_ptrace and compat_arch_ptrace
rather than calling ptrace_request or compat_ptrace_request.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c   |    2 +-
 arch/powerpc/kernel/ptrace32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2a9fe97..47b701e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -843,7 +843,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		break;
 
 	default:
-		ret = ptrace_request(child, request, addr, data);
+		ret = -ENOSYS;
 		break;
 	}
 	return ret;
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index 4c1de6a..7383d15 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -306,7 +306,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 		break;
 
 	default:
-		ret = compat_ptrace_request(child, request, addr, data);
+		ret = -ENOSYS;
 		break;
 	}
 
