Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 69784DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 21:43:25 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1321251uge.0
	for <linuxppc-dev@ozlabs.org>; Thu, 01 May 2008 04:43:23 -0700 (PDT)
Date: Thu, 1 May 2008 15:43:18 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/6] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080501114318.GA10759@zarina>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190017.GA21203@polina.dev.rtsoft.ru>
	<9E78A635-CB7B-4A51-9FD5-2922747D4847@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <9E78A635-CB7B-4A51-9FD5-2922747D4847@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 11:00:42PM -0500, Kumar Gala wrote:
>
> On Apr 29, 2008, at 2:00 PM, Anton Vorontsov wrote:
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
>>
>>
>
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 4e40c12..4070a78 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -538,6 +538,11 @@ config FSL_LBC
>> 	help
>> 	  Freescale Localbus support
>>
>> +config FSL_GTM
>> +	bool
>> +	help
>> +	  Freescale General-purpose Timers support
>> +
>
> what chips actually use this?  just QE or 83xx?

83xx/85xx, QE, CPM2 and CPM1 (no support).
Probably some more old and new chips.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
