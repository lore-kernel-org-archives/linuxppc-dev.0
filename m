Return-Path: <gary@mlbassoc.com>
Message-ID: <48BE92C0.2020205@mlbassoc.com>
Date: Wed, 03 Sep 2008 07:36:00 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: More DTS questions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the pointer to the DTC/DTS documents.  These
help, but I still have many questions and am unsure how
to solve some problems.

Most particularly, I have a number of platforms with
"extended" interrupts.  In these cases, I have an FPGA
which is used as an interrupt controller, multiplexing
a number of external interrupt sources into one [or more]
processor interrupts.

In the past (arch/ppc world), I simple expanded the number
of interrupts on the platform (NUM_IRQ) such that interrupts
0..N were the standard platform interrupts and N+1..M were
provided by my FPGA.  The FPGA support had its own interrupt
tables, etc.  Simply installing a single IRQ handler for the
composite got me to the FPGA handler which then de-multiplexed
and passed on the interrupt to the handler for the external
device.

I'm a bit lost as to how to describe this in the DTS.  For
example, I have a platform with PCI.  I can see how to setup
the rest of the PCI stuff (slots, addresses, etc), but I need
to tell it that the interrupt [in this case list corresponding
to INTA..INTD] is handled by this FPGA based interrupt controller.

Looking at some examples in the sources only bring more questions.
Perhaps someone can guide me through this (from the TQM5200):

         pci@f0000d00 {
                 #interrupt-cells = <1>;
                 #size-cells = <2>;
                 #address-cells = <3>;
                 device_type = "pci";
                 compatible = "fsl,mpc5200-pci";
                 reg = <0xf0000d00 0x100>;
                 interrupt-map-mask = <0xf800 0 0 7>;
                 interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3
                                  0xc000 0 0 2 &mpc5200_pic 0 0 3
                                  0xc000 0 0 3 &mpc5200_pic 0 0 3
                                  0xc000 0 0 4 &mpc5200_pic 0 0 3>;
                 clock-frequency = <0>; // From boot loader
                 interrupts = <2 8 0 2 9 0 2 10 0>;
                 interrupt-parent = <&mpc5200_pic>;
                 bus-range = <0 0>;
                 ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
                           0x02000000 0 0x90000000 0x90000000 0 0x10000000
                           0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
         };

The things that truly aren't clear are the various lists.
For example, how does "interrupt-map" and "interrupts" describe
how the interrupts are handled?  I don't see any reference in
the code to these names (how does a driver get access to such
properties?)  I've read the MPC5200 PCI code (where I'd expect
to find some of these answers) without much elucidation.

Forgive such _newbie_ questions, but I'm just a happy arch/ppc
user trying to catch up to an arch/powerpc world :-)

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
