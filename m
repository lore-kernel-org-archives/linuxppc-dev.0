Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQky3XBQzDqsr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:18 +1000 (AEST)
In-Reply-To: <1456806396-27432-1-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: selftests/powerpc: PMU libs: use signed long to read
 perf_event_paranoid
Message-Id: <3rkQky2FdXz9sf9@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-03 at 04:26:36 UTC, Cyril Bur wrote:
> Excerpt from man 2 perf_event_open:
> 
> /proc/sys/kernel/perf_event_paranoid
>   The perf_event_paranoid file can be set to restrict access to the
>   performance counters.
>     2 allow only user-space measurements.
>     1 allow both kernel and user measurements (default).
>     0 allow access to CPU-specific data but not raw tracepoint samples.
>    -1 no restrictions.
> 
> require_paranoia_below() should return 0 if perf_event_paranoid is below a
> specified level, the value from perf_event_paranoid is read into an
> unsigned long so the incorrect value is returned when perf_event_paranoid
> is set to -1.
> 
> Without this patch applied there is the same number of selftests/powerpc
> which skip when /proc/sys/kernel/perf_event_paranoid is set to 1 or -1 but
> no skips when set to zero.
> With this patch applied there no skipped selftests/powerpc test when
> /proc/sys/kernel/perf_event_paranoid is set to 0 or -1.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d4ecdff2ecdb5c01c46f2a6b1b

cheers
