In-Reply-To: <Pine.HPX.4.10.10002081020040.1866-100000@gra-ux1.iram.es>
Date: Tue, 8 Feb 2000 15:56:37 +0100
To: Gabriel Paubert <paubert@iram.es>
CC: linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] Retrace
Message-Id: <20000208155637.001939@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 8, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>On x86 you have /dev/port which is disabled on PPC. I once or twice
>suggested (but was greeted with a deafening silence) that we could
>resurrect it and add an mmap method so that privileged programs may access
>I/O ports with:
>
>	io_fd= open("/dev/port", O_RDWR);
>	iobase=mmap(0, device_size, PROT_READ|PROT_WRITE, MAP_SHARED,
>			io_fd, device_base);
>
>
>> Unfortunately, with weird host bridges like Apple Uni-N (that has 3
>> busses with 3 different io bases but the same bus number), it's almost
>> impossible to get it correct, or eventually by parsing /proc/device-tree.
>
>Not a problem if device_base is unique, you have to check that
>device_base+device_size fits within one area. It must be unique at one
>point to distinguish them from the processor perspective.

device_base may not be unique. Actually, that depends what is device_base
and how it's retreived. But for example, reading the BARs can give you
identical io base for devices on different sub-bridges, the distinction
beeing done by the iobase of the bridge itself.

The fact is that macos don't care, since it's completely based on the
device-tree, MacOS-drivers call in/out functions that use the base
address of the parent bridge.

I have in mind the possibility of defining fake bridges in the kernel to
work around the Uni-N problem as a whole, but this leads to a bunch of
other problems (like desynchro with the device-tree, which can be
annoying for other things) and I'm not familiar enough with 2.3.x PCI
layer yet.

What's the usual method used by X-like apps to get the base of a device ?
/proc/pci ?

We could also have /proc/pci export "fixed" bases that already take into
account the iobase of the bridge.

We are in a realm where I lack experience with Linux to be able to tell
which solution is better (and have more chances of beeing accepted ;)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
