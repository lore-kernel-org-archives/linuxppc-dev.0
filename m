Message-ID: <35C119252057D511BB9F0003476BF8A208E5CB@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: "'Mark Hatle'" <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Ramdisk: kernel panic...
Date: Fri, 28 Sep 2001 17:08:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I used simple-ramdisk.image.gz (indicated in archives of this list).
It has the following libraries in /lib directory.
 ld.so.1
 libc-1.99.so
 libc.so.6 -> libc-1.99.so
 libcrypt.so.1
 libproc.so.1.2.6
 libtermcap.so.2 -> libtermcap.so.2.0.8
 libtermcap.so.2.0.8

I thought of trying out with montavista's libraries and I built my own
ramdisk with following files replaced in the ramdisk /lib directory. All
these are built for 7xx processor (from CDK 1.2 CD of HHL).
 ld-2.1.3.so
 ld.so.1 -> ld-2.1.3.so
 libc-2.1.3.so
 libc.so.6 -> libc-2.1.3.so
 libcrypt-2.1.3.so
 libcrypt.so.1 ->  libcrypt-2.1.3.so
 libproc.so.2.0.0
 libproc.so ->  libproc.so.2.0.0
 libtermcap.so.2.0.8
 libtermcap.so.2 ->  libtermcap.so.2.0.8

 similarly I replaced bin/sh also.

Still I am getting the same problem. Is there any other libraries that I
need to add ither than the above. Please let me know.

-- Siva


> -----Original Message-----
> From: Mark Hatle [mailto:fray@mvista.com]
> Sent: Friday, September 28, 2001 4:03 PM
> To: Prasad, Siva
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Ramdisk: kernel panic...
>
>
> > Freeing unused kernel memory: 180k init
> > Kernel panic: Attempted to kill init!
> >  <0>Rebooting in 180 seconds..
>
> The message indicates it was unable to execute the init
> program.  Do you
> have the required libraries in your ramdisk?  are they for the right
> machine.. (remember cachelines are different between 8xx and the other
> PPC processors.)
>
> There are a lot of things that can cause init to bail,
> sigsegv, sigill,
> etc, missing/bad library, etc..
>
> --Mark
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
