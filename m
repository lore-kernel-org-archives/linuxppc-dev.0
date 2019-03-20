Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5D6C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:11:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E092184D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E092184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PVgF1SybzDqPl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:11:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PVW40YzTzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 00:04:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44PVW364gBz9sPM; Thu, 21 Mar 2019 00:04:31 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44PVW34B1Cz9sPY; Thu, 21 Mar 2019 00:04:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b5b4453e7912f056da1ca7572574cada32ecb60c
X-Patchwork-Hint: ignore
In-Reply-To: <20190313131438.8212-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038
Message-Id: <44PVW34B1Cz9sPY@ozlabs.org>
Date: Thu, 21 Mar 2019 00:04:31 +1100 (AEDT)
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
Cc: arnd@arndb.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
 john.stultz@linaro.org, tglx@linutronix.de, jaydee@email.cz
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-03-13 at 13:14:38 UTC, Michael Ellerman wrote:
> Jakub Drnec reported:
>   Setting the realtime clock can sometimes make the monotonic clock go
>   back by over a hundred years. Decreasing the realtime clock across
>   the y2k38 threshold is one reliable way to reproduce. Allegedly this
>   can also happen just by running ntpd, I have not managed to
>   reproduce that other than booting with rtc at >2038 and then running
>   ntp. When this happens, anything with timers (e.g. openjdk) breaks
>   rather badly.
> 
> And included a test case (slightly edited for brevity):
>   #define _POSIX_C_SOURCE 199309L
>   #include <stdio.h>
>   #include <time.h>
>   #include <stdlib.h>
>   #include <unistd.h>
> 
>   long get_time(void) {
>     struct timespec tp;
>     clock_gettime(CLOCK_MONOTONIC, &tp);
>     return tp.tv_sec + tp.tv_nsec / 1000000000;
>   }
> 
>   int main(void) {
>     long last = get_time();
>     while(1) {
>       long now = get_time();
>       if (now < last) {
>         printf("clock went backwards by %ld seconds!\n", last - now);
>       }
>       last = now;
>       sleep(1);
>     }
>     return 0;
>   }
> 
> Which when run concurrently with:
>  # date -s 2040-1-1
>  # date -s 2037-1-1
> 
> Will detect the clock going backward.
> 
> The root cause is that wtom_clock_sec in struct vdso_data is only a
> 32-bit signed value, even though we set its value to be equal to
> tk->wall_to_monotonic.tv_sec which is 64-bits.
> 
> Because the monotonic clock starts at zero when the system boots the
> wall_to_montonic.tv_sec offset is negative for current and future
> dates. Currently on a freshly booted system the offset will be in the
> vicinity of negative 1.5 billion seconds.
> 
> However if the wall clock is set past the Y2038 boundary, the offset
> from wall to monotonic becomes less than negative 2^31, and no longer
> fits in 32-bits. When that value is assigned to wtom_clock_sec it is
> truncated and becomes positive, causing the VDSO assembly code to
> calculate CLOCK_MONOTONIC incorrectly.
> 
> That causes CLOCK_MONOTONIC to jump ahead by ~4 billion seconds which
> it is not meant to do. Worse, if the time is then set back before the
> Y2038 boundary CLOCK_MONOTONIC will jump backward.
> 
> We can fix it simply by storing the full 64-bit offset in the
> vdso_data, and using that in the VDSO assembly code. We also shuffle
> some of the fields in vdso_data to avoid creating a hole.
> 
> The original commit that added the CLOCK_MONOTONIC support to the VDSO
> did actually use a 64-bit value for wtom_clock_sec, see commit
> a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support to
> 32 bits kernel") (Nov 2005). However just 3 days later it was
> converted to 32-bits in commit 0c37ec2aa88b ("[PATCH] powerpc: vdso
> fixes (take #2)"), and the bug has existed since then AFAICS.
> 
> Fixes: 0c37ec2aa88b ("[PATCH] powerpc: vdso fixes (take #2)")
> Cc: stable@vger.kernel.org # v2.6.15+
> Link: http://lkml.kernel.org/r/HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz
> Reported-by: Jakub Drnec <jaydee@email.cz>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/b5b4453e7912f056da1ca7572574cada

cheers
