Return-Path: <anton.vorontsov@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B84B5B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2012 03:23:00 +1100 (EST)
Received: by bkwj10 with SMTP id j10so3328797bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 09:22:56 -0700 (PDT)
Date: Sat, 24 Mar 2012 20:21:52 +0400
From: Anton Vorontsov <anton.vorontsov@linaro.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
Message-ID: <20120324162151.GA3640@lizard>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
 <1332593574.16159.31.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1332593574.16159.31.camel@twins>
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>,
 John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 uclinux-dist-devel@blackfin.uclinux.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 24, 2012 at 01:52:54PM +0100, Peter Zijlstra wrote:
[...]
> > p.s. I know Peter Zijlstra detest the __cond_lock() stuff, but untill
> >      we have anything better in sparse, let's use it. This particular
> >      patch helped me to detect one bug that I myself made during
> >      task->mm fixup series. So, it is useful.
> 
> Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Also, why didn't lockdep catch it?

Because patch authors test their patches on architectures they own
(well, sometimes I do check patches on exotic architectures w/ qemu,
but it is less convenient than just build/sparse-test the patch w/
a cross compiler).

And since lockdep is a runtime checker, it is not very useful.

Sparse is a build-time checker, so it is even better in the sense
that it is able to catch bugs even in code that is executed rarely.

> Fix sparse already instead of smearing ugly all over.

Just wonder how do you see the feature implemented?

Something like this?

#define __ret_cond_locked(l, c)	__attribute__((ret_cond_locked(l, c)))
#define __ret_value		__attribute__((ret_value))
#define __ret_locked_nonnull(l)	__ret_cond_locked(l, __ret_value);

extern struct task_struct *find_lock_task_mm(struct task_struct *p)
	__ret_locked_nonnull(&__ret_value->alloc_lock);

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
