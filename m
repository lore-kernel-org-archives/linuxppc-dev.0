Date: Tue, 14 Mar 2000 11:08:24 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.50+vlab mvme bootload
In-Reply-To: <38CBD2E8.B19C67B@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10003131254080.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 12 Mar 2000, David Monro wrote:

> Yes but the funny thing is, the run where I got output was when I had
> the keyboard plugged in. Even unplugging the keyboard didn't get me any
> messages agin. I will have to hack it to always use serial console for
> now (the '850 has built in video etc).

Ok, maybe your keyboard controller behaves differently. These beasts are
so weird.

> Oops, I cut and pasted too much - this the beginning of the bootloader
> messages from the next time I booted. Sorry about that...

Ok...

> Mine stops here; I never get to the next line.

That's very unfortunate, this is the most difficult to debug transition
period. As soon as you get a single kernel message,  everything is often
right. Maybe I've busted interrupt controller code on yur machine...

> > I don't understand how you got this, but did I mention how to use prepboot
> > or not ?
> >
> > select CONFIG_EXPERIMENTAL to make CONFIG_PREPBOOT available. Then take
> > the zImage in arch/ppc/prepboot prodiced by make zImage. it can be dd'ed
> > onto a 0x41 type partition or netbooted if your netboot provides residual
> > data.
>
> I did the above, and dd'd it onto a floppy which seems to work just fine
> for other kernels.
>
> I've just rebuilt it to ignore the keyboard and vga, and the bootloader
> now prints on the serial port again. But I never get past the following:
>
> Linux/PPC load: console=ttyS0 root=/dev/fd0 load_ramdisk=1

Did you try witout load_ramdisk ? The strange thing in any case is that
you don't get any message. Try with console=ttyS0 only just in case, but I
suspect sommething else which is probably very stupid like a mismatch
between bootloader and kernel about parameter passing or so but hard to
track from here :-(

When I had this kind or problems, I usually added code to send a single
char to the serial port and looked where it stopped in head.S. If the
video is in text mode this can also be done by writing chars to the
screen. But the kernel at least has to reach the point where BATs are
loaded...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
