Return-Path: <kernelppc@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 080B3DDEC3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 22:56:51 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so608946nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 04 Jan 2008 03:56:50 -0800 (PST)
From: "mojtaba" <kernelppc@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <169c03cb0801031557r1efbd89fsd971533e04477daa@mail.gmail.com>
In-Reply-To: <169c03cb0801031557r1efbd89fsd971533e04477daa@mail.gmail.com>
Subject: RE: File system problem
Date: Fri, 4 Jan 2008 12:57:36 +0100
Message-ID: <008101c84ec9$002b2640$008172c0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
Thank you all for your helps.

Today I tried to make the file system again using buildroot. This time I
included busybox to the packages for target system (Before that, I did =
not
include the busybox). Surprisingly the system boot correctly.

But, I do not want to use busybox. I already compiled coreutiles and I =
want
to put them on my target system. After building the root file system I =
tried
to replace those symbolic links to busybox(such as ls, cp, ...) with the
real commands from coreutiles but I got this error.

Freeing unused kernel memory: 76k init
missing file opeKernel panic - not syncing: Attempted to kill init!
rand
Try `/bin/Rebooting in 180 seconds..sh --help' for more information.

So, how can I use coreutils instead of busybox?

Regards,
Mojtaba

-----Original Message-----
From: jsamch@gmail.com [mailto:jsamch@gmail.com] On Behalf Of =
Jean-Samuel
Chenard
Sent: Friday, January 04, 2008 12:58 AM
To: linuxppc-embedded@ozlabs.org; kernelppc@gmail.com
Subject: RE: File system problem

> Message: 9
> Date: Thu, 3 Jan 2008 18:00:14 +0100
> From: "mojtaba"
>
> Actually, I removed the console and null created by buildroot and =
create
> them manually using make node. This time the system freezes at this =
point.
> "Freeing unused kernel memory: 76k init"

Hi Mojtaba,

I just want to comment on your observation that the file size in /dev
was zero.  This is normal as the device files are 'special' since they
are a mean of abstracting the interface to the kernel.  I had to read
the online book listed below before I could understand the inner
workings of those special files.  If you plan on interfacing your FPGA
with the Linux Kernel, I suggest you read it too, as it is a very
insightful book:
http://lwn.net/Kernel/LDD3/

At this point, your system is not frozen, but your init script and
configuration files are probably not all correctly set.  You might
need to read some documentation about buildroot to see what its init
scripts are trying to do.

You might be missing a library or symlink (I got that problem in my
attempt to build the BusyBox root filesystem from scratch).  One way
to go at the problem is to pass the init=3D/bin/ash or something like
that to your kernel at the boot prompt (you could even make some
trivial 'hello world' program and pass it to the kernel as the init
process).  This way, you can dive right into a shell or your program
and avoid init and its configuration.

After some copying of required libraries in /lib (I'm using uClibc)
and the creation of the required symbolic links, I got my Busybox root
filesystem working on my ML-310 board.

Good luck!

Regards,

Jean-Samuel
--=20
Ph.D. candidate
Integrated Microsystems Laboratory
McGill University, Montr=E9al, QC, CANADA
Web Page: http://chaos.ece.mcgill.ca
