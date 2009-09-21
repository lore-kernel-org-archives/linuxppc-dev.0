Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D3A7B7B7D
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 18:04:52 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1Mpd3p-0005XO-92
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 09:11:45 +0200
Date: Mon, 21 Sep 2009 09:11:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] perf_counter/powerpc: Fix compilation after
	perf_counter_overflow change
Message-ID: <20090921071127.GA24467@elte.hu>
References: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Markus Metzger <markus.t.metzger@intel.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> Commit 5622f295 ("x86, perf_counter, bts: Optimize BTS overflow
> handling") removed the regs field from struct perf_sample_data and
> added a regs parameter to perf_counter_overflow().  This breaks the
> build on powerpc as reported by Sachin Sant:
> 
> arch/powerpc/kernel/perf_counter.c: In function 'record_and_restart':
> arch/powerpc/kernel/perf_counter.c:1165: error: unknown field 'regs' specified in initializer
> cc1: warnings being treated as errors
> arch/powerpc/kernel/perf_counter.c:1165: error: initialization makes integer from pointer without a cast
> arch/powerpc/kernel/perf_counter.c:1173: error: too few arguments to function 'perf_counter_overflow'
> make[1]: *** [arch/powerpc/kernel/perf_counter.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
> 
> This adjusts arch/powerpc/kernel/perf_counter.c to correspond with the
> new struct perf_sample_data and perf_counter_overflow().
> 
> Reported-by: Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Applied, thanks Paul.

> ---
>
> I missed this problem when the "x86, perf_counter, bts: Optimize BTS 
> overflow handling" patch was posted because the headline made it seem 
> entirely x86-specific, and the changes to struct perf_sample_data and 
> perf_counter_overflow() were not mentioned in the changelog.
> 
> Markus, please take care in future to mention it in the changelog if 
> your patches touch definitions used by other architectures.  If you 
> could go so far as to use grep a bit more and fix up other 
> architectures' callsites for the things you're changing, that would be 
> very much appreciated.  Thanks.

Yes, that should be done in general - still, nothing beats actual 
testing.

Paul, you might also want to test the perfcounter bits of -tip on 
PowerPC a bit more frequently - this patch was there for 5 days before i 
sent it to Linus.

Cross-builds didnt catch it as perfcounters isnt enabled by default in 
any of the powerpc defconfigs:

phoenix:~/linux/linux> grep -w CONFIG_PERF_COUNTERS arch/powerpc/configs/*
arch/powerpc/configs/adder875_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/c2k_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/ep8248e_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/ep88xc_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/linkstation_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mgcoge_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mgsuvd_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc7448_hpc2_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc8272_ads_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc83xx_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc85xx_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc85xx_smp_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc866_ads_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc86xx_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/mpc885_ads_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/pq2fads_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/prpmc2800_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/ps3_defconfig:# CONFIG_PERF_COUNTERS is not set
arch/powerpc/configs/storcenter_defconfig:# CONFIG_PERF_COUNTERS is not set

There's not that many PowerPC users so all extra testing help would be 
much welcome. Also, enabling them in the powerpc defconfigs would be 
helpful as well.

Thanks,

	Ingo
