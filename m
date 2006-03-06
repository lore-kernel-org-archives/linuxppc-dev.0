Return-Path: <Phil.Nitschke@avalon.com.au>
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: linux DMA capabilities in MV64460
References: <kw3bkovcup.fsf@lamorak.int.avalon.com.au>
	<20051220010136.GA31165@mag.az.mvista.com>
Date: Mon, 06 Mar 2006 14:39:38 +1030
Message-ID: <kwlkvomcxp.fsf@lamorak.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>>>>> "MAG" == Mark A Greer <mgreer@mvista.com> writes:
  MAG> On Tue, Dec 20, 2005 at 10:49:58AM +1030, Phil Nitschke wrote:

  >> ... if I wanted to suck the data into main memory using the mv64460
  >> IDMA controller (assuming the device couldn't initiate its own
  >> burst writes), is there a standard kernel interface to allow me to
  >> do this?

  MAG> Yes.  You would make a "dma ctlr driver" for the dma ctlr(s).  I
  MAG> don't know what the best example would be but hopefully someone
  MAG> else has a suggestion.

I'm following up to a thread started in December last year.  The thread
was talking about this device:
  http://www.marvell.com/products/communication/discoveryIII/index.jsp
  http://www.marvell.com/products/communication/Discovery%20MV64460%20FINAL.pdf

Currently I've found the linux kernel has the following files relevant
to this hardware (2.6.15 kernel):

    ./arch/ppc/syslib/mv64360_pic.c
    ./arch/ppc/syslib/mv64x60.c
    ./arch/ppc/syslib/mv64x60_dbg.c
    ./arch/ppc/syslib/mv64x60_win.c
    ./drivers/char/watchdog/mv64x60_wdt.c
    ./drivers/i2c/busses/i2c-mv64xxx.c
    ./drivers/net/mv643xx_eth.c

I'm now looking seriously (and reluctantly!) at writing a DMA Controller
Driver to supplement these functions, and I've started the process of
getting an NDA from Marvell, so I can get their User Manual (and errata!).

Can someone point me in the right direction to get me started?  I need
to come up the learning curve to find out where to start.  

How is a DMA controlled (from a device driver writer's perspective) when
a third-party (i.e. in the bridge) DMA controller needs to do the work
to get the data from a PCI Target into main memory?

What kernel API should be provided by the DMA Controller Driver?  

Any documentation, examples, similar device drivers, etc, would be
appreciated.  TIA,

--
Phil
