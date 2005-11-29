Return-Path: <SRS0+3333510f8c06434b4596+828+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89B2468802
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 11:57:34 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 29 Nov 2005 00:57:17 +0000
Message-Id: <1133225837.31573.110.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, drepper@redhat.com
Subject: [PATCH] 0/3 Add pselect/ppoll()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following implementation of ppoll() and pselect() system calls
depends on the architecture providing a TIF_RESTORE_SIGMASK flag in the
thread_info.

These system calls have to change the signal mask during their
operation, and signal handlers must be invoked using the new, temporary
signal mask. The old signal mask must be restored either upon successful
exit from the system call, or upon returning from the invoked signal
handler if the system call is interrupted. We can't simply restore the
original signal mask and return to userspace, since the restored signal
mask may actually block the signal which interrupted the system call.

The TIF_RESTORE_SIGMASK flag deals with this by causing the syscall exit
path to trap into do_signal() just as TIF_SIGPENDING does, and by
causing do_signal() to use the saved signal mask instead of the current
signal mask when setting up the stack frame for the signal handler -- or
by causing do_signal() to simply restore the saved signal mask in the
case where there is no handler to be invoked.

The first patch implements the sys_pselect() and sys_ppoll() system
calls, which are present only if TIF_RESTORE_SIGMASK is defined. That
#ifdef should go away in time when all architectures have implemented
it. The second patch implements TIF_RESTORE_SIGMASK for the PowerPC
kernel (in the -mm tree), and the third patch then removes the
arch-specific implementations of sys_rt_sigsuspend() and replaces them
with generic versions using the same trick.

-- 
dwmw2
