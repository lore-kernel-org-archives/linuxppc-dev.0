Return-Path: <devtty0@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id E330FDDF37
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 03:13:44 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1185748nfc
	for <linuxppc-dev@ozlabs.org>; Fri, 02 Mar 2007 08:13:41 -0800 (PST)
Message-ID: <45E84D32.8040405@gmail.com>
Date: Fri, 02 Mar 2007 17:13:38 +0100
From: Luotao Fu <devtty0@gmail.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problems with pci bus on a pm520 board
References: <45E5ED35.7090207@gmail.com>
	<0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
	<45E61161.9040900@gmail.com>
	<eaa8f5754d3e1544ce91df01acf2054d@kernel.crashing.org>
	<45E69CDF.20608@gmail.com>
	<3a8c70b34f2ef98fb696c371b4d2c2d2@kernel.crashing.org>
In-Reply-To: <3a8c70b34f2ef98fb696c371b4d2c2d2@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>>>             interrupt-map = <8000 0 0 1 500 1 1 3 // e100, 10.0
>>>>                              8000 0 0 2 500 1 1 3
>>>>                              8000 0 0 3 500 1 1 3
>>>>                              8000 0 0 4 500 1 1 3
>>>
>>> 8000 is device 16, not 10
> 
> <snip>
> 
>> I got the address 8000 here. Is the
>> pdev->bus->number actually supposed to be 10 for device 10? I had some
>> trouble tracking down how the bus number is initialized. It might be
>> nice if you or some one could give me a hint on this.
> 
> 8000 is device 16 is 0x10 hex.  PCI device numbers are
> usually written in decimal.  Is your device 10 == 0x0a
> or 16 == 0x10?

I took the number 10 out of the sysfs bus entry. As they are printed as
%x there. The 10 is a 0x10 = 16. Hence 8000 seemed to be OK then. How is
this actually supposed to be calculated? (As you can see, I know only
little about pci stuffs) As I wrote in the last mail. The addr is
calculated by the parser with
laddr[0] = (pdev->bus->number << 16) | (pdev->devfn << 8)
Since we have only one pci bus here, I suppose the bus number should be
0. However I'm wondering about what does this devfn stands for?

I now finally made some processes. I made a really stupid failure and
put the pci bus in 66 MhZ, the USB controller doesn't like it at all and
went dow the hill.... Now I run the pci bus with 33MhZ and the USB
controller is working all fine now. However I still get troubles with
the intel gd82551t ethernet controller. I connected it to the network
and generated some activities, I even saw the phy blinking. The watchdog
also works properly and reports link status. However the controller just
won't generate or receive any interrupts. Both the Becker Driver and the
intel driver just won't work.

I tried the irqpoll option in the kernel command line, which also didn't
help. Seemed that the no interrupts is coming through at all, which is
really strange since the controller seemed to be corretly configured.

I noticed that the L1 information are different for the ethernet and usb
controllers according to /proc/interrupts. for eth1 it says Main and for
usb it says IRQ[0-3], might this be the reason of my problem?

root@testboard:~ cat /proc/interrupts
           CPU0
 64:          0  MPC52xx Main Edge      eth1
 65:          2   MPC52xx IRQ[0-3]  Edge      ehci_hcd:usb1,
ohci_hcd:usb2, ohci_hcd:usb3
129:        903  MPC52xx Peripherals Edge      mpc52xx_psc_uart
133:          7  MPC52xx Peripherals Edge      mpc52xx-fec_ctrl
145:          0  MPC52xx Peripherals Edge      can0
146:          0  MPC52xx Peripherals Edge      can1
192:       4004  MPC52xx SDMA Edge      mpc52xx-fec_rx
193:       3343  MPC52xx SDMA Edge      mpc52xx-fec_tx
BAD:          0

The interrupt pin of the ethernet controller is connected to irq0 pin of
the MPC5200B while the interrupt pin of the usb controller is connected
to irq1 of the MPC5200B. Since the usb has 65 and is working, I suppose
strongly that 64 for the ethernet controller should also be correct.

The pci node of my the device tree now looks like this:

pci@0d00 {
	#interrupt-cells = <1>;
	#size-cells = <2>;
	#address-cells = <3>;
	device_type = "pci";
	compatible = "mpc5200b-pci\0mpc5200-pci";
	reg = <d00 100>;
	interrupt-map-mask = <f800 0 0 7>;
	interrupt-map = <8000 0 0 1 500 1 0 3 // e100, 10.0               			
8000 0 0 2 500 1 1 3
			 8000 0 0 3 500 1 2 3
			 8000 0 0 4 500 1 3 3

			 8800 0 0 1 500 1 1 3 // usb 11.*
			 8800 0 0 2 500 1 2 3
			 8800 0 0 3 500 1 3 3
			 8800 0 0 4 500 0 0 3>;
	clock-frequency = <0>; // From boot loader
	interrupts = <2 8 0 2 9 0 2 a 0>;
	interrupt-parent = <500>;
	bus-range = <0 0>;
	ranges = <42000000 0 80000000 80000000 0 20000000
		  02000000 0 a0000000 a0000000 0 10000000
		  01000000 0 00000000 b0000000 0 01000000>;
};

Like I mentioned before. I quite did not get the idea of all the open
firmware things. I'd be very appreciate if you could take a near look on
this and tell me if you see anything wrong with this node.

Thanx a lot
cheers
Luotao Fu
