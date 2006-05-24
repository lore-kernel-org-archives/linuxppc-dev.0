Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72DCE67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 05:39:47 +1000 (EST)
In-Reply-To: <4474B4F7.9000204@broadcom.com>
References: <4474B4F7.9000204@broadcom.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B1D76446-3B99-48EC-8DCF-330EC41C430F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Question about IRQs on MPC8540
Date: Wed, 24 May 2006 14:40:08 -0500
To: "Travis B. Sawyer" <tsawyer@broadcom.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 24, 2006, at 2:33 PM, Travis B. Sawyer wrote:

> I sent this to Kumar, should have sent directly to the list...

I guess I'll reply to both :)

> I'm porting our kernel base from 2.4->2.6 for our boards and an ODM  
> board.
> The ODM board is board that is based off of the 8540 ADS.
>
> I'm having a bit of a problem understanding what went on btw 2.6.12  
> and
> 2.6.16.16 wrt
> the 85xx interrupts.
>
> For example, in 2.6.12 I had external interrupts as follows:
>        {0, MPC85xx_IRQ_EXT2, MPC85xx_IRQ_EXT3, 0},    /* The bridge */
>        {MPC85xx_IRQ_EXT2, MPC85xx_IRQ_EXT3, 0, 0},        /*  
> Cardbus */
>        {MPC85xx_IRQ_EXT6, 0, 0, 0},                    /* IDSEL 18  
> -- QE */
>        {MPC85xx_IRQ_EXT5, 0, 0, 0},                    /* neo2 FE */
>        {MPC85xx_IRQ_EXT9, 0, 0, 0},                    /* neo3 FE  
> egress */
>        {MPC85xx_IRQ_EXT10, 0, 0, 0},                    /* neo3 FE
> ingress IDSEL 21 */
> Where ext2 was 98, ext3 was 99, etc.
>
> With the newer 2.6.16.16 kernel, I see
> ext2 is 50, ext3 51, etc.
>
> mpc85xx_map_irq: res: 0 for idsel 16 pin 1 0:16.0
> mpc85xx_map_irq: res: 0 for idsel 16 pin 1 0:16.1
> mpc85xx_map_irq: res: 54 for idsel 18 pin 1 0:18.0
> mpc85xx_map_irq: res: 53 for idsel 19 pin 1 0:19.0
> mpc85xx_map_irq: res: 50 for idsel 16 pin 2 1:1.0
> mpc85xx_map_irq: res: 51 for idsel 16 pin 3 1:1.1

This is because we most likely removed the offset that was added to  
the IRQs.  This is done via MPC85xx_OPENPIC_IRQ_OFFSET, its really  
intended to reserve a range for CPM and/or i8259 interrupts.  On a  
normal 8540 board setting it to 0 is fine.

> The problem is that when the PCI device drivers request the irq, it  
> fails.
> Sandburst Thin Driver 1.1.0 May 24 2006 loaded
>  Support available from http://www.sandburst.com
> sbthin: sb/ife0 (241/0) at 0xea3e0000, device 19
> sbthin_init_one:sb/ife0 request irq failed with -38

what is the IRQ its trying to request?

> and
>
> Yenta: Using CSCINT to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:01:01.0, mfunc 0x00001000, devctl 0x66
> Yenta: request_irq() in yenta_probe_cb_irq() failed!
> Yenta TI: socket 0000:01:01.0 no PCI interrupts. Fish. Please report.
> Yenta: no PCI IRQ, CardBus support disabled for this socket.
>
>
> Can you give me some pointers where to look?  I've been scouring the
> changes and can't
> really put my finger on it.

What does your map_irq function look like?

- k
