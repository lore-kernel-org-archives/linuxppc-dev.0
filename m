Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvCTK152czDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 19:15:01 +1000 (AEST)
In-Reply-To: <20170527080452.GA14021@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: powerpc: Convert VDSO update function to use new update_vsyscall
 interface
Message-Id: <3wvCTJ6Yvmz9s8P@ozlabs.org>
Date: Fri, 23 Jun 2017 19:15:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-05-27 at 08:04:52 UTC, Paul Mackerras wrote:
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
> Acked-by: John Stultz <john.stultz@linaro.org>

Applied to powerpc next-test, thanks.

https://git.kernel.org/powerpc/c/d4cfb11387ee29ba4626546c676fd2

cheers
