Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F2F1DDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 02:11:21 +1100 (EST)
Message-ID: <477BA974.8010308@freescale.com>
Date: Wed, 02 Jan 2008 09:10:44 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
In-Reply-To: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
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
> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
>> +               ssi@16000 {
>> +                       compatible = "fsl,ssi";
>> +                       cell-index = <0>;
>> +                       reg = <16000 100>;
>> +                       interrupt-parent = <&mpic>;
>> +                       interrupts = <3e 2>;
>> +                       fsl,mode = "i2s-slave";
>> +                       codec {
>> +                               compatible = "cirrus,cs4270";
>> +                               /* MCLK source is a stand-alone oscillator */
>> +                               bus-frequency = <bb8000>;
>> +                       };
>> +               };
> 
> Does this need to be bus-frequency? It's always called MCLK in all of
> the literature.

I'm trying to make this node as generic as possible.  The fabric driver 
is the one that will parse this node and pass the data to the codec 
driver, so I can't use any codec-specific terms.

The API from the fabric driver for passing clock information includes a 
clock ID, a direction, and a frequency.  I can do something like this:

clock1 = <0, bb8000>

Would that be better?

> 
> In my case the MCLK comes from a chip on the i2c bus that is
> programmable How would that be encoded?.

I'm going under the assumption that MCLK does not change once the board 
is up and running.  In your case, you'd need to do something quite 
different, because you're not reading the clock info from the device 
tree and passing it to the codec at initialization once.  If you want to 
define an extension to the 'codec' child node that handles that, I'll 
add it to the documentation.
