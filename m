Return-Path: <peter.ryser@xilinx.com>
Received: from mail36-res-R.bigfish.com (mail-res.bigfish.com [63.161.60.61])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E80E67FEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 00:35:46 +1000 (EST)
Message-ID: <43049C69.1060801@xilinx.com>
Date: Thu, 18 Aug 2005 07:34:17 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
References: <20050817200547.GA21017@siegfried.thelikelysolution.ca>
	<43046011.60504@ru.mvista.com>
In-Reply-To: <43046011.60504@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Fix for TLB errata on early Xilinx Virtex-II Pro silicon
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

None of the ML300 will need this workaround as the core voltage is 
slightly higher than recommended in the data sheet of Virtex-II Pro. An 
increased core voltage is one way to fix the TLB problem in early parts 
but it is not the right way as it can have a negative impact on other 
V2P features.

Since the ML300 configuration is used as the base for other boards the 
patch is still useful. However, all Virtex-II Pro FPGAs that are 
shipping today are based on newer core versions and do not show the TLB 
problem.

- Peter


Andrei Konovalov wrote:

> Grant Likely wrote:
>
>> Early versions of the Xilinx Virtex-II Pro have a TLB errata where
>> only even numbered TLB entries work correctly.  Occurs on chips where
>> PVR == 0x20010820 || 0x20010860
>>
>> See Record #14052, solution #12 in the Xilinx answers database
>> http://www.xilinx.com/xlnx/xil_ans_display.jsp?getPagePath=14052
>>
>> This patch adds a config option to use only even TLB entries on the 
>> V2Pro
>> It also makes a trivial change to the Kconfig so that Xilinx options 
>> depend
>> on VIRTEX_II_PRO instead of XILINX_ML300
>>
>> Signed-off-by: Grant Likely <grant.likely@gdcanada.com>
>> ---
>>
>>  arch/ppc/kernel/head_4xx.S     |   11 +++++++++++
>>  arch/ppc/platforms/4xx/Kconfig |   28 ++++++++++++++++++++++------
>>  2 files changed, 33 insertions(+), 6 deletions(-)
>>
>> 322a82cd190a777e4ebe728cad2a2a3759039260
>> diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
>> --- a/arch/ppc/kernel/head_4xx.S
>> +++ b/arch/ppc/kernel/head_4xx.S
>> @@ -769,7 +769,11 @@ finish_tlb_load:
>>         /* load the next available TLB index.
>>         */
>>         lwz     r9, tlb_4xx_index@l(0)
>> +#if defined(CONFIG_VIRTEX_II_PRO_TLB_FIX)
>> +       addi    r9, r9, 2
>> +#else
>>         addi    r9, r9, 1
>> +#endif
>>         andi.   r9, r9, (PPC4XX_TLB_SIZE-1)
>>         stw     r9, tlb_4xx_index@l(0)
>
>
> I would also fix the comment in this file
> (it has nothing to do with the TLB fix but...):
>
> @@ -915,10 +919,10 @@ initial_mmu:
>     mtspr    SPRN_PID,r0
>     sync
>
> -    /* Configure and load two entries into TLB slots 62 and 63.
> -     * In case we are pinning TLBs, these are reserved in by the
> +    /* Configure and load an entry into TLB slot 63.
> +     * In case we are pinning TLBs, it is reserved in by the
>      * other TLB functions.  If not reserving, then it doesn't
> -     * matter where they are loaded.
> +     * matter where it is loaded.
>      */
>     clrrwi    r4,r4,10        /* Mask off the real page number */
>     ori    r4,r4,(TLB_WR | TLB_EX)    /* Set the write and execute 
> bits */
>
>> @@ -926,7 +930,14 @@ initial_mmu:
>>         clrrwi  r3,r3,10                /* Mask off the effective 
>> page number */        ori     r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))
>>
>> +#if defined(CONFIG_VIRTEX_II_PRO_TLB_FIX)
>> +       /* Odd numbered TLB slots are broken on Xilinx V2Pro processors
>> +        * where PVR = 20010820 | 20010860
>> +        */
>> +        li      r0,62                    /* TLB slot 62 */
>> +#else
>>          li      r0,63                    /* TLB slot 63 */
>> +#endif
>>
>>         tlbwe   r4,r0,TLB_DATA          /* Load the data portion of 
>> the entry */        tlbwe   r3,r0,TLB_TAG           /* Load the tag 
>> portion of the entry */
>> diff --git a/arch/ppc/platforms/4xx/Kconfig 
>> b/arch/ppc/platforms/4xx/Kconfig
>> --- a/arch/ppc/platforms/4xx/Kconfig
>> +++ b/arch/ppc/platforms/4xx/Kconfig
>> @@ -161,11 +161,6 @@ config IBM_OCP
>>         depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || 
>> EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
>>         default y
>>
>> -config XILINX_OCP
>> -       bool
>> -       depends on XILINX_ML300
>> -       default y
>> -
>>  config IBM_EMAC4
>>         bool
>>         depends on 440GX || 440SP
>> @@ -201,6 +196,27 @@ config VIRTEX_II_PRO
>>         depends on XILINX_ML300
>>         default y
>>
>> +config VIRTEX_II_PRO_TLB_FIX
>> +       bool "Virtex-II Pro TLB bugfix"
>> +       depends on VIRTEX_II_PRO
>> +       default n
>> +       help
>> +         Early versions of the Xilinx Virtex-II Pro have a TLB 
>> errata where
>> +         only even numbered TLB entries work correctly.  Say Y here if
>> +         PVR == 0x20010820 || 0x20010860, or if your board crashes 
>> early
>> +         after enabling the MMU
>> +
>> +         See Record #14052, solution #12 in the Xilinx answers database
>> +         
>> http://www.xilinx.com/xlnx/xil_ans_display.jsp?getPagePath=14052
>> +
>> +         It is safe to say Y here, but there is a performance impact.
>> +         Say N if unsure.
>> +
>> +config XILINX_OCP
>> +       bool
>> +       depends on VIRTEX_II_PRO
>> +       default y
>> +
>>  config STB03xxx
>>         bool
>>         depends on REDWOOD_5 || REDWOOD_6
>> @@ -208,7 +224,7 @@ config STB03xxx
>>
>>  config EMBEDDEDBOOT
>>         bool
>> -       depends on EP405 || XILINX_ML300
>> +       depends on EP405 || VIRTEX_II_PRO
>>         default y
>>
>>  config IBM_OPENBIOS
>
>
> I would drop the last chunk.
> I agree that VIRTEX_II_PRO_TLB_FIX and XILINX_OCP should depend on the
> chip (VIRTEX_II_PRO), but using EMBEDDEDBOOT or, say, U-Boot is at least
> board specific. Well, even the same board can use different bootloaders,
> but tying together EMBEDDEDBOOT and VIRTEX_II_PRO is even worse IMO.
>
> Otherwise the patch looks OK.
>
> These changes to head_4xx.S were tested OK on ML300:
> in both cases (odd numbered TLB slots used or not) there were no 
> problems.
> (For some unknown reason my ML300 doesn't need this workaround though
> 'cat /proc/cpuinfo' gets "revision        : 8.32 (pvr 2001 0820)")
>
> Thanks,
> Andrei
>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
