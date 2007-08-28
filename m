Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 9D7F0DDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 00:12:47 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	C3C851000A06for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 16:12:45 +0200 (CEST)
Message-ID: <46D42D40.9040204@fz-juelich.de>
Date: Tue, 28 Aug 2007 16:12:16 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Re: Newbie and linux on virtex-II ppc
References: <46D2C9A5.9030708@fz-juelich.de>
	<fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
	<46D2CFFB.6050602@fz-juelich.de>
	<fa686aa40708270719s1fd230e9g188948ef02b3eda7@mail.gmail.com>
	<46D41298.7060109@fz-juelich.de>
	<fa686aa40708280606p67fd74p9287d041d955c538@mail.gmail.com>
	<46D4221D.8030500@fz-juelich.de>
	<fa686aa40708280630x67856334qaf2e0dd59ecb95bf@mail.gmail.com>
	<46D4257C.7060208@fz-juelich.de>
	<fa686aa40708280655mf0c08cct43eb9dbd75452690@mail.gmail.com>
In-Reply-To: <fa686aa40708280655mf0c08cct43eb9dbd75452690@mail.gmail.com>
Content-Type: text/plain;
	charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Okay, im really blind i think, so i started again :

- 2.6.22 kernel from kernel.org
- cp /arch/ppc/configs/ml300_defconfig .config
- edit Makefile to use ARCH=ppc and CROSS_COMPILE=powerpc-405-linux-gnu-
- copy xparams
- make menuconfig -> no SYSACE blockdevice :((( *aaaaargh*

i will try the grant kernel now :)

G


Grant Likely wrote:
> On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
>   
>> Grant Likely wrote:
>>     
>>> On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
>>>
>>>       
>>>> Grant Likely wrote:
>>>>
>>>>         
>>>>> You've got 2 choices:
>>>>> 1. use the new sysace driver; it's already in mainline.  The new
>>>>> driver is faster, but it doesn't handle hotswap of the CF card (yet)
>>>>>
>>>>>
>>>>>           
>>>> But where in menuconfig could i find the sysace driver ? i'm blind, i
>>>> think :)
>>>>
>>>>         
>>> Which version of kernel are you using?  The new sysace driver was
>>> merged into 2.6.22
>>>
>>>
>>>       
>> linux-2.6.22.5
>>     
>
> Should be under drivers->block devices then.
>
>   
>>>>> 2. use the EDK driver; easiest way is to use my tree which already hasGrant Likely <grant.likely@secretlab.ca>
>>>>> it merged:  http://git.secretlab.ca
>>>>>
>>>>>
>>>>>
>>>>>           
>>>> i made an EDK update and now i have the linux_2_2 os in the software
>>>> options. the bsp with all drivers is generated.
>>>> and now ?
>>>>  - copy to kernel tree
>>>>  - use the xmake  to build the kernel, or make ?
>>>>
>>>>         
>>> Grant Likely <grant.likely@secretlab.ca>
>>> Don't use EDK to build you're kernel.  It's too fragile and you need
>>> to use the *exact* version of kernel that EDK expects.  You're better
>>> off to manually copy the xparams file from the generated BSP.  (ie.
>>> Don't let EDK know where your real kernel source tree is)
>>>
>>>       
>> wuh ? i dont need all the driver from the generatet bsp files ? what
>> about the gpios and leds  ?
>>     
>
> Most drivers are already in my tree; any that are missing you can copy
> over manually.
>
>   
>> i compile the kernel with a self made cross toolchain, not with the edk.
>> until now i copied the bsp files into the kernel tree (modfied some
>> defines) und compile with "make zImage". But know with the linux_2_6
>> option there is some more stuff in the bsp directory and i don't know
>> what to do with :)
>>
>>     
>>>> and why is there no dokumentation :)
>>>>         
>>> Care to write some?
>>>
>>>       
>> huh, not really :)
>> im just a little newbie
>>     
>
> best way to learn.  :-)
>
> g.
>   



-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Vorstand: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. 
Vorsitzender)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
