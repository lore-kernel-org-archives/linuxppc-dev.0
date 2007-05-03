Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id AB637DDFCB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 May 2007 00:35:40 +1000 (EST)
Message-ID: <4639EC2A.8080502@smiths-aerospace.com>
Date: Thu, 03 May 2007 10:05:30 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: [U-Boot-Users] Where do you find *.dtb files?
References: <4639B9ED.7030902@cambridgebroadband.com>
	<4639E6A9.2040708@smiths-aerospace.com>
	<4639E9BF.40902@cambridgebroadband.com>
In-Reply-To: <4639E9BF.40902@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Alex Zeffertt wrote:
> Jerry Van Baren wrote:
>> Alex Zeffertt wrote:
>>> Hi all,
>>>
>>> I'm trying to boot linux-2.6.21-rc5 on my mpc832xemds board which is 
>>> running
>>> u-boot 1.2.0.
>>>
>>> According to u-boot I need a device tree blob:
>>>
>>>     => help bootm
>>>     bootm [addr [arg ...]]
>>>         - boot application image stored in memory
>>>              passing arguments 'arg ...'; when booting a Linux kernel,
>>>             'arg' can be the address of an initrd image
>>>              When booting a Linux kernel which requires a flat 
>>> device-tree
>>>              a third argument is required which is the address of the 
>>> of the
>>>              device-tree blob. To boot that kernel without an initrd 
>>> image,
>>>              use a '-' for the second argument. If you do not pass a 
>>> third
>>>              a bd_info struct will be passed instead
>>>
>>>
>>> Can anybody tell me where I can find one for this board?
>>>
>>> TIA,
>>>
>>> Alex
>>
>> Kernel tree under arch/powerpc/boot/dts?
>> <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/powerpc/boot/dts;h=2591d25045401b8beea474a1b4e117527e478521;hb=HEAD> 
>>
>>
>> Best regards,
>> gvb
> 
> Thanks Jerry.  I've found
>     
>     powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts
>     
> ... but when I try to compile it I get an error:
> 
>     $ /opt/freescale/ltib/usr/bin/dtc -I dts -O dtb 
> powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts
>     DTC: dts->dtb  on file "powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts"
>     syntax error at line 14
>     FATAL ERROR: Couldn't read input tree
> 
> Perhaps my dtc is out of date - it came with the BSP from freescale 
> which uses
> the 2.6.11 kernel.
> 
> Do you know where I can find an up to date dtc?  Is there any 
> documentation regarding its use?
> 
> Regards,
> Alex

Hi Alex,

Yes, you need to update your dtc.  The latest dtc can be gotten from:
   http://jdl.com/git_repos/

My makefile looks like this (WARNING: it is whitespace damaged, you must 
replace the eight spaces in the rules with tabs):
8<--------------------------------------------------------------------
#
# Make device tree blobs
#

src = $(wildcard *.dts)
out = $(src:.dts=.dtb)
asm = $(src:.dts=.dtb)

QUIET   = #-q
RESERVE = -R 4
SIZE    = -S 0x3000

all: $(out)

%.dtb : %.dts
         dtc $(QUIET) $(RESERVE) $(SIZE) -b 0 -O dtb -f -o $@ $^

%.asm : %.dts
         dtc $(QUIET) $(RESERVE) $(SIZE) -b 0 -O asm -f -o $@ $^
8<--------------------------------------------------------------------

Best regards,
gvb
