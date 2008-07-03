Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A21C8DDF1A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:53:14 +1000 (EST)
Date: Thu, 3 Jul 2008 22:53:12 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: New fsl device bindings file
Message-ID: <20080703185312.GA6043@polina.dev.rtsoft.ru>
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2008 at 01:20:18PM -0500, Kumar Gala wrote:
> Guys,
>
> I'm sure you'll hate for doing this, but I've asked Kim to create a new 
> Documentation/powerpc/fsl-device-tree-bindings.txt as part of his SEC 
> patch.

Just curious... why we're maintaining documentation in the .txt file?
We could just create Documentation/powerpc/fsl-device-tree-bindings.dts
file, that will be:

1. True device tree source file;
2. With a lots of comments for documentation purposes;
3. Could be compiled (via imaginable dts-doxygen) into .txt or nice .pdf
   file and printed :-), exactly as we do with kerneldoc.

For example, this

- - - -
   e) I2C

   Required properties :

    - device_type : Should be "i2c"
    - reg : Offset and length of the register set for the device

   Recommended properties :

    - compatible : Should be "fsl-i2c" for parts compatible with
      Freescale I2C specifications.
    - interrupts : <a b> where a is the interrupt number and b is a
      field that represents an encoding of the sense and level
      information for the interrupt.  This should be encoded based on
      the information in section 2) depending on the type of interrupt
      controller you have.
    - interrupt-parent : the phandle for the interrupt controller that
      services interrupts for this device.
    - dfsrr : boolean; if defined, indicates that this I2C device has
      a digital filter sampling rate register
    - fsl5200-clocking : boolean; if defined, indicated that this device
      uses the FSL 5200 clocking mechanism.

   Example :

	i2c@3000 {
		interrupt-parent = <40000>;
		interrupts = <1b 3>;
		reg = <3000 18>;
		device_type = "i2c";
		compatible  = "fsl-i2c";
		dfsrr;
	};
- - - -

Turns into

- - - -
/* Freescale I2C controller */
i2c@3000 {
	/* the phandle for the interrupt controller that services interrupts
	 * for this device. */
	interrupt-parent = <40000>;

	/* interrupts: <a b> where a is the interrupt number and b is a
	 * field that represents an encoding of the sense and level
	 * information for the interrupt.  This should be encoded based on
	 * the information in section 2) depending on the type of interrupt
	 * controller you have. */
	interrupts = <1b 3>;

	/* offset and length of the register set for the device */
	reg = <3000 18>;

	/* deprecated; */
	device_type = "i2c";

	/* should be "fsl-i2c" for parts compatible with Freescale I2C
	 * specifications. */
	compatible  = "fsl-i2c";

	/* optional; boolean; if defined, indicates that this I2C device has
 	 * a digital filter sampling rate register */
	dfsrr;

	/* optional; boolean; if defined, indicated that this device
	 * uses the FSL 5200 clocking mechanism. */
	fsl5200-clocking;
};
- - - -

Or is this too wild? :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
