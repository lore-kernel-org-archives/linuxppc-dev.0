Return-Path: <timur@freescale.com>
Message-ID: <4756DAA4.7070702@freescale.com>
Date: Wed, 05 Dec 2007 11:06:44 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, PowerPC dev list <Linuxppc-dev@ozlabs.org>
Subject: Re: ucc_uart: add support for Freescale QUICCEngine UART
References: <11967907173600-git-send-email-timur@freescale.com>
	<200712042313.58252.arnd@arndb.de> <4755D5C7.5050307@freescale.com>
	<200712050037.11489.arnd@arndb.de>
In-Reply-To: <200712050037.11489.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> In that case, I think the right solution would be to have different properties
> in the device tree, depending on whether or not you have a soft-uart and whether
> you need to download the microcode.
> Having only a compile time option is very bad because it prevents you from
> using the driver on a multi-platform kernel.

I can see putting the option to need Soft-UART in the device, because this is an 
attribute of the hardware.  The silicon is broken and UART functionality is 
provided via a secondary mechanism.

I'm not so crazy about an option to tell the driver to upload the firmware.  So 
look at this:

		ucc@2400 {
			device_type = "serial";
			compatible = "ucc_uart";
			model = "UCC";
			device-id = <5>;	/* The UCC number, 1-7*/
			port-number = <0>;	/* Which ttyQEx device */
			soft-uart;		/* We need Soft-UART */
			upload-firmware;	/* Driver should upload FW */
			...

In a sense, this is just a message from U-Boot to the driver.  It's not really 
an attribute of the hardware.

One thing I could do is create a new node under the QE node that describes any 
uploaded microcode.  The nature of the QE microcode is that only one can be 
present at any time.  So I could do this:

	qe@e0100000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "qe";
		model = "QE";
		ranges = <0 e0100000 00100000>;
		...

		microcode@100 {	/* 100 is offset within I-RAM where the microcode was uploaded */
			name = "Soft-UART";
			extended_modes = <0 0>;
			vtraps = <0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
		}

The extended_modes and vtraps are data that the driver needs any way (for 
Soft-UART, it's all zeros, but not for other microcodes).  I currently don't 
have a way to pass this information from U-Boot to the kernel.  The driver could 
then look for this node, and if it finds it, it would know *not* to try to 
upload the microcode itself.  And it would also have the extended_modes and 
vtraps information that it might need.

This would solve your problem and mine.

> gcc tries to use only aligned accesses, depending on the the target CPU, so
> you may end up accessing a member as bytes instead of words.

Would it do that even if the member were naturally aligned?  I find that hard to 
believe, since the compiler always knows the alignment of its members.

  OTOH, if this
> structure is always in __iomem and you use in_be32() and the like, there is
> no problem at all.

I do.  I generally only pack structures that are defined by external hardware, 
and this is one.

-- 
Timur Tabi
Linux kernel developer at Freescale
