From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.18p19
Date: Sat, 4 Nov 2000 05:20:34 +0100
Message-Id: <19340928215218.14436@192.168.1.10>
In-Reply-To: <3A037737.2B131815@denise.shiny.it>
References: <3A037737.2B131815@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Ok, I've just tried 2.2.18p19 tree from linuxcare. At the end of the make
>process, after vmlinux has been created, it complains:
>
>
>ld -T ../vmlinux.lds -Ttext 0x00800000 -o zvmlinux.tmp head.o misc.o
>../coffboot/zlib.o vreset.o kbd.o of1275.o
>vreset.o: In function `vga_init':
>vreset.o(.text+0x3c2): undefined reference to `loops_per_jiffy'
>vreset.o(.text+0x3c6): undefined reference to `loops_per_jiffy'

I fixed that in the bitkeeper _2_2 tree, looks like Paulus don't have the
fix. You should not really care since you probably don't need the zImage.
The fix is easy, repalce the definition of loops_per_sec by
loops_per_jiffy in arch/ppc/boot/vreset.c and divide the value by HZ (100).

>Same thing with the official 2.2.18p19.
>
>I first tried USB-HIDBP and it freezes at boot. Less a second after the
>mouse is turned on, it lights off and all freezes. 2.2.16p hadn't this
>problem. USB-HID works fine.
>My IDE CDROM is now /dev/hda instead hde. The ZIP is hdb instead of hdf.
>
>I'm now trying to d/l the bk tree. rsync connection refused :-(

Hrm.... remind me your hardware ? I'll update my rsync tree from the
latest _2_2 tomorrow, I don't know it Paul's linux-pmac-stable is up-to-
date with bk _2_2.

Also, I don't think the boot protocol USB drivers will do any good for
you, especially if you use ADB-like keymaps. You should probably use the
HID drivers, as those were well tested on macs.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
