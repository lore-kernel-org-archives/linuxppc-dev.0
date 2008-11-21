Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 35BD7DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 20:53:51 +1100 (EST)
Subject: Re: times(2) sys call bug?
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1227259869.5224.123.camel@gentoo-jocke.transmode.se>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
	<1227199742.5224.99.camel@gentoo-jocke.transmode.se>
	<18725.63534.3316.841949@cargo.ozlabs.ibm.com>
	<1227259869.5224.123.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Fri, 21 Nov 2008 10:53:49 +0100
Message-Id: <1227261229.5224.131.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-21 at 10:31 +0100, Joakim Tjernlund wrote:
> On Fri, 2008-11-21 at 10:52 +1100, Paul Mackerras wrote:
> > Joakim Tjernlund writes:
> > 
> > > This little hack changes the kernel sys call handling in an crude
> > > way and then it works. Apperently the kernel thinks is an error if the
> > > syscall returns a value between -_LAST_ERRNO and -1.
> > 
> > Try this patch and let me if it fixes it.  If it does I'll push it
> > upstream.
> > 
> > Paul.
> [SNIP]
> > +	force_successful_syscall_return();
> >  	return (long) jiffies_64_to_clock_t(get_jiffies_64());
> 
> Why is 64 bits ops used here when you only use 32 bits? 
> 
> BTW, I think time(2) needs this:
> 
> diff --git a/kernel/time.c b/kernel/time.c
[SNIP]

Oh, and compat needs fixing too. 

For both my patches:
Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

BTW, why is sys_time() impl. differently in compat:
  do_gettimeofday(&tv);
vs.
  get_seconds();

same for sys_times(): 
  compat_jiffies_to_clock_t(jiffies);
vs.
  jiffies_64_to_clock_t(get_jiffies_64());


diff --git a/kernel/compat.c b/kernel/compat.c
index 32c254a..c6346ec 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -23,6 +23,7 @@
 #include <linux/timex.h>
 #include <linux/migrate.h>
 #include <linux/posix-timers.h>
+#include <linux/ptrace.h>
 
 #include <asm/uaccess.h>
 
@@ -196,6 +197,7 @@ asmlinkage long compat_sys_times(struct compat_tms __user *tbuf)
 		if (copy_to_user(tbuf, &tmp, sizeof(tmp)))
 			return -EFAULT;
 	}
+	force_successful_syscall_return();
 	return compat_jiffies_to_clock_t(jiffies);
 }
 
@@ -850,8 +852,9 @@ asmlinkage long compat_sys_time(compat_time_t __user * tloc)
 
 	if (tloc) {
 		if (put_user(i,tloc))
-			i = -EFAULT;
+			return -EFAULT;
 	}
+	force_successful_syscall_return();
 	return i;
 }
 
