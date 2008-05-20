Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 07671DE335
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 22:41:40 +1000 (EST)
Date: Tue, 20 May 2008 16:41:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080520124138.GA20813@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
	<AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 01:04:55AM -0500, Kumar Gala wrote:
>
> On May 19, 2008, at 12:46 PM, Anton Vorontsov wrote:
>
>> GTM stands for General-purpose Timers Module and able to generate
>> timer{1,2,3,4} interrupts. These timers are used by the drivers that
>> need time precise interrupts (like for USB transactions scheduling for
>> the Freescale USB Host controller as found in some QE and CPM chips),
>> or these timers could be used as wakeup events from the CPU deep-sleep
>> mode.
>>
>> Things unimplemented:
>> 1. Cascaded (32 bit) timers (1-2, 3-4).
>>   This is straightforward to implement when needed, two timers should
>>   be marked as "requested" and configured as appropriate.
>> 2. Super-cascaded (64 bit) timers (1-2-3-4).
>>   This is also straightforward to implement when needed, all timers
>>   should be marked as "requested" and configured as appropriate.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>> Documentation/powerpc/booting-without-of.txt |   37 +++-
>> arch/powerpc/Kconfig                         |    5 +
>> arch/powerpc/sysdev/Makefile                 |    1 +
>> arch/powerpc/sysdev/fsl_gtm.c                |  424 +++++++++++++++++ 
>> +++++++++
>> include/asm-powerpc/fsl_gtm.h                |   47 +++
>> 5 files changed, 513 insertions(+), 1 deletions(-)
>> create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
>> create mode 100644 include/asm-powerpc/fsl_gtm.h
>
>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 3934e26..e5d3366 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -538,6 +538,11 @@ config FSL_LBC
>> 	help
>> 	  Freescale Localbus support
>>
>> +config FSL_GTM
>> +	bool
>
> I'd prefer something like:
>
> depends on PPC_83xx || QUICC_ENGINE || CPM2

Btw, this is silent config, selected by the board's Kconfig
(same as QE block, for example). So "depends on" here is just
no-op, since select disregards dependencies. Still want this?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
