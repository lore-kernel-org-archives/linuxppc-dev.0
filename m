Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78D79DDFE3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 23:55:24 +1000 (EST)
Message-ID: <4639E9BF.40902@cambridgebroadband.com>
Date: Thu, 03 May 2007 14:55:11 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [U-Boot-Users] Where do you find *.dtb files?
References: <4639B9ED.7030902@cambridgebroadband.com>
	<4639E6A9.2040708@smiths-aerospace.com>
In-Reply-To: <4639E6A9.2040708@smiths-aerospace.com>
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

Jerry Van Baren wrote:
> Alex Zeffertt wrote:
>> Hi all,
>>
>> I'm trying to boot linux-2.6.21-rc5 on my mpc832xemds board which is 
>> running
>> u-boot 1.2.0.
>>
>> According to u-boot I need a device tree blob:
>>
>>     => help bootm
>>     bootm [addr [arg ...]]
>>         - boot application image stored in memory
>>              passing arguments 'arg ...'; when booting a Linux kernel,
>>             'arg' can be the address of an initrd image
>>              When booting a Linux kernel which requires a flat 
>> device-tree
>>              a third argument is required which is the address of the 
>> of the
>>              device-tree blob. To boot that kernel without an initrd 
>> image,
>>              use a '-' for the second argument. If you do not pass a 
>> third
>>              a bd_info struct will be passed instead
>>
>>
>> Can anybody tell me where I can find one for this board?
>>
>> TIA,
>>
>> Alex
> 
> Kernel tree under arch/powerpc/boot/dts?
> <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/powerpc/boot/dts;h=2591d25045401b8beea474a1b4e117527e478521;hb=HEAD> 
> 
> 
> Best regards,
> gvb

Thanks Jerry.  I've found
	
	powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts
	
... but when I try to compile it I get an error:

	$ /opt/freescale/ltib/usr/bin/dtc -I dts -O dtb powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts
	DTC: dts->dtb  on file "powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts"
	syntax error at line 14
	FATAL ERROR: Couldn't read input tree

Perhaps my dtc is out of date - it came with the BSP from freescale which uses
the 2.6.11 kernel.

Do you know where I can find an up to date dtc?  Is there any documentation regarding its use?

Regards,

Alex
