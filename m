Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta12.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AABD32C0167
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 10:29:32 +1000 (EST)
In-Reply-To: <1378856847.12204.380.camel@snotra.buserror.net>
References: <20130905055122.F256EE07B6@canberra.localdomain>
 <1378856847.12204.380.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OF7E615C54.5AA6B073-ONCA257BE2.0083B035-CA257BE3.0002ABC9@csc.com>
Date: Wed, 11 Sep 2013 11:29:09 +1100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 09/11/2013 09:47:27 AM:

> From: Scott Wood <scottwood@freescale.com>
> To: Stephen N Chivers/AUS/CSC@CSC
> Cc: Chris Proctor/AUS/CSC@CSC, <linuxppc-dev@lists.ozlabs.org>, 
> <paulus@samba.org>, <benh@kernel.crashing.org>
> Date: 09/11/2013 09:47 AM
> Subject: Re: [RFC PATCH v2 1/1] powerpc/embedded6xx: Add support for
> Motorola/Emerson MVME5100.
> 
> On Thu, 2013-09-05 at 15:51 +1000, Stephen Chivers wrote:
> > Add support for the Motorola/Emerson MVME5100 Single Board Computer.
> > 
> > The MVME5100 is a 6U form factor VME64 computer with:
> > 
> >    - A single MPC7410 or MPC750 CPU
> >    - A HAWK Processor Host Bridge (CPU to PCI) and
> >      MultiProcessor Interrupt Controller (MPIC)
> >    - Up to 500Mb of onboard memory
> >    - A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
> >    - Two 16550 compatible UARTS
> >    - Two Intel E100 Fast Ethernets
> >    - Two PCI Mezzanine Card (PMC) Slots
> >    - PPCBug Firmware
> > 
> > The HAWK PHB/MPIC is compatible with the MPC10x devices.
> > 
> > There is no onboard disk support. This is usually provided by
> > installing a PMC in the first PMC slot.
> > 
> > This patch revives the board support, it was present in early 2.6
> > series kernels. The board support in those days was by Matt Porter of
> > MontaVista Software.
> > 
> > CSC Australia has around 31 of these boards in service. The kernel in 
use
> > for the boards is based on 2.6.31. The boards are operated without 
disks
> > from a file server. 
> > 
> > This patch is based on linux-3.11-rc7 and has been boot tested.
> > 
> > V1->V2:
> >    Address comments by Kular Gama and Scott Wood.
> >    Minor adjustment to platforms/embedded6xx/Kconfig to ensure
> >       correct indentation where possible.
> > 
> > Signed-off-by: Stephen Chivers <schivers@csc.com>
> > ---
> 
> Some comments below, and please run checkpatch.pl, but the next version
> can probably be non-RFC if you're happy with it.
Ok.
> 
> > +      PowerPC,7410 {
> > +         device_type = "cpu";
> > +         reg = <0x0>;
> > +         /* Following required by dtc but not used */
> > +         d-cache-line-size = <32>;
> > +         i-cache-line-size = <32>;
> > +         i-cache-size = <32768>;
> > +         d-cache-size = <32768>;
> > +         timebase-frequency = <25000000>;
> > +         clock-frequency = <500000000>;
> > +                        bus-frequency = <100000000>;
> > +      };
> 
> Whitespace on bus-frequency
Ok. Will fix.
> 
> > +      mpic: interrupt-controller@f3f80000 {
> > +         #interrupt-cells = <2>;
> > +         #address-cells = <0>;
> > +         device_type = "open-pic";
> > +         compatible = "chrp,open-pic";
> > +         interrupt-controller;
> > +         reg = <0xf3f80000 0x40000>;
> > +      };
> > +
> > +   };
> 
> No blank line before }
Ok. Will be fixed.
> 
> > +CONFIG_CMDLINE_BOOL=y
> > +CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
> 
> I take it there's no way to pass a command line in from whatever loader
> this board uses... but you could put it in the dts instead.
>
It can be done by reading the NVRAM/RTC (M48T37) and "overriding" the
DTS specification. But I wanted to keep things simple to start
with.

Putting the default command line in the DTS is required to support
a combined "defconfig" (pp6xx_defconfig) and I know it does work.
So I will do that.

> Did you ever figure out the problem with the combined defconfig?
Not really. But I have been forced to think about that as a new
project will be using some PMCs with 8250 UARTS (PCI) and they are
another way that the console moves from the debug port on the front
panel to somewhere else.

It is very likely that the HAWK UARTS will have to be registered as
platform devices by the board support file itself.

> 
> > +   help
> > +          This option enables support for the Motorola (now 
> Emerson) MVME5100
> > +     board.
> 
> Whitespace
Ok.
> 
> > +/* Board register addresses. */
> > +#define   BOARD_STATUS_REG   0xfef88080
> > +#define   BOARD_MODFAIL_REG   0xfef88090
> > +#define   BOARD_MODRST_REG   0xfef880a0
> > +#define   BOARD_TBEN_REG      0xfef880c0
> > +#define BOARD_SW_READ_REG   0xfef880e0
> > +#define   BOARD_GEO_ADDR_REG   0xfef880e8
> > +#define   BOARD_EXT_FEATURE1_REG   0xfef880f0
> > +#define   BOARD_EXT_FEATURE2_REG   0xfef88100
> 
> Use a space rather than a tab after #define.
Ok.
> 
> > +static unsigned int pci_membase;
> 
> phys_addr_t
Ok.
> 
> > +static void mvme5100_restart(char *cmd)
> > +{
> > +   u_char         *restart;
> 
> Is all that tabbing before "*restart" really necessary?
Will fix.
> 
> > +   restart = ioremap(BOARD_MODRST_REG, 4);
> > +   local_irq_disable();
> > +   mtmsr(mfmsr() | MSR_IP);
> > +
> > +   out_8((u_char *) restart, 0x01);
> 
> If ioremap() fails you'll panic here.
Ok. Will do in mvme5100_setup_arch.
> 
> In any case, you should map things at boot time.
> 
> -Scott
Thanks,
Stephen.
> 
> 
> 
