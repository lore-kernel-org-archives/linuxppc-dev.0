Return-Path: <jsamch@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 697D9DDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 10:57:44 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2069943pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Jan 2008 15:57:43 -0800 (PST)
Message-ID: <169c03cb0801031557r1efbd89fsd971533e04477daa@mail.gmail.com>
Date: Thu, 3 Jan 2008 18:57:43 -0500
From: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Sender: jsamch@gmail.com
To: linuxppc-embedded@ozlabs.org, kernelppc@gmail.com
Subject: RE: File system problem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Message: 9
> Date: Thu, 3 Jan 2008 18:00:14 +0100
> From: "mojtaba"
>
> Actually, I removed the console and null created by buildroot and create
> them manually using make node. This time the system freezes at this point=
.
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
