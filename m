Return-Path: <david-b@pacbell.net>
Received: from smtp121.sbc.mail.sp1.yahoo.com (smtp121.sbc.mail.sp1.yahoo.com
	[69.147.64.94]) by ozlabs.org (Postfix) with SMTP id 73FC2DDEB6
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 07:12:30 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] USB: Add Cypress c67x00 OTG controller driver to
	Kconfig and Makefiles
Date: Sat, 24 Nov 2007 12:12:27 -0800
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<20071124002451.25361.90102.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20071124002451.25361.90102.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711241212.27787.david-b@pacbell.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 November 2007, Grant Likely wrote:
> +config USB_C67X00_DRV
> +       tristate "Cypress C67x00 support"
> +       # only allowed to be =y if both USB!=m and USB_GADGET!=m

This is wrong.  Remember that since this is a dual-role driver,
there are exactly three possible driver modes ... and the driver
must support only one of them at a time:

  - Host-only ... only allowed if host side USB is enabled.  The
    controller driver can be statically linked iff usbcore is too.

  - Peripheral-only ... only allowed if peripheral side USB is
    enabled.  Only one port may be used as the peripheral; the
    controller driver can be linked statically or as a module.

  - OTG ... only allowed if both host and peripheral side USB
    are enabled.  Only one port can be the OTG port, but other
    ports can be used for host functionality.  Static/modular
    linkage follows (more restrictive) the host-only rule.

And of course, what a given board supports is controlled by the
connectors it has ... A, B, or AB.  (Possibly AB plus n*A.)  So
the driver should probably be able to make sense of having OTG
support, but needing to cope with a non-OTG board ... or having
an OTG board, a driver that only copes with one role.

Hmmm ... your patches don't include peripheral mode support yet.

Either all these gadget hooks should vanish, or you should try
to get the controller mode stuff right from the beginning.

I've appended the relevant Kconfig bits from the musb_hdrc
driver, which (despite some glitches) are pretty much correct.

- Dave



> +       depends on (!USB && USB_GADGET) || (!USB_GADGET && USB) || (USB && USB_GADGET)
> +       default n
> +       help
> +         The Cypress C67x00 (EZ-Host/EZ-OTG) chips are dual-role
> +         host/peripheral USB controllers.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called c67x00.
> +
> +config USB_C67X00_HCD
> +       bool "Cypress C67X00 Host support"
> +       depends on USB_C67X00_DRV
> +       depends on USB
> +       default y
> +       help
> +         This enables the host functionality of the Cypress C67X00.
> 


================
#
# USB Dual Role (OTG-ready) Controller Drivers
# for silicon based on Mentor Graphics INVENTRA designs
#

comment "Enable Host or Gadget support to see Inventra options"
	depends on !USB && USB_GADGET=n

# (M)HDRC = (Multipoint) Highspeed Dual-Role Controller
config USB_MUSB_HDRC
	depends on USB || USB_GADGET
	tristate 'Inventra Highspeed Dual Role Controller (TI, ...)'
	help
	  Say Y here if your system has a dual role high speed USB
	  controller based on the Mentor Graphics silicon IP.  Then
	  configure options to match your silicon and the board
	  it's being used with, including the USB peripheral role,
	  or the USB host role, or both.

	  Texas Instruments parts using this IP include DaVinci 644x,
	  OMAP 243x, OMAP 343x, and TUSB 6010.

	  If you do not know what this is, please say N.

	  To compile this driver as a module, choose M here; the
	  module will be called "musb_hdrc".

config USB_MUSB_SOC
	boolean
	depends on USB_MUSB_HDRC
	default y if ARCH_DAVINCI
	default y if ARCH_OMAP2430
	default y if ARCH_OMAP343X
	help
	  Use a static <asm/arch/hdrc_cnf.h> file to describe how the
	  controller is configured (endpoints, mechanisms, etc) on the
	  current iteration of a given system-on-chip.

comment "DaVinci 644x USB support"
	depends on USB_MUSB_HDRC && ARCH_DAVINCI

comment "OMAP 243x high speed USB support"
	depends on USB_MUSB_HDRC && ARCH_OMAP2430

comment "OMAP 343x high speed USB support"
	depends on USB_MUSB_HDRC && ARCH_OMAP343X

config USB_TUSB6010
	boolean "TUSB 6010 support"
	depends on USB_MUSB_HDRC && !USB_MUSB_SOC
	default y
	help
	  The TUSB 6010 chip, from Texas Instruments, connects a discrete
	  HDRC core using a 16-bit parallel bus.  It can use system-specific
	  external DMA controllers.

choice
	prompt "Driver Mode"
	depends on USB_MUSB_HDRC
	help
	  Dual-Role devices can support both host and peripheral roles,
	  as well as a the special "OTG Device" role which can switch
	  between both roles as needed.

# use USB_MUSB_HDRC_HCD not USB_MUSB_HOST to #ifdef host side support;
# OTG needs both roles, not just USB_MUSB_HOST.
config USB_MUSB_HOST
	depends on USB
	bool "USB Host"
	help
	  Say Y here if your system supports the USB host role.
	  If it has a USB "A" (rectangular), "Mini-A" (uncommon),
	  or "Mini-AB" connector, it supports the host role.
	  (With a "Mini-AB" connector, you should enable USB OTG.)

# use USB_GADGET_MUSB_HDRC not USB_MUSB_PERIPHERAL to #ifdef peripheral
# side support ... OTG needs both roles
config USB_MUSB_PERIPHERAL
	depends on USB_GADGET
	bool "USB Peripheral (gadget stack)"
	select USB_GADGET_MUSB_HDRC
	help
	  Say Y here if your system supports the USB peripheral role.
	  If it has a USB "B" (squarish), "Mini-B", or "Mini-AB"
	  connector, it supports the peripheral role.
	  (With a "Mini-AB" connector, you should enable USB OTG.)

config USB_MUSB_OTG
	depends on USB && USB_GADGET && EXPERIMENTAL
	bool "Both host and peripheral:  USB OTG (On The Go) Device"
	select USB_GADGET_MUSB_HDRC
	select USB_OTG
	select PM
	help
	   The most notable feature of USB OTG is support for a
	   "Dual-Role" device, which can act as either a device
	   or a host.  The initial role choice can be changed
	   later, when two dual-role devices talk to each other.

	   Select this if your system has a Mini-AB connector, or
	   to simplify certain kinds of configuration.

	   To implement your OTG Targeted Peripherals List (TPL), enable
	   USB_OTG_WHITELIST and update "drivers/usb/core/otg_whitelist.h"
	   to match your requirements.

endchoice

# enable peripheral support (including with OTG)
config USB_GADGET_MUSB_HDRC
	bool
	depends on USB_MUSB_HDRC && (USB_MUSB_PERIPHERAL || USB_MUSB_OTG)

# enables host support (including with OTG)
config USB_MUSB_HDRC_HCD
	bool
	depends on USB_MUSB_HDRC && (USB_MUSB_HOST || USB_MUSB_OTG)
	select USB_OTG if USB_GADGET_MUSB_HDRC
	default y
