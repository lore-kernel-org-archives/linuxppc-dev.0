Return-Path: <thunderbird2k@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 61CADDE089
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 22:00:18 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 15 Mar 2009 12:00:17 +0100
From: "Roderick Colenbrander" <thunderbird2k@gmx.net>
In-Reply-To: <20090315104313.72510@gmx.net>
Message-ID: <20090315110017.202010@gmx.net>
MIME-Version: 1.0
References: <20090312103219.228100@gmx.net> <20090314215439.8080@gmx.net>
	<20090315083826.302680@gmx.net> <20090315104313.72510@gmx.net>
Subject: Re: DTS file PCI / i8259 for Xilinx ML510
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > I got the i8259 south bridge working now after adding an io_base_virt
> > offset to all inb/outb lines in sysdev/i8259.c. Would it be worth all
> > the troubles to add ppc32 support to isa-bridge.c? The whole point of
> > the code is basically to remap the io memory to low addresses for these
> > 64-bit ppc systems (mainly freescale boards with a i8259 and pseries
> > systems with a i8259).
> pci_process_bridge_OF_ranges() should "ioremap" io_base_virt for you,
> if your board has only one PCI I/O space. It also sets isa_io_base to
> io_base_virt on PPC32, but expects that the ISA I/O space is mapped to
> PCI I/O address 0x0. Isn't that the case for your board?
> 

Ah then perhaps that is my problem. I'm using my own pci implementation for Xilinx their plbv46 soft core. The soft core might be compatible with a generic ibm plb-pci bridge (sysdev/ppc44x_pci.c). Basically I'm doing something like which is done in powermac/pci.c e.g. creating the pci_controller and filling it with cfg_addr / cfg_data pointers, io ranges, resource ranges and so on. The data is obtained from the dts file but from some xilinx generated fields and doesn't have the generic ranges fields and some others. I guess it is time to fix this part of the DTS file.

Some other issue I had which might be related to my DTS file bugs is some i/o port conflict. The M1553 south bridge is just a peripheral on the ML510 primary pci bus there are no PCI slots connected to it. There are four other pci slots of which two are directly connected to the fpga (they are on the same bus as the M1553) and two are connected using a pci-to-pci bridge because they use 5V instead of 3.3V. The bridge chip wanted 0x0-0xfff while some south bridge devices wanted low addresses (if I remember correctly the IDE controller wants 0x1f0-0x1f1 and some 0x3** ports). This generated some "Cannot allocate resource region .. will remap" messages from kernel/pci-common.c. This remapping didn't happen. Should a proper DTS file prevent this issue? If not where is the remapping done (I didn't see it). For that reason I'm ignoring the pci-to-pci bridge for now.

Thanks,
Roderick Colenbrander
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger01
