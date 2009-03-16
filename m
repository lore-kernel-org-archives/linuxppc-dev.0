Return-Path: <thunderbird2k@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 8606FDDFA4
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 19:18:57 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 16 Mar 2009 09:18:54 +0100
From: "Roderick Colenbrander" <thunderbird2k@gmx.net>
In-Reply-To: <20090315104313.72510@gmx.net>
Message-ID: <20090316081854.215310@gmx.net>
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


-------- Original-Nachricht --------
> Datum: Sun, 15 Mar 2009 11:43:13 +0100
> Von: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> An: "Roderick Colenbrander" <thunderbird2k@gmx.net>, linuxppc-dev@ozlabs.org
> Betreff: Re: DTS file PCI / i8259 for Xilinx ML510

> 
> -------- Original-Nachricht --------
> > Datum: Sun, 15 Mar 2009 09:38:26 +0100
> > Von: "Roderick Colenbrander" <thunderbird2k@gmx.net>
> > An: "Gerhard Pircher" <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> > Betreff: Re: DTS file PCI / i8259 for Xilinx ML510
> 
> > > > At some point in the file they create some (dummy?) pcie section in
> > > > which they define a uli1575, an isa bus and attached to that isa bus
> > > > a i8259. Is this the correct way of doing things? The i8259 driver
> > > > seems to use io ports 0x20-21/0xa0-0xa1/0x4d0-0x4d1 those are also
> > > > defined below but how are those mapped to the south bridge? I have
> > > > seen some code in kernel/isa-bridge, is that code indeed responsible
> > > > for setting up these ports?
> > > Yes, the pcie node is the PCI host bridge node and the uli1571 node
> > > acts as PCI2ISA bridge node. AFAIK their ranges properties are parsed
> > > by pci_process_bridge_OF_ranges().
> > > IIRC the code in kernel/isa-bridge is used for 64bit PPC machines only
> > > for now. The I/O addresses for the i8259 PIC are currently hardcoded
> > > and setup (request_resource()) in sysdev/i8259.c.
> > 
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
> > As far as I have seen it is only needed for i8259 interrupt controllers.
> > Personally I think it would be better to pass a io base offset to
> > i8259_setup or so. Or perhaps do some dts file parsing in i8259.c.
> > I'm not sure what the proper layout would be for this in the dts file
> > though.
> I think adding an io base offset parameter to i8259_setup isn't the
> right way to do it. I would expect other problems too, if ISA I/O space
> isn't mapped 1:1 to PCI I/O space on a PPC32 system. Maybe a more
> experienced kernel developer can comment on this?

I'm now back behind my ML510 board and have been doing some tests. As I mentioned before I was doing inb(isa_io_base + port) / outb(val, isa_io_base + port) which worked fine. As far as I see it the problem is the definition of inb/outb on ppc32 they don't take isa_io_base into account. They are:
__do_in_asm(_rec_inb, "lbzx")
__do_out_asm(_rec_outb, "stbx")
#define __do_outb(val, port)    _rec_outb(val, port)
#define __do_inb(port)          _rec_inb(port)

While on 64-bit ppc they are:
#define __do_outb(val, port)    writeb(val,(PCI_IO_ADDR)_IO_BASE+port);
#define __do_inb(port)          readb((PCI_IO_ADDR)_IO_BASE + port);

(On ppc32 _IO_BASE is isa_io_base but on 64-bit it is set to pci_io_base)

Am I correct that inb/outb are broken on ppc32? If so what is the right way to fix them?

Regards,
Roderick
-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger01
