Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2133FDDEE2
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 04:53:25 +1100 (EST)
Message-ID: <477D2150.4020506@freescale.com>
Date: Thu, 03 Jan 2008 11:54:24 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
In-Reply-To: <9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
>> Jon Smirl wrote:
>>> On 1/1/08, Jon Smirl <jonsmirl@gmail.com> wrote:
>>>> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
>>>>> +               ssi@16000 {
>>>>> +                       compatible = "fsl,ssi";
>>>>> +                       cell-index = <0>;
>>>>> +                       reg = <16000 100>;
>>>>> +                       interrupt-parent = <&mpic>;
>>>>> +                       interrupts = <3e 2>;
>>>>> +                       fsl,mode = "i2s-slave";
>>>>> +                       codec {
>>>>> +                               compatible = "cirrus,cs4270";
>>>>> +                               /* MCLK source is a stand-alone oscillator */
>>>>> +                               bus-frequency = <bb8000>;
>>>>> +                       };
>>>>> +               };
>>>> Does this need to be bus-frequency? It's always called MCLK in all of
>>>> the literature.
>>>>
>>>> In my case the MCLK comes from a chip on the i2c bus that is
>>>> programmable How would that be encoded?.
>>> Looking at the cs4270 codec driver it is controlled by i2c (supports
>>> SPI too).  What happened to the conversation about putting codecs on
>>> the controlling bus and then linking them to the data bus?
>> The current CS4270 driver doesn't support device trees.  When I wrote
>> it, the idea of putting I2C info in the device tree was not finalized,
>> and since the driver is supposed to be cross-platform, I decided to do
>> it the old-fashioned way.  Before I update the code, however, I'm
>> waiting for:
>>
>> 1) The current code to be accepted into the tree
>> 2) ASoC is updated to V2
>> 3) The current drivers are updated to support ASoC V2.
> 
> I've been trying to get the i2c code in for two months. Hopefully it
> will go in soon, no one had made any comments on it recently. Have you
> tried your code with it?

No.  I don't like updating my patches with new features while they're 
undergoing review.  If something is clearly wrong with the patch, then I'll 
fix it and resubmit.  But I really don't like to support new stuff just 
because it's there.

> There is nothing stopping your from putting a node for the CS4270 on
> the i2c bus today. It just won't trigger the loading of the driver.

Yes, the thing that's stopping me is that I don't want to do 20 things at 
once.  I already have pending patches that I'm trying to get in.  Once those 
are in, then I will consider additional work.

> Don't we want to follow the device tree policy of putting the device
> on the controlling bus and then link it to the data bus?

Normally, that sounds like a good idea, but the cs4270 is an I2S device first, 
and an I2C device second.  I need to be able to find that codec from the I2S 
node.  My I2S driver would not know to scan all I2C devices to find the codec.

> It makes it a little easier but it doesn't fix everything. We need to
> start looking at it since none of the example driver for it are device
> tree based.

I will look at it, *after* my current V1 driver has been applied to the tree.

 > It still has problems with wanting 'struct
> platform_device' when we have 'struct of_platform_device' pointers. It
> also doesn't know how to dynamically load codecs based on device
> trees.

I agree that these things need to be fixed.  I look forward to thinking about 
these problems, *after* my V1 patches have been applied.

> Liam messed up all of my code when he refactored it in late December.

Bummer.

> I've switched over to the current SOC code for the moment. The big
> thing that v2 fixes is that SOC is changed to being a subsystem
> instead of platform driver. Being a subsystem is the correct model.
> 
> It would be good if more pieces of v2 get push forward. Then we can
> sort out the device tree issues in it.

I agree.

> Adding the second device tree node doesn't have anything to do with
> ASOC v2. It's specific to powerpc and device trees.

Ok, but making my CS4270 driver device-tree aware is a completely separate 
task from what this patchset is addressing.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
