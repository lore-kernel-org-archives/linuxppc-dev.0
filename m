Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 68CDD67A72
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 07:53:35 +1100 (EST)
Message-ID: <422384CA.6090004@mvista.com>
Date: Mon, 28 Feb 2005 13:53:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: James Chapman <jchapman@katalix.com>
References: <42235B0A.3070302@katalix.com>
In-Reply-To: <42235B0A.3070302@katalix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.11-rc4] ppc: add support for Radstone ppc7d boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi James,

All-in-all, this seems good but I have a few comments/questions.

Mark
--

James Chapman wrote:

> Add support for Radstone PPC7D PPC boards.
>
> Signed-off-by: James Chapman <jchapman@katalix.com>
>
> The Radstone PPC7D is a rugged ppc7447A VME card with
> Marvell Discovery-II dual GigE, dual PCI/PCI-X PMC sites,
> 4 UARTs, 2 high speed serial ports, USB and optional
> SCSI / VGA.

 >  diff -Nru a/arch/ppc/platforms/radstone_ppc7d.c 
b/arch/ppc/platforms/radstone_ppc7d.c
 > +void __init ppc7d_setup_peripherals(void)

 > +       val32 = mv64x60_read(&bh, MV64x60_PCI1_PCI_DECODE_CNTL);
 > +       val32 &= ~(1 << 3);
 > +       mv64x60_write(&bh, MV64x60_PCI1_PCI_DECODE_CNTL, val32);

Bit 3 is already cleared by the core code.

 > +       /* Setup P2P for PCI#0 */
 > +       val32 = mv64x60_read(&bh, MV64x60_PCI0_P2P_CONFIG);
 > +       val32 &= ~(0x00ffffff);
 > +       val32 |= ((bh.hose_a->first_busno & 0xff) << 16);
etc.

Do you really use the P2P bridge?  Unless I missed something, I think it 
remains disabled.  You shouldn't need it unless you have PCI devices on 
one hose directly accessing PCI devices on the other hose.  The P2P 
stuff seems complicated & unnecessary.
