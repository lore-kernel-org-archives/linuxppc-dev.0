Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05283DDED3
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 07:31:28 +1000 (EST)
Subject: Re: [PATCH] POWERPC: Support ISA legacy addresses in
	of_address_to_resource()
From: Nate Case <ncase@xes-inc.com>
To: benh@kernel.crashing.org
In-Reply-To: <1210307480.1421.132.camel@pasglop>
References: <1210289192.13845.281.camel@localhost.localdomain>
	<1210307480.1421.132.camel@pasglop>
Content-Type: text/plain
Date: Fri, 09 May 2008 16:31:19 -0500
Message-Id: <1210368679.13845.315.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-05-09 at 14:31 +1000, Benjamin Herrenschmidt wrote:
> I don't understand that fix. Can you tell us more about the exact
> failure mode ? Especially, show us the device-tree bits and the
> addresses returned.
> 
> I suspect the bug is in your device-tree that is forwarding IO
> addresses
> all the way without converting them to memory or something like that.

Your suspicion is correct in a way -- this allows IO port addresses to
make their way to 'struct resource' so that drivers can use inb(),
outb(), etc.  After some thought, I'm not sure if a device tree using
I/O port addresses for a legacy node is considered a bug or not.

Here is the failure case my patch fixes:

        isa@0,e00f0000 {
                linux,phandle = <0x3ff93688>;
                ranges = <0x1 0x0 0x0 0x0 0x1000>;
                reg = <0x0 0xe00f0000 0x0 0x10000>;
                class-code = <0x601ff>;
                device-id = <0xa008>;
                vendor-id = <0x1959>;
                #address-cells = <0x2>;
                #size-cells = <0x1>;
                device_type = "isa";

                ipmi@ca2 {
                        linux,phandle = <0x3ff93a00>;
                        reg = <0x1 0xca2 0x100>;
                        reg-spacing = <0x1>;
                        reg-size = <0x1>;
                        compatible = "ipmi-kcs";
                        device_type = "ipmi";
                };
        };

The address returned for ipmi@ for this case is 0x10ca2 instead of
0xca2.

The legacy "isa" bus node and the device nodes give the raw port
addresses (0xca2 in this case).  In order for this to work, it has to be
assumed that ISA_IO_BASE is mapped properly on the platform so that the
port I/O functions will work with the raw port addresses.

The problem I encountered was that it would call pci_address_to_pio() on
the reg address of the ipmi node just because it had the IORESOURCE_IO
flag.  This would result in the 'struct resource' getting the bogus
address of 0x10ca2 rather than 0xca2.

In my case, my real fix I have settled on is using the following instead
of using the I/O method:

        isa@0,e00f0000 {
                linux,phandle = <0x3ff93688>;
                ranges = <0x0 0x0 0x0 0xfc800000 0x1000>;
                reg = <0x0 0xe00f0000 0x0 0x10000>;
                class-code = <0x601ff>;
                device-id = <0xa008>;
                vendor-id = <0x1959>;
                #address-cells = <0x2>;
                #size-cells = <0x1>;
                device_type = "isa";

                ipmi@ca2 {
                        linux,phandle = <0x3ff93a00>;
                        reg = <0x0 0xca2 0x100>;
                        reg-spacing = <0x1>;
                        reg-size = <0x1>;
                        compatible = "ipmi-kcs";
                        device_type = "ipmi";
                };
        };

That is, the typical MMIO case so that 'struct resource' ends up with
0xfc800ca2.  This works fine without the patch of course.  If legacy I/O
port addresses are not permitted in device trees this way and we don't
want to support it, then you can ignore my patch.  However, it does seem
a little strange to me that __of_address_to_resource() assumes anything
with IORESOURCE_IO is a PCI device.

- Nate Case <ncase@xes-inc.com>
