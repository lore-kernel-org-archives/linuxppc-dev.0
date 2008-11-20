Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18725.63534.3316.841949@cargo.ozlabs.ibm.com>
Date: Fri, 21 Nov 2008 10:52:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: joakim.tjernlund@transmode.se
Subject: Re: times(2) sys call bug?
In-Reply-To: <1227199742.5224.99.camel@gentoo-jocke.transmode.se>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
	<1227199742.5224.99.camel@gentoo-jocke.transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund writes:

> This little hack changes the kernel sys call handling in an crude
> way and then it works. Apperently the kernel thinks is an error if the
> syscall returns a value between -_LAST_ERRNO and -1.

Try this patch and let me if it fixes it.  If it does I'll push it
upstream.

Paul.

diff --git a/kernel/sys.c b/kernel/sys.c
index 31deba8..1bf8c5c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -33,6 +33,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/seccomp.h>
 #include <linux/cpu.h>
+#include <linux/ptrace.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -878,6 +879,7 @@ asmlinkage long sys_times(struct tms __user * tbuf)
 		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
 			return -EFAULT;
 	}
+	force_successful_syscall_return();
 	return (long) jiffies_64_to_clock_t(get_jiffies_64());
 }
 
