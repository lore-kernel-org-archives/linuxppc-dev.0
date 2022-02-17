Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDC6C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Feb 2022 22:54:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K09BV40dRz3cbb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Feb 2022 09:54:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.231;
 helo=out01.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
X-Greylist: delayed 1032 seconds by postgrey-1.36 at boromir;
 Fri, 18 Feb 2022 09:54:13 AEDT
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K099x2wDfz2x9V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Feb 2022 09:54:13 +1100 (AEDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:48942)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1nKpOJ-001bK3-23; Thu, 17 Feb 2022 15:36:47 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:32906
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1nKpOG-00GKIm-Md; Thu, 17 Feb 2022 15:36:46 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Arnd Bergmann <arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-19-arnd@kernel.org>
Date: Thu, 17 Feb 2022 16:36:20 -0600
In-Reply-To: <20220216131332.1489939-19-arnd@kernel.org> (Arnd Bergmann's
 message of "Wed, 16 Feb 2022 14:13:32 +0100")
Message-ID: <8735khi0ij.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nKpOG-00GKIm-Md; ; ;
 mid=<8735khi0ij.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.227.174.4; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1/V+0C7NWKuSkdwXmdluwhE5ZIu3hq7L5I=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, dalias@libc.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, peterz@infradead.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, guoren@kernel.org, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
 will@kernel.org, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, bcain@codeaurora.org, deller@gmx.de,
 x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org,
 ardb@kernel.org, mingo@redhat.com, geert@linux-m68k.org,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 arnd@arndb.de, hca@linux.ibm.com, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 viro@zeniv.linux.org.uk, shorne@gmail.com, monstr@monstr.eu,
 tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org, nickhu@andestech.com,
 jcmvbkbc@gmail.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 dinguyen@kernel.org, richard@nod.at, akpm@linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, davem@davemloft.net,
 green.hu@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> There are no remaining callers of set_fs(), so CONFIG_SET_FS
> can be removed globally, along with the thread_info field and
> any references to it.
>
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
>
> With CONFIG_SET_FS gone, so drop all remaining references to
> set_fs()/get_fs(), mm_segment_t and uaccess_kernel().

For the bits I have looked at recently, and think I understand.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/exec.c                                 |  6 --
>  kernel/exit.c                             | 14 -----
>  kernel/kthread.c                          |  5 --
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..bc68a0c089ac 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1303,12 +1303,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out_unlock;
>  
> -	/*
> -	 * Ensure that the uaccess routines can actually operate on userspace
> -	 * pointers:
> -	 */
> -	force_uaccess_begin();
> -
>  	if (me->flags & PF_KTHREAD)
>  		free_kthread_struct(me);
>  	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
> diff --git a/kernel/exit.c b/kernel/exit.c
> index b00a25bb4ab9..0884a75bc2f8 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -737,20 +737,6 @@ void __noreturn do_exit(long code)
>  
>  	WARN_ON(blk_needs_flush_plug(tsk));
>  
> -	/*
> -	 * If do_dead is called because this processes oopsed, it's possible
> -	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
> -	 * continuing. Amongst other possible reasons, this is to prevent
> -	 * mm_release()->clear_child_tid() from writing to a user-controlled
> -	 * kernel address.
> -	 *
> -	 * On uptodate architectures force_uaccess_begin is a noop.  On
> -	 * architectures that still have set_fs/get_fs in addition to handling
> -	 * oopses handles kernel threads that run as set_fs(KERNEL_DS) by
> -	 * default.
> -	 */
> -	force_uaccess_begin();
> -
>  	kcov_task_exit(tsk);
>  
>  	coredump_task_exit(tsk);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 38c6dd822da8..16c2275d4b50 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -55,7 +55,6 @@ struct kthread {
>  	int result;
>  	int (*threadfn)(void *);
>  	void *data;
> -	mm_segment_t oldfs;
>  	struct completion parked;
>  	struct completion exited;
>  #ifdef CONFIG_BLK_CGROUP
> @@ -1441,8 +1440,6 @@ void kthread_use_mm(struct mm_struct *mm)
>  		mmdrop(active_mm);
>  	else
>  		smp_mb();
> -
> -	to_kthread(tsk)->oldfs = force_uaccess_begin();
>  }
>  EXPORT_SYMBOL_GPL(kthread_use_mm);
>  
> @@ -1457,8 +1454,6 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
>  	WARN_ON_ONCE(!tsk->mm);
>  
> -	force_uaccess_end(to_kthread(tsk)->oldfs);
> -
>  	task_lock(tsk);
>  	/*
>  	 * When a kthread stops operating on an address space, the loop
