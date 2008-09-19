Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7EC91DE0B2
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 01:33:28 +1000 (EST)
Date: Fri, 19 Sep 2008 19:33:25 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible
	SOC GPIOs
Message-ID: <20080919153325.GA548@oksana.dev.rtsoft.ru>
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
	<87ej3gyxv0.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <87ej3gyxv0.fsf@macbook.be.48ers.dk>
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

On Fri, Sep 19, 2008 at 05:11:15PM +0200, Peter Korsgaard wrote:
> >>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:
> 
> Hi,
> 
>  >> It seems basically the same as my patch (gpio driver for
>  >> mpc831x/mpc834x/mpc837x with OF bindings) from September 5th except
>  >> you don't have any documentation
> 
>  Anton> Well, do we really need documentation for every trivial gpio
>  Anton> controller? The bindings are the same, only different compatible
>  Anton> entries...
> 
> Well, we need some way of knowing that atleast. Having people grepping
> through arch/powerpc/boot/dts/ (and knowing that they should look for
> 8349 even though they might use 8313 or 8610) doesn't seem optimal to
> me - I take it that's why we created
> Documentation/powerpc/dts-bindings in the first place?

Ok.

>  Anton> If we do need the documentation for this, I can readily include it.
> 
>  >> and the Kconfig doesn't depend on
>  >> 831x/834x/837x.
> 
>  Anton> This is purposely. We also need support for 8610, and maybe
>  Anton> later we'll find another chip with the same unit. So, to not touch
>  Anton> the Kconfig for every new chip I just made it PPC32-wide. Other
>  Anton> option is to depend on FSL_SOC, but the driver really does not
>  Anton> depend on any fsl_soc stuff...
> 
> Adding another symbol to the Kconfig once it is verified that a new
> SoC is compatible doesn't seem like a big deal - Figuring out all the
> knobs we already have is, without having options for stuff that is
> known to be irrelevant for the SoC.
> 
> The other 83xx specific drivers also depend on PPC_83xx.

Lets wait for Kumar's comments. We've already had a PPC_* mess
for the USB_EHCI_FSL symbol. What I've learned from it, is that
huge PPC_* list isn't perfect either.

See this discussion:

http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01926.html

And this one:

http://fixunix.com/kernel/397972-patch-1-4-spi-powerpc-spi_mpc83xx-handles-freescale-mpc8610-well.html

>  >> Why do you need this when you have the lock?
> 
>  Anton> See this discussion:
> 
>  Anton> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg12299.html
> 
> Ahh, for open drain outputs. gpiolib doesn't actually provide an
> interface to put the gpios in that mode, but it could ofcause have
> been set up in the bootloader. I'll fix that and send an updated
> patch.

Pardon? Who will send an updated patch, and what patch exactly? ;-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
