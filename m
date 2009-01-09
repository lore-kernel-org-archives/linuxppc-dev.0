Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66668474CA
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 02:40:13 +1100 (EST)
Message-Id: <A231017D-1ECD-4F92-84A4-16BC39E5DC2B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Pieter <phenning@vastech.co.za>
In-Reply-To: <49675205.9010800@vastech.co.za>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Trouble moving custom MPC8548 board to U-boot 1.3
Date: Fri, 9 Jan 2009 09:38:01 -0600
References: <49635C62.5090307@vastech.co.za>
	<1231260769.21398.5.camel@ld0161-tx32>
	<49675205.9010800@vastech.co.za>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2009, at 7:32 AM, Pieter wrote:

> Hi all,
>>> I have spent quite some time trying to move from U-Boot 1.2 to a  
>>> newer
>>> version.. I am stuck at the initialization of the ram. The ram  
>>> checksum
>>> fails and gives me a "total memory of 0". (the board has 512MB and  
>>> work
>>> when booting uboot 1.2)
>>>
>>> can anyone pls. point me in the right direction?
>>>
>>>
>> This is your root cause:  Unable to get the SPD information
>> for the DDR DIMM in slot 0 of controller 0.
>>
>> What part are you using?  Does it support SPD?
>> Is your I2C to it hooked up correctly?
>> Can you dump the SPD information that is read?
>> Does it match the part specs?
>>
>> HTH,
>> jdl
> I have managed to read the SPD data for the dram. I also confirmed  
> that
> the dram control and timing settings correspond to the settings that
> worked in the previous uboot.
> I am now able to run uboot up to the "relocate_code". The new Stack
> pointer is set to 0x0FF8DF58 witch is close enough to what i expected.
> This is however where the board hangs. (The board also hang when  
> running
> the "testram").  I tried reading the data at the new stack pointer but
> get "SAP: read access failed"  i get the same error when trying to  
> read
> any address within the RAM or any address of other devices.  This  
> leads
> me to think that my LAW or TLB setup is incorrect.
>
> Looking at LAW setup: (based on board sbc8548)
>
>    /* LAW(Local Access Window) configuration:
>     * 0x0000_0000     0x1fff_ffff     DDR             512M/Auto
>     * 0x8000_0000     0xbfff_ffff     PCI1 MEM        1G
>     * 0xc000_0000     0xcfff_ffff     PCI1 IO         16M
>     * 0xe000_0000     0xffff_ffff      LBC                        
> 512M */
>
>    struct law_entry law_table[] = {
>    #ifndef CONFIG_SPD_EEPROM
>            SET_LAW(CONFIG_SYS_DDR_SDRAM_BASE, LAWAR_SIZE_512M,
>    LAWAR_TRGT_IF_DDR),
>    #endif
>            SET_LAW(CONFIG_SYS_PCI1_MEM_PHYS, LAWAR_SIZE_1G,
>    LAWAR_TRGT_IF_PCI1 ),
>            SET_LAW(CONFIG_SYS_PCI1_IO_PHYS, LAWAR_SIZE_16M,
>    LAWAR_TRGT_IF_PCI1),
>            SET_LAW(CONFIG_SYS_LBC_BASE, LAWAR_SIZE_512M,  
> LAWAR_TRGT_IF_LBC)
>    };
>
> Since my board uses SPD_EEPROM, where does the LAW entry for DDR get
> initilized or should the #ifndef statement be removed?
>
>
>
> Am I on the  right track to solving my problem?
>

This should be discussed on the u-boot list not the linuxppc-dev list

- k
