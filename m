Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 019091A0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 00:15:11 +1000 (AEST)
Date: Tue, 21 Apr 2015 16:14:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods
 with timespec64 type for k_clock structure
In-Reply-To: <3755355.Xf0HbltZXg@wuerfel>
Message-ID: <alpine.DEB.2.11.1504211528040.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <1429509459-17068-5-git-send-email-baolin.wang@linaro.org>
 <alpine.DEB.2.11.1504202131500.13914@nanos> <3755355.Xf0HbltZXg@wuerfel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, richardcochran@gmail.com, tj@kernel.org,
 john.stultz@linaro.org, rth@twiddle.net, Baolin Wang <baolin.wang@linaro.org>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, schwidefsky@de.ibm.com, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Apr 2015, Arnd Bergmann wrote:
> > COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
> >                        struct compat_itimerspec __user *, setting)
> 
> As a side note, I want to kill off the get_fs()/set_fs() calls in
> the process. These always make me dizzy when I try to work out whether
> there is a potential security hole (there is not in this case), and
> they can be slow on some architectures.

Yeah. I have to take a deep breath every time I look at those :)
 
> My preferred solution is one where we end up with the same syscalls
> for both 32-bit and 64-bit, and basically use the
> compat_sys_timer_gettime() implementation (or a simplified version)
> for the existing , something like this:

No objections from my side. I was not looking into the syscall magic
yet. I just wanted to avoid the code churn and have the guts of the
syscalls factored out for simple reusage.

....
 
> Note the use of a separate __kernel_itimerspec64 for the user interface
> here, which I think will be needed to hide the differences between the
> normal itimerspec on 64-bit machines, and the new itimerspec on 32-bit
> platforms that will be defined differently (using 'long long').

Confused.

timespec64 / itimerspec64 should be the same independent of 64bit and
32bit. So why do we need another variant ?

> I would also prefer not too many people to work on the syscalls, and
> would rather have Baolin not touch any of the syscall prototypes for
> the moment.

I did not ask him to change any of the syscall prototypes. I just
wanted him to split out the guts of the syscall into a seperate static
function to avoid all that code churn.

Thanks,

	tglx
