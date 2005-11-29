Return-Path: <mika.penttila@kolumbus.fi>
Received: from mail-gw1.turkuamk.fi (mail-gw1.turkuamk.fi [195.148.208.125])
	by ozlabs.org (Postfix) with ESMTP id DFD66687FD
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 16:35:07 +1100 (EST)
Message-ID: <438BE48B.9060908@kolumbus.fi>
Date: Tue, 29 Nov 2005 07:18:03 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
References: <1133225007.31573.86.camel@baythorne.infradead.org>
	<1133225852.31573.115.camel@baythorne.infradead.org>
In-Reply-To: <1133225852.31573.115.camel@baythorne.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

David Woodhouse wrote:

>The TIF_RESTORE_SIGMASK flag allows us to have a generic implementation
>of sys_rt_sigsuspend() instead of duplicating it for each architecture.
>This provides such an implementation and makes arch/powerpc use it.
>
>It also tidies up the ppc32 sys_sigsuspend() to use TIF_RESTORE_SIGMASK.
>
>Signed-off-by: David Woodhouse <dwmw2@infradead.org>
>  
>
> 
>+#ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
>+long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
>+{
>+	sigset_t saveset, newset;
>+
>+	/* XXX: Don't preclude handling different sized sigset_t's.  */
>+	if (sigsetsize != sizeof(sigset_t))
>+		return -EINVAL;
>+
>+	if (copy_from_user(&newset, unewset, sizeof(newset)))
>+		return -EFAULT;
>+	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
>+
>+	spin_lock_irq(&current->sighand->siglock);
>+	saveset = current->blocked;
>+	current->blocked = newset;
>+	recalc_sigpending();
>+	spin_unlock_irq(&current->sighand->siglock);
>+
>+	current->state = TASK_INTERRUPTIBLE;
>+	schedule();
>+	set_thread_flag(TIF_RESTORE_SIGMASK);
>+	return -ERESTARTNOHAND;
>+}
>+#endif /* __ARCH_WANT_SYS_RT_SIGSUSPEND */
>+
>  
>
You are not setting saved_sigmask here. And shouldn't it return -EINTR?

Thanks,
Mika
