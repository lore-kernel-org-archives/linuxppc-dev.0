Date: Wed, 2 May 2001 20:16:53 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: John Fremlin <chief@bandits.org>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	"Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
	sfr@canb.auug.org.au, linux-arm-kernel@lists.arm.linux.org.uk,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: pmevent patch and PM
Message-ID: <20010502201653.A6711@flint.arm.linux.org.uk>
References: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com> <m23danaayj.fsf@boreas.yi.org.> <20010502205746.G11059@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010502205746.G11059@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Wed, May 02, 2001 at 08:57:46PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 02, 2001 at 08:57:46PM +0200, Erik Mouw wrote:
> maintainer". We do clock switching (on SA11x0 and XScale), CPU core
> voltage switching, and other things. Note that most ARM systems don't
> have things like ACPI BIOSes that do funky things, everything is
> controlled from the OS. Russell usually coordinates things.

I've been specifically discussing the CPU clock switching issues
with Erik, and we have the bones of a kernel-internal generic
interface that should be suitable for both ARM and Intel SpeedStep
(thanks to Andy Grover for his input to this).

By "clock switching" here, I'm talking about the ability for the OS
to reprogram the clock rate at which the CPU core is clocked, and/or
surrounding devices.  For instance, on some of the StrongARM cores,
you need to adjust the SDRAM timing parameters either before or after
the clock change).

The interface doesn't have anything to drive it yet - its literally
an interface where you can say "please set my CPU clock speed to
xxx MHz".
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |        Russell King       linux@arm.linux.org.uk      --- ---
  | | | |            http://www.arm.linux.org.uk/            /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
