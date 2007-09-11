Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75D09DDEFC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:57:57 +1000 (EST)
In-Reply-To: <20070911172000.GC10743@lixom.net>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<20070911172000.GC10743@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9C9F1918-1B55-4426-8138-842B9AAA5BD5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
Date: Tue, 11 Sep 2007 13:00:47 -0500
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 11, 2007, at 12:20 PM, Olof Johansson wrote:

> On Fri, Aug 17, 2007 at 12:03:48AM -0500, Kumar Gala wrote:
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>  arch/powerpc/boot/dts/mpc8544ds.dts        |   88 ++++------
>>  arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  114 +++----------
>>  arch/powerpc/platforms/85xx/Kconfig        |    1 +
>>  arch/powerpc/platforms/85xx/mpc8544_ds.c   |  214 + 
>> +----------------------
>>  arch/powerpc/platforms/86xx/Kconfig        |    1 +
>>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  224 + 
>> +-----------------------
>>  arch/powerpc/platforms/Kconfig             |    8 +
>>  arch/powerpc/platforms/Makefile            |    3 +
>>  arch/powerpc/platforms/fsl_uli1575.c       |  255 ++++++++++++++++ 
>> ++++++++++++
>>  9 files changed, 363 insertions(+), 545 deletions(-)
>>  create mode 100644 arch/powerpc/platforms/fsl_uli1575.c
>>
>
> Since when do we add code directly under powerpc/platforms? Isn't that
> what we have sysdev for?
>
> I know this is already picked up, but I just noticed it when  
> looking at
> Kumar's 8572 patch. :-(

I put it in platforms since it was related to the boards not the  
chips.  We can go around about what sysdev actual means, but I'm  
using the assumption that its for processor & bridges (for discrete  
processors 10x, mv640x0, etc).  Things that are board specific like  
the ULI I'm putting under platforms/

- k
