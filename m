Message-ID: <002f01c0dd5c$f64942e0$7a00000a@roma.quadrics.com>
Reply-To: "Amelia De Vivo" <amelia.devivo@roma.quadrics.com>
From: "Amelia De Vivo" <amelia@roma.quadrics.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Addressing PCI memory
Date: Tue, 15 May 2001 18:34:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all, I'm trying to write a driver for a 64 bit PCI device. Something like
this works well under i386 Linux, but it doesn't work at all for Linux
2.2.15 by Yellow Dog:

    struct pci_dev *dev = NULL;
    dev = pci_find_device(vendor, device, dev);
    pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &cards[0].addr0);
    cards[0].vaddr = (void *) ioremap((cards[0].addr0 &
PCI_BASE_ADDRESS_MEM_MASK), cards[0].size);
    writeb('A',(cards[0].vaddr)+0x1000);

I have a kernel panic on writeb. Has someone some suggestion?
Thanks in advance

Amelia


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
