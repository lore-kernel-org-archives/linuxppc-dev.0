Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88528DE015
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:46:56 +1000 (EST)
Message-Id: <ABD97D30-4503-4A5E-A04B-2D644BF31124@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080919181258.GA14093@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC
	GPIOs
Date: Fri, 19 Sep 2008 13:46:49 -0500
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
	<87ej3gyxv0.fsf@macbook.be.48ers.dk>
	<20080919153325.GA548@oksana.dev.rtsoft.ru>
	<1BA571BA-BA43-4C18-9CBF-0F1461E6734E@kernel.crashing.org>
	<20080919181258.GA14093@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 19, 2008, at 1:12 PM, Anton Vorontsov wrote:

> On Fri, Sep 19, 2008 at 01:02:11PM -0500, Kumar Gala wrote:
> [...]
>>>> Anton> This is purposely. We also need support for 8610, and maybe
>>>> Anton> later we'll find another chip with the same unit. So, to not
>>>> touch
>>>> Anton> the Kconfig for every new chip I just made it PPC32-wide.
>>>> Other
>>>> Anton> option is to depend on FSL_SOC, but the driver really does  
>>>> not
>>>> Anton> depend on any fsl_soc stuff...
>>>>
>>>> Adding another symbol to the Kconfig once it is verified that a new
>>>> SoC is compatible doesn't seem like a big deal - Figuring out all  
>>>> the
>>>> knobs we already have is, without having options for stuff that is
>>>> known to be irrelevant for the SoC.
>>>>
>>>> The other 83xx specific drivers also depend on PPC_83xx.
>>>
>>> Lets wait for Kumar's comments. We've already had a PPC_* mess
>>> for the USB_EHCI_FSL symbol. What I've learned from it, is that
>>> huge PPC_* list isn't perfect either.
>>
>> I've alone glanced over this, but some initial comments are.. lets
>> rename the thing to not be 83xx specific since 8610 uses it and I'm  
>> sure
>> we'll have other parts that do similar things.
>
> Ok, mpc8xxx_gpio.c would be fine? (Note that I'm agree with 8xxx, for
> the file name).
>
>> With regards to the binding, lets make it generic like 'fsl,mpc8xxx-
>> gpio", "fsl,CHIP-gpio" and than we can use cpm1/cpm2/pq1/pq2 as  
>> prefixes
>> to distinguish and major differences.
>
> But for compatible entry, shouldn't we use the last compatiblle entry
> as a generic one? Then fsl,mpc8349-gpio is perfectly valid. I.e.,
> for MPC8610 chips we will have:
>
> "fsl,mpc8610-gpio", "fsl,mpc8349-gpio"

Yeah the order is correct.. should be:

"fsl,CHIP-gpio", "fsl,mpc8xxx-gpio"

The last entry is most generic, and 8610 is registers-compatible with
>
> the earlier (8349) chips. I thought that we tend to not do "made up"
> 8xxx things in the device tree... Am I wrong?

You are correct we try to avoid this, but than I suggest we do it by  
family.  I think its confusing to show 8610 and 8349 in the same dev  
tree.

What we do in PCI is use the first in family.  So lets take 8379 as an  
example it would look like:

"fsl,mpc8379-gpio", "fsl-mpc8349-gpio"

and 8610 would look like:

"fsl,mpc8610-gpio"

This way the compatiable binding in the code just lists something like  
"fsl,mpc8349-gpio", "fsl,mpc8610-gpio", "fsl,mpc8572-gpio".

Does that make sense?

- k
