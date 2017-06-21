Return-Path: <srs0=hv2q=52=linaro.org=john.stultz@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtDMl0g4SzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:51:47 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wtDMl092bz8t1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 04:51:47 +1000 (AEST)
Received: from mail-wr0-x230.google.com (mail-wr0-x230.google.com
 [IPv6:2a00:1450:400c:c0c::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wtDMk2GgJz9s7M
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2017 04:51:46 +1000 (AEST)
Received: by mail-wr0-x230.google.com with SMTP id r103so146933549wrb.0
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2017 11:51:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170527080452.GA14021@fergus.ozlabs.ibm.com>
References: <20170527080452.GA14021@fergus.ozlabs.ibm.com>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 21 Jun 2017 11:51:42 -0700
Message-ID: <CALAqxLXiDZyDKOYBKXYPk1No_=6jCuC65rZQrdYqpv7CoCpqPA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Convert VDSO update function to use new
 update_vsyscall interface
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <michael@ellerman.id.au>,
 lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 27, 2017 at 1:04 AM, Paul Mackerras <paulus@ozlabs.org> wrote:
> This converts the powerpc VDSO time update function to use the new
> interface introduced in commit 576094b7f0aa ("time: Introduce new
> GENERIC_TIME_VSYSCALL", 2012-09-11).  Where the old interface gave
> us the time as of the last update in seconds and whole nanoseconds,
> with the new interface we get the nanoseconds part effectively in
> a binary fixed-point format with tk->tkr_mono.shift bits to the
> right of the binary point.
>
> With the old interface, the fractional nanoseconds got truncated,
> meaning that the value returned by the VDSO clock_gettime function
> would have about 1ns of jitter in it compared to the value computed
> by the generic timekeeping code in the kernel.
>
> The powerpc VDSO time functions (clock_gettime and gettimeofday)
> already work in units of 2^-32 seconds, or 0.23283 ns, because that
> makes it simple to split the result into seconds and fractional
> seconds, and represent the fractional seconds in either microseconds
> or nanoseconds.  This is good enough accuracy for now, so this patch
> avoids changing how the VDSO works or the interface in the VDSO data
> page.
>
> This patch converts the powerpc update_vsyscall_old to be called
> update_vsyscall and use the new interface.  We convert the fractional
> second to units of 2^-32 seconds without truncating to whole nanoseconds.
> (There is still a conversion to whole nanoseconds for any legacy users
> of the vdso_data/systemcfg stamp_xtime field.)
>
> In addition, this improves the accuracy of the computation of tb_to_xs
> for those systems with high-frequency timebase clocks (>= 268.5 MHz)
> by doing the right shift in two parts, one before the multiplication and
> one after, rather than doing the right shift before the multiplication.
> (We can't do all of the right shift after the multiplication unless we
> use 128-bit arithmetic.)
>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Apologies again for missing this earlier.

So no objections from me. I can't say I really worked the whole thing
out, but you're handling the xtime_nsec field properly and the rest
looks reasonable and is well documented.

So for what its worth:
Acked-by: John Stultz <john.stultz@linaro.org>

Thanks again for making this update!
-john
