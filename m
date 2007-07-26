Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id 2C749DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 22:22:39 +1000 (EST)
Date: Thu, 26 Jul 2007 15:22:24 +0300
To: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>,
	"Scott Wood" <scottwood@freescale.com>
Subject: Re: About mdio_bus for 82xx based board
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
References: <op.tv0x7yvmnhx3hy@phoenix>
	<20070725162305.GA26276@ld0162-tx32.am.freescale.net>
	<op.tv2in7f5nhx3hy@phoenix> <op.tv2kmbgqnhx3hy@phoenix>
Message-ID: <op.tv2nbmkonhx3hy@phoenix>
In-Reply-To: <op.tv2kmbgqnhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Well, I've downloaded the latest git from Paul's tree, and some patches  
still fail (and the mpc8272_ads config doesn't compile). Must I get some  
other revision of the tree (if yes, how's that done in git - my first time  
with it )

thanks

alex


On Thu, 26 Jul 2007 14:24:01 +0300, Alexandros Kostopoulos  
<akostop@inaccessnetworks.com> wrote:

> Oops! I've just noticed in your previous mail that I need to apply the  
> patches to Paul's tree...Sorry 'bout that... my mistake
>
> alex
>
>
> On Thu, 26 Jul 2007 13:42:46 +0300, Alexandros Kostopoulos  
> <akostop@inaccessnetworks.com> wrote:
>
>> Hello Scott,
>>
>> Thanks for your response. I'm trying to apply your patches to vanilla  
>> 2.6.22.1 kernel, but unfortunately some patches fail, namely:
>>
>> patching file arch/powerpc/boot/dts/mpc8272ads.dts
>> Hunk #1 FAILED at 10.
>>
>> patching file arch/powerpc/boot/Makefile
>> Hunk #1 FAILED at 44.
>>
>> patching file arch/powerpc/boot/Makefile
>> Hunk #1 FAILED at 48.
>>
>> patching file arch/powerpc/platforms/Kconfig
>> Hunk #1 FAILED at 19.
>>
>> and others, and also some patches appear to be already applied.
>>
>> Maybe I'm patching the wrong kernel version?
>>
>> thanks
>>
>> Alex
>>
>> On Wed, 25 Jul 2007 19:23:05 +0300, Scott Wood  
>> <scottwood@freescale.com> wrote:
>>
>>> On Wed, Jul 25, 2007 at 05:22:40PM +0300, Alexandros Kostopoulos wrote:
>>>> 1) When mdiobus_register() called from mii-bitbang.c  
>>>> (fs_enet_mdio_probe()
>>>> function) attemps to do a device_register for the mdio bus, it  
>>>> actually
>>>> registers the device with a bus_id in the form [0|1|...]:<phy_addr>,  
>>>> that
>>>> is the first part a simple integer. This, of course, happens because
>>>> fs_enet_of_init() (fsl_soc.c) does a
>>>> platform_device_register_simple("fsl-bb-mdio", i,  NULL, 0); with i  
>>>> being
>>>> the first part of the bus, starting from 0. Unfortunately, when
>>>> fs_init_phy() (fs_enet_main.c) calls phy_connect() and therefore
>>>> phy_attach() (phy_device.c), the latter attempts to find the device  
>>>> in the
>>>> mdio bus, but it searches using the bus_id registered in the  
>>>> net_device
>>>> struct, which is in the form of <resource address>:<phy_addr>, eg.
>>>> f0000000:0, and therefore it fails... I don't know if I am doing  
>>>> something
>>>> wrong here, so any hint would be greatly appreciated.
>>>
>>> The code is broken.  Try applying the set of 61 patches I posted a week
>>> or so ago (you'll need to apply them to Paul's tree from around the  
>>> same
>>> time, not the current tree).
>>>
>>>> 2) Since there are two ethernet@<address> nodes in my device tree,
>>>> fs_of_enet_init() calls  
>>>> platform_device_register_simple("fsl-bb-mdio",...)
>>>> twice, therefore creating two mdio busses, 0 and 1, each having the  
>>>> same
>>>> two devices. For example, if I have two PHYs with addresses 1 and 5, I
>>>> will get two mdio busses and 4 devices, 0:1, 0:5, 1:1 and 1:5. Well,  
>>>> this
>>>> doesn't sound right to me, although I am not sure if this is a fatal
>>>> issue. Any comments?
>>>
>>> It's not right -- my patchset gets rid of all of this mess.
>>>
>>>> 3) Also, if I don't want to enter the phy interrupt in the device tree
>>>> (there is not one or I want to use PHY_POLL), what should I do? dtc  
>>>> seems
>>>> to not allow -1 as a value in the reg property.
>>>
>>> Leave the property out altogether.
>>>
>>> -Scott
>>
>
