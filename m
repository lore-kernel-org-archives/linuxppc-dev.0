From: Benjamin Herrenschmidt <bh40@calva.net>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>,
        LinuxPPC-Dev
 Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FireWire on Apple PowerBook PISMO
Date: Thu, 11 May 2000 14:54:21 +0200
Message-Id: <20000511125422.13794@mailhost.mipsys.com>
In-Reply-To: <3912AE0C.9C8D096B@mpifr-bonn.mpg.de>
References: <3912AE0C.9C8D096B@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 5, 2000, Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de> wrote:

>With the information from some people on the LinuxPPC list, I was able
to talk
>to the FireWire OHCI controller in the new Apple PowerBook (PISMO).  I had to
>add the vendor/device id of the chip and (as usual, as OpenFirmware does
>not do
>it) add a few lines to enable the pci device.  The "basic" startup seems to
>work, but any further operation (e.g. testlibraw) hangs.  Maybe one of the FW
>gurus can tell me from the logs below what is missing?

OF does it, but will undo it when "quiesce" is called (like for the USB
controllers). This is a safety to make sure the chip is no longer bus
mastering when the OS relocates itself.

A strange thing is that the address 0xf5000000 looks more like an IO
region than a memory region, but this may not be a problem actually. (the
cell is inside the north bridge which has a weird PCI management.

It's possible that, like the GMAC ethernet (which is also inside Apple
ASIC), the device clock need to be enabled in the memory controller. You
can try to look at OF methods for it to see what's up.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
