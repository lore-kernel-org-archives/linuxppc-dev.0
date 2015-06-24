Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 978551A0034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 17:46:37 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 24 Jun 2015 13:16:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 479D3E005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 13:19:38 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5O7jwkW2883954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 13:15:58 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5O7jvSZ025591
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 13:15:58 +0530
Message-ID: <1435131944.3310.25.camel@localhost.localdomain>
Subject: Re: [v3] powerpc/configs: enable RTC class support
From: Vaibhav <vaibhav@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Date: Wed, 24 Jun 2015 13:15:44 +0530
In-Reply-To: <20150617054315.9BABF140290@ozlabs.org>
References: <20150617054315.9BABF140290@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Behn,

Need your help in understanding the historical context for having two
rtc interfaces in the kernel (CONFIG_GEN_RTC & CONFIG_RTC_CLASS) and
which one should be enabled for pseries_defconfig. I have posted a patch
(http://patchwork.ozlabs.org/patch/478899/) to enable CONFIG_RTC_CLASS
in the defconfig so that opal rtc driver (/drivers/rtc/opal-rtc.c) is
enabled.

Afaik CONFIG_RTC_CLASS is more generic and can emulate the older
interface provided by gen_rtc. So imho it would make sense to enable
rtc-class with pseries_defconfig as we already have an opal-rtc-driver.

My limited testing with gen_rtc on a tulleta reveals issues with hwclock
as it reports invalid rtc-time error which I suspect is due to a genrtc
driver trying to read date time values from an rtc port that is not
available on the tulleta.

With RTC_CLASS enabled however hwclock seems to work fine.

Requesting your inputs,

Thanks,
~Vaibhav

On Wed, 2015-06-17 at 15:43 +1000, Michael Ellerman wrote:
> On Mon, 2015-01-06 at 10:48:55 UTC, Vaibhav Jain wrote:
> > A working rtc kernel driver is needed so that hwclock can synchronize
> > system clock to rtc during shutdown/boot. We already have a rtc platform
> > driver for power arch located at drivers/rtc/rtc-opal.c However it
> > depends on CONFIG_RTC_CLASS which is disabled by default. So this driver
> > is not compiled with pseries defconfig as rtc class support is missing
> > from the kernel.
> > 
> > We fix this by enabling rtc class support in pseries defconfig so that
> > this driver gets enabled and is compiled into the pseries kernel.
> 
> So that seems fair enough.
> 
> But, it disables CONFIG_GEN_RTC. Which *I think* means we won't get an RTC
> driver at all on pseries machines.

> There's some history between those two options but I don't know it off the top
> of my head. Ben should know?
> 
> cheers
> 
