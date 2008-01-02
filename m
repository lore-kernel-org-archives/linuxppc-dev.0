Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A34DDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 02:18:51 +1100 (EST)
Message-ID: <477BAB67.4080003@freescale.com>
Date: Wed, 02 Jan 2008 09:19:03 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
In-Reply-To: <9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:
> On 1/1/08, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
>>> +               ssi@16000 {
>>> +                       compatible = "fsl,ssi";
>>> +                       cell-index = <0>;
>>> +                       reg = <16000 100>;
>>> +                       interrupt-parent = <&mpic>;
>>> +                       interrupts = <3e 2>;
>>> +                       fsl,mode = "i2s-slave";
>>> +                       codec {
>>> +                               compatible = "cirrus,cs4270";
>>> +                               /* MCLK source is a stand-alone oscillator */
>>> +                               bus-frequency = <bb8000>;
>>> +                       };
>>> +               };
>> Does this need to be bus-frequency? It's always called MCLK in all of
>> the literature.
>>
>> In my case the MCLK comes from a chip on the i2c bus that is
>> programmable How would that be encoded?.
> 
> Looking at the cs4270 codec driver it is controlled by i2c (supports
> SPI too).  What happened to the conversation about putting codecs on
> the controlling bus and then linking them to the data bus?

The current CS4270 driver doesn't support device trees.  When I wrote 
it, the idea of putting I2C info in the device tree was not finalized, 
and since the driver is supposed to be cross-platform, I decided to do 
it the old-fashioned way.  Before I update the code, however, I'm 
waiting for:

1) The current code to be accepted into the tree
2) ASoC is updated to V2
3) The current drivers are updated to support ASoC V2.

I think ASoC V2 will make it easier to support device trees, but I'm not 
ready yet for that.

> If that's the case the cs4270 should be in the i2c bus node (missing
> currently) and then a link from the SSI bus would point to it.

The CS4270 is a child of both the I2C bus *and* the SSI bus.  It needs 
to have two nodes, one under each.  Your're right in that there needs to 
be a link, but until the code is updated to ASoC V2, I think it's 
premature to add that support.
