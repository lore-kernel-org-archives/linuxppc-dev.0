Message-ID: <20030815123316.97767.qmail@web40410.mail.yahoo.com>
Date: Fri, 15 Aug 2003 05:33:16 -0700 (PDT)
From: Todd <to_dd@yahoo.com>
Subject: basic "pci_dev / pci_any_id" questions
To: linux <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



hello,

I am working at building a PCI device driver and have
some very basic questions regarding the pci_dev
structure.
Q1.
I have included a segment of my code below. I can
successfully enable PCI devices in my system. When I
read the device information from the configuration
space, which I get in the following way:
pci_read_config_word(dev,PCI_INTERRUPT_LINE,
&interruptLine);
the data is correct, but the values in the pci_dev
structure, such as dev->irq are not populated with the
same information.
I am resorting to probing the configuration space,
like so:
pci_read_config_word(dev,PCI_STATUS, &status);
MSG("Status = (%x)\n",status);
pci_read_config_word(dev,PCI_COMMAND,&command);
MSG("Command = (%x)\n",command);
I can't determine why the pci_dev structure which dev
points to is not populated with the correct device
information.

Q2.
I am unable to use the wildcard PCI_ANY_ID to search
for devices from the same vendor. I have also tried
%PCI_ANY_ID, which I have also seen used, but no luck.
Is there a similar wildcard for searching through all
vendor_ids?

thanks in advance,
Todd

struct pci_dev *dev = NULL;
while ((dev =
pci_find_device(PCI_VENDOR_ID_CREATIVE,0x0006,dev)))
{
if (pci_setup_device(dev) == 0) //returns 0 in success
/ -1 if unknown type of device
  MSG("known device...\n");
if (pci_setup_device(dev) == 0)
  MSG("device setup...\n");
if (pci_enable_device(dev) == 0)
  MSG("device enabled successfully !!\n");
pci_read_config_word(dev,PCI_VENDOR_ID, &subvendor);
pci_read_config_word(dev,PCI_DEVICE_ID, &subdevice);
pci_read_config_word(dev,PCI_INTERRUPT_LINE,
&interruptLine);
MSG("IRQ = (%x)\n",interruptLine); //gives correct
value
MSG("IRQ = %x\n",dev->irq); //gives incorrect value
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
