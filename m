Date: Tue, 2 Feb 1999 10:47:38 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on MVME 2306 board
In-Reply-To: <3.0.6.32.19990202101943.007e4d30@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990202101833.16636J-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 2 Feb 1999, David De Ridder wrote:

> At 14:13 1-2-99 +0100, Gabriel Paubert wrote:
> 
> >At least simliar ones, I don't remember exactly what the 230x has. But as
> >long as it has a DEC21x4x Ethernet, there should not be any problem...
> 
>  It has a DEC21140 Ethernet controller (with RJ-45 plug) and a serial
>  interface (PC16550 UART).

Ok, I have a 21140 too. So it should work (I also have compiled kernels
with root on NFS on this machine, no cross compile) 

> >> 2) Since we don't have a spare developer PPC machine, is it possible
> >>    to crosscompile the LinuxPPC kernel from the standard Linux sources
> >>    on an Intel based machine ? I tried it and had problems with an
> >>    unfound 'semaphore.h' file.
> >> 
> >
> >Yes, you'll need a rather recent egcs version. 
> 
>  The egcs on that machine came with a Slackware 3.6 (Octobre 1998?). It
>  should be recent. And how will a new egcs prevent the unfound-include-file-
>  problem from happening ?

You might have to tweak the main Makefile for cross compiling, this
depends on which kernel you are using, and how egcs (in which
directories) has been installed.

However the following:

	make ARCH=ppc CROSS_COMPILE=<correct directory name> 

should work most of the time.

> >I have put an untested zImage on my ftp server (I want to test it soon):
> >
> >ftp://vcorr1.iram.es/pub/linux-2.2/zImage.nfsroot-2.2.0
> 
>  Thank you. BTW, is is possible to use 'rdev' on a cross-compiled
>  kernel image ? I mean : can I set the root device for a LinuxPPC with
>  a PC's rdev ?

No, I don't think so. Ah, and BTW the kernel I put on the ftp server has a
serial console: all message will be logged to the serial port and you can
also set a getty on the serial port in /etc/inittab:

S0:12345:respawn:/sbin/getty -h ttyS0 DT9600 vt100

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
