Return-Path: <SRS0+3333510f8c06434b4596+828+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 336C4687F5
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 21:42:15 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
In-Reply-To: <438BE48B.9060908@kolumbus.fi>
References: <1133225007.31573.86.camel@baythorne.infradead.org>
	<1133225852.31573.115.camel@baythorne.infradead.org>
	<438BE48B.9060908@kolumbus.fi>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Nov 2005 10:42:03 +0000
Message-Id: <1133260923.31573.131.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	drepper@redhat.com
Subject: Re: [PATCH] 3/3 Generic sys_rt_sigsuspend
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-11-29 at 07:18 +0200, Mika Penttilä wrote:
> You are not setting saved_sigmask here. 

Oops; well spotted. Thanks.

> And shouldn't it return -EINTR?

I believe not. The previous versions would loop until do_signal()
returned non-zero; i.e. until a signal was actually delivered.
By returning -ERESTARTNOHAND we achieve the same effect. If there's a
signal delivered, that gets magically converted to -EINTR, but if
there's no signal delivered, the syscall gets restarted.

diff -u b/kernel/compat.c b/kernel/compat.c
--- b/kernel/compat.c
+++ b/kernel/compat.c
@@ -859,7 +859,7 @@
 #ifdef __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
 long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
 {
-	sigset_t saveset, newset;
+	sigset_t newset;
 	compat_sigset_t newset32;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
@@ -872,7 +872,7 @@
 	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
diff -u b/kernel/signal.c b/kernel/signal.c
--- b/kernel/signal.c
+++ b/kernel/signal.c
@@ -2626,7 +2626,7 @@
 #ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
 long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
 {
-	sigset_t saveset, newset;
+	sigset_t newset;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset_t))
@@ -2637,7 +2637,7 @@
 	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);


-- 
dwmw2
