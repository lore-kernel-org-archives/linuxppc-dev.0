In-Reply-To: <v04011700b301bd4f1962@[206.173.232.34]>
Date: Wed, 3 Mar 1999 12:24:25 +0100
To: "Randall R. Schulz" <rrschulz@cris.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Offer of Work on Blue G3 Port
Message-Id: <19990303122425.018576@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 2, 1999, Randall R. Schulz <rrschulz@cris.com> wrote:

>So, to get to the real point of this message, I'm wondering if I might make
>a meaningful contribution to the porting efforts. I have extensive
>experience in UNIX kernel and system programming, though it is a bit dated
>now and I've never worked on Linux internals per se.
>
>My questions are these:
>
>- Is there a need for help on this port?

Yep !

>- What is a meaningful commitment of time?
>- If I decide I can make the committment, how do I go about doing so?

You already posted in the proper mailing list.

So first, you need a way to compile kernels. Either another PPC machines,
or another linux machine with PPC cross-compilers.

Once you have that, grab the kernel source tree. I suggest using Paul
Mackerras rsync tree with iMac (usbd) support:

rsync -avz samba.anu.edu.au::linux-pmac-devel

Then, begin fixing.

Some tips (note that I don't have one of those machines) :

- Use BootX with "no video driver". There is currently no driver for the
ATI 128 chip. Use the latest (1.0.2b4) version of bootx, it will work
better with those new machines.

- Get the "core" OS to work: mainly the setup of the PCI bridges and
interrupt controller. The first bridge is the same Grackle used in
earlier machines, probably configured the same way the iMac is, so this
should not be an issue. The main difference is that it's overclocked to
66MHz. Then, you'll need to identify and get the second PCI bridge to
work, and make sure it's properly initialized by the kernel.

- The pmac-specific stuffs (interrupt control, VIAs, ADB, etc...) are
handled by the almost-identical paddington ASIC used in the iMac, which
itself is very similar to the Heathrow and OHare used in previous Macs.
By precaution, I suggest you begin with a kernel with almost no drivers
and re-include drivers one by one to make sure Apple did't break
anything. Note that the "big" difference with other machines is that the
ASIC is behind the second PCI bridge, which must be correctly configured.
The consequence is that missing eieio() or reads to flush the PCI path
will cause more trouble than they did before.

- Then, get the fast IDE to work. This should not be an issue since it
seems to be a standard chip (a winbond ?). it's PCI vendorID/deviceID is
0x1095/0x0646 (PCI_VENDOR_ID_CMD/PCI_DEVICE_ID_CMD_646 according to linux
pci.h). This chip seems to be already supported by the ide-pci driver,
You'll just have to make sure it's correctly probed.

- The second PCI bridge is a DEC 21154, (vendorID/deviceID:
0x1011/0x0026). The linux pci.h file stops at device 0x0025 (21153), you
may have to add support for it, but I don't think it's very complex. (Not
that I didn't try to get docs for this chip yet).

- The USB controller has a vendorID/deviceID of 0x1045/0xc861, it's
apparently an OHCI controller 82C861 and is apparently already handled by
usbd.


Ok, that's all for now, feel free to ask more questions.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
