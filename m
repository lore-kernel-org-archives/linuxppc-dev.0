Date: Tue, 8 Feb 2000 10:29:59 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Retrace
In-Reply-To: <20000207200203.007111@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10002081020040.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 7 Feb 2000, Benjamin Herrenschmidt wrote:

>
> On Mon, Feb 7, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> >And now the bad news: the address you have to mmap() depends on the machine
> >type :-(
>
> We need to find a solution for that one day or another. The iobase is not
> only arch-dependant (PReP, PowerMac, CHRP...) but also machine dependant,
> since it depends on the host bridge type.

On x86 you have /dev/port which is disabled on PPC. I once or twice
suggested (but was greeted with a deafening silence) that we could
resurrect it and add an mmap method so that privileged programs may access
I/O ports with:

	io_fd= open("/dev/port", O_RDWR);
	iobase=mmap(0, device_size, PROT_READ|PROT_WRITE, MAP_SHARED,
			io_fd, device_base);


> Unfortunately, with weird host bridges like Apple Uni-N (that has 3
> busses with 3 different io bases but the same bus number), it's almost
> impossible to get it correct, or eventually by parsing /proc/device-tree.

Not a problem if device_base is unique, you have to check that
device_base+device_size fits within one area. It must be unique at one
point to distinguish them from the processor perspective.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
