Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62B7ADE35C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 23:16:49 +1000 (EST)
Message-Id: <6907979B-054E-4133-8230-B47B7901F2A8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080520124138.GA20813@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
Date: Tue, 20 May 2008 08:16:39 -0500
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
	<AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
	<20080520124138.GA20813@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 7:41 AM, Anton Vorontsov wrote:

> On Tue, May 20, 2008 at 01:04:55AM -0500, Kumar Gala wrote:
>>
>> On May 19, 2008, at 12:46 PM, Anton Vorontsov wrote:
>>
>>> GTM stands for General-purpose Timers Module and able to generate
>>> timer{1,2,3,4} interrupts. These timers are used by the drivers that
>>> need time precise interrupts (like for USB transactions scheduling  
>>> for
>>> the Freescale USB Host controller as found in some QE and CPM  
>>> chips),
>>> or these timers could be used as wakeup events from the CPU deep- 
>>> sleep
>>> mode.
>>>
>>> Things unimplemented:
>>> 1. Cascaded (32 bit) timers (1-2, 3-4).
>>>  This is straightforward to implement when needed, two timers should
>>>  be marked as "requested" and configured as appropriate.
>>> 2. Super-cascaded (64 bit) timers (1-2-3-4).
>>>  This is also straightforward to implement when needed, all timers
>>>  should be marked as "requested" and configured as appropriate.
>>>
>>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>> ---
>>> Documentation/powerpc/booting-without-of.txt |   37 +++-
>>> arch/powerpc/Kconfig                         |    5 +
>>> arch/powerpc/sysdev/Makefile                 |    1 +
>>> arch/powerpc/sysdev/fsl_gtm.c                |  424 +++++++++++++++ 
>>> ++
>>> +++++++++
>>> include/asm-powerpc/fsl_gtm.h                |   47 +++
>>> 5 files changed, 513 insertions(+), 1 deletions(-)
>>> create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
>>> create mode 100644 include/asm-powerpc/fsl_gtm.h
>>
>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 3934e26..e5d3366 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -538,6 +538,11 @@ config FSL_LBC
>>> 	help
>>> 	  Freescale Localbus support
>>>
>>> +config FSL_GTM
>>> +	bool
>>
>> I'd prefer something like:
>>
>> depends on PPC_83xx || QUICC_ENGINE || CPM2
>
> Btw, this is silent config, selected by the board's Kconfig
> (same as QE block, for example). So "depends on" here is just
> no-op, since select disregards dependencies. Still want this?

I do, its at least documentation if its not used.

- k
