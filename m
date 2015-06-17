Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0B971A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 15:43:15 +1000 (AEST)
In-Reply-To: <1433155735-23751-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Cyril Bur <cyrilbur@gmail.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: [v3] powerpc/configs: enable RTC class support
Message-Id: <20150617054315.9BABF140290@ozlabs.org>
Date: Wed, 17 Jun 2015 15:43:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-06 at 10:48:55 UTC, Vaibhav Jain wrote:
> A working rtc kernel driver is needed so that hwclock can synchronize
> system clock to rtc during shutdown/boot. We already have a rtc platform
> driver for power arch located at drivers/rtc/rtc-opal.c However it
> depends on CONFIG_RTC_CLASS which is disabled by default. So this driver
> is not compiled with pseries defconfig as rtc class support is missing
> from the kernel.
> 
> We fix this by enabling rtc class support in pseries defconfig so that
> this driver gets enabled and is compiled into the pseries kernel.

So that seems fair enough.

But, it disables CONFIG_GEN_RTC. Which *I think* means we won't get an RTC
driver at all on pseries machines.

There's some history between those two options but I don't know it off the top
of my head. Ben should know?

cheers
