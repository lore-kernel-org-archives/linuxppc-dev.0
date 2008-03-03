Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 07DE4DDF2E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 08:26:23 +1100 (EST)
Date: Mon, 3 Mar 2008 22:26:22 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080303212622.GB20382@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47CC696C.4090103@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Mon, Mar 03, 2008 at 03:11:08PM -0600, Scott Wood wrote:
> Philippe De Muyter wrote:
>> Is the PCI-interrupt map that part of the dts file :
>>                 interrupt-map = <
>>                         /* IDSEL 0x02 */
>>                         1000 0 0 1 &mpic 1 1
>>                         1000 0 0 2 &mpic 2 1
>>                         1000 0 0 3 &mpic 3 1
>>                         1000 0 0 4 &mpic 4 1
>>                         /* IDSEL 0x03 */
>>                         1800 0 0 1 &mpic 4 1
>>                         1800 0 0 2 &mpic 1 1
>>                         1800 0 0 3 &mpic 2 1
>>                         1800 0 0 4 &mpic 3 1
>> 			...
>
> Yes.
>
>> I do not understand anything there :(
>
> It maps PCI interrupts to mpic interrupts.  The first three cells are the 
> PCI address (only the device number is unmasked), then the PCI interrupt 
> (INTA=1, INTB=2, etc.), then a phandle to the parent interrupt controller, 
> then the interrupt specifier for the parent controller.

Thanks

The following seems important also :

/*
                interrupts = <18 2>;
*/
                /* interrupts number are coded in hexa ! */
                interrupts = <12 2 19 2 1a 2 1b 2 35 2 36 2 37 2>;

I have replaced the interrupts spec in comments by the longer interrupts spec
below, and it seems to have some positive effect, but I do not know
precisely what I have described there.

I know that 25, 26, 27, 53, 54 and 55 decimal i(hence 19, 1a etc...) are the
interrupts numbers that I had in the ARCH=ppc version.  I added 18 because
of the error message, but it did not help.

What should be described here and how ?

Philippe
