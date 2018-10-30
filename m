Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21064C6786F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:52:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A6020664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A6020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kwvX3cm7zF35T
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:52:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42krZK0gxQzDrhk;
 Tue, 30 Oct 2018 23:36:51 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2018 05:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; d="scan'208";a="92375856"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2018 05:36:31 -0700
Received: from andy by smile with local (Exim 4.91)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1gHTFz-00049a-Ck; Tue, 30 Oct 2018 14:36:27 +0200
Date: Tue, 30 Oct 2018 14:36:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
Message-ID: <20181030123627.GS10650@smile.fi.intel.com>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Wed, 31 Oct 2018 02:47:32 +1100
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
Cc: nm@ti.com, linux-mips@linux-mips.org, dalias@libc.org, vigneshr@ti.com,
 linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, mhocko@suse.com,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, jslaby@suse.com,
 mingo@kernel.org, marex@denx.de, sfr@canb.auug.org.au,
 Daniel Thompson <daniel.thompson@linaro.org>, ysato@users.sourceforge.jp,
 linux-hexagon@vger.kernel.org, x86@kernel.org, linux@armlinux.org.uk,
 tony@atomide.com, mingo@redhat.com, joel@jms.id.au,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 jhogan@kernel.org, rolf.evers.fischer@aptiv.com, asierra@xes-inc.com,
 linux-snps-arc@lists.infradead.org, dan.carpenter@oracle.com,
 ying.huang@intel.com, Jisheng.Zhang@synaptics.com, riel@surriel.com,
 linux-arm-msm@vger.kernel.org, frederic@kernel.org, pombredanne@nexb.com,
 rppt@linux.vnet.ibm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, andrew@aj.id.au,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
 rkuo@codeaurora.org, paul.burton@mips.com, vgupta@synopsys.com, jk@ozlabs.org,
 Jason Wessel <jason.wessel@windriver.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 kstewart@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> I started out this series trying to make sysrq work over the serial
> console on qcom_geni_serial, then fell into a rat's nest.
> 
> To solve the deadlock I faced when enabling sysrq I tried to borrow
> code from '8250_port.c' which avoided grabbing the port lock in
> console_write().  ...but since these days I try to run with lockdep on
> all the time, I found it caused an annoying lockdep splat (which I
> also reproduced on my rk3399 board).  ...so I instead changed my
> qcom_geni_serial solution to borrow code from 'msm_serial.c'
> 
> I wasn't super happy with the solution in 'msm_serial.c' though.  I
> don't like releasing the spinlock there.  Not only is it ugly but it
> means we are unlocking / re-locking _all the time_ even though sysrq
> characters are rare.  ...so I came up with what I think is a better
> solution and then implemented it for qcom_geni_serial.
> 
> Since I had a good way to test 8250-based UARTs, I also fixed that
> driver to use my new method.  When doing so, I ran into a missing
> msm_serial.c at all, so I didn't switch that (or all other serial
> drivers for that matter) to the new method.
> 
> After fixing all the above issues, I found the next lockdep splat in
> kgdb and I think I've worked around it in a good-enough way, but I'm
> much less confident about this.  Hopefully folks can take a look at
> it.
> 
> In general, patches earlier in this series should be "less
> controversial" and hopefully can land even if people don't like
> patches later in the series.  ;-)
> 
> Looking back, this is pretty much two series squashed that could be
> treated indepdently.  The first is a serial series and the second is a
> kgdb series.
> 
> For all serial patches I'd expect them to go through the tty tree once
> they've been reviewed.
> 
> If folks are OK w/ the 'smp' patch it probably should go in some core
> kernel tree.  The kgdb patch won't work without it, though, so to land
> that we'd need coordination between the folks landing that and the
> folks landing the 'smp' patch.

I have got only 0/7 and 5/7, everything okay with your mail client and other tools?

> 
> 
> Douglas Anderson (7):
>   serial: qcom_geni_serial: Finish supporting sysrq
>   serial: core: Allow processing sysrq at port unlock time
>   serial: qcom_geni_serial: Process sysrq at port unlock time
>   serial: core: Include console.h from serial_core.h
>   serial: 8250: Process sysrq at port unlock time
>   smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
>   kgdb: Remove irq flags and local_irq_enable/disable from roundup
> 
>  arch/arc/kernel/kgdb.c                      |  4 +--
>  arch/arm/kernel/kgdb.c                      |  4 +--
>  arch/arm64/kernel/kgdb.c                    |  4 +--
>  arch/hexagon/kernel/kgdb.c                  | 11 ++----
>  arch/mips/kernel/kgdb.c                     |  4 +--
>  arch/powerpc/kernel/kgdb.c                  |  2 +-
>  arch/sh/kernel/kgdb.c                       |  4 +--
>  arch/sparc/kernel/smp_64.c                  |  2 +-
>  arch/x86/kernel/kgdb.c                      |  9 ++---
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 +++-
>  drivers/tty/serial/8250/8250_fsl.c          |  6 +++-
>  drivers/tty/serial/8250/8250_omap.c         |  6 +++-
>  drivers/tty/serial/8250/8250_port.c         |  8 ++---
>  drivers/tty/serial/qcom_geni_serial.c       | 10 ++++--
>  include/linux/kgdb.h                        |  9 ++---
>  include/linux/serial_core.h                 | 38 ++++++++++++++++++++-
>  kernel/debug/debug_core.c                   |  2 +-
>  kernel/smp.c                                |  4 ++-
>  18 files changed, 80 insertions(+), 53 deletions(-)
> 
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
With Best Regards,
Andy Shevchenko


