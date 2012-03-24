Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A7A71B703E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 23:53:59 +1100 (EST)
Message-ID: <1332593574.16159.31.camel@twins>
Subject: Re: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Date: Sat, 24 Mar 2012 13:52:54 +0100
In-Reply-To: <20120324103127.GJ29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Mike Frysinger <vapier@gentoo.org>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
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

On Sat, 2012-03-24 at 14:31 +0400, Anton Vorontsov wrote:
> This is needed so that callers would not get 'context imbalance'
> warnings from the sparse tool.
>=20
> As a side effect, this patch fixes the following sparse warnings:
>=20
>   CHECK   mm/oom_kill.c
>   mm/oom_kill.c:201:28: warning: context imbalance in 'oom_badness' -
>   unexpected unlock
>   include/linux/rcupdate.h:249:30: warning: context imbalance in
>   'dump_tasks' - unexpected unlock
>   mm/oom_kill.c:453:9: warning: context imbalance in 'oom_kill_task' -
>   unexpected unlock
>   CHECK   mm/memcontrol.c
>   ...
>   mm/memcontrol.c:1130:17: warning: context imbalance in
>   'task_in_mem_cgroup' - unexpected unlock
>=20
> p.s. I know Peter Zijlstra detest the __cond_lock() stuff, but untill
>      we have anything better in sparse, let's use it. This particular
>      patch helped me to detect one bug that I myself made during
>      task->mm fixup series. So, it is useful.

Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Also, why didn't lockdep catch it?

Fix sparse already instead of smearing ugly all over.
