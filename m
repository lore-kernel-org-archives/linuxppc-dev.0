Date: Fri, 27 Aug 2004 19:00:21 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Reply-To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <1441098375.20040827190021@varma-el.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: [RFC] Remove G2_LE core decl from CLASSIC_PPC part of arch/ppc/kernel/cputable.c
In-Reply-To: <87957638-F833-11D8-994C-000393DBC2E8@freescale.com>
References: <927068331.20040827153454@varma-el.com>
 <87957638-F833-11D8-994C-000393DBC2E8@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Kumar,

Friday, August 27, 2004, 6:15:20 PM, you wrote:

> What purpose does this change really serve.  Linux does not use the
> true little-endian feature of the G2_LE core, beyond that it is very
> much in the class of classic ppc.
> Is the memory savings really that much?

sizeof(*cpu_table) ~ 1300 bytes
+ code in cpu_setup_6xx.S ~ 1000 bytes
+ more simple to filter out some features in Kconfig (ex. SMP,
ALTIVEC...)

And optionally (?):
+ LE (if it will be needed sometime for somebody)
+ "An additional input interrupt signal, core_cint,
   implements a critical interrupt function."

>>
>> Since G2_LE is NOT a "classic" core ( in particular - true
>> little-endian),
>> may be now is time to remove it from CLASSIC_PPC part of
>> arch/ppc/kernel/cputable.c, and move it to itself part.
>> I bear in mind next:
>>
>> from arch/ppc/kernel/cputable.c:
>>
>> #if CLASSIC_PPC
>> .....
>>     {   /* All G2_LE (603e core, plus some) have the same pvr */
>>         0x7fff0000, 0x00820000, "G2_LE",
>>         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
>>         CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
>>         COMMON_PPC,
>>         32, 32,
>>         __setup_cpu_603
>>     },
>> ....
>> #endif /* CLASSIC_PPC */
>>
>> May be better like this:
>>
>> #if CONFIG_G2_LE
>>     {   /* All G2_LE (603e core, plus some) have the same pvr */
>>         0x7fff0000, 0x00820000, "G2_LE",
>>         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
>>         CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
>>         COMMON_PPC,
>>         32, 32,
>>         __setup_cpu_603
>>     },
>> #endif
>>
>> With that move we'll conserve some memory of kernel,
>> but need some explanations which PPCs based on
>> it, for modify Kconfig ( I know MPC52xx and MPC82xx based on it).

--
Best regards,
 Andrey Volkov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
