Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-33.bluehost.com (outbound-mail-33.bluehost.com
	[70.96.188.153]) by ozlabs.org (Postfix) with SMTP id AEDE0681BD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jan 2006 08:13:52 +1100 (EST)
Message-ID: <43D546FD.8010403@secretlab.ca>
Date: Mon, 23 Jan 2006 14:13:33 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH 4/9] Migrate ML300 reference design to the platform bus
References: <20060119081303.GA24908@weasley-twins.secretlab.ca>
	<43D5130E.2020404@ru.mvista.com>
In-Reply-To: <43D5130E.2020404@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrei Konovalov wrote:
> Hi Grant,
> 
> Grant C. Likely wrote:
> 
>> Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>
>>
>> ---
>>
>>  arch/ppc/Kconfig.debug                |    2 -
>>  arch/ppc/platforms/4xx/xilinx_ml300.c |   74 
>> +++++++++++++++++++++++----------
>>  arch/ppc/platforms/4xx/xilinx_ml300.h |    2 -
>>  arch/ppc/syslib/Makefile              |    2 -
>>  4 files changed, 55 insertions(+), 25 deletions(-)
> 
> 
> <snip>
> 
>> +/* Board specifications structures */
>> +struct ppc_sys_spec *cur_ppc_sys_spec;
>> +struct ppc_sys_spec ppc_sys_specs[] = {
>> +    {
>> +        /* Only one entry, always assume the same design */
>> +        .ppc_sys_name    = "Xilinx ML300 Reference Design",
>> +        .mask         = 0x00000000,
>> +        .value         = 0x00000000,
> 
> 
> "Always assume the same design" could be a considerable limitation
> for the Virtex FPGAs.
> 
> <snip>
> 
>> @@ -131,6 +159,8 @@ platform_init(unsigned long r3, unsigned
>>  {
>>      ppc4xx_init(r3, r4, r5, r6, r7);
>>  
>> +    identify_ppc_sys_by_id(mfspr(SPRN_PVR));
> 
> 
> This is OK for the single ppc_sys_specs[] case, but in general
> I am not sure using PVR to identify the system makes much sense
> in case of Virtex FPGAs. IIRC, for the mpc8xxx Freescale SOCs PVR
> gives enough information to determine what on-chip peripherals are
> present (but not how multi-function peripherals like SCC are configured).
> In case of Xilinx the situation is worse: depending on the bitstream
> loaded into the FPGA, the same chip (the same PVR) and the board
> can have several sets of on-chip peripherals which could be completely
> different from each other. And knowing the PVR value alone puts no 
> limitation
> on what peripherals could get into the FPGA (unless e.g. a Virtex-4 
> specific
> hardware block is used by an IP - like in case of TEMAC).
 >
 > What do you think?

In short; I agree 100%.  There are also some other issues with the way I 
set things up.  The only reason I used the ppc_sys functions was because 
the other freescale ports used them.  (It seemed like a good starting 
point).  I now thing platform devices should be registered directly by 
the board setup code (or flattened-device-tree parser); just like your 
code below.

> So far I've used a fairly dumb code like:
> 
>   static int __init xilinx_platform_init(void)
>   {
>   #ifdef XPAR_EMAC_0_BASEADDR
>         memcpy(xemac_0_pdata.mac_addr, __res.bi_enetaddr, 6);
>         platform_device_register(&xilinx_emac_0_device);
>   #endif /* XPAR_EMAC_0_BASEADDR */
> 
>   #ifdef XPAR_TEMAC_0_BASEADDR
>         memcpy(xtemac_0_pdata.mac_addr, __res.bi_enetaddr, 6);
>         platform_device_register(&xilinx_temac_0_device);
>   #endif /* XPAR_TEMAC_0_BASEADDR */
> 
>   #ifdef XPAR_TFT_0_BASEADDR
>         platform_device_register(&xilinx_lcd_0_device);
>   #endif /* XPAR_TFT_0_BASEADDR */
> 
>   #ifdef XPAR_GPIO_0_BASEADDR
>         platform_device_register(&xilinx_gpio_0_device);
>   #endif /* XPAR_GPIO_0_BASEADDR */
>   #ifdef XPAR_GPIO_1_BASEADDR
>         platform_device_register(&xilinx_gpio_1_device);
>   #endif /* XPAR_GPIO_1_BASEADDR */
> 
>   #ifdef XPAR_PS2_0_BASEADDR
>         platform_device_register(&xilinx_ps2_0_device);
>   #endif /* XPAR_PS2_0_BASEADDR */
>   #ifdef XPAR_PS2_1_BASEADDR
>         platform_device_register(&xilinx_ps2_1_device);
>   #endif /* XPAR_PS2_1_BASEADDR */
> 
>     return 0;
>   }
> 
> - to associate the devices to the drivers (the drivers
> call driver_register() from their module_init function).
> This helps me holding all that ugly stuff in one file
> (this single file can be used by multiple boards),
> and should make it easier to switch to something using
> the flattened device tree parsing when the OF DT comes
> into play.

yes; plus the flattened tree parser can allocate platform device 
structures as needed at runtime.

> 
> Probably using ppc_sys infrastructure now has some advantages,
> but they are not evident to me.

No, I don't really think it fits for the Virtex either; I'm just using 
it as a starting point.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
