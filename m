Date: Wed, 12 Apr 2000 09:45:39 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Prep interrupt routing (carolina-type board)
In-Reply-To: <38F3C93A.5BEDC95F@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10004120939260.4369-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Apr 2000, David Monro wrote:

>
> Hi all,
>
>
> Does anybody know for sure if the ibm8xx_pci_IRQ_map structure in
> prep_pci.c is correct? I'm trying to use an ncr53c825 board in one of
> the PCI slots, and I'm getting the exact symptoms I used to get on my
> intel box when the PCI bios screwed up and assigned the wrong irq to it
> (it goes into an endless loop:
>
> scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
> lun 0 Te
> st Unit Ready 00 00 00 00 00
> ncr53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
>
>
> etc...)
>
> Should the PCI interrupts turn up in the residual data in one of these
> boards?


Yes, residual data gives you even the rouuting of interrupts for empty
slots. The code to find them is in my patches and looks like:

static inline void fixup_pci_interrupts(PnP_TAG_PACKET *pkt) {
#define data pkt->L4_Pack.L4_Data.L4_PPCPack.PPCData
        u_int bus = data[16];
        u_char *End, *p;

        End = data + ld_le16((u_short *)(&pkt->L4_Pack.Count0)) - 1;
        for (p=data+20; p<End; p+=12){
                struct pci_dev *dev;
                pci_for_each_dev(dev) {
                        unsigned code, irq;
                        u_char pin;

                        if ( dev->bus->number != bus ||
                             PCI_SLOT(dev->devfn) != PCI_SLOT(p[1]))
                                continue;
                        pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin);
                        if(!pin) continue;
                        code=ld_le16((unsigned short *)
                                    (p+4+2*(pin-1)));
                        /* Set vector to 0 for unrouted PCI ints. This code
                         * is ugly but handles correctly the special case of
                         * interrupt 0 (8259 cascade) on OpenPIC
                         */
                        irq = (code == 0xffff) ? 0 : code&0x7fff;
                        if (p[2] == 2) { /* OpenPIC */
                                if (irq) {
                                        openpic_set_sense(irq, code<0x8000);
                                        irq=openpic_to_irq(irq);
                                } else continue;
                        } else if (p[2] != 1){ /* Not 8259 */
                                printk("Unknown or unsupported "
                                       "interrupt controller"
                                       "type %d.\n",  p[2]);
                                continue;
                        }
                        dev->irq=irq;
                }

        }
#undef data
}

and later:

        /*
         * The residual data about the bridges gives the interrupt
         * routing (admittedly in an awkward way). I would like
         * to have a PCI<->PCI bridge to see what happens.
         * (Apparently it works on the only test case I've got
         * report on).
         *  -- Gabriel
         */
        i = 0;
        while ((Bridge = residual_find_device(-1, NULL,
                                              BridgeController,
                                              PCIBridge, -1, i++))) {
                PnP_TAG_PACKET *pkt;
                pkt = PnP_find_large_vendor_packet
                  (res->DevicePnPHeap+Bridge->AllocatedOffset, 3, 0);
                if (!pkt) continue;
                printk("Setting bridge %d\n", i-1);
                fixup_pci_interrupts(pkt);
        }


that's not very simple but it seems to work (you might still get the wrong
edge/level setting for i8259 interrupts however).


	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
