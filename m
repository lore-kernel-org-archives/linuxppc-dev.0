Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id CEEBF67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jan 2005 08:37:48 +1100 (EST)
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Crffq-00013e-00
	for linuxppc-embedded@ozlabs.org; Thu, 20 Jan 2005 18:00:46 +0100
Received: from [217.228.220.126] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1Crffo-0000Lz-00
	for linuxppc-embedded@ozlabs.org; Thu, 20 Jan 2005 18:00:45 +0100
Message-ID: <41EFE450.8020206@anagramm.de>
Date: Thu, 20 Jan 2005 18:03:12 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <41EF94DB.4090604@anagramm.de>
	<611DB920-6AF8-11D9-A0BF-000393DBC2E8@freescale.com>
In-Reply-To: <611DB920-6AF8-11D9-A0BF-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Instruction Cache Parity Error / 2.6.10 on MPC8540
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Kumar!

Thank you again for your help...

The inscription of the CPU says:
PPC8540 PX833LB
2L71V MSIA
QEAD0412
(Yes, there is a heatsink on it ;-)

root@PM854:/cdrom/crux/base$ cat /proc/cpuinfo
processor       : 0
cpu             : e500
revision        : 2.0 (pvr 8020 0020)
bogomips        : 823.29
Vendor          : Freescale Semiconductor
Machine         : mpc8540ads
clock           : 825MHz
PVR             : 0x80200020
SVR             : 0x80300020
PLL setting     : 0x5
Memory          : 256 MB

I hope that this is current...
Where can I find more information about the SVR?
(I had a look to the Errata Sheets... but there is no
overview of the different silicons.)

Up to now, the Panic didn't appear again - I didn't
change anything yet...
I just try to setup a new system (CRUX) on the attached hdd.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

Kumar Gala wrote:
> Clemens,
> 
> I dont think there is really and debug to do with this.  If this is 
> happening consistently it suppose to be an faulty part.  What rev of the 
> silicon do you have (PVR, SVR)?
> 
> - kumar
> 
> On Jan 20, 2005, at 5:24 AM, Clemens Koller wrote:
> 
>> Hello,
>>
>> Well, I made good progress with Kernel 2.6.10 on my target (PM854,
>>  Microsys) which is very similar to the MPC8540_ads configuration.
>>  But now, after working for several minutes, I ran into the following
>>  Oops:
>>
>> -----8<-------------------------------------------------------------
>>  root@PM854:~/openssh-3.9p1$ Machine check in kernel mode.
>>  Caused by (from MCSR=40000000): Instruction Cache Parity Error
>>  Oops: machine check, sig: 7 [#1]
>>  PREEMPT
>>  NIP: C00054F8 LR: C01F8348 SP: C0263E70 REGS: c0232f50 TRAP: 0202    Not
>> tainted
>>  MSR: 00021000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
>>  TASK = c0233720[0] 'swapper' THREAD: c0262000
>>  Last syscall: 120
>>  GPR00: C01F8348 C0263E70 C0233720 C0233720 C054C400 00000000 00000351
>> 00000000
>>  GPR08: 00000000 00000003 C054C400 0000473A 0000AE53 00000000 10000700
>> 007FFF93
>>  GPR16: 00000000 00000001 007FFF00 C02B0000 C02C0000 C0233884 3B9ACA00
>> C02B5C78
>>  GPR24: 000000F4 C02B5C78 C0233720 C054C400 C02AED00 00000000 00000000
>> C0263E90
>>  NIP [c00054f8] __switch_to+0x14/0x9c
>> LR [c01f8348] schedule+0x318/0x704
>> Call trace:
>>    [c01f8348] schedule+0x318/0x704
>>   [c00026c8] resume_kernel+0x38/0x5c
>>   [c00039f8] cpu_idle+0x28/0x40
>>   [c0001afc] rest_init+0x28/0x38
>>   [c0264804] start_kernel+0x16c/0x1a4
>>   [c0000364] skpinv+0x294/0x2d0
>> Kernel panic - not syncing: Attempted to kill the idle task!
>>    <0>Rebooting in 180 seconds..
>>  -----8<-------------------------------------------------------------
>>
>> Does this look familiar to anybody? Any ideas where to start
>>  debugging?
>>
>> Best greets,
>>
>> Clemens Koller
>> _______________________________
>> R&D Imaging Devices
>>  Anagramm GmbH
>>  Rupert-Mayer-Str. 45/1
>>  81379 Muenchen
>>  Germany
>>
>> http://www.anagramm.de
>> Phone: +49-89-741518-50
>>  Fax: +49-89-741518-19
>>  _______________________________________________
>> Linuxppc-embedded mailing list
>>  Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> 
