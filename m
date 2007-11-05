Return-Path: <stuart@quadrics.com>
Received: from quadbrsmgw.quadrics.com (quadmail.quadrics.com
	[194.202.174.130]) by ozlabs.org (Postfix) with ESMTP id 6C116DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Nov 2007 19:38:53 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by quadbrsmgw.quadrics.com (Postfix) with ESMTP id 06964356723
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Nov 2007 08:38:52 +0000 (GMT)
Received: from quadbrsmgw.quadrics.com ([127.0.0.1])
	by localhost (quadbrsmgw.quadrics.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id QD7mc7-tH2s2 for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Nov 2007 08:38:39 +0000 (GMT)
Received: from exch01.quadrics.com (owa.quadrics.com [194.202.174.9])
	by quadbrsmgw.quadrics.com (Postfix) with ESMTP id 58AB7356A04
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Nov 2007 08:38:39 +0000 (GMT)
Message-ID: <472ED67B.2080205@quadrics.com>
Date: Mon, 05 Nov 2007 08:38:19 +0000
From: Stuart Hodgson <stuart@quadrics.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: GDB bdi2000 and mpc85xx
References: <394028554.26200@lzu.edu.cn> <394123578.13658@eyou.net>
In-Reply-To: <394123578.13658@eyou.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wang,

I had a closer look at all the configuration file options to see what we 
had set up. We were missing

REGLIST E500

in the [TARGET] Section.

Thanks again

Stuart

Adding this solved the translation problem

Wang, Baojun wrote:
> On Saturday 03 November 2007 01:17:48, Stuart Hodgson wrote:
>   
>> Hi,
>>
>> I am attempting to get Kernel debugging working on our mpc8541 based
>> board via a BDI2000. The various components in use are
>>
>> kernel - 2.6.19.2
>> BDI firmware - 1.08
>> U-Boot - 1.2.0
>> ppc_85xx-gdb - from eldk4.1 (6.3.0.0-1.21_3rh)
>>
>>
>> Kernel is configured with `-g` in CFLAGS and not with CONFIG_BDI_SWITCH,
>> from the information I have read around the subject this seem to be
>> correct. I also have `MMU  XLAT`, and `PTBASE 0xF0` set in by BDI
>> configuration file. The default value for XLAT of `0xc0000000` matches
>> the kernel our kernel config.
>>
>> Steps that I done so far
>>
>> 1. Power on BDI
>> 2. Power on the board
>> 3. BDI> reset run
>> 4. Enter u-boot environment to stop linux booting immediately.
>> 5. BDI> HALT
>> 6. BDI> BREAK HARD
>> 7. BDI> BI 0xc025a51c   (this is the address of start_kernel for my build)
>> 8. BDI> GO
>> 9. From U-boot prompt `bootm`, kernel is copied from flash and loading
>> begins
>> 10. Kernel does not halt at start_kernel and continues to the login
>>
>> If I attempt to break at an address later in the boot sequence, such as
>> qmx19_ata_input_data (this is the area that I am trying to investigate)
>> I get
>>
>> - TARGET: core #0 has entered debug mode
>>
>> So from here I attempt to connect to the BDI from gdb
>>
>> linux> cd ~/linux-2.6.19.2
>> linux> ppc_85xx-gdb vmlimux
>>     
> Most of the operation could be done within gdb
>
> BDI> reset
>
> powerpc-unknown-linux-gnu-gdb vmlinux
> (gdb) target remote bdi:2001
> (gdb) ^C
> (gdb) b *0x12345678
> (gdb) c
> ...
>   
>> "
>> GNU gdb Red Hat Linux (6.3.0.0-1.21_3rh)
>> Copyright 2004 Free Software Foundation, Inc.
>> GDB is free software, covered by the GNU General Public License, and you
>> are welcome to change it and/or distribute copies of it under certain
>> conditions.
>> Type "show copying" to see the conditions.
>> There is absolutely no warranty for GDB.  Type "show warranty" for details.
>> This GDB was configured as "--host=i386-redhat-linux --target=ppc-linux".
>> The target architecture is set automatically (currently powerpc:603)
>> "
>>
>> I noticed here that the last line does not match the e500 core I am
>> using, but there does not seem to a change if I change this using `set
>> architecture powerpc:e500`
>>
>>
>> (gdb) tar rem <bdi_ip>:2001
>> Remote debugging using <bdi_ip>:2001
>> 0x00000000 in ?? ()
>>     
>
> Which configuration file do you use for mpc85xx? probably is the config file 
> problem?
>
>   
>> What I don't understand here is why 0x00000000 is shown as the address,
>> further on the BDI the following error is shown then the connection is made
>>
>> "
>> *** MMU: address translation for 0x00000000 failed
>>     
>
>   
>> Stuart Hodgson
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>     
>
> Wang
>
>   
