Message-ID: <38CBD2E8.B19C67B@amberdata.demon.co.uk>
Date: Sun, 12 Mar 2000 17:24:56 +0000
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.50+vlab mvme bootload
References: <Pine.HPX.4.10.10003111820070.22162-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Sat, 11 Mar 2000, David Monro wrote:
>
> > Hi.
> >
> > I've had a shot at booting using your prep bootloader - grabbed the
> > patch from vlab and dropped it into the bitkeeper 2.3.50 tree. The patch
> > went in cleanly and the build suceeded.
> >
> > However it behaves in a strange way. I've only managed to make it
> > produce any output at all once, and I still don't know what I did to
> > make it boot that time. Normally it simply sits there and then
> > eventually goes beep and reboots. Below is the output from the one time
> > I got any:
> >
> > Keyboard error 2, using serial console!
>
> Normal, the bootloaderr switches automaticaly to serial console when it
> does not find a display _and_ a connected keyboard.

Yes but the funny thing is, the run where I got output was when I had
the keyboard plugged in. Even unplugging the keyboard didn't get me any
messages agin. I will have to hack it to always use serial console for
now (the '850 has built in video etc).

[pci data, looks OK, removed]

> >
> > Linux/PPC load: console=ttyS0 root=/dev/hda5 hda=3079,64,32 hdc=swapdata
> > -b
> >
> > Uncompressing the kernel...done
> > Now building bootinfo...
> > done
> > Now booting...
> > Kernel at 0x00000000, size=0x204024
> > Initrd at 0x09ff8af8, size=0x0
> > Boot info 0x00205000, size=0x78
> > Residual data at 0x00206000
>
> Now the following is strange:
>
> > loaded at:     00358050 0036EE70
> > relocated to:  00800000 00816E20
> > board data at: 00121FE0 001289EC
> > relocated to:  00810314 00816D20
> > zimage at:     00363050 003F0DD0
> > relocated to:  00817000 008A4D80
> > avail ram:     00400000 00800000

Oops, I cut and pasted too much - this the beginning of the bootloader
messages from the next time I booted. Sorry about that...
>
> these are the messages from the oter bootloader as if it were nested or
> something strange. Here is what I get on my machines:
> Calling the emulator.
> ROM enabled @fc6b0000
>
> Linux/PPC load: console=ttyS0
>
> Uncompressing the kernel...done
> Now building bootinfo...
> done
> Now booting...
> Kernel at 0x00000000, size=0x1e72c4
> Initrd at 0x00eca000, size=0x0
> Boot info 0x001e8000, size=0x4c
> Residual data at 0x001e9000

Mine stops here; I never get to the next line.

> PReP architecture
> Total memory = 16MB; using 0kB for hash table (at 00000000)
> Linux version 2.3.50 (root@vdevel) (gcc version 2.95.2 19991024 (release/franzo)
> ) #11 Thu Mar 9 12:09:21 CET 2000
> Boot arguments: console=ttyS0
>
> > and then it sat there for a while, then went beep and rebooted.
>
> I don't understand how you got this, but did I mention how to use prepboot
> or not ?
>
> select CONFIG_EXPERIMENTAL to make CONFIG_PREPBOOT available. Then take
> the zImage in arch/ppc/prepboot prodiced by make zImage. it can be dd'ed
> onto a 0x41 type partition or netbooted if your netboot provides residual
> data.

I did the above, and dd'd it onto a floppy which seems to work just fine
for other kernels.

I've just rebuilt it to ignore the keyboard and vga, and the bootloader
now prints on the serial port again. But I never get past the following:

Linux/PPC load: console=ttyS0 root=/dev/fd0 load_ramdisk=1

Uncompressing the kernel...done
Now building bootinfo...
done
Now booting...
Kernel at 0x00000000, size=0x204024
Initrd at 0x09ff8918, size=0x0
Boot info 0x00205000, size=0x68
Residual data at 0x00206000


Cheers,
	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
