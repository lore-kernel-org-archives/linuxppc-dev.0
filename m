Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 136DADDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 03:08:36 +1100 (EST)
Message-ID: <47557B6B.9020105@freescale.com>
Date: Tue, 04 Dec 2007 10:08:11 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
	<20071203204652.GB4850@loki.buserror.net>
	<47553D31.4080306@anagramm.de>
	<20071204130841.GA5765@loki.buserror.net>
	<4755731D.4050106@anagramm.de>
In-Reply-To: <4755731D.4050106@anagramm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clemens Koller wrote:
> Scott Wood schrieb:
>  >> I would prefer to not tell the driver for 'foo' that it should attach to
>  >> 0-0068
>  >> because it should attach to the first i2c bus (0) it finds per default.
>  >
>  > Absolutely wrong.
> 
> Hmm... Why?

It's error prone.

>  > What if foo is on bus 1?
> 
> Then I would need to tell the driver 'foo' that it should attach
> to 1-0068.

So we're back to the situation where drivers that aren't explicitly told 
where to look are making assumptions that are possibly incorrect.  You 
should be able to enable drivers without harm, even if the hardware 
isn't there.

> Propably you should see the bigger picture here:

Pot, meet kettle. :-)

> We just need to tell what we have, if it's not some default...
> statically (kconfig) or dynamically (of/dt) to get it right
> because we cannot probe for sure what we have (in contrast to PCI).
> 
> I just don't want to be pushed into configuring things twice or on
> two different places because that's error prone.

The new system is far less error prone than the old system.  You seem to 
be suggesting a third system, with a radically different kconfig format 
and no multiplatform support (again, this was one of your complaints in 
your original e-mail -- why do you ignore it now?).  Please show us the 
code, or at least some description of how you would change kconfig to 
get it up to the task, and how you would handle multiplatform kernels.

>  >> Then I would need to tell 'bar' to attach to 1-0068. Where is the 
> problem?
>  >
>  > OK, now say there's another foo on bus 2, and a pair of bars on buses 
> 3 and
>  > 4?
> 
> Okay, let's play that game:
> foo -> connect an instance to 0-0068 and 2-0068
> bar -> connect an instance to 1-0068 and and 3-0068 and 4-0068

That doesn't resemble kconfig in the least -- and even if you transform 
it into some sort of runtime-parsable textual list, what do those bus 
numbers mean, anyway?  How do you associate those with various i2c 
buses, potentially coming from different i2c drivers?  How do you 
specify IRQs?  How do you specify device variants among those the driver 
supports?  By the time you fix all of that, you'll basically have the 
device tree.

The device tree provides a hierarchy that is well suited to handling 
this sort of problem, and it also logically separates what the kernel 
supports from what the hardware has (which is *necessary* for 
multiplatform support).

>  >> The 0068 is already redundant in the case of these RTCs because they 
> are
>  >> fixed.
>  >
>  > How do you know I'm even talking about RTCs?
> 
> Well, the subject is about RTCs.

Not really, it's about a change in the i2c subsystem (I noticed you 
didn't include the i2c list or linuxppc-dev... you'd get a larger 
audience of the people that actually made the change that way).  That it 
happens to be an RTC chip you're using on the i2c bus is an 
inconsequential detail.

>  >> linux-2.6/Documentation/powerpc$ grep "rtc" *
>  >> only gives on hit in the mpc52xx-device-tree-bindings.txt (from Grant,
>  >> btw.).
>  >> which could give a clue what's going on here.
>  >> linux-2.6/Documentation/powerpc$ grep "fsl_soc" *
>  >> - nothing -
>  >
>  > Uh, did you try grepping for "i2c"?
> 
> No, I've just read the whole file from time to time.

OK, it seems the description of i2c devices didn't make it into that 
file.  I'm not sure why.

> That was discussed already in detail in several threads and there
> were already decisions made that the DT went into the kernel - no problem
> with that.
> I just don't see that it 'really does help' in it's current state if
> things are broken in a way they are hard to fix for non DT-familiar
> developers, almost impossible to fix for users which just need to
> compile their own kernel to achieve their project goal.

I agree there's been excessive roughness in the transition -- but in 
this case, it's largely due to the i2c subsystem change, whereby a 
driver can't be new-style and old-style at the same time.  Thus, once 
the driver is converted, all platforms have to register the device.  On 
powerpc, we happen to do it using the device tree (though you could do 
it with board-specific platform code the way other arches do if you 
really wanted).

> Well... let's take it easy. I'll dig into the pcf8563 code now.

BTW, there were patches posted recently by Jon Smirl to convert that 
driver to new-style, and to change the i2c subsystem to have the OF 
matches in the driver itself.

-Scott
