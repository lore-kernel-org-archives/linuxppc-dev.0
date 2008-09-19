Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7165ADDFDB
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:02:18 +1000 (EST)
Message-Id: <1BA571BA-BA43-4C18-9CBF-0F1461E6734E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080919153325.GA548@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC
	GPIOs
Date: Fri, 19 Sep 2008 13:02:11 -0500
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
	<87ej3gyxv0.fsf@macbook.be.48ers.dk>
	<20080919153325.GA548@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 19, 2008, at 10:33 AM, Anton Vorontsov wrote:

> On Fri, Sep 19, 2008 at 05:11:15PM +0200, Peter Korsgaard wrote:
>>>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:
>>
>> Hi,
>>
>>>> It seems basically the same as my patch (gpio driver for
>>>> mpc831x/mpc834x/mpc837x with OF bindings) from September 5th except
>>>> you don't have any documentation
>>
>> Anton> Well, do we really need documentation for every trivial gpio
>> Anton> controller? The bindings are the same, only different  
>> compatible
>> Anton> entries...
>>
>> Well, we need some way of knowing that atleast. Having people  
>> grepping
>> through arch/powerpc/boot/dts/ (and knowing that they should look for
>> 8349 even though they might use 8313 or 8610) doesn't seem optimal to
>> me - I take it that's why we created
>> Documentation/powerpc/dts-bindings in the first place?
>
> Ok.
>
>> Anton> If we do need the documentation for this, I can readily  
>> include it.
>>
>>>> and the Kconfig doesn't depend on
>>>> 831x/834x/837x.
>>
>> Anton> This is purposely. We also need support for 8610, and maybe
>> Anton> later we'll find another chip with the same unit. So, to not  
>> touch
>> Anton> the Kconfig for every new chip I just made it PPC32-wide.  
>> Other
>> Anton> option is to depend on FSL_SOC, but the driver really does not
>> Anton> depend on any fsl_soc stuff...
>>
>> Adding another symbol to the Kconfig once it is verified that a new
>> SoC is compatible doesn't seem like a big deal - Figuring out all the
>> knobs we already have is, without having options for stuff that is
>> known to be irrelevant for the SoC.
>>
>> The other 83xx specific drivers also depend on PPC_83xx.
>
> Lets wait for Kumar's comments. We've already had a PPC_* mess
> for the USB_EHCI_FSL symbol. What I've learned from it, is that
> huge PPC_* list isn't perfect either.

I've alone glanced over this, but some initial comments are.. lets  
rename the thing to not be 83xx specific since 8610 uses it and I'm  
sure we'll have other parts that do similar things.

With regards to the binding, lets make it generic like 'fsl,mpc8xxx- 
gpio", "fsl,CHIP-gpio" and than we can use cpm1/cpm2/pq1/pq2 as  
prefixes to distinguish and major differences.

- k
