Message-Id: <9912040050.AA54380@marc.watson.ibm.com>
To: "David W. Patmore" <dwp@bluesteelnet.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Update: RE: G4 + Linux + PCI device + x86 driver = 0 
In-Reply-To: Message from "David W. Patmore" <dwp@bluesteelnet.com>
   of "Fri, 03 Dec 1999 15:00:13 PST." <NDBBKOPFGLPEGICBJFDIOEDCCDAA.dwp@bluesteelnet.com>
Date: Fri, 03 Dec 1999 19:50:05 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "David W Patmore" writes:

avid> 1.  I had to enable memory writes (PCI_COMMAND_MEMORY), which was somehow
David> handled automataically on x86, but not here.
David> {
David> pci_read_config_word( pDev, PCI_COMMAND, &value );
David> value |= PCI_COMMAND_MEMORY;
David> pci_write_config_word( pDev, PCI_COMMAND, value );
David> }
David> For good measure, I also set PCI_COMMAND_MASTER, though I also call
David> pci_set_master(), which covers the issue.

	It is up to the device driver or the card to set all of these bits
if necessary.

David> 2.  I had to byte-swap all pointers that I supply to my device.  For
David> portability, I made a set of macros, "SYS_TO_LE() and LE_TO_SYS(), etc. so
David> that both endian architectures could work out.

	Linux already provides macros like le16_to_cpu(), etc. for this. 

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
