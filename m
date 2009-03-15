Return-Path: <thunderbird2k@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 74016DE08A
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 19:38:29 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 15 Mar 2009 09:38:26 +0100
From: "Roderick Colenbrander" <thunderbird2k@gmx.net>
In-Reply-To: <20090314215439.8080@gmx.net>
Message-ID: <20090315083826.302680@gmx.net>
MIME-Version: 1.0
References: <20090312103219.228100@gmx.net> <20090314215439.8080@gmx.net>
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


> > At some point in the file they create some (dummy?) pcie section in
> > which they define a uli1575, an isa bus and attached to that isa bus a
> > i8259. Is this the correct way of doing things? The i8259 driver seems
> > to use io ports 0x20-21/0xa0-0xa1/0x4d0-0x4d1 those are also defined
> > below but how are those mapped to the south bridge? I have seen some
> > code in kernel/isa-bridge, is that code indeed responsible for setting
> > up these ports?
> Yes, the pcie node is the PCI host bridge node and the uli1571 node acts
> as PCI2ISA bridge node. AFAIK their ranges properties are parsed by
> pci_process_bridge_OF_ranges().
> IIRC the code in kernel/isa-bridge is used for 64bit PPC machines only
> for now. The I/O addresses for the i8259 PIC are currently hardcoded and
> setup (request_resource()) in sysdev/i8259.c.

I got the i8259 south bridge working now after adding an io_base_virt offset to all inb/outb lines in sysdev/i8259.c. Would it be worth all the troubles to add ppc32 support to isa-bridge.c? The whole point of the code is basically to remap the io memory to low addresses for these 64-bit ppc systems (mainly freescale boards with a i8259 and pseries systems with a i8259). As far as I have seen it is only needed for i8259 interrupt controllers. Personally I think it would be better to pass a io base offset to i8259_setup or so. Or perhaps do some dts file parsing in i8259.c. I'm not sure what the proper layout would be for this in the dts file though.

With those changes I mentioned to i8259.c I got some PCI devices of my ali m1553 south bridge working. The code is ugly and I need to do cleanups. When it is done I will submit some patches.

Regards,
Roderick Colenbrander
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger01
