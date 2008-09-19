Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BA9EBDDF19
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:12:59 +1000 (EST)
Date: Fri, 19 Sep 2008 22:12:58 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible
	SOC GPIOs
Message-ID: <20080919181258.GA14093@oksana.dev.rtsoft.ru>
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
	<87ej3gyxv0.fsf@macbook.be.48ers.dk>
	<20080919153325.GA548@oksana.dev.rtsoft.ru>
	<1BA571BA-BA43-4C18-9CBF-0F1461E6734E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1BA571BA-BA43-4C18-9CBF-0F1461E6734E@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 01:02:11PM -0500, Kumar Gala wrote:
[...]
>>> Anton> This is purposely. We also need support for 8610, and maybe
>>> Anton> later we'll find another chip with the same unit. So, to not  
>>> touch
>>> Anton> the Kconfig for every new chip I just made it PPC32-wide.  
>>> Other
>>> Anton> option is to depend on FSL_SOC, but the driver really does not
>>> Anton> depend on any fsl_soc stuff...
>>>
>>> Adding another symbol to the Kconfig once it is verified that a new
>>> SoC is compatible doesn't seem like a big deal - Figuring out all the
>>> knobs we already have is, without having options for stuff that is
>>> known to be irrelevant for the SoC.
>>>
>>> The other 83xx specific drivers also depend on PPC_83xx.
>>
>> Lets wait for Kumar's comments. We've already had a PPC_* mess
>> for the USB_EHCI_FSL symbol. What I've learned from it, is that
>> huge PPC_* list isn't perfect either.
>
> I've alone glanced over this, but some initial comments are.. lets  
> rename the thing to not be 83xx specific since 8610 uses it and I'm sure 
> we'll have other parts that do similar things.

Ok, mpc8xxx_gpio.c would be fine? (Note that I'm agree with 8xxx, for
the file name).

> With regards to the binding, lets make it generic like 'fsl,mpc8xxx- 
> gpio", "fsl,CHIP-gpio" and than we can use cpm1/cpm2/pq1/pq2 as prefixes 
> to distinguish and major differences.

But for compatible entry, shouldn't we use the last compatiblle entry
as a generic one? Then fsl,mpc8349-gpio is perfectly valid. I.e.,
for MPC8610 chips we will have:

"fsl,mpc8610-gpio", "fsl,mpc8349-gpio"

The last entry is most generic, and 8610 is registers-compatible with
the earlier (8349) chips. I thought that we tend to not do "made up"
8xxx things in the device tree... Am I wrong?


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
