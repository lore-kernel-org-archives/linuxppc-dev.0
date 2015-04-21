Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 691D41A0214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 01:14:10 +1000 (AEST)
Date: Tue, 21 Apr 2015 17:13:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods
 with timespec64 type for k_clock structure
In-Reply-To: <3231171.5TrYVVBLh4@wuerfel>
Message-ID: <alpine.DEB.2.11.1504211701140.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <3755355.Xf0HbltZXg@wuerfel> <alpine.DEB.2.11.1504211528040.13914@nanos>
 <3231171.5TrYVVBLh4@wuerfel>
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
> On Tuesday 21 April 2015 16:14:26 Thomas Gleixner wrote:
> > > Note the use of a separate __kernel_itimerspec64 for the user interface
> > > here, which I think will be needed to hide the differences between the
> > > normal itimerspec on 64-bit machines, and the new itimerspec on 32-bit
> > > platforms that will be defined differently (using 'long long').
> > 
> > Confused.
> > 
> > timespec64 / itimerspec64 should be the same independent of 64bit and
> > 32bit. So why do we need another variant ?
> 
> There are multiple reasons:
> 
> * On 64-bit systems, timespec64 would always be defined in the same way
>   as struct timespec { __kernel_time_t tv_sec; long tv_nsec; }, with
>   __kernel_time_t being 'long'. On 32-bit, we probably need to make both
>   members 'long long' for the user space side, in order to share the
>   syscall implementation with the kernel side, but we may also want to
>   keep the internal timespec64 using a 'long' for tv_nsec, as we do
>   today. This means that both the binary layout (padding or no padding)
>   and the basic types (long or long long) are different between 32-bit
>   and 64-bit, and between kernel and user space

So you want to avoid a compat syscall for 32bit applications on a
64bit kernel, right?

That burdens 32bit with the extra 'long long' in user space. Not sure
whether user space folks will be happy about it.

> * We should not put 'struct timespec64' into the user space namespace,
>   as applications might already use that identifier. This is similar
>   to the __u32/u32 or __kernel_time_t/time_t tuple of types for interface
>   and in-kernel uses. This is particularly important when embedding a
>   timespec in another data structure.

Fair enough.

> * My plan is to use a temporary hack where I actually define
>   __kernel_timespec64 to look like the 32-bit version of timespec,
>   as an intermediate step when converting all 32-bit architectures over
>   to use the compat_*() syscalls in place of the existing ones, so
>   I can change over the normal syscalls to use __kernel_timespec64
>   without having to change all architectures at once, or having to
>   modify each syscall multiple times.

Makes sense.

Thanks,

	tglx
