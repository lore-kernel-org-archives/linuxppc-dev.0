Message-ID: <40B4575A.5030801@fh-landshut.de>
Date: Wed, 26 May 2004 10:37:46 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Memory layout question]
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Maybe the following logic for getting proper PCI addresses would work:

1.) Use stuff like pci_module_init() to find and register the Universe
device (using standard PCI functions to find the Tundra device).
2.) Determine its PCI bus from the pci_dev structure.
3.) Use the resource[] vector associated with that bus to request a set
of PCI addresses on that bus.

This should be portable and clean, and always return a set of proper PCI
addresses usable by the Tundra Universe, at least AFAIK from looking at
include/linux/pci.h and drivers/pci/pci.c.

Since you already use the PCI configuration word mechanism and device
IDs this shouldn't be too hard to adapt to.

What do you think?

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
