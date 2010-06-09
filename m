Return-Path: <martyn.welch@ge.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7F2B1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 00:37:52 +1000 (EST)
Message-ID: <4C0FA73B.4070905@ge.com>
Date: Wed, 09 Jun 2010 15:37:47 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: CPM UART on MPC8270
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I'm attempting to get an SCC port on an MPC8270 working with Linux. I'm
not overly familiar with the CPM and am having a bit of trouble.

Linux is booting natively on the 8270. I have access to the 8270 via a
set of PCI windows from a second core (includes one setup over the main
memory and one over the IMMR) and SMC1 is up and working with a console.

The SCCs seem to be detected correctly at boot:

f011a80.serial: ttyCPM0 at MMIO 0xc3014a80 (irq = 16) is a CPM UART
f011a00.serial: ttyCPM1 at MMIO 0xc3018a00 (irq = 40) is a CPM UART
f011a20.serial: ttyCPM2 at MMIO 0xc3020a20 (irq = 41) is a CPM UART
f011a40.serial: ttyCPM3 at MMIO 0xc3028a40 (irq = 42) is a CPM UART

With the DTS reading:

                        smc1: serial@11a80 {
                                device_type = "serial";
                                compatible = "fsl,mpc8270-smc-uart",
                                             "fsl,cpm2-smc-uart";
                                reg = <0x11a80 0x20 0x87fc 2>;
                                interrupts = <4 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <7>;
                                fsl,cpm-command = <0x1d000000>;
                        };

                        scc1: serial@11a00 {
                                device_type = "serial";
                                compatible = "fsl,mpc8270-scc-uart",
                                             "fsl,cpm2-scc-uart";
                                reg = <0x11a00 0x20 0x8000 0x100>;
                                interrupts = <40 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <3>;
                                fsl,cpm-command = <0x800000>;
                        };

                        scc2: serial@11a20 {
                                device_type = "serial";
                                compatible = "fsl,mpc8270-scc-uart",
                                             "fsl,cpm2-scc-uart";
                                reg = <0x11a20 0x20 0x8100 0x100>;
                                interrupts = <41 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <6>;
                                fsl,cpm-command = <0x4a00000>;
                        };

                        scc3: serial@11a40 {
                                device_type = "serial";
                                compatible = "fsl,mpc8270-scc-uart",
                                             "fsl,cpm2-scc-uart";
                                reg = <0x11a40 0x20 0x8200 0x100>;
                                interrupts = <42 8>;
                                interrupt-parent = <&PIC>;
                                fsl,cpm-brg = <1>;
                                fsl,cpm-command = <0x8c00000>;
                        };

I believe that I have the pins setup correctly and the BRGs connected
correctly in the setup_arch function.

At the moment I have SCC3 wired out. If I attempt to echo data out of
the SCC (echo "Hello" > /dev/ttyCPM3) I get the prompt sits waiting.
Rebooting and turning on the debug yields the following output on the
console (but nothing out of the SCC port):

CPM uart[3]:startup
Interrupt attached
CPM uart[3]:set_termios
CPM uart[3]:start tx
CPM uart[3]:stop tx
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:stop rx
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:shutdown
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
CPM uart[3]:tx_empty: 0
...


It seemed to be waiting for ready bit of the Transmit Buffer Descriptor
to be cleared (which it never seems to be), prodding this bit through
the pci window did cause the process to continue, no data out but I did
get back to the prompt on the console.

I'm sure I'm just missing something really basic - can anyone enlighten me?

Martyn

-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
