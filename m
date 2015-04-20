Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5F0A1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 07:09:32 +1000 (AEST)
Date: Mon, 20 Apr 2015 23:09:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 09/11] cputime:Introduce the
 cputime_to_timespec64/timespec64_to_cputime function
In-Reply-To: <1429509459-17068-10-git-send-email-baolin.wang@linaro.org>
Message-ID: <alpine.DEB.2.11.1504202249590.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org>
 <1429509459-17068-10-git-send-email-baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com,
 paulus@samba.org, cl@linux.com, heenasirwani@gmail.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org,
 rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com,
 riel@redhat.com, arnd@arndb.de, richardcochran@gmail.com,
 schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tj@kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Apr 2015, Baolin Wang wrote:

> This patch introduces some functions for converting cputime to timespec64 and back,
> that repalce the timespec type with timespec64 type, as well as for arch/s390 and
> arch/powerpc architecture.

No. We want a patch which adds the functions and then a patch which
uses them. This stuff is tricky and hard to review. So please split
the patches into smaller chunks.

> +unsigned long
> +timespec64_to_jiffies(const struct timespec64 *value)
> +{
> +	return __timespec_to_jiffies(value->tv_sec, value->tv_nsec);
> +}
> +EXPORT_SYMBOL(timespec64_to_jiffies);

So we have now two exports which are doing exactly the same
thing. Copy and paste is wonderful, right?

What about exporting __timespec_to_jiffies() and providing inlines for
timespec_to_jiffies() and timespec64_to_jiffies() ?

EXPORT_SYMBOL is not just a stupid annotation. Its impact on the
resulting kernel size is larger than the actual function
implementation.

> +void
> +jiffies_to_timespec64(const unsigned long jiffies, struct timespec64 *value)
> +{
> +	/*
> +	 * Convert jiffies to nanoseconds and separate with
> +	 * one divide.
> +	 */
> +	u32 rem;
> +	value->tv_sec = div_u64_rem((u64)jiffies * TICK_NSEC,
> +				   NSEC_PER_SEC, &rem);
> +	value->tv_nsec = rem;
> +}
> +EXPORT_SYMBOL(jiffies_to_timespec64);

Sigh.

Thanks,

	tglx
