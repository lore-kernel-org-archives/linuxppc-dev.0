Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41716DDFB5
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 12:12:24 +1100 (EST)
Message-Id: <FC69A78E-BDFC-4E89-AF28-42CBA49234FE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Johns Daniel <johns.daniel@gmail.com>
In-Reply-To: <ba5d9360903241413u47a199d4kbde3ed9af238a916@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PCIe interrupts in the device tree
Date: Tue, 24 Mar 2009 20:12:17 -0500
References: <ba5d9360903241324n57aa74caq2dd2bcdd2a885e19@mail.gmail.com>
	<651BE815-4BF6-4AA3-AA43-C0B7C98A0FCC@kernel.crashing.org>
	<ba5d9360903241413u47a199d4kbde3ed9af238a916@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 24, 2009, at 4:13 PM, Johns Daniel wrote:

>
> On Tue, Mar 24, 2009 at 3:54 PM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>
> On Mar 24, 2009, at 3:24 PM, Johns Daniel wrote:
>
> Could somebody please explain the declaration of the PCIe interrupts
> in the device tree?
>
> I was under the impression that PCIe interrupts in the PowerPC Linux
> kernel default to using INTx signaling (vs. external IRQ pin assertion
> and MSI signaling). Am I right?
>
> If so, then do the interrupt-map lines in the DTS refer to the
> internal IRQ used by Freescale processors to implement INTx virtual
> wire interrupts?
>
> For example, in the mpc8536ds.dts file, under "pci1: pcie@ffe09000"  
> we have:
>                interrupt-map = <
>                        /* IDSEL 0x0 */
>                        0000 0 0 1 &mpic 4 1
>                        0000 0 0 2 &mpic 5 1
>                        0000 0 0 3 &mpic 6 1
>                        0000 0 0 4 &mpic 7 1
>                        >;
> Are the 4, 5, 6, and 7 internal or external IRQs?
>
> The .dts and linux make no distinction between internal & external  
> IRQs.  This is a silly artifact of Freescale UMs.  IRQ 0 starts at  
> offset 0x50000 and each 0x20 offset is another IRQ.  So typically  
> External 0 == IRQ0, Internal 0 == IRQ16.
>
> So this says that Ext 4, 5, 6, 7 and wired to INTA, INTB, INTC, INTD  
> for this particular PCIe controller.
>
> When you say "wired", do you mean hard-wired?

Yes.  The INTx emulation interrupts are hard-wired by the SoC on top  
of the external IRQs.

> If so, how would you specify and use INTx message interrupts?

Do you mean MSI or INTx emulation?

- k
