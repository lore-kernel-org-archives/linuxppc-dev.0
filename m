Date: Thu, 20 Jul 2000 08:13:06 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Sacha Varma <sacha@ssl.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI compatibility
In-Reply-To: <39770DCD.B7F1C6FE@ssl.co.uk>
Message-ID: <Pine.LNX.4.10.10007200804160.22316-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Jul 2000, Sacha Varma wrote:

> So... does this mean that as far as hardware is concerned there is nothing to prevent me from using any old PCI graphics card in a (non-AGP?) mac so long as linux has drivers for it?

Correct, there is nothing preventing any PCI graphics device from working
in linux unless there is something extremely fundamentally wrong with it
(like relying on PC BIOS too much, but that is very rare)

>From personal experience, I have the following "PC" graphics cards working
on my PowerMac:  CirrusLogic 5340, Trident Image3D 975, S3 Savage4, S3
Vision968, and a 3dfx banshee.  Yes, I'm a video card junkie.


>
> Where in the kernel source is the bit where it initialises the display (is this a per-host-architecture thing, per-video-chipset thing, or a generic PCI thing)?
>

you can enable it by:  (pdev is the struct pci_dev pointer to your device)

u16 tmp;

pci_read_config_word(pdev, PCI_COMMAND, &tmp);
if (!(tmp & PCI_COMMAND_MEMORY)) {
	tmp |= PCI_COMMAND_MEMORY;
	pci_write_config_word(pdev, PCI_COMMAND, tmp);
}

and same for PCI_COMMAND_IO instead of PCI_COMMAND_MEMORY

you do this before any IO/mem access to the device.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
