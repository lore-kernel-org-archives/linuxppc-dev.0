Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 963FFDDF37
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 08:10:36 +1100 (EST)
Message-ID: <47CC696C.4090103@freescale.com>
Date: Mon, 03 Mar 2008 15:11:08 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
In-Reply-To: <20080303210532.GA20382@netgate.macqel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Philippe De Muyter wrote:
> Is the PCI-interrupt map that part of the dts file :
> 
>                 interrupt-map = <
> 
>                         /* IDSEL 0x02 */
>                         1000 0 0 1 &mpic 1 1
>                         1000 0 0 2 &mpic 2 1
>                         1000 0 0 3 &mpic 3 1
>                         1000 0 0 4 &mpic 4 1
> 
>                         /* IDSEL 0x03 */
>                         1800 0 0 1 &mpic 4 1
>                         1800 0 0 2 &mpic 1 1
>                         1800 0 0 3 &mpic 2 1
>                         1800 0 0 4 &mpic 3 1
> 
> 			...

Yes.

> I do not understand anything there :(

It maps PCI interrupts to mpic interrupts.  The first three cells are 
the PCI address (only the device number is unmasked), then the PCI 
interrupt (INTA=1, INTB=2, etc.), then a phandle to the parent interrupt 
controller, then the interrupt specifier for the parent controller.

-Scott
