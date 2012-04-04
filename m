Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 048A0B7016
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2012 01:00:36 +1000 (EST)
Subject: Re: [PATCH] powerpc: select PPC_CLOCK unconditionally for FSL_SOC
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120404133246.GA25168@S2101-09.ap.freescale.net>
Date: Wed, 4 Apr 2012 10:00:18 -0500
Message-Id: <9F34EEF5-830B-4115-8BB0-DE9FF794BDB9@kernel.crashing.org>
References: <1333085936-8977-1-git-send-email-shawn.guo@linaro.org>
 <20120404133246.GA25168@S2101-09.ap.freescale.net>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 4, 2012, at 8:32 AM, Shawn Guo wrote:

> Kumar,
> 
> Gentle ping ...
> 
> Regards,
> Shawn

Was on a bit of travel to nowhere, but that's a different story.

What timeframe are you looking for this to go in? 3.4 or 3.5?

- k

> 
> On Fri, Mar 30, 2012 at 01:38:56PM +0800, Shawn Guo wrote:
>> Freescale PowerPC SoCs share a number of IP blocks with Freescale
>> ARM/IMX SoCs, FlexCAN, SSI, FEC, eSDHC, USB, etc.  There are some
>> effort consolidating those drivers to make them work for both
>> architectures.
>> 
>> One outstanding difference between two architectures is ARM/IMX will
>> turn off module clocks during platform initialization for power saving
>> and expects drivers manage clocks using clk API, while PowerPC
>> mostly does not do that, and thus does not always build in clk API.
>> 
>> Listing all those driver Kconfig options in "select PPC_CLOCK if" seems
>> not scalable for long term maintenance, and could easily introduce
>> Kconfig recursive dependency.  This patch chooses to select PPC_CLOCK
>> unconditionally for FSL_SOC to always build clk API for PowerPC in.
>> 
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> ---
>> arch/powerpc/Kconfig |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index feab3ba..63fa7fb 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -661,7 +661,7 @@ config SBUS
>> config FSL_SOC
>> 	bool
>> 	select HAVE_CAN_FLEXCAN if NET && CAN
>> -	select PPC_CLOCK if CAN_FLEXCAN
>> +	select PPC_CLOCK
>> 
>> config FSL_PCI
>>  	bool
>> -- 
>> 1.7.5.4
>> 
