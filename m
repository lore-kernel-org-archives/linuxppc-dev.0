Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98CE3DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Nov 2008 04:33:15 +1100 (EST)
Message-ID: <49147B8E.4060600@freescale.com>
Date: Fri, 07 Nov 2008 11:31:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: wael showair <showair2003@yahoo.com>
Subject: Re: How to register an interrupt under linux?
References: <20376306.post@talk.nabble.com>
In-Reply-To: <20376306.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

wael showair wrote:
> Dear all,
> First here is the setup i've:
> 1. The board is SPTWIMAX-CC1E board 
> 2. The processor is MPC8555 i found it in the powerpc family NOT ppc family.
> Also the board contains DSP core.
> 3. Linux Kernel 2.6.19-rc5 running on the MPC8555 processor side.

That's rather old...

> I aim to let the DSP processor interrupts the MPC8555 processor so i think
> the first step is to register an interrupt handler for an interrupt number.
> i found this in the linux API request_irq. so 
> 
> i make a simple module & write in it
> request_irq(4,my_handler,SA_INTERRUPT,"DSP",NULL); but unfortunately it
> returns -ENOSYS.

If we had a FAQ, this would be entry #1.  request_irq() takes virtual 
IRQ numbers, not hardware numbers of some specific PIC.  You need to 
create a mapping, typically via the device tree.  Google should be able 
to provide more details.

> i have tracked the error & i found this is because the
> irq_chip structure was not set.
> 
> so i added the API of set_irq_chip as follows:
> 
> irqChip.enable = NULL;
> irqChip.disable = NULL;
> irqChip.startup = NULL;
> irqChip.shutdown = NULL;

That's kind of like commenting out every line with an error until the 
code builds. :-P

>  but unfortunately when i tried to insert my module i got a segmentation
> fault.

That tends to happen if you tell the kernel to call a NULL pointer.

  i have tracked it & i found this is because of the unmask function of
> my interrupt irq_chip was not set.
> so do i have to implement it

No, it's already implemented in the MPIC driver.

-Scott
