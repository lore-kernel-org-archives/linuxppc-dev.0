Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 714E21A0205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 06:14:04 +1000 (AEST)
Date: Tue, 21 Apr 2015 22:13:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods
 with timespec64 type for k_clock structure
In-Reply-To: <2819798.f0KhjY3UAe@wuerfel>
Message-ID: <alpine.DEB.2.11.1504212204130.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <3231171.5TrYVVBLh4@wuerfel> <alpine.DEB.2.11.1504211701140.13914@nanos>
 <2819798.f0KhjY3UAe@wuerfel>
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
> I know there are concerns about this, in particular because C11 and
> POSIX both require tv_nsec to be 'long', unlike timeval->tv_usec,
> which is a 'suseconds_t' and can be defined as 'long long'.
>
> a)
> 
> struct timespec {
> 	time_t tv_sec;
> 	long long tv_nsec; /* or typedef long long snseconds_t */
> };
> 
> This is not directly compatible with C11 or POSIX.1-2008, but it
> matches what we do inside of 64-bit kernels, so probably has the
> highest chance of working correctly in practice

After reading Linus rant in the x32 thread again (thanks for the
reminder), and looking at b/c/d - which rate between ugly and butt
ugly - I think we should go for a) and screw POSIX and C11 as those
committee dinosaurs seem to completely ignore the 2038 problem on
32bit machines. At least I have not found any hint that these folks
care at all. So why should we comply to something which is completely
useless?

That also makes the question about the upper 32bits check moot, so
it's the simplest and clearest of the possible solutions.

Thanks,

	tglx
